//+------------------------------------------------------------------+
//|                                        EA_MA_TradeManagement.mqh |
//|                                                   Majid Namnabat |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Majid Namnabat"
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict

#include <MD_V_LAST\\EA_MD_UtilityFunctions.mqh>
#include <MD_V_LAST\\EA_MD_Types.mqh>
#include <MD_V_LAST\\EA_MD_IndicatorsInterface.mqh>
#include <MD_V_LAST\\EA_MD_LiveOrderManagement.mqh>
#include <MD_V_LAST\\EA_MD_LadderTradeManagement.mqh>
#include <MD_V_LAST\\EA_MD_ChartCharacteristics.mqh>

enum ENUM_ORDER_STATE  // Enumeration of named constants
  {
   ENUM_ORDER_ZERO=1,
   ENUM_ORDER_BUY=2,
   ENUM_ORDER_SELL=3,
   ENUM_ORDER_BUY_PENDING = 4,
   ENUM_ORDER_SELL_PENDING = 5,
   ENUM_ORDER_UNKNOWN = 0//,
//ENUM_ORDER_NOTALLOWED_LOCK = 5
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class EA_MA_TradeManagement
  {
private:
   string            m_strSymbol;
   int               m_nTimeFrame;
   double            m_fPOINT;
   bool              m_bOpenOrder_Allow;

public:
   CLadderTradeManagement  m_oLadderTradeManager;
   CAllTradesStatistic  m_oTradesStatistics;
   CIndicatorsInterface m_oIndicatorsInterface;

   ChartCharacteristics m_oChartCharacter;
   CLiveOrderManagement  m_oLiveOrderManager;
public:
   void              Prohibit_OpenOrder() {m_bOpenOrder_Allow = false;}
   void              Allow_OpenOrder() {m_bOpenOrder_Allow = true;}
   bool              Is_OpenOrder_Allow() {return m_bOpenOrder_Allow;}

                     EA_MA_TradeManagement();
                    ~EA_MA_TradeManagement();

   int               DetermineOrderState(ENUM_ORDERS_INVESTIGATE_STATE nInvestigateState);
   bool              IsMustNowRest_CauseBigLoss(int nRestHours, double fBalanceRiskVolume,double fLoss_RiskBalance_Ratio_Rest);

   bool              TimeManager_AllowOpen(ENUM_TIME_TRADE_MANAGEMENT nTimeTradeSetting);
   bool              TimeManager_MustCloseOrder(ENUM_TIME_TRADE_MANAGEMENT nTimeTradeSetting);
   bool              CheckPending_Activated();

   void              Setup(string strSymbol, int nTimeFrame,
                           ENUM_NORMAL_MV nFastMVPeriod, ENUM_MA_METHOD nFastMVType,
                           ENUM_NORMAL_MV nSlowMVPeriod, ENUM_MA_METHOD nSlowMVType,
                           ENUM_CUSTOM_APPLIED_PRICE nActiveCloseOrderCurrentCandle,
                           datetime dtExpert_TimeInit);
   void              OpenInitOrder(int nCommand);
   bool              MustOpenOrder(int& nCommand, bool isCandleTick, bool isNewBar,bool isForex, int nHigherPeriod, int nLowerPeriod, bool isHigherPeriodNewBar);
   void              ExistingOrdersManagement(ENUM_ORDERS_INVESTIGATE_STATE nInvestigateMethod, bool isCandleTick);
   bool              IsMustRest_CauseBigLoss();
   bool              DetermineOpenAllowance(int nOrderState);
   bool              CheckAngle_Stop(int nCommand, double fSL_Origin);
   bool              CheckAngle_Order(int nCommand, double fOpenPrice);

  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
EA_MA_TradeManagement::EA_MA_TradeManagement()
  {
   m_bOpenOrder_Allow = true;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
EA_MA_TradeManagement::~EA_MA_TradeManagement()
  {
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void EA_MA_TradeManagement::Setup(string strSymbol, int nTimeFrame,
                                  ENUM_NORMAL_MV nFastMVPeriod, ENUM_MA_METHOD nFastMVType,
                                  ENUM_NORMAL_MV nSlowMVPeriod, ENUM_MA_METHOD nSlowMVType,
                                  ENUM_CUSTOM_APPLIED_PRICE nActiveCloseOrderCurrentCandle, datetime dtExpert_TimeInit)
  {
   if(strSymbol!=m_strSymbol || nTimeFrame!=m_nTimeFrame || m_strSymbol=="")
     {
      m_oLadderTradeManager.ResetHistory();
     }
   m_strSymbol = strSymbol;
   m_nTimeFrame = nTimeFrame;
   m_fPOINT = SymbolInfoDouble(m_strSymbol,SYMBOL_POINT);
//m_nOrderState = ENUM_ORDER_UNKNOWN;
   m_bOpenOrder_Allow = true;
   m_oIndicatorsInterface.Setup(m_strSymbol,m_nTimeFrame,
                                nFastMVPeriod,nFastMVType,
                                nSlowMVPeriod,nSlowMVType,
                                nActiveCloseOrderCurrentCandle);
   m_oLadderTradeManager.Setup(m_oChartCharacter,m_oIndicatorsInterface,m_strSymbol,m_nTimeFrame);
   m_oLiveOrderManager.Setup(m_oTradesStatistics,m_oIndicatorsInterface,m_oLadderTradeManager,m_strSymbol,m_nTimeFrame);
   m_oChartCharacter.Setup(m_strSymbol,m_nTimeFrame,m_oIndicatorsInterface);
   double isAnalyseShortTermTrades = (ActiveBreakEvenDistance == ENUM_BREAKEVEN_INTELLIGENT);
   m_oTradesStatistics.Insert_Symbol_TF(m_strSymbol,m_nTimeFrame, isAnalyseShortTermTrades,dtExpert_TimeInit);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int EA_MA_TradeManagement::DetermineOrderState(ENUM_ORDERS_INVESTIGATE_STATE nInvestigateState)
  {
   int nSell=0,nBuy=0,nPendingSell=0,nPendingBuy=0,nTotalMarketOrder;
   string strSymbol = (nInvestigateState == ENUM_ORDERS_INVESTIGATE_ALL) ? "" : m_strSymbol;
   nTotalMarketOrder = SpecialOrdersTotal(strSymbol,MACROSS_MAGIC_NUM,nBuy,nSell,nPendingBuy,nPendingSell);
   int nOrderState = ENUM_ORDER_UNKNOWN;
   nOrderState = (nTotalMarketOrder == 0 && nPendingBuy == 0 && nPendingSell == 0) ? SetBit(nOrderState,ENUM_ORDER_ZERO) : nOrderState;

   nOrderState |= (nSell > 0 && nBuy == 0) ? SetBit(nOrderState,ENUM_ORDER_SELL) : nOrderState;
   nOrderState |= (nSell == 0 && nBuy > 0) ? SetBit(nOrderState,ENUM_ORDER_BUY) : nOrderState;

   nOrderState |= (nSell == 0 && nBuy == 0 && nPendingBuy > 0) ? SetBit(nOrderState,ENUM_ORDER_BUY_PENDING) : nOrderState;
   nOrderState |= (nSell == 0 && nBuy == 0 && nPendingSell > 0) ? SetBit(nOrderState,ENUM_ORDER_SELL_PENDING) : nOrderState;
//if(IS_ENABLE_LOG) Print("EATradeManager::DetermineOrderState  "  , nOrderState , " " );
   return nOrderState;


  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool              EA_MA_TradeManagement::IsMustNowRest_CauseBigLoss(int nRestHours, double fBalanceRiskVolume,double fLoss_RiskBalance_Ratio_Rest)
  {
   datetime dtLastOrderCloseTime = 0 ;
   double fProfit = GetProfits(m_strSymbol,  MACROSS_MAGIC_NUM, 1,dtLastOrderCloseTime);
   if(fProfit >= 0)
     {
      return false;
     }
//double fInitialDeposit = AccountInfoDouble(ACCOUNT_BALANCE)- AccountInfoDouble(ACCOUNT_PROFIT);
//double fInitialDeposit = TesterStatistics(STAT_INITIAL_DEPOSIT) ; //GetInitialDeposit();
//if(IS_ENABLE_LOG) Print("IsMustNowRest_CauseBigLoss fInitialDeposit " , fInitialDeposit );
//10% of Initial Balance
//if( fProfit < 0 && MathAbs(fProfit) > (0.1 * fInitialDeposit ) )
//2.5% of Balance
   if(fProfit < 0 && MathAbs(fProfit) > ((fBalanceRiskVolume) * AccountInfoDouble(ACCOUNT_BALANCE)) && 0)
     {
      int nDuration =(int)((TimeCurrent() - dtLastOrderCloseTime) / 3600) ;      // in hour
      if(nDuration < nRestHours)
        {
         /*if(nDuration < 1)
            if(IS_ENABLE_LOG) Print("In Rest_CauseBigLost");
          */
         return true;
        }
     }
   else
     {
      double fProfit3Last = GetProfits(m_strSymbol,  MACROSS_MAGIC_NUM,3,dtLastOrderCloseTime);
      if(fProfit < 0 && fProfit3Last< 0 && MathAbs(fProfit3Last) > ((fLoss_RiskBalance_Ratio_Rest*fBalanceRiskVolume) * AccountInfoDouble(ACCOUNT_BALANCE)))
        {
         int nDuration =(int)((TimeCurrent() - dtLastOrderCloseTime) / 3600) ;      // in hour
         if(nDuration < nRestHours)
           {
            /*
            if(nDuration < 1)
               if(IS_ENABLE_LOG) Print("In Rest_CauseBigLost");
            */
            return true;
           }
        }
     }
   return false;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool              EA_MA_TradeManagement::TimeManager_AllowOpen(ENUM_TIME_TRADE_MANAGEMENT nTimeTradeSetting)
  {
   if(DayOfWeek() != 0 && DayOfWeek() != 6 && DayOfWeek() != 5)  // 5 is Friday
      return true;
   switch(nTimeTradeSetting)
     {
      case ENUM_TIME_TRADE_FRIDAY_ALL_NOT_OPEN :
      case ENUM_TIME_TRADE_HOLIDAY_OFFSET_FRIDAY_NOT_OPEN:
         return false;
         break;
      case ENUM_TIME_TRADE_FRIDAY_AFTERNOON_NOT_OPEN:
      case ENUM_TIME_TRADE_HOLIDAY_OFFSET_FRIDAY_AFTERNOON_NOT_OPEN:
         if(DayOfWeek() == 5 && Hour() > 15)
           {
            //if(IS_ENABLE_LOG) Print("TimeManager_AllowOpen : Return False");

            return false;
           }
         if(DayOfWeek() == 0 || DayOfWeek() == 6)
           {
            return false;
           }
         break;

     }
   return true;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool         EA_MA_TradeManagement::TimeManager_MustCloseOrder(ENUM_TIME_TRADE_MANAGEMENT nTimeTradeSetting)
  {

   switch(nTimeTradeSetting)
     {
      case ENUM_TIME_TRADE_HOLIDAY_OFFSET_FRIDAY_AFTERNOON_NOT_OPEN:
      case ENUM_TIME_TRADE_HOLIDAY_OFFSET_FRIDAY_NOT_OPEN:
         //if(IS_ENABLE_LOG) Print("TimeManager_MustCloseOrder ",DayOfWeek(),Hour());

         if(DayOfWeek() == 5 && Hour() == 23 && Minute() > 30) // پنجشنبه ساعت 11.5 شب
           {
            //if(IS_ENABLE_LOG) Print("TimeManager_MustCloseOrder : Return True");
            return true;
           }
         else
            return false;
         break;
     }
   return false;
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool   EA_MA_TradeManagement::CheckPending_Activated()
  {
   if(m_oLadderTradeManager.m_oTradeHistory.m_fInitialLots > 0.000001)
      return true;

   if(OrderSelect(m_oLadderTradeManager.m_oTradeHistory.m_nInitOrder_Ticket, SELECT_BY_TICKET, MODE_TRADES) == false)
     {
      if(IS_ENABLE_LOG)
         Print("ERROR - Unable to select the order - ",GetLastError());
      return false;
     }
//it is activated
   if(OrderType()== OP_BUY || OrderType()== OP_SELL)
     {
      m_oLadderTradeManager.m_oTradeHistory.m_fInitialLots = OrderLots();
      /*m_nOrderState = (OrderType()== OP_BUY) ? ENUM_ORDER_BUY : m_nOrderState;
      m_nOrderState = (OrderType()== OP_SELL) ? ENUM_ORDER_SELL : m_nOrderState;*/
      return true;
     }
   return false;
  }

//+------------------------------------------------------------------+
void EA_MA_TradeManagement::OpenInitOrder(int nCommand)
  {
   bool bActPending = false;
   RefreshRates();
   double fOpenPrice=0.f;
   double fSLPrice=0.f;
   double fTPPrice=0.f;
   int nCoef = 1 ;
   ENUM_HT_CLOSEPRICE_STATUS nHFTrendResult = ENUM_HT_STATUS_UNKNOWN;
   int nSLDistance_InPip = 0 ;
   double fPendingOrderOpenPrice = 0.f;
   double fAsk = SymbolInfoDouble(m_strSymbol,SYMBOL_ASK); // Best Buy Offer
   double fBid = SymbolInfoDouble(m_strSymbol,SYMBOL_BID); // Best Buy Offer

   double fMarkPrice = nCommand==OP_BUY ? fAsk : fBid;
   double fSLPrice_Origin = 0.f;
   ENUM_TRACK_ORDER_TRADE nTrackOrderTrade =  ENUM_TRACK_ORDER_INIT;
   nCoef = nCommand==OP_BUY ? 1 : -1;
// in roboforex test , one trade one candle after cause call margin ,
//Not acceptable never , so stoploss must set always when order init
   fSLPrice= m_oLiveOrderManager.DetermineStopLossValue(nCommand, fMarkPrice,fSLPrice_Origin);
   nSLDistance_InPip = fSLPrice > 0.000001 ? (int) MathRound((MathAbs(fMarkPrice - fSLPrice_Origin) / m_fPOINT)) : 999999 ;
   if(IS_ENABLE_LOG)
      Print("OpenInitOrder nSLDistance_InPip : ", nSLDistance_InPip, " SLPrice: ", fSLPrice, " SLPriceOrigin: ", fSLPrice_Origin, " MarkPrice: ", fMarkPrice);
   switch(m_nInitOrderSetRule)
     {
      case ENUM_INITORDER_SET_ALLSPOT :
         bActPending = false;
         break;
      case ENUM_INITORDER_SET_STOPDISTANCE_ADJUSTMENT :
         fPendingOrderOpenPrice = m_oIndicatorsInterface.m_oMVCrossDis.GetMovingAverageFastValue() + nCoef * 0 * MVsMinOpenDistance * m_fPOINT;
         if(fPendingOrderOpenPrice >= fMarkPrice && nCommand==OP_BUY)
            bActPending = false;
         if(fPendingOrderOpenPrice <= fMarkPrice && nCommand==OP_SELL)
            bActPending = false;
         //Experience Amazing In RoboForex XAUUSD AS Underestanding , More Distance From Slow MV
         //( more distance from StopLoss) is more profitable )
         if(nSLDistance_InPip < 1.5 * MVsMinOpenDistance)
            bActPending = true;
         else
            bActPending = false;
         break;
      case ENUM_INITORDER_SET_HFTREND_ADJUSTMENT :

         nHFTrendResult = (ENUM_HT_CLOSEPRICE_STATUS) m_oIndicatorsInterface.Get_HalfTrend_Buf(0,2, 2, false, false);
         if(nCommand == OP_BUY && nHFTrendResult == ENUM_HT_BULLISH_OUT_UPCHANNEL)
           {
            bActPending = true;
            fPendingOrderOpenPrice = fMarkPrice - nCoef * 10 * m_fPOINT;
           }
         else
            if(nCommand == OP_SELL && nHFTrendResult == ENUM_HT_BEARISH_OUT_DOWNCHANNEL)
              {
               bActPending = true;
               fPendingOrderOpenPrice = fMarkPrice - nCoef * 10 * m_fPOINT;
              }
            else
               bActPending = false;
         break;
      case ENUM_INITORDER_SET_ALLPENDING :
         bActPending = true;
         fPendingOrderOpenPrice = fMarkPrice - nCoef * 3 * m_fPOINT;
         break;
     }
   if(!bActPending)
     {
      fOpenPrice = fMarkPrice;
     }
   else
     {
      fOpenPrice = NormalizePrice(fPendingOrderOpenPrice,NULL);
      fSLPrice= m_oLiveOrderManager.DetermineStopLossValue(nCommand, fOpenPrice,fSLPrice_Origin);
      nSLDistance_InPip = fSLPrice > 0.000001 ? (int) MathRound((MathAbs(fOpenPrice - fSLPrice_Origin) / m_fPOINT)) : 999999 ;
      if(nCommand == OP_BUY)
         nCommand = OP_BUYLIMIT;
      else
         if(nCommand == OP_SELL)
            nCommand = OP_SELLLIMIT;
      nTrackOrderTrade = ENUM_TRACK_ORDER_INIT_PENDING;
     }
   fTPPrice=ManualTakeProfit != 0 ? (fOpenPrice + nCoef * ManualTakeProfit*m_fPOINT) : fTPPrice ;
   double fLots = m_oLiveOrderManager.OrderLotDetermine_SL_Risk_Base(nSLDistance_InPip,fOpenPrice);
   if(fLots < 0.0001)
      return;
   if(fSLPrice_Origin==0.f)
     {
      Print("OpenInitOrder fSLPrice_Origin==0.f Err!!!", fSLPrice_Origin);
     }
   if(CheckAngle_Order(nCommand,fOpenPrice) && CheckAngle_Stop(nCommand,fSLPrice_Origin))
     {
      int nTicket = COrdersManagement::OpenOrder(m_strSymbol,MACROSS_MAGIC_NUM, nCommand, fOpenPrice, fLots, fSLPrice, fTPPrice,DoubleToStr(fSLPrice_Origin)) ;

      if(nTicket>0)
        {
         m_oLadderTradeManager.ChangeHistory(nTrackOrderTrade, fLots, fOpenPrice, nTicket, TimeCurrent());
         m_oTradesStatistics.OrderOpened(m_strSymbol,m_nTimeFrame,nCommand, nTicket,fLots,fOpenPrice, TimeCurrent(),
                                         m_oIndicatorsInterface.m_oMVCrossDis.GetMovingAverageFastValue(),
                                         m_oIndicatorsInterface.m_oMVCrossDis.GetMovingAverageSlowValue(),
                                         nSLDistance_InPip);
        }
     }
     else
     {
      Print("CheckAngle Not Allows");
      Prohibit_OpenOrder();
     }
   /*
   double PipValue = MarketInfo(m_strSymbol, MODE_TICKVALUE); // Pip Value in the deposit currency
   double PipSize = MarketInfo(m_strSymbol, MODE_TICKSIZE); // Pip Size in the quote currency
   */

  }
//+------------------------------------------------------------------+
bool              EA_MA_TradeManagement::MustOpenOrder(int& nCommand, bool isCandleTick, bool isNewBar,bool isForex, int nHigherPeriod, int nLowerPeriod, bool isHigherPeriodNewBar)
  {
   bool bIsMVPriceStateSuitable_Buy = false, bIsMVPriceStateSuitable_Sell =false   ;
   ENUM_WAVE_TREND nTrendDirection = ENUM_TREND_UNKNOWN ;
   int nOrderState = DetermineOrderState(ENUM_ORDERS_INVESTIGATE_ALL);
   if(isCandleTick && (m_nIs_ExitSignal_NonMVMethod == ENUM_EXITSIGNAL_NONMV_METHOD_CANDLESTICK_AND_DIVERGENCE ||
                       m_nIs_ExitSignal_NonMVMethod == ENUM_EXITSIGNAL_NONMV_METHOD_ONLY_DIVERGENCE ||
                       m_nIs_ExitSignal_NonMVMethod == ENUM_EXITSIGNAL_NONMV_METHOD_DIVERGENCE_SATURATION))
     {

      m_oChartCharacter.Determine_CandleStick(isForex);
      m_oChartCharacter.Determine_MACD_Divergene(nHigherPeriod,nLowerPeriod,isHigherPeriodNewBar);

     }
   if(IsBitOn(nOrderState, ENUM_ORDER_ZERO) && isNewBar)
     {
      switch(OrderAsTrend)
        {
         case ENUM_TREND_GOLDENCROSS :
            nTrendDirection = m_oIndicatorsInterface.GoldenDeathCrossStatus(0);
            break;
         case ENUM_TREND_GOLDENCROSS_HIGHER :
            nTrendDirection = m_oIndicatorsInterface.GoldenDeathCrossStatus(nHigherPeriod);
            break;
         case ENUM_TREND_HIGHER_TIMEFRAME :
            nTrendDirection = m_oIndicatorsInterface.HigherTimeFrameTrendDetermine(nHigherPeriod);
            break;
         case ENUM_TREND_WEEKLY_CANDLE:
            nTrendDirection = m_oIndicatorsInterface.WeeklyTrendDetermine();
            break;
         case ENUM_TREND_DETERMINE_NONE:
            nTrendDirection = ENUM_TREND_UNKNOWN;
            break;
        }
      double fAsk = SymbolInfoDouble(m_strSymbol,SYMBOL_ASK); // Best Buy Offer
      double fBid = SymbolInfoDouble(m_strSymbol,SYMBOL_BID); // Best Buy Offer

      bIsMVPriceStateSuitable_Buy = (m_oChartCharacter.m_nMVStates == ENUM_MV_CROSSOVER &&
                                     m_oIndicatorsInterface.m_oMVCrossDis.GetIsCrossOccurred() &&
                                     m_oIndicatorsInterface.m_oMVCrossDis.GetMVDistanceInPoint() > 0 &&
                                     m_oIndicatorsInterface.m_oMVCrossDis.GetMVDistanceInPoint() > MVsMinOpenDistance &&
                                     fAsk >= m_oIndicatorsInterface.m_oMVCrossDis.GetMovingAverageSlowValue());

      bIsMVPriceStateSuitable_Sell = (
                                        m_oChartCharacter.m_nMVStates == ENUM_MV_CROSSOVER &&
                                        m_oIndicatorsInterface.m_oMVCrossDis.GetIsCrossOccurred() &&
                                        m_oIndicatorsInterface.m_oMVCrossDis.GetMVDistanceInPoint() < 0 &&
                                        MathAbs(m_oIndicatorsInterface.m_oMVCrossDis.GetMVDistanceInPoint()) > MVsMinOpenDistance &&
                                        fBid <= m_oIndicatorsInterface.m_oMVCrossDis.GetMovingAverageFastValue());
      //Print ("MustOpenOrder : Symbol : ", m_strSymbol , " isNewBar , bIsMVPriceStateSuitable_Buy : " , bIsMVPriceStateSuitable_Buy , " bIsMVPriceStateSuitable_Sell : " ,bIsMVPriceStateSuitable_Sell , " MVDistance : " , m_oIndicatorsInterface.m_oMVCrossDis.GetMVDistanceInPoint());
      if(bIsMVPriceStateSuitable_Buy || bIsMVPriceStateSuitable_Sell)
        {
         m_oChartCharacter.m_nMVStates = ENUM_MV_DISTANCE_SUITABLE_OPEN;
         if(IS_ENABLE_LOG)
            Print(" ENUM_MV_DISTANCE_SUITABLE_OPEN Symbol : ", m_strSymbol, " OrderAsTrend : ", EnumToString(OrderAsTrend), " TrendDirection :  ", EnumToString(nTrendDirection));
         switch(nTrendDirection)
           {
            case ENUM_TREND_BULLISH:
               if(m_oIndicatorsInterface.m_oMVCrossDis.GetMVDistanceInPoint() < 0 && m_oChartCharacter.m_nMVStates == ENUM_MV_DISTANCE_SUITABLE_OPEN) //CrossDown
                 {
                  Prohibit_OpenOrder();
                  if(IS_ENABLE_LOG)
                     Print("Decision Make Prohibit_OpenOrder");
                 }
               break;
            case ENUM_TREND_BEARISH:
               if(m_oIndicatorsInterface.m_oMVCrossDis.GetMVDistanceInPoint() > 0 && m_oChartCharacter.m_nMVStates == ENUM_MV_DISTANCE_SUITABLE_OPEN) //CrossUp
                 {
                  Prohibit_OpenOrder();
                  //if(IS_ENABLE_LOG)
                  Print("Decision Make Prohibit_OpenOrder");
                 }
               break;
            case ENUM_TREND_NEURAL:
               Prohibit_OpenOrder();
               //if(IS_ENABLE_LOG) Print("Decision Make Prohibit_OpenOrder");
               break;
           }

        }
     }
   bool bFullCloseCondition = false;
   if(IsBitOn(nOrderState,ENUM_ORDER_ZERO))
     {

      if(bIsMVPriceStateSuitable_Buy &&
         Is_OpenOrder_Allow() &&
         m_oIndicatorsInterface.m_oMVCrossDis.GetCurrentCandle_MVTrend() == ENUM_TREND_BULLISH)
        {
         //میخواهم در پولبک ها به خطوط میانگین آنها را گیر بیندازم
         // بنظرم اشتباه است، روندهای پرسرعت را نمی گیرد و این بد هست
         // در روندهای پرسرعت اصلا فیدبکی صورت نمی گیرد
         ENUM_RISK_DEGREE nRiskDegree = m_oChartCharacter.OpenOrder_RiskAnalysis(OP_BUY,m_nOpenOrder_RiskAnalysis);
         if(IS_ENABLE_LOG)
            Print("OpenNewOrder-Buy MVDistancePoint = ",m_oIndicatorsInterface.m_oMVCrossDis.GetMVDistanceInPoint(), " Risk : ", EnumToString(nRiskDegree));
         if(nRiskDegree != ENUM_RISK_HIGH && nRiskDegree != ENUM_RISK_VERY_HIGH)
           {
            nCommand = OP_BUY;
            return true;
           }
        }
      if(bIsMVPriceStateSuitable_Sell &&
         Is_OpenOrder_Allow() &&
         m_oIndicatorsInterface.m_oMVCrossDis.GetCurrentCandle_MVTrend() == ENUM_TREND_BEARISH)
        {
         ENUM_RISK_DEGREE nRiskDegree = m_oChartCharacter.OpenOrder_RiskAnalysis(OP_SELL,m_nOpenOrder_RiskAnalysis);
         if(IS_ENABLE_LOG)
            Print("OpenNewOrder - Sell MVDistancePoint = ",m_oIndicatorsInterface.m_oMVCrossDis.GetMVDistanceInPoint(), "Risk : ", EnumToString(nRiskDegree));
         if(nRiskDegree != ENUM_RISK_HIGH && nRiskDegree != ENUM_RISK_VERY_HIGH)
           {
            nCommand = OP_SELL;
            return true;
           }
        }
     }
   return false;
  }
//+------------------------------------------------------------------+
void              EA_MA_TradeManagement::ExistingOrdersManagement(ENUM_ORDERS_INVESTIGATE_STATE nInvestigateMethod, bool isCandleTick)
  {
   int nCommand = OP_BUY;
   int nOrderState = DetermineOrderState(ENUM_ORDERS_INVESTIGATE_SYMBOL_ONLY);
   if(IsBitOn(nOrderState,ENUM_ORDER_ZERO))
      return;
   if(TimeManager_MustCloseOrder(m_nTimeTradeManager))
     {
      COrdersManagement::RemoveAllPendings(m_strSymbol,MACROSS_MAGIC_NUM);
      if(IsBitOn(nOrderState, ENUM_ORDER_BUY) ||
         IsBitOn(nOrderState, ENUM_ORDER_SELL))
        {
         if(IS_ENABLE_LOG)
            Print("TimeManager_MustCloseOrder   return  TRUE ");
         m_oLiveOrderManager.CloseInitOrders(IsBitOn(nOrderState, ENUM_ORDER_BUY) ?  OP_BUY : OP_SELL);
        }
      return;
     }

   bool bFullCloseCondition = false;
   if(IsBitOn(nOrderState,ENUM_ORDER_BUY))
     {

      nCommand = OP_BUY ;
      bFullCloseCondition = (m_oIndicatorsInterface.m_oMVCrossDis.GetMVDistanceInPoint() >= 0 && m_oIndicatorsInterface.m_oMVCrossDis.GetMVDistanceInPoint() <= MVsMaxCloseDistance) || (m_oIndicatorsInterface.m_oMVCrossDis.GetMVDistanceInPoint() < 0);
     }
   else
      if(IsBitOn(nOrderState,ENUM_ORDER_SELL))
        {
         nCommand = OP_SELL ;
         bFullCloseCondition = (m_oIndicatorsInterface.m_oMVCrossDis.GetMVDistanceInPoint() <= 0 &&    MathAbs(m_oIndicatorsInterface.m_oMVCrossDis.GetMVDistanceInPoint()) <=  MVsMaxCloseDistance) || (m_oIndicatorsInterface.m_oMVCrossDis.GetMVDistanceInPoint() > 0);
        }
   if(bFullCloseCondition)
     {
      m_oChartCharacter.m_nMVStates = ENUM_MV_DISTANCE_SUITABLE_CLOSE;
      if(IS_ENABLE_LOG)
         Print("CloseOrder-Buy MVDistancePoint = ",m_oIndicatorsInterface.m_oMVCrossDis.GetMVDistanceInPoint());
      m_oLiveOrderManager.CloseInitOrders(nCommand);
      return;
     }
   else
     {
      if(isCandleTick)
        {

         if(m_nIs_ExitSignal_NonMVMethod != ENUM_EXITSIGNAL_NONMV_METHOD_DISABLE  && m_oLadderTradeManager.IsExitPoint_NonMVMethod(nCommand))
           {
            if(IS_ENABLE_LOG)
               Print("m_nIs_ExitSignal_NonMVMethod != ENUM_EXITSIGNAL_NONMV_METHOD_DISABLE ");
            ENUM_ORDER_SIZE nRatio = ENUM_ORDER_SIZE_STEP;
            if(m_nActiveStairTradingManagement == ENUM_STAIRTRADING_MANAGEMENT_NONE)
               m_oLiveOrderManager.CloseInitOrders(nCommand);
            else
              {
               if(m_oLadderTradeManager.ExitSignals_Decision(nRatio))
                 {
                  switch(nRatio)
                    {
                     case ENUM_ORDER_SIZE_FULL :
                        if(IS_ENABLE_LOG)
                           Print("ExitSignals_Decision Return Full");
                        m_oLiveOrderManager.CloseInitOrders(nCommand);
                        break;
                     case ENUM_ORDER_SIZE_STEP :
                        //Print ("ExitSignals_Decision Return ENUM_ORDER_SIZE_STEP");
                        if(m_oLadderTradeManager.Allow_StepTrade())
                           m_oLiveOrderManager.CloseStepOrder(nCommand);
                        break;
                    }
                 }
              }
           }
         if((m_nActiveStairTradingManagement == ENUM_STAIRTRADING_MANAGEMENT_SIMPLE_COMPENSATE ||
             m_nActiveStairTradingManagement == ENUM_STAIRTRADING_MANAGEMENT_STC_COMPENSATE ||
             m_nActiveStairTradingManagement == ENUM_STAIRTRADING_MANAGEMENT_MACD_SIGNAL_COMPENSATE)  &&
            m_oLadderTradeManager.Allow_StepCompensate() && m_oLadderTradeManager.IsStepCompensate(nCommand))
           {
            m_oLadderTradeManager.OpenStepOrder(nCommand);
           }
        }
      m_oLiveOrderManager.DoManagement(ENUM_ORDERS_INVESTIGATE_ALL);
     }

  }
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool EA_MA_TradeManagement::IsMustRest_CauseBigLoss()
  {
   if(m_nHoursRest_WhenBigLoss <= 0)
      return false;
   return IsMustNowRest_CauseBigLoss(m_nHoursRest_WhenBigLoss,BalanceRiskVolume,m_fLoss_RiskBalance_Ratio_Rest);
  }
//+------------------------------------------------------------------+
bool EA_MA_TradeManagement::DetermineOpenAllowance(int nOrderState)
  {
   if(IsMustRest_CauseBigLoss())
     {
      return false;
     }
   if(!TimeManager_AllowOpen(m_nTimeTradeManager))
     {
      return false;
     }
   return true;
  }
//+------------------------------------------------------------------+
bool              EA_MA_TradeManagement::CheckAngle_Stop(int nCommand, double fSL_Origin)
  {
   datetime nCurrentTime = iTime(m_strSymbol,m_nTimeFrame,0);
   double fAngle = m_oChartCharacter.GetSlope(
                      (long)m_oIndicatorsInterface.m_oMVCrossDis.GetDate_CrossOver(),
                      m_oIndicatorsInterface.m_oMVCrossDis.GetPrice_CrossOver(),
                      (long)nCurrentTime,
                      fSL_Origin);
                      
  
  if(m_nMaxSlope_Stop_Distance>0 )
  { 
   if(fAngle>90) fAngle = 360 - fAngle;
   Print("CheckAngle_Stop :" , MathAbs(fAngle));

   if(MathAbs(fAngle)>m_nMaxSlope_Stop_Distance)
      return false;
  }                    
  
   return true;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool              EA_MA_TradeManagement::CheckAngle_Order(int nCommand, double fOpenPrice)
  {
   datetime lCurrentTime = iTime(m_strSymbol,m_nTimeFrame,0);
   double fAngle = m_oChartCharacter.GetSlope(
                      m_oIndicatorsInterface.m_oMVCrossDis.GetDate_CrossOver(),
                      m_oIndicatorsInterface.m_oMVCrossDis.GetPrice_CrossOver(),
                      lCurrentTime,
                      fOpenPrice);

  if(m_nMaxSlope_45_Distance >0)
  {
   if(fAngle>90) fAngle = 360 - fAngle;
   Print("CheckAngle_Order :" , MathAbs(fAngle));

   fAngle = MathAbs(fAngle)-45;
   if(MathAbs(fAngle)>m_nMaxSlope_45_Distance)   
      return false;
  }

   return true;
  }



//+------------------------------------------------------------------+
