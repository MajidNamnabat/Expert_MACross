//+------------------------------------------------------------------+
//|                                              OptimizatonTest.mqh |
//|                                                   Majid Namnabat |
//|                                                maj.nam@gmail.com |
//+------------------------------------------------------------------+
#property copyright "Majid Namnabat"
#property link      "maj.nam@gmail.com"
#include <MD_V_LAST\\EA_CustomOptimization.mqh>
#include <MD_V_LAST\\EA_MD_Types.mqh>

//+------------------------------------------------------------------+
//| defines                                                          |
//+------------------------------------------------------------------+
// #define MacrosHello   "Hello, world!"
// #define MacrosYear    2010
//+------------------------------------------------------------------+
//| DLL imports                                                      |
//+------------------------------------------------------------------+
// #import "user32.dll"
//   int      SendMessageA(int hWnd,int Msg,int wParam,int lParam);
// #import "my_expert.dll"
//   int      ExpertRecalculate(int wParam,int lParam);
// #import
//+------------------------------------------------------------------+
//| EX5 imports                                                      |
//+------------------------------------------------------------------+
// #import "stdlib.ex5"
//   string ErrorDescription(int error_code);
// #import
//+------------------------------------------------------------------+
enum ENUM_OPTIMIZATION_LEVEL
  {
   ENUM_OPTIMIZATION_DISABLED = 0,
   ENUM_OPTIMIZATION_OPENORDER_1 = 1,
   ENUM_OPTIMIZATION_OPENORDER_OPENDISTANCE_DET,
   ENUM_OPTIMIZATION_OPENORDER_OPENDISTANCE_FASTMETHOD_DET,
   ENUM_OPTIMIZATION_OPENORDER_PENDINGORSPOT,
   ENUM_OPTIMIZATION_CLOSEORDER_1,
   ENUM_OPTIMIZATION_CLOSEORDER_CLOSE_DIS,
   ENUM_OPTIMIZATION_STOPLOSS_OPTMV_V2,
   ENUM_OPTIMIZATION_DETAILS_1,
   ENUM_OPTIMIZATION_STATISTICS,
  };
const ENUM_OPTIMIZATION_LEVEL m_nOptimizationLevel = ENUM_OPTIMIZATION_OPENORDER_1;
struct stctTrailingCombination
  {
   ENUM_TRAILINGSTOP_METHOD Type;
   int                  nParamVal;
  };
struct stctOptTstMVCombination
  {
   ENUM_NORMAL_MV FastPeriod ;
   ENUM_NORMAL_MV SlowPeriod ;
   ENUM_MA_METHOD    FastMethod;
   ENUM_MA_METHOD    SlowMethod;
   double fStdRatio;
   int               MinOpenDistance;
   int               SuitableCloseDistance;
   ENUM_CUSTOM_APPLIED_PRICE AppliedPrice;
   ENUM_STOPLOSS_TYPE nStopLossType;
   ENUM_BRIEF_MV nStopLossParameter;
   ENUM_BREAKEVEN       nActiveBreakEvenDistance;
   ENUM_TAKEPROFIT_METHOD nTakeProfitMethod;
   ENUM_OPENORDER_RISKANALYSIS   nOpenOrderRiskAnalysis;
   int nOpenOrder_RiskAnalysis_LevelUp ;
   int nOpenOrder_RiskAnalysis_LevelDown;
   
  };
struct stctOptTstMVCombinationV2
  {
   int nMVPeriodIndex;
   ENUM_MA_METHOD    FastMethod;
   double fStdRatio;
  };

struct stctOptTstBrTrDisCombination
  {
   int BreakeEvenDis ;
   int TrailingDis ;
  };
struct stctMVPeriodCombination
  {
   ENUM_NORMAL_MV FastMBVPeriod ;
   ENUM_NORMAL_MV SlowMVPeriod ;
  };
struct stctMVStatistics
  {
   ENUM_NORMAL_MV m_nFastPeriod ;
   ENUM_NORMAL_MV m_nSlowPeriod ;
   ENUM_MA_METHOD    m_nFastMethod;
   double            m_fMean;
   double            m_fStd;
   int               m_nBarsCount;
  };
struct stctOptimizationCriterias
  {
   int m_nMonthNext;
   double m_fProfitFactor_Criteria; //This ProfitGross / LossGross
   double m_fNetProfit_Criteria; //This is ProfitGross - LossGross
   double m_fNetProfit_PercentTime_Criteria; //This is (ProfitGross - LossGross)/InitialDeposit
   bool m_bTradeCountLimit_Activate;
   double m_fWinRatio_Criteria;
   bool m_bValidateCriterias_NextMonthes ;
   int m_nValidateCriterias_CalculatedCount ; 
  };

const int trailParamsArray_Size = 18;
stctTrailingCombination trailParams[] = {{ENUM_TRAILINGSTOP_MV,3},{ENUM_TRAILINGSTOP_MV,5},
     {ENUM_TRAILINGSTOP_MV,7},{ENUM_TRAILINGSTOP_MV,9},
     {ENUM_TRAILINGSTOP_MV,21},{ENUM_TRAILINGSTOP_MV,34},

     {ENUM_TRAILINGSTOP_ATR15,7},/*{ATR15,12},*/{ENUM_TRAILINGSTOP_ATR15,13},{ENUM_TRAILINGSTOP_ATR15,21},{ENUM_TRAILINGSTOP_ATR15,26},{ENUM_TRAILINGSTOP_ATR15,30},
   /*{ATR20,7},{ATR20,12},*/{ENUM_TRAILINGSTOP_ATR20,13},{ENUM_TRAILINGSTOP_ATR20,21},{ENUM_TRAILINGSTOP_ATR20,26},
     {ENUM_TRAILINGSTOP_ATR20,30},{ENUM_TRAILINGSTOP_FIXEDPOINT,15},{ENUM_TRAILINGSTOP_FIXEDPOINT,20},
     {ENUM_TRAILINGSTOP_FIXEDPOINT,25}
  };
  
///////////////////////////////////////////////////////////////////
//const int m_nOptimizationCriteria_Count = 2;
stctOptimizationCriterias m_OptimizationCriterias[] = {{8,0.05,-1.0,-1.0,false,-1.0 ,false,0},
                                                       {12,0.1,-1.0,-1.0,false,-1.0 ,false,0}};
//const int    optMvs_Size = 11;
/*
1 : 13,30
2 : 21,30
3 : 13,34
4 : 21,34 ?
5 : 26,34 ?

6 : 13,50 ?

5 : 21,34
6 : 26,34
9 : 21,50
10 : 26,50

Normal Open Distance :
13,34,EMA : 160
09,30,LWMA : 220
09,34,EMA : 190
*/
/*USDJPY
stctOptTstMVCombination optMvs[] = {{ENUM_NORMAL_MV13,ENUM_NORMAL_MV34,MODE_EMA,MODE_SMA,160,80,PREVIOUS_CANDLE},
                                    {ENUM_NORMAL_MV09,ENUM_NORMAL_MV34,MODE_EMA,MODE_SMA,190,80,PREVIOUS_CANDLE}}; //2
*/
/*
stctOptTstMVCombination optMvs[] = {{ENUM_NORMAL_MV21,ENUM_NORMAL_MV50,MODE_EMA,MODE_SMA,180,80,PREVIOUS_CANDLE},
     {ENUM_NORMAL_MV13,ENUM_NORMAL_MV30,MODE_EMA,MODE_SMA,180,80,PREVIOUS_CANDLE},
     {ENUM_NORMAL_MV09,ENUM_NORMAL_MV50,MODE_LWMA,MODE_SMA,340,80,PREVIOUS_CANDLE}
  }; //2
*/
//EURUSD 15
stctOptTstMVCombination optMvs[] = {{ENUM_NORMAL_MV09,ENUM_NORMAL_MV34,MODE_EMA,MODE_SMA,1.5,180,35,PREVIOUS_CANDLE,ENUM_STOPLOSS_BELOW_CUSTOM_MV,21,ENUM_BREAKEVEN_FIXED_N2 , ENUM_TAKEPROFIT_DISABLED , ENUM_OPENORDER_RISKANALYSIS_DLB_BASED , 84 , 6 },
     {ENUM_NORMAL_MV13,ENUM_NORMAL_MV50,MODE_EMA,MODE_SMA,1.5,210,40,PREVIOUS_CANDLE,ENUM_STOPLOSS_BELOW_CUSTOM_MV,21,ENUM_BREAKEVEN_FIXED_50, ENUM_TAKEPROFIT_DISABLED  , ENUM_OPENORDER_RISKANALYSIS_RSI_BASED , 87 , 17 },
     {ENUM_NORMAL_MV09,ENUM_NORMAL_MV34,MODE_LWMA,MODE_SMA,1.5,210,125,PREVIOUS_CANDLE,ENUM_STOPLOSS_BELOW_CUSTOM_MV,21,ENUM_BREAKEVEN_INTELLIGENT, ENUM_TAKEPROFIT_DISABLED , ENUM_OPENORDER_RISKANALYSIS_RSI_BASED , 87 , 17 },
     {ENUM_NORMAL_MV13,ENUM_NORMAL_MV50,MODE_LWMA,MODE_SMA,1.5,240,125,PREVIOUS_CANDLE,ENUM_STOPLOSS_BELOW_CUSTOM_MV,21,ENUM_BREAKEVEN_FIXED_40, ENUM_TAKEPROFIT_DISABLED , ENUM_OPENORDER_RISKANALYSIS_RSI_BASED , 87 , 17 },
     {ENUM_NORMAL_MV13,ENUM_NORMAL_MV34,MODE_EMA,MODE_SMA,1.5,150,65,PREVIOUS_CANDLE,ENUM_STOPLOSS_BELOW_CUSTOM_MV,21,ENUM_BREAKEVEN_INTELLIGENT, ENUM_TAKEPROFIT_DISABLED , ENUM_OPENORDER_RISKANALYSIS_RSI_BASED , 87 , 17 },
  }; //2

stctOptTstMVCombinationV2 optMvsV2[]= {
{10,MODE_LWMA,1.7},

};
const int optBrTrDis_Size = 33;
stctOptTstBrTrDisCombination optBrTrDis[] ;
//const int  optMVPeriods_Size = 31;
stctMVPeriodCombination optMVPeriods[];
stctMVStatistics optMVStatistics[];
/////////////////////////////////////////////////////////////////
TCustomCriterionArray   *criterion_Ptr;
const int MIN_TRADES_COUNT = 50 ;
const double MIN_PROFIT_FACTOR = 1.05;
const double MIN_KELLY_FACTOR  = 0.03;
const int MIN_NET_PROFIT = 20;   // 15 MinTrade & 50000 Balance
//+------------------------------------------------------------------+
//| LoadArray function                                             |
//+------------------------------------------------------------------+
void LoadArrays()
  {
   int nBreakeEvenDis[] = {0,30,50,70, 90, 110, 130};
   int nTrailingStopDis[] = { 60,  80,  100, 120,  140, 160, 180, 200, 220, 240};
//int commonMVPeriods[12] = {8,9,10,12,13,20,21,26,30,34,50,55};
//int commonMVPeriods[] = {9,12,21,26,30,34,50,55}; //simple & fast
   int commonMVPeriods[] = {9,12,13,21,26,30,34,50}; //simple & fast
   int commonMVPeriods_Fast[] = {9,13,21,26,30,34}; //simple & fast
   int commonMVPeriods_Slow[] = {21,26,30,34,50}; //simple & fast
   int nCounter = 0;
   int n1,n2;
//first count
   ArrayResize(optBrTrDis,36,0);
   for(n1 = 0 ; n1 < 6 ; n1++)
     {
      for(n2 = 0 ; n2 < 6 ; n2++)
        {
         if(nBreakeEvenDis[n1] >= nTrailingStopDis[n2])
            continue;
         optBrTrDis[nCounter].BreakeEvenDis = nBreakeEvenDis[n1] ;
         optBrTrDis[nCounter].TrailingDis= nTrailingStopDis[n2] ;
         nCounter++;

        }
     }
   ArrayResize(optBrTrDis,nCounter,0);
   if(!IS_SECURE)
      Print("LoadArrays optBrTrDis Size : ", ArraySize(optBrTrDis)," nCounter = ", nCounter);

   nCounter = 0;
   /*
   ArrayResize(optMVPeriods,ArraySize(commonMVPeriods)*ArraySize(commonMVPeriods),0);
   for ( n1 = 2 ; n1 < ArraySize(commonMVPeriods) ; n1++) {
      for ( n2 = 0 ; n2 < ArraySize(commonMVPeriods) ; n2++) {
         if((commonMVPeriods[n2] >= commonMVPeriods[n1] - 5)  )
            continue;
         optMVPeriods[nCounter].SlowMVPeriod= commonMVPeriods[n1] ;
         optMVPeriods[nCounter].FastMBVPeriod = commonMVPeriods[n2] ;
         nCounter++;
      }
   }
   */
   ArrayResize(optMVPeriods,ArraySize(commonMVPeriods_Fast)*ArraySize(commonMVPeriods_Slow),0);
   for(n1 = 2 ; n1 < ArraySize(commonMVPeriods_Slow) ; n1++)
     {
      for(n2 = 0 ; n2 < ArraySize(commonMVPeriods_Fast) ; n2++)
        {
         if((commonMVPeriods_Fast[n2] >= commonMVPeriods_Slow[n1] - 5 || (commonMVPeriods_Slow[n1]-commonMVPeriods_Fast[n2])>40))
            continue;
         optMVPeriods[nCounter].SlowMVPeriod= (ENUM_NORMAL_MV)commonMVPeriods_Slow[n1] ;
         optMVPeriods[nCounter].FastMBVPeriod = (ENUM_NORMAL_MV)commonMVPeriods_Fast[n2] ;
         nCounter++;
        }
     }

   ArrayResize(optMVPeriods,nCounter,0);
   if(!IS_SECURE)
      Print("LoadArrays optMVPeriods Size : ", ArraySize(optMVPeriods)," nCounter = ", nCounter);


  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void LoadMVStatistics()
  {
   if(m_nOptimizationLevel == ENUM_OPTIMIZATION_STATISTICS)
      return;
   ArrayResize(optMVStatistics,ArraySize(optMVPeriods)*2);
   int nRow=0;
   int filehandle = FileOpen("MV_statistics_"+Symbol()+"_"+IntegerToString(Period())+".txt",FILE_CSV|FILE_READ,",");
   if(filehandle==INVALID_HANDLE)
     {
      if(IS_ENABLE_LOG)
         Print("Failed to open the file by the absolute path ");
      if(IS_ENABLE_LOG)
         Print("Error code ",GetLastError());
     }
   else
     {
      do //loop through each cell
        {
         if(IS_ENABLE_LOG)
            Print("LoadMVStatistics nRow: ", nRow);
          if(nRow>=ArraySize(optMVStatistics))
            break;
         optMVStatistics[nRow].m_nFastPeriod = (ENUM_NORMAL_MV)StringToInteger(FileReadString(filehandle));
         optMVStatistics[nRow].m_nSlowPeriod = (ENUM_NORMAL_MV)StringToInteger(FileReadString(filehandle));
         optMVStatistics[nRow].m_nFastMethod = StringToEnum(FileReadString(filehandle),optMVStatistics[nRow].m_nFastMethod);
         optMVStatistics[nRow].m_fMean = StringToDouble(FileReadString(filehandle));
         optMVStatistics[nRow].m_fStd = StringToDouble(FileReadString(filehandle));
         optMVStatistics[nRow].m_nBarsCount = (int)StringToInteger(FileReadString(filehandle));
         nRow++;

        }
      while(!FileIsEnding(filehandle));
      FileClose(filehandle);

     }
   ArrayResize(optMVStatistics,nRow+1);
   if(IS_ENABLE_LOG)
      Print("LoadMVStatistics "," Load Finished ");

  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int FindMVStatistics()
  {
   if(m_nOptimizationLevel == ENUM_OPTIMIZATION_STATISTICS)
      return -1;
   for(int n=0; n<ArraySize(optMVStatistics); n++)
     {
      if(IS_ENABLE_LOG)
         Print("FindMVStatistics ", optMVStatistics[n].m_nSlowPeriod, " ", optMVStatistics[n].m_nFastPeriod, " ", optMVStatistics[n].m_nFastMethod);
      if(optMVStatistics[n].m_nSlowPeriod == SlowMVPeriod && optMVStatistics[n].m_nFastPeriod == FastMVPeriod && optMVStatistics[n].m_nFastMethod == FastMVType)
        {
         return n;
        }
     }
   return -1;
  }
//+------------------------------------------------------------------+
//| if 6 month Trade and low Trade Count or NetProfit negative , leave it                                                                  |
//+------------------------------------------------------------------+
bool ValidateCriterias(string strSymbol , int nTimeFrame,int nCriteria , datetime dt_FirstCrossOccurred, CAllTradesStatistic& oAllTradesStatistics)
  {
   if(m_OptimizationCriterias[nCriteria].m_nValidateCriterias_CalculatedCount>0 && m_nIsDoneValidatoin_DuringTesting == ENUM_VALIDATION_FULL)
      return m_OptimizationCriterias[nCriteria].m_bValidateCriterias_NextMonthes;
   int nMonthLast = m_OptimizationCriterias[nCriteria].m_nMonthNext;
   
   int nDays = GetDaysElapsed(dt_FirstCrossOccurred);
   nDays -= (SlowMVPeriod * nTimeFrame)/(24*60);
   if(nDays < 31*nMonthLast)
      return true;

   CAllTradesStatistic *poAllTradesStatistics = GetPointer(oAllTradesStatistics);
   poAllTradesStatistics.CalcStatistics(ENUM_ORDERS_INVESTIGATE_ALL);

   int nMinimumTradesCount = (int)MathRound(nDays/20); //2. Prev 20 //1. Prev Standard 12
   //Print("ValidateCriterias dtExpert_TimeInit " , dt_FirstCrossOccurred , " nDays: " , nDays , " nMinTradesCount:  " , nMinimumTradesCount , " nTradeCount: " , poAllTradesStatistics.m_nTradeCount);
   //at least each 4 days one Trade Done
   //int nTotalTrade = (int)TesterStatistics(STAT_TRADES);
   //double fNetProfit = TesterStatistics(STAT_PROFIT);
   double fNetProfit_PercentTime_Criteria = m_OptimizationCriterias[nCriteria].m_fNetProfit_PercentTime_Criteria;
   int nBarsCount = iBars(strSymbol , nTimeFrame);
   int nTotalBarsCount = 0;
   int nMVStIndex = FindMVStatistics();
   double fRatioLast = 0.f;
   double fSuitableNetProfit_PercentTime_Criteria = -1.0;
   double fNetProfit_PercentTime = 0.f;

   if(nMVStIndex>-1 && fNetProfit_PercentTime_Criteria>-1)
   {
     nTotalBarsCount = optMVStatistics[nMVStIndex].m_nBarsCount;
     fRatioLast = (double)  nBarsCount / nTotalBarsCount ;
     fSuitableNetProfit_PercentTime_Criteria = ( fNetProfit_PercentTime_Criteria ) * fRatioLast;
     fNetProfit_PercentTime = poAllTradesStatistics.m_fNetProfit / poAllTradesStatistics.m_fInitialDeposit;
     
   }
   if(poAllTradesStatistics.m_nTradeCount < nMinimumTradesCount && m_OptimizationCriterias[nCriteria].m_bTradeCountLimit_Activate)
   {
      m_OptimizationCriterias[nCriteria].m_bValidateCriterias_NextMonthes = false;
      //Print("ValidateCriterias !!!return false!!! nTotalTrade: " , poAllTradesStatistics.m_nTradeCount , " nMinimumTradesCount : " , nMinimumTradesCount , " Days: " , nDays);
   }
   else if(m_OptimizationCriterias[nCriteria].m_fProfitFactor_Criteria > 0 && poAllTradesStatistics.m_fProfitFactor < m_OptimizationCriterias[nCriteria].m_fProfitFactor_Criteria)
   {
      m_OptimizationCriterias[nCriteria].m_bValidateCriterias_NextMonthes = false;
      Print("ValidateCriterias false (ProfitFactor)!!! ProfitFactor: " , poAllTradesStatistics.m_fProfitFactor);
   }
   else if(fSuitableNetProfit_PercentTime_Criteria > -1 && fNetProfit_PercentTime < fSuitableNetProfit_PercentTime_Criteria)
   {
      m_OptimizationCriterias[nCriteria].m_bValidateCriterias_NextMonthes = false;
      Print("ValidateCriterias false!!! fNetProfit_PercentTime: " , fNetProfit_PercentTime, " fSuitableNetProfit_PercentTime_Criteria " , fSuitableNetProfit_PercentTime_Criteria , " fRatioLast " , fRatioLast );
      Print("ValidateCriterias false!!!: TradesNetProfit : " , poAllTradesStatistics.m_fNetProfit, " fSuitableNetProfit_PercentTime_Criteria " , fSuitableNetProfit_PercentTime_Criteria , " fRatioLast " , fRatioLast );
   }
   else if(m_OptimizationCriterias[nCriteria].m_fWinRatio_Criteria > 0 && poAllTradesStatistics.m_fWinRatio < m_OptimizationCriterias[nCriteria].m_fWinRatio_Criteria)
   {
      m_OptimizationCriterias[nCriteria].m_bValidateCriterias_NextMonthes = false;
      Print("ValidateCriterias false!!! fWinRatio: " , poAllTradesStatistics.m_fWinRatio , " m_OptimizationCriterias[nCriteria].m_fWinRatio_Criteria " , m_OptimizationCriterias[nCriteria].m_fWinRatio_Criteria );
   }
   else if(m_OptimizationCriterias[nCriteria].m_fNetProfit_Criteria > 0 && poAllTradesStatistics.m_fNetProfit < m_OptimizationCriterias[nCriteria].m_fNetProfit_Criteria)
   {
      m_OptimizationCriterias[nCriteria].m_bValidateCriterias_NextMonthes = false;
      Print("ValidateCriterias false!!! fNetProfit: " , poAllTradesStatistics.m_fNetProfit , " fNetProfit_Criteria " , m_OptimizationCriterias[nCriteria].m_fNetProfit_Criteria , " fRatioLast " , fRatioLast );
   }
   else 
   {
      ///Print("ValidateCriterias true!!! fProfitFactor: " , poAllTradesStatistics.m_fProfitFactor , " fSuitableNetProfit_PercentTime_Criteria : " , fSuitableNetProfit_PercentTime_Criteria , " fRatioLast " , fRatioLast );
      m_OptimizationCriterias[nCriteria].m_bValidateCriterias_NextMonthes = true;
   }
   m_OptimizationCriterias[nCriteria].m_nValidateCriterias_CalculatedCount++;
   return m_OptimizationCriterias[nCriteria].m_bValidateCriterias_NextMonthes;
  }
//+------------------------------------------------------------------+
