//+------------------------------------------------------------------+
//|                                                EA_MACross_V1.mq4 |
//|                                                   Majid Namnabat |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Majid Namnabat"
#property link      "maj.nam@gmail.com"
#property version   "8.00"
#property strict
#include <stderror.mqh>
#include <stdlib.mqh>
#include <MD_V_LAST\\EA_MD_Types.mqh>
#include <MD_V_LAST\\EA_MD_UtilityFunctions.mqh>
#include <MD_V_LAST\\EA_MD_TradeManagement.mqh>
#include <MD_V_LAST\\EA_MD_Profiles.mqh>
#include <MD_V_LAST\\EA_MD_Protect.mqh>

//#include <candlepatterns.mqh>
// This defines the magic number for this EA. A magic number can be
// assigned to an order, so that orders opened by this EA have this magic
// number. This is how we distinguish between orders opened by this EA,
// and those opened by the user or other EAs.
// Ref: http://articles.mql4.com/145


/////////////////// global variables

const int MINBARS_COUNT=50;                        //Minimum bars in the graph to enable trading
//static bool IsOPenOrder_NextCross = false;

static int m_nSymbols_TF_Count = 0;
static datetime dtTime_Current[] ;
static datetime dtTime_Lower[] ;
static datetime dtTime_1Min[] ;
static datetime dtTime_Higher[] ;
static long      m_nSeconds_Elapsed = -1;
static datetime m_dtExpert_TimeInit = 0;
static bool m_forex=false;
static bool m_bInitLoad_Done = false;

CStatisticCalculator m_oMVDistanceStats;
//static double m_fSL_Origin_LastOrder = -1.f;  //May be BreakEven or Trail , Origin StopLoss Store Here


static bool m_isNewBar[];
static bool m_isLowerPeriodNewBar[];
static bool m_isOneMinuteNewBar[];
static bool m_isHigherPeriodNewBar[];
static int m_nLowerPeriod[];
static int m_nHigherPeriod[];

//EA_MACD_Div objDerermine_MACDL_Divergence;
//EA_MACD_Div objDerermine_MACDC_Divergence;
//EA_MACD_Div objDerermine_MACDH_Divergence;
EA_MA_TradeManagement m_oTradeManager;
//CTradesStatistic  m_oTradeManager.m_oTradesStatistics;
CEAProtect m_oLockProtection;
CEAProfile m_oProfile;
int FilePtr;               //  To save optimization result
///////////////

/////////////////Trailing Stop Global Variable
/////////////////Trend Determine
//static ENUM_WAVE_TREND TrendDirection = ENUM_TREND_UNKNOWN;

/////////////////////////////////////////////////////////////////

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
   Print("OnInit");
   m_oLockProtection.Init(D'2025.08.26',365,"47019215");

   m_oLockProtection.Init(D'2025.08.26',365,"500267859");
   if(!m_oLockProtection.IsAllowed())
     {
      return(INIT_PARAMETERS_INCORRECT);
     }
//---
//--- create timer
//EventSetTimer(60);
   if(!CheckAllowedOrder())
      return(INIT_AGENT_NOT_SUITABLE);
   m_dtExpert_TimeInit = TimeCurrent();
////////////////////////////////////////////////
   m_oProfile.CopyOriginalParameters();
   Print ("OnInit " , m_dtExpert_TimeInit , "  " , BoolToStr ( IsTesting() ) );
///////////////////////////////////////////////
   InitExpert();


   m_bInitLoad_Done = false;
//m_fSL_Origin_LastOrder = -1.f;
   LoadArrays();

//m_forex = false;



   /*
      string terminal_data_path=TerminalInfoString(TERMINAL_DATA_PATH);
   Print ("Data Path Saved in " , terminal_data_path);
      string common_data_path=TerminalInfoString(TERMINAL_COMMONDATA_PATH);
      Print ("Data Path Saved in " , common_data_path);
   file in this folder is store :
   C:\Users\majid\AppData\Roaming\MetaQuotes\Terminal\7440C33DD76D5341D528D03C8C69F80D\tester\files
   */
//---
//--- during optimization
   if(MQLInfoInteger(MQL_OPTIMIZATION) || IsTesting())
     {
      LoadMVStatistics();

      m_oProfile.LoadProfile(Symbol(),Period());
      //m_dtExpert_TimeInit = iTime(Symbol(),Period(),iBars(Symbol(),Period()));
      //Print("OnInit " , iBars(Symbol(),Period()) , " " , m_dtExpert_TimeInit , " " ,iTime(Symbol(),Period(),0) );
      int nMVStIndex = FindMVStatistics();
      if(nMVStIndex>-1)
         Print("OnInit nMVStIndex : ", nMVStIndex, " Mean : ", optMVStatistics[nMVStIndex].m_fMean, " Std : ", optMVStatistics[nMVStIndex].m_fStd);
      if(m_nOptimizationLevel == ENUM_OPTIMIZATION_STATISTICS && !m_bInitLoad_Done)
        {
         Setup(Symbol(), Period());
         m_bInitLoad_Done = true;
        }
      for(int n=0; n<ArraySize(m_OptimizationCriterias); n++)
        {
         m_OptimizationCriterias[n].m_fProfitFactor_Criteria = -1;//0.3;
         //not go under 50% loss of initial deposit
         m_OptimizationCriterias[n].m_fNetProfit_PercentTime_Criteria = -1;//-0.57;
         m_OptimizationCriterias[n].m_fNetProfit_Criteria = -1;
         m_OptimizationCriterias[n].m_fWinRatio_Criteria = 0.3;
        }

      if(m_nOptimizationLevel == ENUM_OPTIMIZATION_OPENORDER_1 ||
         m_nOptimizationLevel == ENUM_OPTIMIZATION_OPENORDER_OPENDISTANCE_DET ||
         m_nOptimizationLevel == ENUM_OPTIMIZATION_OPENORDER_OPENDISTANCE_FASTMETHOD_DET ||
         m_nOptimizationLevel == ENUM_OPTIMIZATION_CLOSEORDER_1 || 
         m_nOptimizationLevel == ENUM_OPTIMIZATION_CLOSEORDER_CLOSE_DIS ||
         m_nOptimizationLevel == ENUM_OPTIMIZATION_STOPLOSS_OPTMV_V2)
        {
         for(int n=0; n<ArraySize(m_OptimizationCriterias); n++)
           {
            m_OptimizationCriterias[n].m_fProfitFactor_Criteria = -1;//0.3;
            //not go under 50% loss of initial deposit
            m_OptimizationCriterias[n].m_fNetProfit_PercentTime_Criteria = -1;//-0.57;
            m_OptimizationCriterias[n].m_fNetProfit_Criteria = -1;
            m_OptimizationCriterias[n].m_fWinRatio_Criteria = -1;
           }
        }
      m_nIsDoneValidatoin_DuringTesting = ENUM_VALIDATION_DISABLE;
      if(MVsMinOpenDistance <= MVsMaxCloseDistance)
      {
         Print("Error MVsMinOpenDistance or MVsMaxCloseDistance");
         return(INIT_PARAMETERS_INCORRECT);
      }
      if(prMVOpenOrderOptimizeSeries == -1 && !m_oTradeManager.m_oIndicatorsInterface.m_oMVCrossDis.ValidationSettings())
      {
         Print("Error m_oMVCrossDis.ValidationSettings");
         return(INIT_PARAMETERS_INCORRECT);
      }
      if(prOptTstBrTrDisOptimizationSeries == -1 && ActiveBreakEvenDistance > 1 && ProfitToTrailingStop != ENUM_TRAILING_STOP_DISABLED && ActiveBreakEvenDistance > (ProfitToTrailingStop - 6) && ProfitToTrailingStop != ENUM_TRAILING_STOP_RSI_SATURATION)
      {
         return(INIT_PARAMETERS_INCORRECT);
      }
      //MODE_SMMA for fast is not good really bad in testbench of 1 Year of XAUUSD RoboForex
      if(FastMVType == MODE_SMMA)
      {
         return(INIT_PARAMETERS_INCORRECT);
      }
      /*
      Good OpenDistance Ratio -Mean/Std
      1.32
      1.248
      1.7
      1.567
      1.312
      1.558
      */
      if(nMVStIndex>-1 && MVsMinOpenDistance <= (optMVStatistics[nMVStIndex].m_fMean+ 1.15 * optMVStatistics[nMVStIndex].m_fStd))
       {
         //Print("Error MVsMinOpenDistance");
         //return(INIT_PARAMETERS_INCORRECT);
       }
      if(nMVStIndex>-1 && MVsMinOpenDistance >= (optMVStatistics[nMVStIndex].m_fMean+ 2 * optMVStatistics[nMVStIndex].m_fStd))
       {
         Print("Error MVsMinOpenDistance");
         return(INIT_PARAMETERS_INCORRECT);
       }
      if(m_nStopLossParameter < FastMVPeriod)
       {
         Print("Error m_nStopLossParameter");
         return(INIT_PARAMETERS_INCORRECT);
       }
      //if(prTrailingCombinationParameter == -1 && TrailingStopMethod == MovingAverageCustom && TrailingParameter!=3 && TrailingParameter!=5 && TrailingParameter!=7 && TrailingParameter!=9)
      //  return(INIT_PARAMETERS_INCORRECT);
      //logical
      /*if (prMVOpenOrderOptimizeSeries == -1 && !IsCommonMVPeriod(FastMVPeriod))
         return(INIT_PARAMETERS_INCORRECT);
      if (prMVOpenOrderOptimizeSeries == -1 && !IsCommonMVPeriod(SlowMVPeriod))
         return(INIT_PARAMETERS_INCORRECT);*/

      /*if(prTrailingCombinationParameter == -1 && TrailingStopMethod == FixedPointDistance && TrailingParameter < 10)
         return(INIT_PARAMETERS_INCORRECT);
       if(prTrailingCombinationParameter == -1 && (TrailingStopMethod == ENUM_TRAILINGSTOP_ATR15 || TrailingStopMethod == ATR20 || TrailingStopMethod == ATR) && !IsCommonATRPeriod (TrailingParameter))
         return(INIT_PARAMETERS_INCORRECT);*/


      //simply optimization
      /*if(prTrailingCombinationParameter == -1 && TrailingStopMethod == FixedPointDistance && TrailingParameter%5 !=0)
         return(INIT_PARAMETERS_INCORRECT);
      if(prOptTstBrTrDisOptimizationSeries == -1 && ActiveBreakEvenDistance > 1 && ActiveBreakEvenDistance%5 != 0)
         return(INIT_PARAMETERS_INCORRECT);*/

      //as liked and old experience
      /*if(prTrailingCombinationParameter == -1 && (TrailingStopMethod == NotUsing || TrailingStopMethod == ATR))
         return(INIT_PARAMETERS_INCORRECT);
      if(prMVOpenOrderOptimizeSeries == -1 && (SlowMVPeriod - FastMVPeriod) > 20)
         return(INIT_PARAMETERS_INCORRECT);
      if(prOptTstBrTrDisOptimizationSeries == -1 && ActiveBreakEvenDistance > 1 && ActiveBreakEvenDistance < 40)
         return(INIT_PARAMETERS_INCORRECT);
      if(prTrailingCombinationParameter == -1 && TrailingStopMethod == MovingAverageCustom && TrailingParameter > 30)
         return(INIT_PARAMETERS_INCORRECT);*/
      ////////////////////////////////////////////////


      ///////////////
      /*if (GlobalVariableCheck("FilePtr")==false ) {
        FilePtr = 0;
        GlobalVariableSet("FilePtr",0);
      } else {
        FilePtr = GlobalVariableGet("FilePtr");
        }*/


     }
   criterion_Ptr=new TCustomCriterionArray();
   if(CheckPointer(criterion_Ptr)==POINTER_INVALID)
     {
      return(-1);
     }
   criterion_Ptr.Add(new TTSSFCriterion());
   criterion_Ptr.Add(new TKellyCriterion(MIN_KELLY_FACTOR));

/////////////////////////////////////////////////////////////
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//--- destroy timer
   EventKillTimer();
//IsOPenOrder_NextCross = false;
   int nCIndex = 0;
   for(int s=0; s<ArraySize(m_SymbolsList); s++)
     {
      for(int t=0; t<ArraySize(m_TimeFramesList); t++)
        {
         nCIndex  = s*ArraySize(m_TimeFramesList)+t ;

         dtTime_Current[nCIndex] = iTime(m_SymbolsList[s],m_TimeFramesList[t],0) - 1;
         dtTime_Lower[nCIndex] =iTime(m_SymbolsList[s], m_nLowerPeriod[t],0)-1;
         dtTime_1Min[nCIndex] =iTime(m_SymbolsList[s], 1,0)-1;
         dtTime_Higher[nCIndex] = iTime(m_SymbolsList[s], m_nHigherPeriod[t],0)-1;

        }
     }

   m_bInitLoad_Done = false;
   if(CheckPointer(criterion_Ptr)==POINTER_DYNAMIC)
     {
      delete(criterion_Ptr);
     }
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//---
// برای اینکه سر هر تیک محاسبات صورت نگیرد و فقط وقتی که کندل جدید باز می شود محاسبات صورت بگیرد.
   if(Bars<MINBARS_COUNT /*|| IsTradeAllowed()==false*/)
     {
      if(IS_ENABLE_LOG)
         Print("INFO - Not enough Bars to trade or Not Allowed");
      return;
     }
   if(m_nOptimizationLevel == ENUM_OPTIMIZATION_STATISTICS)
     {
      return;
     }
   if((MQLInfoInteger(MQL_OPTIMIZATION) || IsTesting()) && m_nIsDoneValidatoin_DuringTesting!=ENUM_VALIDATION_DISABLE && m_oTradeManager.m_oIndicatorsInterface.m_oMVCrossDis.GetDate_FirstCrossOver()>0)
     {
      //Print("OnTick " , iTime(Symbol(),Period(),0));
      for(int n=0; n<ArraySize(m_OptimizationCriterias); n++)
        {
         if(!ValidateCriterias(Symbol(),Period(),n,m_oTradeManager.m_oIndicatorsInterface.m_oMVCrossDis.GetDate_FirstCrossOver(),m_oTradeManager.m_oTradesStatistics))
           {
            return;
           }
        }
     }
   /*   datetime datePrvPrv = iTime(NULL,60 , 2 );
          int YY=TimeYear(  datePrvPrv );   // Year
       int MN=TimeMonth( datePrvPrv );   // Month
       int DD=TimeDay(   datePrvPrv );   // Day
       int HH=TimeHour(  datePrvPrv );   // Hour

   if(YY == 2021 && MN == 3 && ( DD >= 15 && DD <= 29 ) )
   {
    if(m_isNewBar)
     {
       Print ( "OnTick :" , YY ," ", MN ," ", DD );
        DrawArrowCheckCandle(120, ENUM_OBJECT_BELOW_CANDLE,2,60);
       }
   }
   */
//Problem Really Experience : 1Minute Data Begin Later than 15Minute
   Process_All();
  }
//+------------------------------------------------------------------+
//| Timer function                                                   |
//+------------------------------------------------------------------+
void OnTimer()
  {
//---

  }

//+------------------------------------------------------------------+
//| ChartEvent function                                              |
//+------------------------------------------------------------------+
void OnChartEvent(const int id,
                  const long &lparam,
                  const double &dparam,
                  const string &sparam)
  {
//---
   if(id==CHARTEVENT_OBJECT_CLICK)
     {
      if(IS_ENABLE_LOG)
         Print("OnChartEvent ",sparam);
      ChartRedraw();// Forced redraw all chart objects

     }
  }
// Exit Fully , Nothing , One Step Exit
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
void InitExpert()
  {
   m_nSymbols_TF_Count = (ArraySize(m_SymbolsList))*ArraySize(m_TimeFramesList);
  Print("OnInit , m_nSymbols_TF_Count ", m_nSymbols_TF_Count, " SymbolsSize : ", ArraySize(m_SymbolsList), " TFSize : ", ArraySize(m_TimeFramesList), "Symbol 0 ", m_SymbolsList[0], "TF 0 ", m_TimeFramesList[0]);
   ArrayResize(dtTime_Current, m_nSymbols_TF_Count, 0) ;
   ArrayResize(dtTime_Lower, m_nSymbols_TF_Count, 0);
   ArrayResize(dtTime_1Min, m_nSymbols_TF_Count, 0);
   ArrayResize(dtTime_Higher, m_nSymbols_TF_Count, 0);

   ArrayResize(m_isNewBar, m_nSymbols_TF_Count, 0);
   ArrayResize(m_isLowerPeriodNewBar, m_nSymbols_TF_Count, 0);
   ArrayResize(m_isOneMinuteNewBar, m_nSymbols_TF_Count, 0);
   ArrayResize(m_isHigherPeriodNewBar, m_nSymbols_TF_Count, 0);
   ArrayResize(m_nLowerPeriod, ArraySize(m_TimeFramesList), 0);
   ArrayResize(m_nHigherPeriod, ArraySize(m_TimeFramesList), 0);
   int nCIndex = 0 ;

   for(int s=0; s<ArraySize(m_SymbolsList); s++)
     {
      for(int t=0; t<ArraySize(m_TimeFramesList); t++)
        {
         //Print("OnInit , s: ", s, " t: ", t);

         nCIndex  = s*ArraySize(m_TimeFramesList)+t ;

         m_nLowerPeriod[t] = LowerPeriod(m_TimeFramesList[t]) ;
         m_nHigherPeriod[t] = HigherPeriod(m_TimeFramesList[t]);

         dtTime_Current[nCIndex] = iTime(m_SymbolsList[s],m_TimeFramesList[t],0) - 1;
         dtTime_Lower[nCIndex] =iTime(m_SymbolsList[s], m_nLowerPeriod[t],0)-1;
         dtTime_1Min[nCIndex] =iTime(m_SymbolsList[s], 1,0)-1;
         dtTime_Higher[nCIndex] = iTime(m_SymbolsList[s], m_nHigherPeriod[t],0)-1;

        }
     }

  }
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
void CheckMACross(string strSymbol, int nTimeFrame)
  {
   m_oTradeManager.m_oIndicatorsInterface.m_oMVCrossDis.CheckMACross(); // According to Prev and Prev Prev Candle , This is logical
   if(m_oTradeManager.m_oIndicatorsInterface.m_oMVCrossDis.GetTrackerStatus()==CROSSUP || m_oTradeManager.m_oIndicatorsInterface.m_oMVCrossDis.GetTrackerStatus()==CROSSDOWN)
     {
      m_oTradeManager.m_oChartCharacter.m_nMVStates = ENUM_MV_CROSSOVER;
      COrdersManagement::RemoveAllPendings(strSymbol,MACROSS_MAGIC_NUM);
      m_oTradeManager.Allow_OpenOrder();
      //if(IS_ENABLE_LOG) Print("CrossOver   Cross Type : " , EnumToString(m_oTradeManager.m_oIndicatorsInterface.m_oMVCrossDis.GetTrackerStatus()));
     }

  }
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
void TryNewOrder(int nSymbol, int nTF, int nOrderState)
  {
   int nCommand = OP_BUY;
   int nCIndex =  nSymbol * ArraySize(m_TimeFramesList) + nTF ;

   if(m_oTradeManager.DetermineOpenAllowance(nOrderState) && m_oTradeManager.MustOpenOrder(nCommand,CandleTick(nCIndex),m_isNewBar[nCIndex],m_forex,m_nHigherPeriod[nTF],m_nLowerPeriod[nTF],m_isHigherPeriodNewBar[nCIndex]))
     {
      //if(IS_ENABLE_LOG) Print("TryNewOrder   ");
      m_oTradeManager.OpenInitOrder(nCommand);  // 2 : Sell
      m_oTradeManager.Prohibit_OpenOrder();   //Why ? In Some Condition SL active and then one candle later another position was opened

      if(IS_ENABLE_LOG && CheckBit(nOrderState,ENUM_ORDER_ZERO)!=1)
         Print("Error Existing Order & MustOpenOrder True ", nOrderState, " ", m_oTradeManager.DetermineOrderState(ENUM_ORDERS_INVESTIGATE_SYMBOL_ONLY));
     }

  }
//+------------------------------------------------------------------+
//| Candle tick function                                             |
//+------------------------------------------------------------------+
bool CandleTick(int nCIndex)
  {
   return (m_isNewBar[nCIndex] || m_isLowerPeriodNewBar[nCIndex]);
  }
//+------------------------------------------------------------------+
//| Setup function                                              |
//+------------------------------------------------------------------+
void Setup(string strSymbol, int nTimeFrame)
  {
   m_oProfile.LoadProfile(strSymbol,nTimeFrame);
   m_oTradeManager.Setup(strSymbol,nTimeFrame,FastMVPeriod,FastMVType,SlowMVPeriod,SlowMVType,ActiveCloseOrderCurrentCandle,m_dtExpert_TimeInit);
   if(SymbolInfoInteger(strSymbol,SYMBOL_TRADE_CALC_MODE)==(int)SYMBOL_CALC_MODE_FOREX)
      m_forex=true;
  }
//+------------------------------------------------------------------+
//| Process function                                              |
//+------------------------------------------------------------------+
void Process_Special_Symbol_TF(string strSymbol, int nSymbol, int nTimeFrame, int nTFIndex, bool isChangedSymbolTF)
  {
   int nCIndex = nSymbol * ArraySize(m_TimeFramesList) + nTFIndex ;
   if(!m_bInitLoad_Done)
     {
      Setup(strSymbol, nTimeFrame);
      m_bInitLoad_Done = true;
     }
   if(isChangedSymbolTF)
     {
      Setup(strSymbol, nTimeFrame);
     }
   int nOrderState = m_oTradeManager.DetermineOrderState(ENUM_ORDERS_INVESTIGATE_ALL);
//Print("OnTick OrderState ", nOrderState);
   if(IsBitOn(nOrderState, ENUM_ORDER_ZERO))
     {
      //Check Previous Order , Finished ? Why ? Cal Statisticals
      m_oTradeManager.m_oTradesStatistics.HistoryScanner(strSymbol);
      //if(IS_ENABLE_LOG) Print("CheckMACross   ");
      if(!m_oTradeManager.DetermineOpenAllowance(nOrderState))
        {
         return;
        }

      m_oTradeManager.m_oIndicatorsInterface.m_oMVCrossDis.SetCandleApplied(PREVIOUS_CANDLE);
      CheckMACross(strSymbol,nTimeFrame);
      TryNewOrder(nSymbol, nTFIndex, nOrderState);
     }
   else
      if(IsBitOn(nOrderState, ENUM_ORDER_BUY) ||
         IsBitOn(nOrderState, ENUM_ORDER_SELL) ||
         IsBitOn(nOrderState, ENUM_ORDER_BUY_PENDING) ||
         IsBitOn(nOrderState, ENUM_ORDER_SELL_PENDING))
        {
         //Check Previous Order , Finished ? Why ? Cal Statisticals
         m_oTradeManager.m_oTradesStatistics.HistoryScanner(strSymbol);
         if(IsBitOn(nOrderState, ENUM_ORDER_BUY_PENDING) || IsBitOn(nOrderState, ENUM_ORDER_SELL_PENDING))
           {
            m_oTradeManager.CheckPending_Activated();
            nOrderState = m_oTradeManager.DetermineOrderState(ENUM_ORDERS_INVESTIGATE_ALL);
           }
         if(ActiveCloseOrderCurrentCandle != PREVIOUS_CANDLE)
           {
            m_oTradeManager.m_oIndicatorsInterface.m_oMVCrossDis.SetCandleApplied(ActiveCloseOrderCurrentCandle);
           }
         else
           {
            m_oTradeManager.m_oIndicatorsInterface.m_oMVCrossDis.SetCandleApplied(PREVIOUS_CANDLE);
           }
         CheckMACross(strSymbol,nTimeFrame);
         m_oTradeManager.ExistingOrdersManagement(ENUM_ORDERS_INVESTIGATE_ALL,CandleTick(nCIndex));
         /*
         nOrderState =m_oTradeManager.DetermineOrderState(ENUM_ORDERS_INVESTIGATE_ALL);   //Update after Pending Remove and OrderManagements
         TryNewOrder(nOrderState);
         */
        }

  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void Process_All()
  {
   const int SECOND_DISTANCE = 3;
   bool isFastProcess = MQLInfoInteger(MQL_OPTIMIZATION);

   string strSymbol = Symbol();//"XAUUSD";
   int nTimeFrame = 15;
   int nSymbolsCount = ArraySize(m_SymbolsList);
   int nTFCounts = ArraySize(m_TimeFramesList);
   int nIndex = 0;
   long secs_elapsed = 0;
   bool isSecondsElapsed = false;
   bool isProcessing = false;
   m_isOneMinuteNewBar[0] =(dtTime_1Min[0] != iTime(strSymbol, 1,0));
   if(m_isOneMinuteNewBar[0] && !m_oLockProtection.IsAllowed())
     {
      return;
     }

   for(int nSymbol = 0; nSymbol < nSymbolsCount ; nSymbol++)
     {
      for(int nTF = 0; nTF < nTFCounts; nTF++)
        {
         nIndex = nSymbol*nTFCounts+nTF;
         strSymbol = m_SymbolsList[nSymbol];
         nTimeFrame = m_TimeFramesList[nTF];

         m_isNewBar[nIndex] = (dtTime_Current[nIndex] != iTime(strSymbol,nTimeFrame,0));
         dtTime_Current[nIndex] = iTime(strSymbol,nTimeFrame,0);

         secs_elapsed = (long)(TimeCurrent() - iTime(strSymbol,nTimeFrame,0));
         isSecondsElapsed = ((secs_elapsed - m_nSeconds_Elapsed) > SECOND_DISTANCE || !isFastProcess) ? true : false;
         m_nSeconds_Elapsed = isSecondsElapsed ? secs_elapsed : m_nSeconds_Elapsed;
         /////////////////////
         m_isOneMinuteNewBar[nIndex] =(dtTime_1Min[nIndex] != iTime(strSymbol, 1,0));
         dtTime_1Min[nIndex] = iTime(strSymbol, 1,0);

         m_isLowerPeriodNewBar[nIndex] = (dtTime_Lower[nIndex] != iTime(strSymbol, m_nLowerPeriod[nTF],0));
         dtTime_Lower[nIndex] = iTime(strSymbol, m_nLowerPeriod[nTF],0);


         m_isHigherPeriodNewBar[nIndex] = (dtTime_Higher[nIndex] != iTime(strSymbol, m_nHigherPeriod[nTF],0));
         dtTime_Higher[nIndex] = iTime(strSymbol, m_nHigherPeriod[nTF],0);
         ////////////////
         isProcessing = false;
         if(isSecondsElapsed && (secs_elapsed >= 3*(PeriodSeconds()/4)))
         {
            isProcessing = true;
         }
         else if(m_isOneMinuteNewBar[nIndex] || m_isNewBar[nIndex])
         {
            isProcessing = true;
         }
         if(isProcessing)
         {
            /*if(m_dtExpert_TimeInit==0)
            {
               m_dtExpert_TimeInit = iTime(strSymbol,nTimeFrame,0);
               Print("Process_All " , m_dtExpert_TimeInit ," " , iTime(strSymbol,nTimeFrame,0), " " , TimeCurrent());
            }*/
            Process_Special_Symbol_TF(strSymbol,nSymbol, nTimeFrame, nTF, m_nSymbols_TF_Count==1 ? false : true);
         }
         //if(iBars(m_SymbolsList[nSymbol],m_TimeFramesList[nTF])<MINBARS_COUNT /*|| IsTradeAllowed()==false*/)
         //I must know New Candle or not ....staticTime ?
         //if(m_isOneMinuteNewBar)
           {
            //I must know Hav Active Orders On this Symbol TimeFrame ?
            //m_oTradeManager.Setup(m_SymbolsList[nSymbol],m_TimeFramesList[nTF]);
           }
        }
     }
//if(IS_ENABLE_LOG) Print(Symbol());
  }

/*
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double GetStopLossBuy(string Instrument)
  {
   double SLValue=Close[0]-iATR(Instrument,PERIOD_CURRENT,TrailingParameter,0);
   return SLValue;
  }
///////////////////////////////////////////////////////////////////////////////////////////

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double GetStopLossSell(string Instrument)
  {
   double SLValue=Close[0]+iATR(Instrument,PERIOD_CURRENT,TrailingParameter,0);
   return SLValue;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
*/
///////////////////////////////////////////////////////////////////////////////////////////
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//OnTester function
//+------------------------------------------------------------------+
double OnTester(void)
  {
//File Address
// C:\Users\majid\AppData\Roaming\MetaQuotes\Terminal\7440C33DD76D5341D528D03C8C69F80D\tester\files
   double   param=0.0;
   const int TradeCount_WriteLimit = 120;  //Customizable to Symbol and Period and Offline Data
   const double NetProfit_WriteLimit = 20.0; //Customizable to Symbol and Period and Offline Data
   const double Param_WriteLimit = 0.05;  //Customizable to Symbol and Period and Offline Data

   string row;
   if(m_nOptimizationLevel == ENUM_OPTIMIZATION_STATISTICS)
     {
      int nDistanceList[];
      m_oTradeManager.m_oIndicatorsInterface.m_oMVCrossDis.GetHistory_MV_Distance(nDistanceList);
      m_oMVDistanceStats.UpdateBatch(nDistanceList);
      //Not asnwered , because in OnInit only with 100 bars started

      Print("UpdateBatch m_oMVDistanceStats Mean : ", m_oMVDistanceStats.m_fMean, " Std : ", m_oMVDistanceStats.m_fStd, " Size : ", ArraySize(nDistanceList), " Bars : ", iBars(Symbol(),Period()));
      ResetLastError();
      //FileDelete("EAMA_parameters.txt");
      int filehandle = FileOpen("MV_statistics_"+Symbol()+"_"+IntegerToString(Period())+".txt",FILE_WRITE|FILE_READ);
      if(filehandle==INVALID_HANDLE)
        {
         if(IS_ENABLE_LOG)
            Print("Failed to open the file by the absolute path ");
         if(IS_ENABLE_LOG)
            Print("Error code ",GetLastError());
        }
      else
        {
         FileSeek(filehandle,0,SEEK_END);
         row = StringFormat("%d,%d,%s,%.2f,%.2f,%d\n",
                            (int)FastMVPeriod, (int)SlowMVPeriod, EnumToString(FastMVType), m_oMVDistanceStats.m_fMean, m_oMVDistanceStats.m_fStd, ArraySize(nDistanceList));

         FileWriteString(filehandle,row,StringLen(row));
         FileClose(filehandle);
        }
      return param;
     }

   m_oTradeManager.m_oTradesStatistics.CalcStatistics(ENUM_ORDERS_INVESTIGATE_ALL);
   if(!IS_SECURE && m_oTradeManager.m_oTradesStatistics.m_oWinTradesStat.m_nCount>0)
     {
      row = StringFormat("OnTester WinRatio : %.2f  Profit Factor : %.2f ", m_oTradeManager.m_oTradesStatistics.m_fWinRatio, m_oTradeManager.m_oTradesStatistics.m_fProfitFactor);
      Print(row);
      row = StringFormat("OnTester Commisions : Sum:  %.2f  Mean : %.2f , Std : %.2f ",
                         m_oTradeManager.m_oTradesStatistics.m_oCommission.m_fSum, m_oTradeManager.m_oTradesStatistics.m_oCommission.m_fMean, m_oTradeManager.m_oTradesStatistics.m_oCommission.m_fStd);

      Print(row);
      row = StringFormat("OnTester AllTrades :   Mean$ : %.2f , Std$ : %.2f ",
                         m_oTradeManager.m_oTradesStatistics.m_oAllTradeStat.m_fMean, m_oTradeManager.m_oTradesStatistics.m_oAllTradeStat.m_fStd);
      Print(row);
      row = StringFormat("OnTester ProfitTrades :   Mean$ : %.2f , Std$ : %.2f BreakEvened %: %.2f Trailed %: %.2f",
                         m_oTradeManager.m_oTradesStatistics.m_oWinTradesStat.m_fMean, m_oTradeManager.m_oTradesStatistics.m_oWinTradesStat.m_fStd,
                         (double)(m_oTradeManager.m_oTradesStatistics.m_nBreakEvened * 100)/ m_oTradeManager.m_oTradesStatistics.m_oWinTradesStat.m_nCount,
                         (double)(m_oTradeManager.m_oTradesStatistics.m_nTrailed * 100)/ m_oTradeManager.m_oTradesStatistics.m_oWinTradesStat.m_nCount);
      Print(row);
      row = StringFormat("OnTester ProfitTrades Ratio All : BreakEvened %: %.2f Trailed %: %.2f",
                         (double)(m_oTradeManager.m_oTradesStatistics.m_nBreakEvened * 100)/ m_oTradeManager.m_oTradesStatistics.m_oAllTradeStat.m_nCount,
                         (double)(m_oTradeManager.m_oTradesStatistics.m_nTrailed * 100)/ m_oTradeManager.m_oTradesStatistics.m_oAllTradeStat.m_nCount);
      Print(row);

      row = StringFormat("OnTester Win_CloseDistance_Pip :   Mean : %.2f , Std : %.2f ,    SL Distance Mean: %.2f , Std : %.2f ",
                         m_oTradeManager.m_oTradesStatistics.m_oWinPipDistance.m_fMean, m_oTradeManager.m_oTradesStatistics.m_oWinPipDistance.m_fStd,
                         m_oTradeManager.m_oTradesStatistics.m_oSLPipDistance.m_fMean, m_oTradeManager.m_oTradesStatistics.m_oSLPipDistance.m_fStd);
      Print(row);

     }
   int nTotalTrade = (int)TesterStatistics(STAT_TRADES);
   double fNetProfit = TesterStatistics(STAT_PROFIT);
   double fProfitFactor = TesterStatistics(STAT_PROFIT_FACTOR);
   if(IS_ENABLE_LOG)
      Print("OnTester TotalTrade :", nTotalTrade, " NetProfit : ", fNetProfit, " fProfitFactor : ", fProfitFactor);
   //fekr , in open order analysis , win ratio high is more important others.
   if(m_nOptimizationLevel == ENUM_OPTIMIZATION_OPENORDER_1 ||
      m_nOptimizationLevel == ENUM_OPTIMIZATION_OPENORDER_OPENDISTANCE_DET ||
      m_nOptimizationLevel == ENUM_OPTIMIZATION_OPENORDER_OPENDISTANCE_FASTMETHOD_DET ||
      m_nOptimizationLevel == ENUM_OPTIMIZATION_OPENORDER_PENDINGORSPOT)
     {
      return(m_oTradeManager.m_oTradesStatistics.m_fWinRatio);

     }
   if(m_nOptimizationLevel == ENUM_OPTIMIZATION_CLOSEORDER_CLOSE_DIS || m_nOptimizationLevel == ENUM_OPTIMIZATION_STOPLOSS_OPTMV_V2)
   {
      //In StopLosss Adjustment we want Minimum Loss Against Maximum Win Trades
      //double fPerformance = (double) m_oTradeManager.m_oTradesStatistics.m_oLossTradeStat.m_fSum / (m_oTradeManager.m_oTradesStatistics.m_nTradeCount - m_oTradeManager.m_oTradesStatistics.m_oLossTradeStat.m_nCount) ;
      //return fPerformance;
      //In BreakEven Adjustment WinRatio Is Important , Minimum Loss Trades and Maximum Profitable Trades
      
      //
            //return(m_oTradeManager.m_oTradesStatistics.m_fWinRatio);
            return (double) (m_oTradeManager.m_oTradesStatistics.m_oWinTradesStat.m_nCount - m_oTradeManager.m_oTradesStatistics.m_nBreakEvened) / (m_oTradeManager.m_oTradesStatistics.m_oWinTradesStat.m_nCount + m_oTradeManager.m_oTradesStatistics.m_oLossTradeStat.m_nCount - m_oTradeManager.m_oTradesStatistics.m_nBreakEvened);

   }
   if(m_nOptimizationLevel == ENUM_OPTIMIZATION_CLOSEORDER_1 )
   {
      //Average Loss Per Win
      double fPerformance = (double) m_oTradeManager.m_oTradesStatistics.m_oLossTradeStat.m_fSum / (m_oTradeManager.m_oTradesStatistics.m_nTradeCount - m_oTradeManager.m_oTradesStatistics.m_oLossTradeStat.m_nCount) ;
      return fPerformance;
   }
   if(nTotalTrade < MIN_TRADES_COUNT)
     {
      if(IS_ENABLE_LOG)
         Print("nTotalTrade < MIN_TRADES_COUNT");
      return 0.0;
     }
   if(fProfitFactor < MIN_PROFIT_FACTOR)
     {
      if(IS_ENABLE_LOG)
         Print("fProfitFactor < MIN_PROFIT_FACTOR");
      return 0.0;
     }
   if(fNetProfit < MIN_NET_PROFIT)
     {
      if(IS_ENABLE_LOG)
         Print("fNetProfit < MIN_NET_PROFIT");
      return 0.0;
     }
// Balance max + min Drawdown + Trades Number:
   if(CheckPointer(criterion_Ptr)!=POINTER_INVALID)
     {
      param=criterion_Ptr.GetCriterion();
      row = StringFormat("OnTester Evaluation :   TTSSF : %.2f , Kelly : %.2f ",
                         criterion_Ptr.GetCriterion(0),  criterion_Ptr.GetCriterion(1));
      Print(row);
     }
   /*
   if(nTotalTrade > TradeCount_WriteLimit &&  param > Param_WriteLimit && fNetProfit > NetProfit_WriteLimit && MQLInfoInteger(MQL_OPTIMIZATION))
     {
      ResetLastError();
      //FileDelete("EAMA_parameters.txt");
      int filehandle = FileOpen("EAMA_parameters.txt",FILE_WRITE|FILE_READ);
      if(filehandle==INVALID_HANDLE)
        {
         if(IS_ENABLE_LOG)
            Print("Failed to open the file by the absolute path ");
         if(IS_ENABLE_LOG)
            Print("Error code ",GetLastError());
        }
      else
        {
         FileSeek(filehandle,0,SEEK_END);
         TOptimalFCriterion optimalFCriteria(0.0f);
         double optimalfParam = optimalFCriteria.GetCriterion();
         row = StringFormat("%.2f;%d;%.2f;%.2f;%.2f;%.2f;%.2f,%.2f,%.6f;%.6f;%d;%d;%s;%s;%d;%d;%s;%s;%s;%s;%d;%s;%d\n",
                            fNetProfit,nTotalTrade,
                            TesterStatistics(STAT_PROFIT_FACTOR) < 999.0f ? TesterStatistics(STAT_PROFIT_FACTOR) : 999.0f,
                            TesterStatistics(STAT_EXPECTED_PAYOFF),TesterStatistics(STAT_EQUITY_DD),TesterStatistics(STAT_EQUITYDD_PERCENT),
                            TesterStatistics(STAT_MAX_PROFITTRADE),TesterStatistics(STAT_PROFITTRADES_AVGCON),
                            param,optimalfParam, FastMVPeriod,SlowMVPeriod,EnumToString(FastMVType),EnumToString(SlowMVType),
                            MVsMinOpenDistance,MVsMaxCloseDistance,EnumToString(ActiveCloseOrderCurrentCandle),
                            EnumToString(OrderAsTrend),EnumToString(PatientTime),EnumToString(ActiveBreakEvenDistance),
                            ProfitToTrailingStop,EnumToString(TrailingStopMethod),TrailingParameter);

         FileWriteString(filehandle,row,StringLen(row));
         FileClose(filehandle);
        }
     }
   */
   return(param);


//const int
//double ret=0.0;
//return(ret);

   /*
      //https://www.investopedia.com/articles/trading/04/091504.asp
      double w=((TesterStatistics(STAT_PROFIT_TRADES)+TesterStatistics(STAT_LOSS_TRADES))>0)?TesterStatistics(STAT_PROFIT_TRADES)/(TesterStatistics(STAT_PROFIT_TRADES)+TesterStatistics(STAT_LOSS_TRADES)):0; // winning probability
      double r=((TesterStatistics(STAT_GROSS_LOSS)!=0)&&(TesterStatistics(STAT_LOSS_TRADES)!=0)&&(TesterStatistics(STAT_PROFIT_TRADES)!=0))?(TesterStatistics(STAT_GROSS_PROFIT)/TesterStatistics(STAT_PROFIT_TRADES))/(-TesterStatistics(STAT_GROSS_LOSS)/TesterStatistics(STAT_LOSS_TRADES)):0; // Win/loss ratio;
      double Kelly=(r!=0)?w-((1-w)/r):0; // Kelly Criterion
      return(Kelly);
      */
   /*
   I couldn't find MQL5 code for the Kelly Criterion, so I decided to write it myself; but it turned out that the Kelly Criterion only works for Bernoulli Distributions. This means it works only for fixed profits and losses, i.e. fixed SL and TP, but I rarely do.

   So, based upon the work of Ralph Vince's book The Mathematics of Money Management, and borrowing concepts from python code I found online, I created this MQL5 library for Optimal f.

   I am including test(s) that I used to verify that my code gives the same results as the example in Ralph Vince's book. That is: +9, +18, +7, +1, +10, -5, -3, -17, -7 .

   Note: I set GEOM_MEAN_MIN_TRADES = 0 to have the unit tests run.

   Note: This calculates Optimal f only. It does not show how to calculate a position size. That part is up to you.

   Note: This code is provided for testing and edification only. UNDERSTAND THE MATHEMATICS BEFORE USING THIS ON A REAL TRADING ACCOUNT! It's highly possible you will wipe out your account if you don't know what you are doing.

   */
   /*
   Yellow: from Zero to 1/2 Kelly is the Conservative risk area
   Orange: 1/2 Kelly to 1 Kelly is the Aggressive risk area
   Red: 1 Kelly to 2 Kelly is the Over-Aggressive risk area
   Black: Anything above 2 Kelly falls in the Insane risk-taking area
   */
   /*
   مهم است. می گوید هر درصد شد همان درصد باید پوزیشن گرفت
   Interpreting the Results
   The percentage (a number less than one) that the equation produces represents the size of the positions you should be taking. For example, if the Kelly percentage is 0.05, then you should take a 5% position in each of the equities in your portfolio. This system, in essence, lets you know how much you should diversify.
   بطور کلی معیار کلی درباره مدیریت سرمایه است حجم ریسک این ها خیلی ربطی به بهینه سازی و یافتن پارامترهای مناسب ندارد.

   البته اگر صفر برگرداند یا خیلی کم باشد مسلم آن است که این  پارامترها پرریسک بوده و مناسب نمی باشد.

   */
  }


//+------------------------------------------------------------------+
// Converts the ENUM_CUSTOM_APPLIED_PRICE value to ENUM_APPLIED_PRICE value
//+------------------------------------------------------------------+



//+------------------------------------------------------------------+
//| Candle tick function                                             |
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//| LoadProfile function                                             |
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//| Testing Set Parameters File Generation                                   |
//+------------------------------------------------------------------+
void TestParametersGeneration()
  {
//---

   int commonMVPeriods[12] = {9,12,13,20,21,26,30,34,50};
   int commonATRPeriods[7] = {3,7,12,13,21,26,30};
   for(int n1=0; n1<12; n1++)
     {
      FastMVPeriod = (ENUM_NORMAL_MV)commonMVPeriods[n1];
      for(int n2=0; n2<12; n2++)
        {
         SlowMVPeriod = (ENUM_NORMAL_MV)commonMVPeriods[n2];
         if(FastMVPeriod>=SlowMVPeriod-3)
            continue;
         if((SlowMVPeriod - FastMVPeriod) > 20)
            continue;
         for(int n3=13 ; n3<40 ; n3+=3)
           {
            MVsMinOpenDistance = n3;
            for(int n4=1 ; n4 <25 ; n4 +=3)
              {
               MVsMaxCloseDistance  = n4;
               for(int n5=1 ; n5 < 3 ; n5++)    //
                 {
                  PatientTime = (EnumPatientTime)n5;
                  for(int n6=0 ; n6 < 3 ; n6++)    //
                    {
                     OrderAsTrend = (ENUM_TREND_DETERMINE_METHOD) n6;
                     for(int n7=0 ; n7 < 75 ; n7 +=5)
                       {
                        //ActiveBreakEvenDistance = n7;

                        ProfitToTrailingStop = 100;
                        TrailingStopMethod = ENUM_TRAILINGSTOP_MV;
                        TrailingParameter = 20;
                       }
                    }
                 }
              }
           }
        }
     }



//if(ActiveBreakEvenDistance > 1 && ActiveBreakEvenDistance > ProfitToTrailingStop) return(INIT_PARAMETERS_INCORRECT);
  }
//--- during optimization



/*
// Experience Optimization EA
// MA_SMMA Smoothed Method Not Used for SlowMV Type 100% Proved
// m_nStopLossType Parameter Set To SlowMA , deactivate it , increase profit but increase GrossLoss and DD significantly.
// MA_SMA for Fast MV : not answered
// MA_LWMA also answered for Fast, it's similar to EMA, More Profit and Param Than EMA
// Step2 : Optimize OpenDistance 1 Step ,
// Negative Param : f : MODE_LWMA s :MODE_EMA remove it.
// Open Distance : 30,55,LWMA,SMA Start from 28 , 29 more stable in best result,
// Close Distance : 18 best
// 34,55,LWMA,SMA : OpenDis 26 ,27, 28 best , Close Distance : 14 best more stable in best result
// 26,55,EMA,SMA Open : 29,30,31b best , CloseDis  10 best , Step3 : 11b
// Finish : insert best values to array MV
// Step3 Close and Current Or Prev Candle :
   Prev Candle :
   PatientTime OneCandleInMiddle or CurrentCandle is not profitable , I select OneCandleInMiddle premanantly

   30,55,LWMA,SMA , DisClose 19b,16 best in Prev, but

   CURMEDIAN and TYPICAL  in 11,12b , param is better , ( I think MEDIAN and TYPICAL is same , MEDIAN is more show , so only MEDIAN is engough to test)
   34,55,LWMA,SMA : MEDIAN is select , DisClose 11b,12
   Step 4 : Finish insert best values to array MV , Test Order As Trend with this MV and all MVs,
   Not Good , GoldenCross and HigherHighFrame not good

   MODE_LWMA is Faster Than MODE_EMA
*/
/*
 Evaluation
  ESI Divergence T1 Higher Time Only : and STC Compensate XAUUSD 15 very little decrease
  Divergence T1 Higher and Current Time , and STC 1/4 decrease , SIMPLE METHOD 5/40 decrease XAUUSD 15

  RSI become very complex system , can not جمعش کنم
  // hamintor edame darad , saxt karde ast.
  // کلی وقت گذاشته ام اما تمام نمی شود واقعا بنظرم باید رهایش کرد فیل سفید دارد میشود


*/
/*
Evaluation
Trailing Stop In RSI Saturation Become Benefit , Less DrawDown Percent and Increase Profit Factor
 ENUM_TRAILINGSTOP_ATR15 is good

 T1 & T2 Main and Higher Time Frame , Check RSI one Peak Above 78 or 32 , Has benefitial


*/
/*
RoboForex Test
BreakEven is important part ,
I guess if BreakEven become Time Etc. Activate After 3 Candle is better .....

SomeTimes is some Conditions , Market Conditions is Bad , And I lost ContinuesLy ,
I money Management Advise to Break Esterahat for One Day When I lost a lot.
This is advised most , You can Implement it
//Test Robo , 2.5 Day Rest when .025 Lost In Profitable ,
With SignalExit and SignalCompensate DrawDown Become 43%

Determine Trend , Using Higher Time Frame , Or Golden Is Very Complicated , It is not simple , SomeTimes H1 is bearish H4 bulish  ...

BreakEven Point is also a Complicated and Complex Must Thought and Investigate Can Determine It

BolingerBands may be can used for determine peaks , order get and then fall
Or a Coef of MV

Class and Perestizh
Buy Limit Or Stop Limit , Pending Order , Really The Inputs is Bad Not Good  , At Least in MV 3 or 3Pip discount or 5pip

*/
//+------------------------------------------------------------------+
//XAUUSD 15M
//EMA : 280 Open Good Parameters MV10
//SMA : 240 Open Good Parameters MV4
//320 Cause Trade Count Decrease Bad Except LWMA,
//EMA act better SMA 100%
//MV7 EMA Most Robust related to Loss
//MV 2 4 5 7 9 10 , Answer Other No , On EMA LWMA
//MV Only Above Except 10 On SMA
//MV5 320 Profit > 100 ALL SMA,EMA,LWMA , LWMA Trade Count Acceptable

//////////////////////
//+------------------------------------------------------------------+
//EURUSD 15M
///Fixed Spread 14 Used , 23 in XAUUSD Decrease to  14
/*
بریک ایون ، نقطه سر به سر است. نقطه ای است که برشکستگی بعد از آن اتفاق می افتد. خوب از کی می خواهم بریک اون کنم ؟ اصلا کی ها می خواهم بریک اون کنم. مثلا با توجه به بالانس بعضی وقت ها تمایل دارم بیشتر ریسک کنم. در سود مناسبی هستم. اصلا شرایط بازار مساعد هست. یک مواقعی نه وضعیت بالانس من خوب نیست می خواهم بریک اون کنم. یک مواقعی فاصله استاپ لاس را نگاه میکنم. ببین روش محافظه کارانه ای است که وقتی انسان تریدر در فشار است بکار می آید. آیا به فاصله تا StopLoss ارتباط دارد. ببین در Money Management ارتباط پیدا می کند. وقتی مثلا 2 برابر 1 برابر رفتی در سود و رد کرد، دیگر آنجا قفل می کنی. یا از حجم می کاهی. هر دو این روش ها در آلفونسو ... متداول است و جواب هم می دهد.

بنظر من همه اینها BreakEven است. روشی است برای حفظ کردن سود، تلاشی است برای عدم رفتن در ضرر. کی می خواهیم به هیچ وجه وارد ضرر نشویم وقتی در فشار Balance هست. وقتی چندبار متوالی ضرر می کنیم. حق داریم محتاط باشیم. وقتی بازار همسو با من هست باید اجازه دهیم ریسک کنمی.

حالا چه مقداری باشد، چطور تعیین شود ؟ ببین یک Level دارد ؟ چرا ؟ چرا باید یک Level داشته باشد. یعنی چه ؟ می گوید وقتی سود از یک مقداری رفت بالا. دیگر حداقل اجازه ندهیم وارد ضرر شویم. حاضر باشیم یر به یر ببندیم. بنظرم با همان مفهوم Money Management فقط معنا دارد. در سطوح 1 ، 1.5، 2 ، 2.5، 3  و ... همینطور به بالا معنا پیدا میکند.

*/
/*
ENUM_STOPLOSS_BELOW_CUSTOM_MV_UPDATEBLE

Custom MV Updateable is worst , MV 26,34,50

*/
//+------------------------------------------------------------------+
