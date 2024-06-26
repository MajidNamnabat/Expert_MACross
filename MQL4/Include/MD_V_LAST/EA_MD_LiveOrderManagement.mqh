//+------------------------------------------------------------------+
//|                                    EA_HF_LiveOrderManagement.mqh |
//|                                                  Majid Namanabat |
//|                                                maj.nam@gmail.com |
//+------------------------------------------------------------------+
#property copyright "Majid Namanabat"
#property link      "maj.nam@gmail.com"
#property strict
#include <stdlib.mqh>
#include <MD_V_LAST\\EA_MD_Types.mqh>
#include <MD_V_LAST\\EA_MD_Parameters.mqh>
#include <MD_V_LAST\\EA_MD_IndicatorsInterface.mqh>
#include <MD_V_LAST\\EA_MD_OrdersManagement.mqh>
#include <MD_V_LAST\\EA_MD_AllTrades_Statistic.mqh>
#include <MD_V_LAST\\EA_MD_LadderTradeManagement.mqh>
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
class CLiveOrderManagement
  {
public:
                     CLiveOrderManagement();
                    ~CLiveOrderManagement();
   void              Setup(CAllTradesStatistic &oTradesStatictic,CIndicatorsInterface &oIndicatorInterface,
                           CLadderTradeManagement &oLadderTradeManager,
                           string strSymbol, int nTimeFrame);
private:
   string            m_strSymbol;
   int               m_nTimeFrame;
   double            m_fPOINT;
   int               m_nDIGITS;
   CAllTradesStatistic*  m_poTradesStatistics;
   CIndicatorsInterface*  m_poIndicatorInterface;
   CLadderTradeManagement* m_poLadderTradeManager;
   bool              CheckHitTP(int nOrderType,int nTicket);
   bool              CheckHitSL(int nOrderType,int nTicket);

   bool              CheckClose(int nOrderType, int nTicket);
   bool              AdjustBreakEven(int nOrderType, int nTicket);

   bool              AdjustTrailingStop(int nOrderType, int nTicket);
   bool              AdjustStopLoss(int nOrderType, int nTicket);
public:
   double            DetermineStopLossValue(int nOrderType, double fOpenOrderPrice,double& fOriginSLPrice, double fOldSL = 0.f);
   void              DoManagement(ENUM_ORDERS_INVESTIGATE_STATE nInvestigateMethod);
   double            MoneyManagement();
   double            PointCost();
   double            RiskInPoints();
   double            PoseSize();
   double            PointValuePerLot() ;  // Value in account currency of a m_fPOINT of Symbol.
   double            FixedPercentOfBalanceV1();
   double            OrderLotDetermine_SL_Risk_Base(int nSLDistance_InPip, double fOpenOrderPrice);
   double            FixedPercentOfBalanceV3();
   void              CloseStepOrder(int Command);
   bool              PatientTimeElapsed(datetime order_OpenTime);
   void              CloseInitOrders(int Command);
   void              BehaveIntelligent(int nDistance_InPP, int nStopDistance_InPP, int& nCustomBreakEvenDistance, int& nCustomBreakEvenPoint);

  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
CLiveOrderManagement::CLiveOrderManagement()
  {
   m_strSymbol ="";
   m_nTimeFrame = 0;
   m_fPOINT = 0.f;

  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
CLiveOrderManagement::~CLiveOrderManagement()
  {
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CLiveOrderManagement::Setup(CAllTradesStatistic &oTradesStatictic,CIndicatorsInterface &oIndicatorInterface,
                                 CLadderTradeManagement &oLadderTradeManager,
                                 string strSymbol, int nTimeFrame)
  {
   m_strSymbol = strSymbol;
   m_nTimeFrame = nTimeFrame;
   Print("CLiveOrderManagement::Setup POINT1:", SymbolInfoDouble(m_strSymbol,SYMBOL_POINT), " POINT2: ", MarketInfo(m_strSymbol,MODE_POINT));
   m_fPOINT = MarketInfo(m_strSymbol,MODE_POINT);
//;
   m_nDIGITS = (int)MarketInfo(m_strSymbol,MODE_DIGITS);

   m_poIndicatorInterface = GetPointer(oIndicatorInterface);
   m_poTradesStatistics = GetPointer(oTradesStatictic);
   m_poLadderTradeManager = GetPointer(oLadderTradeManager);

  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double CLiveOrderManagement::DetermineStopLossValue(int nOrderType, double fOpenOrderPrice,double& fOriginSLPrice, double fOldSL = 0.f)
  {
   int StopLevel = (int)MarketInfo(m_strSymbol, MODE_STOPLEVEL);
   if(StopLevel == 0)
      StopLevel = (int)MarketInfo(m_strSymbol,MODE_SPREAD) + 3;

   int nCoef = nOrderType==OP_BUY ? 1 : -1;
   double fSLPrice = 0.f;
   switch(m_nStopLossType)
     {
      case ENUM_STOPLOSS_BELOW_SLOW_MV :
         fSLPrice = m_poIndicatorInterface.m_oMVCrossDis.GetMovingAverageSlowValue() ;
         fSLPrice= fSLPrice - nCoef * 4 * m_fPOINT;
         break;
      case ENUM_STOPLOSS_BELOW_SLOW_MV_UPDATEBLE :
         fSLPrice = m_poIndicatorInterface.m_oMVCrossDis.GetMovingAverageSlowValue() ;
         fSLPrice= fSLPrice - nCoef * 4 * m_fPOINT;
         break;
      case ENUM_STOPLOSS_BELOW_CUSTOM_MV :
         // I am using EMA because EMA 21 is mashhor
         fSLPrice = m_nStopLossParameter > 0 ? iMA(m_strSymbol,m_nTimeFrame,m_nStopLossParameter,0,MODE_EMA,PRICE_CLOSE,1) - nCoef * 4 * m_fPOINT : fSLPrice;
         break;
      case ENUM_STOPLOSS_BELOW_CUSTOM_MV_CLOSE_BASED :
         // I am using EMA because EMA 21 is mashhor
         fSLPrice = m_nStopLossParameter > 0 ? iMA(m_strSymbol,m_nTimeFrame,m_nStopLossParameter,0,MODE_EMA,PRICE_CLOSE,1) - nCoef * FIXEDPOINT_BELOW_CLOSEBASED_SL * m_fPOINT : fSLPrice;
         break;

      case ENUM_STOPLOSS_BELOW_CUSTOM_MV_UPDATEBLE :
         fSLPrice = m_nStopLossParameter > 0 ? iMA(m_strSymbol,m_nTimeFrame,m_nStopLossParameter,0,MODE_EMA,PRICE_CLOSE,1) - nCoef * 4 * m_fPOINT : fSLPrice;
         break;
      case ENUM_STOPLOSS_BELOW_CUSTOM_MV_UPDATEBLE_CLOSE_BASED :
         fSLPrice = m_nStopLossParameter > 0 ? iMA(m_strSymbol,m_nTimeFrame,m_nStopLossParameter,0,MODE_EMA,PRICE_CLOSE,1) - nCoef * FIXEDPOINT_BELOW_CLOSEBASED_SL * m_fPOINT : fSLPrice;
         break;
      case ENUM_STOPLOSS_FIXED_POINT:
         fSLPrice = m_nStopLossParameter > 0 ? (fOpenOrderPrice - nCoef * m_nStopLossParameter*m_fPOINT) : fSLPrice;  // can be OpenPrice-ManualStopLoss*m_fPOINT
         break;

     }
   if(fSLPrice == 0.f)
     {
      fOriginSLPrice = fSLPrice ;

      return fSLPrice;
     }
// iMA is based Bid , Ask  has an  Spreed insert ,if OrderTpe = Bid , then  must Sell Bid is important , Sell is Ask important, so an Spreed must consider and add
//review I think this must reverse , For OP_BUY ask sell is important so SPREAD must add

   if(IS_ENABLE_LOG)
      Print("DetermineStopLossValue fSLPrice : ", fSLPrice, " MODE_SPREAD ", MarketInfo(m_strSymbol,MODE_SPREAD), " fSLPriceNew : ", (fSLPrice +  MarketInfo(m_strSymbol,MODE_SPREAD)*m_fPOINT));

   fSLPrice = nOrderType==OP_SELL ? (fSLPrice +  MarketInfo(m_strSymbol,MODE_SPREAD)*m_fPOINT) : fSLPrice;
   fSLPrice =  NormalizeDouble(fSLPrice,m_nDIGITS);
   fSLPrice = MathAbs(fOpenOrderPrice - fSLPrice) < StopLevel*m_fPOINT ? (fOpenOrderPrice - nCoef * StopLevel * m_fPOINT) : fSLPrice;

   fSLPrice = nOrderType==OP_BUY &&  fSLPrice >= fOpenOrderPrice ? (fOpenOrderPrice - nCoef * StopLevel * m_fPOINT) : fSLPrice;

   fSLPrice = nOrderType==OP_SELL &&  fSLPrice <= fOpenOrderPrice ? (fOpenOrderPrice - nCoef * StopLevel * m_fPOINT) : fSLPrice;

   fSLPrice = NormalizeDouble(fSLPrice, m_nDIGITS) ;

   if(fOldSL > 0.f && MathAbs(fOldSL - fSLPrice) < StopLevel*m_fPOINT)
     {
      fOriginSLPrice = fSLPrice ;
      return 0.f;
     }
   fOriginSLPrice = fSLPrice ;
   if(m_nStopLossParameter>0 && (m_nStopLossType == ENUM_STOPLOSS_BELOW_CUSTOM_MV_CLOSE_BASED || m_nStopLossType == ENUM_STOPLOSS_BELOW_CUSTOM_MV_UPDATEBLE_CLOSE_BASED))
     {
      fOriginSLPrice +=  nCoef * FIXEDPOINT_BELOW_CLOSEBASED_SL * m_fPOINT ;
     }
//Print ("StopLoss Price : " , fSLPrice , " Mark Price : " , fMarkPrice , " Stop Level : " , StopLevel * m_fPOINT ,  " nOrderType : " , nOrderType==OP_BUY ? "Bid" : "Ask");

   return fSLPrice;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CLiveOrderManagement::DoManagement(ENUM_ORDERS_INVESTIGATE_STATE nInvestigateMethod)
  {
   bool isCloseOrder = false;
   for(int i = 0 ; i < OrdersTotal() ; i++)
     {
      if(OrderSelect(i, SELECT_BY_POS, MODE_TRADES) == false)
        {
         if(IS_ENABLE_LOG)
            Print("ERROR - Unable to select the order - ",GetLastError());
         break;
        }
      if(OrderMagicNumber() ==  MACROSS_MAGIC_NUM &&
         ((OrderSymbol() == m_strSymbol && nInvestigateMethod == ENUM_ORDERS_INVESTIGATE_SYMBOL_ONLY) ||
          nInvestigateMethod == ENUM_ORDERS_INVESTIGATE_ALL))
        {
         isCloseOrder = false;
         if(m_nStopLossType == ENUM_STOPLOSS_BELOW_SLOW_MV_UPDATEBLE ||
            m_nStopLossType == ENUM_STOPLOSS_BELOW_CUSTOM_MV_UPDATEBLE ||
            m_nStopLossType == ENUM_STOPLOSS_BELOW_CUSTOM_MV_UPDATEBLE_CLOSE_BASED)
           {
            AdjustStopLoss(OrderType(),OrderTicket());
           }
         if(m_nStopLossType == ENUM_STOPLOSS_BELOW_CUSTOM_MV_CLOSE_BASED ||
            m_nStopLossType == ENUM_STOPLOSS_BELOW_CUSTOM_MV_UPDATEBLE_CLOSE_BASED ||
            m_nTimeLimit_StopLoss>0)
           {
            isCloseOrder =  CheckHitSL(OrderType(),OrderTicket());
            if(isCloseOrder)
               continue;
           }
         if(ActiveBreakEvenDistance != ENUM_BREAKEVEN_DISABLED || m_nTakeProfitMethod != ENUM_TAKEPROFIT_DISABLED)
           {
            AdjustBreakEven(OrderType(),OrderTicket());
           }
         if(ProfitToTrailingStop != ENUM_TRAILING_STOP_DISABLED)
           {
            AdjustTrailingStop(OrderType(),OrderTicket());
           }
        }
     }

  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CLiveOrderManagement::CheckHitTP(int nOrderType, int nTicket)
  {

   if(OrderSelect(nTicket,SELECT_BY_TICKET,MODE_TRADES)==false)
     {
      if(IS_ENABLE_LOG)
         Print("ERROR - Unable to select the order - ",GetLastError());
      return false;
     }
   if(OrderProfit()<=0)
      return false;
   return false;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CLiveOrderManagement::CheckHitSL(int nOrderType,int nTicket)
  {
   const int NEURAL_TREND_PIPDISTANCE = 15;
   if(OrderSelect(nTicket,SELECT_BY_TICKET,MODE_TRADES)==false)
     {
      if(IS_ENABLE_LOG)
         Print("ERROR - Unable to select the order - ",GetLastError());
     }

   int nCoef = nOrderType==OP_BUY ? 1 : -1;
   bool isSLHit = false;
//بخاطر ایمنی این مقدار فیکس زیر استاپ لاس حقیقی فرض شده است
   if(m_nStopLossType == ENUM_STOPLOSS_BELOW_CUSTOM_MV_CLOSE_BASED ||
      m_nStopLossType == ENUM_STOPLOSS_BELOW_CUSTOM_MV_UPDATEBLE_CLOSE_BASED)
     {
      double fPrice = iClose(m_strSymbol,m_nTimeFrame,1);
      double fSLOrderReal = OrderStopLoss() + nCoef * FIXEDPOINT_BELOW_CLOSEBASED_SL * m_fPOINT;
      isSLHit = (nOrderType == OP_BUY && fPrice < fSLOrderReal) ? true : isSLHit;
      isSLHit = (nOrderType == OP_SELL && fPrice > fSLOrderReal) ? true : isSLHit;
     }
   if(m_nTimeLimit_StopLoss>0)
     {
      int nBarsElapsed = GetBarsElapsed(OrderOpenTime(),m_nTimeFrame);
      double fAsk = SymbolInfoDouble(m_strSymbol,SYMBOL_ASK); // Best Buy Offer
      double fBid = SymbolInfoDouble(m_strSymbol,SYMBOL_BID); // Best Buy Offer
      double fMarkPrice = (OrderType()==OP_BUY) ? fBid : fAsk;
      int nDistance_InPP = int (MathAbs(fMarkPrice-OrderOpenPrice())/m_fPOINT);

      isSLHit = (nBarsElapsed > m_nTimeLimit_StopLoss && (OrderProfit()<0 || nDistance_InPP < NEURAL_TREND_PIPDISTANCE)) ? true : isSLHit;
     }
   if(isSLHit)
     {
      double fClosePrice=0;
      if(nOrderType==OP_BUY)
         fClosePrice=SymbolInfoDouble(m_strSymbol,SYMBOL_BID);
      if(nOrderType==OP_SELL)
         fClosePrice=SymbolInfoDouble(m_strSymbol,SYMBOL_ASK);
      if(COrdersManagement::CloseOrder(m_strSymbol,nTicket,OrderLots(),fClosePrice))
        {
         if(IS_ENABLE_LOG)
            Print("CLiveOrderManagement::CheckHitSL ,  CloseOrder");
         m_poTradesStatistics.OrderClosed(m_strSymbol,nTicket);
         return true;
        }
     }
   return false;
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool              CLiveOrderManagement::CheckClose(int nOrderType, int nTicket)
  {
   if(OrderSelect(nTicket,SELECT_BY_TICKET,MODE_TRADES)==false)
     {
      if(IS_ENABLE_LOG)
         Print("ERROR - Unable to select the order - ",GetLastError());
      return false;
     }
   bool isClose = false;
   double fClosePrice=0.0f;
   return false;
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
bool CLiveOrderManagement::PatientTimeElapsed(datetime order_OpenTime)
  {

   bool IsCloseConditionOK = false;
   int duration =(int)((TimeCurrent() - order_OpenTime) / 60) ;      // in minute
//Print ("PatientTimeElapsed duration: " , duration , " m_nTimeFrame : " , m_nTimeFrame , " Time Candle : " , iTime(m_strSymbol, PERIOD_M1, 0) , " TimeCurrent : " , TimeCurrent() , " OpenOrderTime : " , order_OpenTime ) ;
   switch(PatientTime)
     {
      case HuryUp :
         IsCloseConditionOK = true;
         break;
      case CurrentCandle :


         if(duration < m_nTimeFrame)
            IsCloseConditionOK = false;
         else
            IsCloseConditionOK = true;
         break;
      case OneCandleInMiddle :

         if(duration < 1.8 * m_nTimeFrame) //prev 2 , but In Candle Has Problem , I change 1.6 , change 1.8 ??
            IsCloseConditionOK = false;
         else
            IsCloseConditionOK = true;
         break;
      case TwoCandleInMiddle :
         if(duration < 2.8 * m_nTimeFrame) //prev 2 , but In Candle Has Problem , I change 1.6 , change 1.8 ??
            IsCloseConditionOK = false;
         else
            IsCloseConditionOK = true;
         break;
      case ThreeCandleInMiddle :
         if(duration < 3.8 * m_nTimeFrame) //prev 2 , but In Candle Has Problem , I change 1.6 , change 1.8 ??
            IsCloseConditionOK = false;
         else
            IsCloseConditionOK = true;
         break;
     }
   return IsCloseConditionOK;
  }
//+------------------------------------------------------------------+
// assume only one open order exist alltime , so close all orders
void CLiveOrderManagement::CloseStepOrder(int Command)
  {
   double fClosePrice=0;
   if(Command==OP_BUY)
      fClosePrice=SymbolInfoDouble(m_strSymbol,SYMBOL_BID);
   if(Command==OP_SELL)
      fClosePrice=SymbolInfoDouble(m_strSymbol,SYMBOL_ASK);
   if(OrderSelect(m_poLadderTradeManager.GetInitOrderTicket(), SELECT_BY_TICKET, MODE_TRADES) == false)
     {
      if(IS_ENABLE_LOG)
         Print("CloseStepOrder ERROR - Unable to select the order - ",GetLastError());
      return;
     }
   int nTicket=OrderTicket();
   double fLots=  OrderLots();
   int nNewTicket = -1;
   if(fLots < (m_poLadderTradeManager.GetLotOneStep() + 0.1) && m_poLadderTradeManager.GetLastStepCompensateTicket() > 0)   // capacity lower than 2 step , final step is for CloseInit , So Compensate Order must be closed
     {
      if(OrderSelect(m_poLadderTradeManager.GetLastStepCompensateTicket(), SELECT_BY_TICKET, MODE_TRADES) == false)
        {
         //if(IS_ENABLE_LOG)   Print("CloseStepOrder ERROR - Unable to select the order - ",GetLastError());
         return;
        }
      nTicket = m_poLadderTradeManager.GetLastStepCompensateTicket();
      fLots=  OrderLots();
      if(COrdersManagement::CloseOrder(m_strSymbol,nTicket,fLots,fClosePrice))
        {
         //if(IS_ENABLE_LOG)   Print("CLiveOrderManagement::CloseStepOrder ,  CloseOrder");
         m_poLadderTradeManager.ChangeHistory(ENUM_TRACK_STEP_ORDERED, fLots, fClosePrice, nTicket,TimeCurrent());
         m_poTradesStatistics.OrderClosed(m_strSymbol,nTicket);
        }
     }
   else
     {
      fLots = m_poLadderTradeManager.GetLotOneStep();
      nNewTicket = COrdersManagement::PartialCloseOrder(m_strSymbol,MACROSS_MAGIC_NUM,nTicket,fLots,fClosePrice);
      if(nNewTicket > 0)
        {
         m_poLadderTradeManager.ChangeHistory(ENUM_TRACK_STEP_ORDERED, fLots, fClosePrice, nNewTicket,TimeCurrent());
         m_poLadderTradeManager.ChangeHistory(ENUM_TRACK_ORDER_INIT_MODIFY_TICKET, OrderLots()-fLots, fClosePrice, nNewTicket,TimeCurrent());
         m_poTradesStatistics.OrderClosed(m_strSymbol,nTicket);
         if(IS_ENABLE_LOG)
            Print("CLiveOrderManagement::CloseStepOrder ,  CloseOrder");
         int nSLDistance_InPip =  OrderStopLoss() > 0.000001 ? (int) MathRound((MathAbs(OrderOpenPrice() - OrderStopLoss()) / m_fPOINT)) : 999999 ;
         m_poTradesStatistics.OrderOpened(m_strSymbol,m_nTimeFrame,Command,nNewTicket,OrderLots()-fLots,OrderOpenPrice(),OrderOpenTime(),
                                          m_poIndicatorInterface.m_oMVCrossDis.GetMovingAverageFastValue(),m_poIndicatorInterface.m_oMVCrossDis.GetMovingAverageSlowValue(),nSLDistance_InPip);
        }
     }

/////////////////////////
  }


// assume only one open order exist alltime , so close all orders
void CLiveOrderManagement::CloseInitOrders(int Command)
  {

   RefreshRates();
   double fClosePrice=0;
   double fAsk = SymbolInfoDouble(m_strSymbol,SYMBOL_ASK); // Best Buy Offer
   double fBid = SymbolInfoDouble(m_strSymbol,SYMBOL_BID); // Best Buy Offer
   if(Command==OP_BUY)
     {
      fClosePrice=fBid; //not must Sell to close
     }
   else
      if(Command==OP_SELL)
        {
         fClosePrice=fAsk; //not must Buy to close
        }
//simulate test bench , sometimes stoploss is reached and Order Close and You don't underestand
   if(OrdersTotal()==0)
     {
      //if(IS_ENABLE_LOG) Print("Simulation : TRADE - CLOSE - Order "," closed at price ",ClosePrice);
      if(IS_ENABLE_LOG)
         Print("Simulation : TRADE - CLOSE - Order MVDistancePoint = ",m_poIndicatorInterface.m_oMVCrossDis.GetMVDistanceInPoint());
      return;
     }

   for(int i = 0 ; i < OrdersTotal() ; i++)
     {
      if(OrderSelect(i, SELECT_BY_POS, MODE_TRADES) == false)
        {
         if(IS_ENABLE_LOG)
            Print("ERROR - Unable to select the order - ",GetLastError());
         break;
        }
      if(OrderSymbol()==m_strSymbol  && OrderMagicNumber() ==  MACROSS_MAGIC_NUM &&
         (OrderType()==Command))
        {
         int nTicket=OrderTicket();
         if(PatientTimeElapsed(OrderOpenTime()))
           {
            double fLots=  OrderLots();


            /////////////////////////
            if(COrdersManagement::CloseOrder(m_strSymbol,nTicket,fLots,fClosePrice))
              {
               //if(IS_ENABLE_LOG)    Print("CLiveOrderManagement::CloseInitOrders ,  CloseOrder");
               m_poLadderTradeManager.ChangeHistory(
                  ENUM_TRACK_STEP_ORDERED, fLots, fClosePrice, nTicket, TimeCurrent());
               m_poTradesStatistics.OrderClosed(m_strSymbol,nTicket);
              }
           }
        }
     }

  }
//+------------------------------------------------------------------+
//Adjust StopLoss After PatientTime is Elapsed , Only One
bool CLiveOrderManagement::AdjustStopLoss(int nOrderType, int nTicket)
  {
   RefreshRates();
   bool success,IsModifyOrder = false;
   int err;
   double fSL = 0.0,fSLPrice = 0.0f, fSLOriginPrice = 0.f;
   double fMarkPrice = 0.0 ;
   if(m_nStopLossType == ENUM_STOPLOSS_FIXED_POINT ||
      m_nStopLossType == ENUM_STOPLOSS_NONE)
      return false;
   if(m_nStopLossType == ENUM_STOPLOSS_BELOW_SLOW_MV ||
      m_nStopLossType == ENUM_STOPLOSS_BELOW_CUSTOM_MV)
      return false;
   if(m_nStopLossType != ENUM_STOPLOSS_BELOW_SLOW_MV_UPDATEBLE &&
      m_nStopLossType != ENUM_STOPLOSS_BELOW_CUSTOM_MV_UPDATEBLE &&
      m_nStopLossType != ENUM_STOPLOSS_BELOW_CUSTOM_MV_UPDATEBLE_CLOSE_BASED)
      return false;
   if(OrderSelect(nTicket, SELECT_BY_TICKET, MODE_TRADES) == false)
     {
      if(IS_ENABLE_LOG)
         Print("ERROR - Unable to select the order - ",GetLastError());
      return false;
     }
   if(PatientTimeElapsed(OrderOpenTime()) == false)
     {
      return false;
     }
   if(OrderType() == OP_BUY && OrderStopLoss() > (OrderOpenPrice() + (BreakEvenPoint - 5)*m_fPOINT))
      return false;
   if(OrderType() == OP_SELL && OrderStopLoss() < (OrderOpenPrice() - (BreakEvenPoint - 5)*m_fPOINT))
      return false;

   double fAsk = SymbolInfoDouble(m_strSymbol,SYMBOL_ASK); // Best Buy Offer
   double fBid = SymbolInfoDouble(m_strSymbol,SYMBOL_BID); // Best Buy Offer
   fMarkPrice = (OrderType()==OP_BUY) ? fBid : fAsk;
   fSL = DetermineStopLossValue(OrderType(),fMarkPrice,fSLOriginPrice,OrderStopLoss());
   IsModifyOrder =(OrderType() == OP_BUY && fSL > OrderStopLoss() && fSLPrice > 0.000001) ? true : false;
   IsModifyOrder =(OrderType() == OP_SELL && fSL < OrderStopLoss() && fSLPrice > 0.000001) ? true : IsModifyOrder;


   if(IsModifyOrder)
     {
      if(IS_ENABLE_LOG)
         Print("AdjustStopLoss : OrderModify Try SL :", fSL," Spreed ", MarketInfo(m_strSymbol,MODE_SPREAD), " Ask: ", fAsk);

      success = OrderModify(OrderTicket(),OrderOpenPrice(),fSL,OrderTakeProfit(),0,CLR_NONE);
      if(!success)
        {
         err=GetLastError();
         if(IS_ENABLE_LOG)
            Print("AdjustStopLoss : Error Modifying order : (",err,") ", ErrorDescription(err));
        }
      else
        {
         return true;
        }
     }
   return false;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CLiveOrderManagement::AdjustBreakEven(int nOrderType, int nTicket)
  {
   bool success,IsModifyOrder = false;
   int err;
   double SL = 0.0;
   double MarkPrice = 0.0 ;
   int StopLevel = (int)MarketInfo(m_strSymbol, MODE_STOPLEVEL);
   if(StopLevel == 0)
      StopLevel = /*(int)MarketInfo(m_strSymbol,MODE_SPREAD) +*/ 3;
   int nCustomBreakEvenDistance = ActiveBreakEvenDistance ;
   int nCustomBreakEvenPoint = BreakEvenPoint ;
   int nDistance_InPP = 0;
   int nStopDistance_InPP = 0 ;
   if(ActiveBreakEvenDistance == ENUM_BREAKEVEN_DISABLED && m_nTakeProfitMethod == ENUM_TAKEPROFIT_DISABLED)
      return false;

//Print ("AdjustBreakeven function :" , ActiveBreakEvenDistance);
   if(OrderSelect(nTicket,SELECT_BY_TICKET,MODE_TRADES)==false)
     {
      if(IS_ENABLE_LOG)
         Print("ERROR - Unable to select the order - ",GetLastError());
      return false;
     }
   if(OrderProfit()<=0)
      return false;
   if(PatientTimeElapsed(OrderOpenTime()) == false)
      return false;
   if(ActiveBreakEvenDistance == ENUM_BREAKEVEN_INTELLIGENT ||
      m_nTakeProfitMethod == ENUM_TAKEPROFIT_MM_R_R ||
      m_nTakeProfitMethod == ENUM_TAKEPROFIT_MM_R_HR ||
      m_nTakeProfitMethod == ENUM_TAKEPROFIT_STATISTICS
     )
     {
      //m_nBreakEven_Intelligent_PipDistance_Activation = (int)MathRound(( m_poIndicatorInterface.GetATR(TrailingParameter, 1) + 3 * m_fPOINT) / m_fPOINT);
      //Print("AdjustBreakEven " , m_nBreakEven_Intelligent_PipDistance_Activation , " " , m_poIndicatorInterface.GetATR(TrailingParameter, 1)  );
     }
   SL = 0.0;
   IsModifyOrder = false;
   double fAsk = SymbolInfoDouble(m_strSymbol,SYMBOL_ASK); // Best Buy Offer
   double fBid = SymbolInfoDouble(m_strSymbol,SYMBOL_BID); // Best Buy Offer
   switch(OrderType())
     {
      case OP_BUY :
         MarkPrice = fBid;
         break;
      case OP_SELL :
         MarkPrice = fAsk;
         break;
     }
   nDistance_InPP = int (MathAbs(MarkPrice-OrderOpenPrice())/m_fPOINT);
//Risk Reward Ration , You Don't Know Reward , This Have Problem I thought
   if(OrderStopLoss() > 0.0f)
     {
      if(m_nTakeProfitMethod == ENUM_TAKEPROFIT_DISABLED)
        {
         if(OrderType() == OP_BUY && OrderStopLoss() > (OrderOpenPrice() + (BreakEvenPoint - 5)*m_fPOINT))
            return false;
         if(OrderType() == OP_SELL && OrderStopLoss() < (OrderOpenPrice() - (BreakEvenPoint - 5)*m_fPOINT))
            return false;
        }
      nStopDistance_InPP = int (MathAbs(OrderOpenPrice()-OrderStopLoss())/m_fPOINT);
      if((m_nStopLossType == ENUM_STOPLOSS_BELOW_CUSTOM_MV_CLOSE_BASED ||
          m_nStopLossType == ENUM_STOPLOSS_BELOW_CUSTOM_MV_UPDATEBLE_CLOSE_BASED) &&
         nStopDistance_InPP > FIXEDPOINT_BELOW_CLOSEBASED_SL)
        {
         nStopDistance_InPP  -= FIXEDPOINT_BELOW_CLOSEBASED_SL;
        }
      switch(m_nTakeProfitMethod)   //Buggy Last Code ActiveBreakEvenDistance changed in this area but fixed
        {
         case ENUM_TAKEPROFIT_R_R_100:
            nCustomBreakEvenDistance = nStopDistance_InPP;
            break;
         case ENUM_TAKEPROFIT_R_R_200:
            nCustomBreakEvenDistance = nStopDistance_InPP * 2 ;
            break;
         case ENUM_TAKEPROFIT_R_R_50:
            nCustomBreakEvenDistance = int (nStopDistance_InPP * 0.5)  ;
            break;
         case ENUM_TAKEPROFIT_R_R_25:
            nCustomBreakEvenDistance = int (nStopDistance_InPP * 0.25)  ;
            break;
         case ENUM_TAKEPROFIT_FIXED_100:
            nCustomBreakEvenDistance = int (ENUM_TAKEPROFIT_FIXED_100)  ;
            break;
         case ENUM_TAKEPROFIT_FIXED_150:
            nCustomBreakEvenDistance = int (ENUM_TAKEPROFIT_FIXED_150)  ;
            break;

        }
      if(ActiveBreakEvenDistance == ENUM_BREAKEVEN_INTELLIGENT)
        {
         if((OrderType() == OP_BUY && OrderStopLoss() >= (OrderOpenPrice()-10*m_fPOINT)) ||
            (OrderType() == OP_SELL && OrderStopLoss() <= OrderOpenPrice()+10*m_fPOINT))
           {
            return false;
           }
         if(nDistance_InPP < (nCustomBreakEvenPoint + m_nBreakEven_Intelligent_PipDistance_Activation))
            return false;

         BehaveIntelligent(nDistance_InPP, nStopDistance_InPP, nCustomBreakEvenDistance, nCustomBreakEvenPoint);
        }
      if(m_nTakeProfitMethod == ENUM_TAKEPROFIT_STATISTICS ||
         m_nTakeProfitMethod == ENUM_TAKEPROFIT_MM_R_R ||
         m_nTakeProfitMethod == ENUM_TAKEPROFIT_MM_R_HR)
        {
         if((OrderType() == OP_BUY && OrderStopLoss() >= (OrderOpenPrice()-10*m_fPOINT)) ||
            (OrderType() == OP_SELL && OrderStopLoss() <= OrderOpenPrice()+10*m_fPOINT))
           {
            //assume only one order exist , can  cause problem when multiple order
            // stairtrading not work now
            double fSL_Origin = StrToDouble(OrderComment());
            if(fSL_Origin==0.f)
              {
               Print("AdjustBreakEven fSL_Origin==0.f Error !!!", OrderComment());
              }
            nStopDistance_InPP = int (MathAbs(OrderOpenPrice()-fSL_Origin)/m_fPOINT);
            if(nStopDistance_InPP<10)
              {
               Print("AdjustBreakEven nStopDistance_InPP<10 Error !!!", OrderComment());
               return false;
              }
           }
         BehaveIntelligent(nDistance_InPP, nStopDistance_InPP, nCustomBreakEvenDistance, nCustomBreakEvenPoint);
        }
     }
   if(nCustomBreakEvenDistance == ENUM_BREAKEVEN_DISABLED)
      return false;
   if(nDistance_InPP < nCustomBreakEvenDistance)
      return false;
   if(ProfitToTrailingStop != ENUM_TRAILING_STOP_DISABLED && nDistance_InPP > ProfitToTrailingStop && ProfitToTrailingStop > 1 && ProfitToTrailingStop != ENUM_TRAILING_STOP_RSI_SATURATION && ProfitToTrailingStop != ENUM_TRAILING_STOP_SAR_METHOD)
      return false;
   if(nDistance_InPP < (StopLevel + nCustomBreakEvenPoint) + 1)
      return false;
   fAsk = SymbolInfoDouble(m_strSymbol,SYMBOL_ASK); // Best Buy Offer
   fBid = SymbolInfoDouble(m_strSymbol,SYMBOL_BID); // Best Buy Offer



   switch(OrderType())
     {
      case OP_BUY :
         SL =  NormalizeDouble((OrderOpenPrice()+(nCustomBreakEvenPoint*m_fPOINT)),m_nDIGITS);
         SL = (fBid - SL) < StopLevel*m_fPOINT ? (fBid - StopLevel * m_fPOINT) : SL;
         SL = NormalizeDouble(SL, m_nDIGITS)  ;
         IsModifyOrder = ((SL > OrderStopLoss() || OrderStopLoss() == 0.0f) /*&& SL < fBid*/)? true : false;

         break;
      case OP_SELL :
         SL = NormalizeDouble(OrderOpenPrice()-(nCustomBreakEvenPoint*m_fPOINT), m_nDIGITS) ;
         SL = (SL - fAsk) < StopLevel*m_fPOINT ? (fAsk + StopLevel * m_fPOINT) : SL;
         SL = NormalizeDouble(SL, m_nDIGITS)  ;
         IsModifyOrder = ((SL < OrderStopLoss() || OrderStopLoss() == 0.0f) /*&& SL > fAsk*/) ? true : false;
         //Print(" AdjustBreakEven ", nCustomBreakEvenPoint," ", SL, " IsModifyOrder ", IsModifyOrder, "  Ask ", fAsk);
         break;
     }
   if(IsModifyOrder)
     {

      success = OrderModify(OrderTicket(),OrderOpenPrice(),SL,OrderTakeProfit(),0,CLR_NONE);
      if(IS_ENABLE_LOG)
         Print("AdjustBreakeven : OrderModify Try SL :", SL, " MarkPrice ", MarkPrice, " StopLevel ", StopLevel," Spreed ", MarketInfo(m_strSymbol,MODE_SPREAD), " Ask: ", fAsk);
      if(!success)
        {
         err=GetLastError();
         //if(IS_ENABLE_LOG)
         Print("AdjustBreakeven : Error Modifying order : (",err,") ", ErrorDescription(err));
         return false;
        }
      else
        {
         m_poTradesStatistics.BreakEvenActivated(m_strSymbol,OrderTicket());
         return true;
        }
     }
   return false;
  }

//+------------------------------------------------------------------+
//trailing stop function
//+------------------------------------------------------------------+
bool CLiveOrderManagement::AdjustTrailingStop(int nOrderType, int nTicket)
  {
   bool success;
   int err;
   double MarkPrice = 0.0,SLDistance = 0.0, SL = 0.0;
   double fSarValue = 0.f;
   int StopLevel = (int)MarketInfo(m_strSymbol, MODE_STOPLEVEL);
   if(StopLevel == 0)
      StopLevel = 3;
   if(ProfitToTrailingStop == ENUM_TRAILING_STOP_DISABLED)
      return false;
   int nSpread = 10;
//buy order section
   if(OrderSelect(nTicket, SELECT_BY_TICKET, MODE_TRADES) == false)
     {
      if(IS_ENABLE_LOG)
         Print("ERROR - Unable to select the order - ",GetLastError());
      return false;
     }
   if(OrderProfit()<=0)
      return false;
   if(PatientTimeElapsed(OrderOpenTime()) == false)
      return false;
   double fAsk = SymbolInfoDouble(m_strSymbol,SYMBOL_ASK); // Best Buy Offer
   double fBid = SymbolInfoDouble(m_strSymbol,SYMBOL_BID); // Best Buy Offer

   switch(OrderType())
     {
      case OP_BUY :
         MarkPrice = fBid;
         break;
      case OP_SELL :
         MarkPrice = fAsk;
         break;
     }
   SLDistance = 0.0;
   int dis_in_point = int (MathAbs(OrderOpenPrice()-MarkPrice)/m_fPOINT);
//Experience : in EURUSD Robo 2 Years History , this cause Profit Decrease , about 10%
//Experience RSI_SATURATION in condition , even in min_sl_distance negative can improve very profit
   int min_sl_in_point = (ActiveBreakEvenDistance> 1 && ProfitToTrailingStop != ENUM_TRAILING_STOP_RSI_SATURATION && ProfitToTrailingStop != ENUM_TRAILING_STOP_SAR_METHOD)? ActiveBreakEvenDistance : 5 ;
   min_sl_in_point = (ProfitToTrailingStop == ENUM_TRAILING_STOP_RSI_SATURATION) ? -10 : min_sl_in_point;
   min_sl_in_point = (ProfitToTrailingStop == ENUM_TRAILING_STOP_SAR_METHOD) ? 10 : min_sl_in_point;
//if(IS_ENABLE_LOG) Print("AdjustTrailingStop : MathAbs(OrderOpenPrice()-MarkPrice))/m_fPOINT :",(MathAbs(OrderOpenPrice()-MarkPrice))/m_fPOINT);
   if((dis_in_point>ProfitToTrailingStop && ProfitToTrailingStop != ENUM_TRAILING_STOP_RSI_SATURATION && ProfitToTrailingStop != ENUM_TRAILING_STOP_SAR_METHOD) ||
      (m_poIndicatorInterface.Activate_TrailingStop(OrderType()) && ProfitToTrailingStop == ENUM_TRAILING_STOP_RSI_SATURATION) ||
      (ProfitToTrailingStop == ENUM_TRAILING_STOP_SAR_METHOD))
     {
      switch(TrailingStopMethod)
        {
         case ENUM_TRAILINGSTOP_ATR :
            SLDistance  = iATR(m_strSymbol,m_nTimeFrame,TrailingParameter,1)+3*m_fPOINT;
            break;
         case ENUM_TRAILINGSTOP_FIXEDPOINT :
            SLDistance = TrailingParameter *m_fPOINT ;
            break;
         case ENUM_TRAILINGSTOP_MV :
            SLDistance = MathAbs(MarkPrice - iMA(m_strSymbol,m_nTimeFrame,TrailingParameter,0,MODE_SMA,PRICE_CLOSE,1))+ 3 * m_fPOINT;
            break;
         case ENUM_TRAILINGSTOP_ATR15 :
            SLDistance  = iATR(m_strSymbol,m_nTimeFrame,TrailingParameter,1) * 1.5+ 1*m_fPOINT;
            break;
         case ENUM_TRAILINGSTOP_ATR20 :
            SLDistance  = iATR(m_strSymbol,m_nTimeFrame,TrailingParameter,1) * 2 + 1*m_fPOINT;
            break;
         case ENUM_TRAILINGSTOP_PARABOLIC_SAR:
            fSarValue = m_poIndicatorInterface.ParabolicSAR();
            if(OrderType() == OP_BUY && fSarValue < iOpen(m_strSymbol,m_nTimeFrame,1))    //Buy & Still Below
               return false;
            if(OrderType() == OP_SELL && fSarValue > iOpen(m_strSymbol,m_nTimeFrame,1))    //Sell & Still Above
               return false;
            SLDistance = MathAbs(MarkPrice - fSarValue)+ 1 * m_fPOINT;
            break;
        }

      SL = 0.0;
      bool IsSetStopLoss = false;
      if(OrderType() == OP_BUY)
        {
         fBid = SymbolInfoDouble(m_strSymbol,SYMBOL_BID); // Best Buy Offer
         SL = NormalizeDouble(fBid - SLDistance,m_nDIGITS);
         SL = SL > (OrderOpenPrice()+min_sl_in_point*m_fPOINT) ? SL : (OrderOpenPrice()+min_sl_in_point*m_fPOINT);
         SL = (fBid - SL) < StopLevel*m_fPOINT ? (fBid - StopLevel * m_fPOINT) : SL;
         SL = NormalizeDouble(SL, m_nDIGITS)  ;
        }
      else
         if(OrderType() == OP_SELL)
           {
            // iMA is based Bid , Ask  has an  Spreed insert ,if OrderTpe = Bid , then  must Sell Bid is important , Sell is Ask important, so an Spreed must consider and add
            fAsk = SymbolInfoDouble(m_strSymbol,SYMBOL_ASK); // Best Buy Offer
            nSpread = (int)MarketInfo(m_strSymbol,MODE_SPREAD);
            SL = NormalizeDouble(fAsk + SLDistance + nSpread  *m_fPOINT,m_nDIGITS);
            //Print("AdjustTrailingStop : SL " ,  SL , " fAsk : " , fAsk , " SLDistance : " , SLDistance , " nSpread : " , nSpread , " POINT : " , m_fPOINT);
            SL = SL < (OrderOpenPrice()-min_sl_in_point*m_fPOINT) ? SL : (OrderOpenPrice()-min_sl_in_point*m_fPOINT);
            SL = (SL - fAsk) < StopLevel*m_fPOINT ? (fAsk + StopLevel * m_fPOINT) : SL;
            SL = NormalizeDouble(SL, m_nDIGITS)  ;
           }
      //if(IS_ENABLE_LOG) Print("AdjustTrailingStop : SLDistance : ", SLDistance, " TrailingStopMethod: ", TrailingStopMethod, " SL :" , SL);
      if(OrderType() == OP_BUY && SL > OrderStopLoss() && (SL > OrderOpenPrice()  || OrderStopLoss()<OrderOpenPrice()))
        {
         IsSetStopLoss = true;

        }
      else
         if(OrderType() == OP_SELL && SL < OrderStopLoss() && (SL < OrderOpenPrice() || OrderStopLoss()>OrderOpenPrice()))
           {
            IsSetStopLoss = true;

           }
      if(IsSetStopLoss)
        {
         success = OrderModify(OrderTicket(),OrderOpenPrice(),SL,OrderTakeProfit(),0,CLR_NONE);
         if(IS_ENABLE_LOG)
            Print("AdjustTrailingStop : OrderModify Try SL :", SL, " MarkPrice ", MarkPrice, " StopLevel ", StopLevel, " nSpread : ", nSpread);
         if(!success)
           {
            err=GetLastError();
            //if(IS_ENABLE_LOG)
            Print("AdjustTrailingStop : Error Modifying order : (",err,") ", ErrorDescription(err));
           }
         else
           {
            m_poTradesStatistics.TrailingActivated(m_strSymbol,OrderTicket());
            return true;
           }
        }
     }
   return false;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CLiveOrderManagement::BehaveIntelligent(int nDistance_InPP, int nStopDistance_InPP, int& nCustomBreakEvenDistance, int& nCustomBreakEvenPoint)
  {
//Main Variables because second variables may be change

   int nRatio = -1 ;
   double  fRatio = -1.f;
   int nMeanStdRatios[] = {6,5,4,2};
   int nMinMeanStdRatio = nMeanStdRatios[ArrayMinimum(nMeanStdRatios)];
   const double fStaticsRatio = (double)nMinMeanStdRatio / 2 ;
   const int nDistanceFromBreakPoint = 30;
   if(nStopDistance_InPP > 0)
     {
      fRatio = (double)nDistance_InPP / nStopDistance_InPP ;
      nRatio = (int) fRatio;
      //Print("BehaveIntelligent " , nDistance_InPP , "  " , nStopDistance_InPP ,  " " , fRatio , " " , nRatio );
     }

   if((m_nTakeProfitMethod == ENUM_TAKEPROFIT_MM_R_R) && fRatio > 1.0)
     {
      nCustomBreakEvenDistance = nRatio * nStopDistance_InPP + m_nBreakEven_Intelligent_PipDistance_Activation; //must at least 15 pip hither than threshold
      nCustomBreakEvenPoint = nRatio * nStopDistance_InPP ;
     }
   else
      if((m_nTakeProfitMethod == ENUM_TAKEPROFIT_MM_R_HR) && fRatio > 0.5)
        {
         //Print("BehaveIntelligent nStopDistance_InPP ", nStopDistance_InPP, " fRatio ",  fRatio);
         nRatio = (int)((nDistance_InPP) / (nStopDistance_InPP / 2)) ;
         nCustomBreakEvenDistance = nRatio * (nStopDistance_InPP / 2) + m_nBreakEven_Intelligent_PipDistance_Activation;   //must at least 15 pip hither than threshold
         nCustomBreakEvenPoint = nRatio * (nStopDistance_InPP / 2);
        }
      else
         if(m_nTakeProfitMethod == ENUM_TAKEPROFIT_STATISTICS && nDistance_InPP > (m_fStat_Profit_Avg+ fStaticsRatio *  m_fStat_Profit_Std))
           {
            fRatio = (double)(nDistance_InPP - m_fStat_Profit_Avg) / (m_fStat_Profit_Std / 2);

            nRatio = (int) fRatio;
            //Print ("BehaveIntelligent fRatio : ", fRatio ," nRatio " ,nRatio);
            int nMMLevelInPip = nCustomBreakEvenPoint;
            for(int n=0; n<ArraySize(nMeanStdRatios); n++)
              {
               if(fRatio >= nMeanStdRatios[n])
                 {
                  nMMLevelInPip = (int)(nMeanStdRatios[n] * (m_fStat_Profit_Std / 2) + m_fStat_Profit_Avg) ;
                 }
              }
            if(fRatio >= nMinMeanStdRatio)
              {
               nCustomBreakEvenDistance = nMMLevelInPip + m_nBreakEven_Intelligent_PipDistance_Activation; //must at least 15 pip hither than threshold
               nCustomBreakEvenPoint = nMMLevelInPip;
              }
           }
         else
            if(ActiveBreakEvenDistance == ENUM_BREAKEVEN_INTELLIGENT)
              {
               ENUM_FEELING nFeeling = m_poTradesStatistics.GetShortTermFeeling(m_strSymbol,m_nTimeFrame);
               //Print("BehaveIntelligent : nFeeling :", EnumToString(nFeeling));
               switch(nFeeling)
                 {
                  case ENUM_FEELING_NORMAL :
                     nCustomBreakEvenDistance = ENUM_BREAKEVEN_DISABLED ;
                     break;
                  case ENUM_FEELING_HIGHRISK_CONSERVATIVE :
                     nCustomBreakEvenDistance = (nCustomBreakEvenPoint + m_nBreakEven_Intelligent_PipDistance_Activation) ;
                     //Print("BehaveIntelligent : ", nCustomBreakEvenDistance, " ", m_nBreakEven_Intelligent_PipDistance_Activation);
                     break;
                  case ENUM_FEELING_RISKY_CONSERVATIVE :
                     nCustomBreakEvenDistance = (nCustomBreakEvenPoint + m_nBreakEven_Intelligent_PipDistance_Activation);
                     //Print("BehaveIntelligent : ", nCustomBreakEvenDistance, " ", m_nBreakEven_Intelligent_PipDistance_Activation);
                     break;
                  case ENUM_FEELING_WINNY_DORISK :
                     nCustomBreakEvenDistance = ENUM_BREAKEVEN_DISABLED ;
                     break;
                 }
              }
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double CLiveOrderManagement::MoneyManagement()
  {

   MMMode RiskMode       = Percentage;
   double FixedRisk      = 100;
   double PercentageRisk = BalanceRiskVolume * 100;
   double moneyRisk = RiskMode == Fixed ? FixedRisk : PercentageRisk/100 * AccountBalance();
   double lots      = 0.01;//ComputeLots(moneyRisk, SL);
   return lots;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double CLiveOrderManagement::PointCost()
  {
   double result;
   double BasePointCost;
   string BaseString;
   string String1;
   string String2;
//+------------------------------------------------------------------+
   BasePointCost=MarketInfo(m_strSymbol,MODE_LOTSIZE)*MarketInfo(m_strSymbol,MODE_POINT);
   BaseString=StringSubstr(m_strSymbol,3,3);
   String1="USD"+BaseString;
   String2=BaseString+"USD";
//+------------------------------------------------------------------+
   if(BaseString=="USD")
      result=BasePointCost;
//+------------------------------------------------------------------+
   else
      if(MarketInfo(String1,MODE_BID)!=0)
         result=BasePointCost*(1/MarketInfo(String1,MODE_BID));
      //+------------------------------------------------------------------+
      else
         result=BasePointCost*MarketInfo(String2,MODE_ASK);
//+------------------------------------------------------------------+
//double PipValue = MarketInfo(m_strSymbol, MODE_TICKVALUE); // Pip Value in the deposit currency
//double PipSize = MarketInfo(m_strSymbol, MODE_TICKSIZE); // Pip Size in the quote currency


   return(result);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double CLiveOrderManagement::RiskInPoints()
  {
   double result;
   result=MathAbs(SymbolInfoDouble(m_strSymbol,SYMBOL_BID)-m_nStopLossParameter*m_fPOINT)/m_fPOINT;
   return(result);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double CLiveOrderManagement::PoseSize()
  {
   double result;
   double PoseSize;
   double RP;
   RP=RiskInPoints();
   if(PointCost()>0&&RP>0)
     {
      PoseSize=(AccountBalance()*BalanceRiskVolume)/(RP*PointCost());
      //result=MathFloor(PoseSize*10)/10;
      result=PoseSize;
     }
   else
      result=0;
   return(result);
  }
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double  CLiveOrderManagement::PointValuePerLot()   // Value in account currency of a m_fPOINT of Symbol.
  {
   /* In tester I had a sale: open=1.35883 close=1.35736 (0.00147)
    * gain$=97.32/6.62 lots/147 points=$0.10/point or $1.00/pip.
    * IBFX demo/mini       EURUSD TICKVALUE=0.1 MAXLOT=50 LOTSIZE=10,000
    * IBFX demo/standard   EURUSD TICKVALUE=1.0 MAXLOT=50 LOTSIZE=100,000
    *                                  $1.00/point or $10.00/pip.
    *
    * https://www.mql5.com/en/forum/127584 CB: MODE_TICKSIZE will usually return the
    * same value as MODE_POINT (or m_fPOINT for the current symbol), however, an
    * example of where to use MODE_TICKSIZE would be as part of a ratio with
    * MODE_TICKVALUE when performing money management calculations which need
    * to take account of the pair and the account currency. The reason I use
    * this ratio is that although TV and TS may constantly be returned as
    * something like 7.00 and 0.00001 respectively, I've seen this
    * (intermittently) change to 14.00 and 0.00002 respectively (just example
    * tick values to illustrate). */
   return(MarketInfo(m_strSymbol, MODE_TICKVALUE)
          / MarketInfo(m_strSymbol, MODE_TICKSIZE));  // Not m_fPOINT.
// خودم
//In marketinfo(), MODE_TICKVALUE is defined as "Tick value in the deposit currency".
//m_fPOINT or POINT_SIZE is a change of 1 in the least significant digit of the price.
//TICK_SIZE is the smallest movement in the price quoted by the broker, which could be several points.
//In this way TICK_SIZE is always a multiple of m_fPOINT.

//MODE_LOTSIZE    Lot size in the base currency
//MODE_TICKVALUE   Tick value in the deposit currency
//MODE_TICKSIZE    Tick size in points



  }
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double CLiveOrderManagement::FixedPercentOfBalanceV1()
  {
   bool AccountIsMini = true; // Change to False if trading a 100k/regular account

   if(IS_ENABLE_LOG)
      Print("MARGIN INIT = ",MarketInfo(m_strSymbol,MODE_MARGININIT));     //return zero ?!

   if(MarketInfo(m_strSymbol,MODE_MARGININIT)==10000)
     {
      AccountIsMini = true;
      if(IS_ENABLE_LOG)
         Print("IsMini");
     }

   if(MarketInfo(m_strSymbol,MODE_MARGININIT)==100000)
     {
      AccountIsMini = false;
      if(IS_ENABLE_LOG)
         Print("User is Regular");
     }
   double lotSize = 0.01;

   lotSize = MathCeil(AccountBalance() * BalanceRiskVolume / 10000) / 10;

   if(IS_ENABLE_LOG)
      Print("lotSize = ",lotSize);


   if(AccountIsMini)
     {
      lotSize = lotSize * 10;
     }

   if(lotSize < 0.01)
     {
      lotSize = 0;
     }

   if(lotSize > 1)
     {
      lotSize = MathCeil(lotSize);
     }

   if(lotSize > 100)
     {
      lotSize = 100;
     }

   return lotSize;

  }

//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double CLiveOrderManagement::OrderLotDetermine_SL_Risk_Base(int nSLDistance_InPip, double fOpenOrderPrice)
  {
   /*
   // Standard Lot=1, Mini=0.1 and Micro=0.01
   //AccountBalance * percent/100 = RISK = OrderLots * (|OrderOpenPrice - OrderStopLoss| * DeltaPerLot + CommissionPerLot) (Note OOP-OSL includes the spread,
   and DeltaPerLot is usually around $10/pip but it takes account of the exchange rates of the pair vs. your account currency.)
   //Do NOT use TickValue by itself - DeltaPerLot and verify that MODE_TICKVALUE is returning a value in your deposit currency,
   as promised by the documentation, or whether it is returning a value in the instrument's base currency.
   //
   Do NOT use TickValue by itself - DeltaPerLot and verify that MODE_TICKVALUE is returning a value in your deposit currency, as promised by the documentation, or whether it is returning a value in the instrument's base currency.
   ۱ لات = هر پیپ ۱۰ دلار محاسبه می­‌شود

   ۰٫۱ لات = هر پیپ ۱ دلار محاسبه می­‌شود

   ۰٫۰۱ لات = هر پیپ ۱۰ سنت محاسبه می­‌شود.

   //pip change of 1 , in axarin ragham

   // Hesabe Man MiniLot hast

   MODE_TICKVALUE : 1.0 MODE_TICKSIZE : 1e-05

   TICKSIZE is wrong ,
    */

//--- calculating loss
//double Value_Per_Point = MarketInfo(m_strSymbol, MODE_TICKVALUE) / (MarketInfo(m_strSymbol, MODE_TICKSIZE));
   double Value_Per_Point = MarketInfo(m_strSymbol, MODE_TICKVALUE);
//NormalizeDouble( (AccountBalance() * BalanceRiskVolume )/ (ManualStopLoss * Value_Per_Point+ MarketInfo (m_strSymbol, MODE_MARGINREQUIRED)), 2);
   double OrderSize = 0.0 ;
////Calculate Distance In m_fPOINT From fSLPrice
//Cause RoboForex , XAUUSD 15 , Profit From $500 To $743 not DrawDown Increase
   bool bStrategy_BigStop_MoreRisk = (!m_nBigStop_FixedLot || nSLDistance_InPip < 1000) ;
   if(AccountFreeMargin()<0 || nSLDistance_InPip<40)
     {
      return 0;
     }
   if(m_nLotManagementMethod == ENUM_LOT_MANAGEMENT_SL_BELOW_SMV && (nSLDistance_InPip * Value_Per_Point) > 0.f && bStrategy_BigStop_MoreRisk)
     {
      OrderSize = NormalizeDouble((AccountBalance() * BalanceRiskVolume)/ (/*10 **/ nSLDistance_InPip * Value_Per_Point), 2);
      if(IS_ENABLE_LOG)
         Print("OrderLotDetermine_SL_Risk_Base : nSLDistance_InPip : ", nSLDistance_InPip, " OrderSize ",OrderSize," Value_Per_Point : ",  Value_Per_Point, " MODE_TICKVALUE : ", MarketInfo(m_strSymbol, MODE_TICKVALUE), " MODE_TICKSIZE : ", MarketInfo(m_strSymbol, MODE_TICKSIZE));
      if(IS_ENABLE_LOG)
         Print("OrderLotDetermine_SL_Risk_Base : FreeMargin : ", AccountFreeMargin());

     }
   else
     {
      OrderSize = NormalizeDouble((AccountBalance() * BalanceRiskVolume)/ 1000, 2);

     }
//Print ("You can\'t afford to open the smallest lot : ", OrderSize , " Use Minimum Lot : ", MarketInfo (m_strSymbol, MODE_MINLOT));
   if(OrderSize > MarketInfo(m_strSymbol, MODE_MAXLOT))
     {
      OrderSize = MarketInfo(m_strSymbol, MODE_MAXLOT);
      if(IS_ENABLE_LOG)
         Print("You can\'t afford to open the order lot : ", OrderSize, " Use Maximum Lot : ", MarketInfo(m_strSymbol, MODE_MAXLOT));
     }
   if(OrderSize < MarketInfo(m_strSymbol, MODE_MINLOT))
     {
      //Strategy Before this I used MODE_MINLOT , but this wrong , Now I used 0
      if(IS_ENABLE_LOG)
         Print("You can\'t afford to open the smallest lot : ", OrderSize, " Use 0 Lot : ", MarketInfo(m_strSymbol, MODE_MINLOT));
      OrderSize = 0;
     }
   else
     {
      OrderSize -= MarketInfo(m_strSymbol, MODE_MINLOT);
      int size_lot = 0;
      if(OrderSize >= MarketInfo(m_strSymbol, MODE_LOTSTEP)&& MarketInfo(m_strSymbol, MODE_LOTSTEP) > 0)
         size_lot = int (OrderSize / MarketInfo(m_strSymbol, MODE_LOTSTEP));
      OrderSize = MarketInfo(m_strSymbol, MODE_MINLOT)+(size_lot* MarketInfo(m_strSymbol, MODE_LOTSTEP));
     }


   return OrderSize;
  }
//+------------------------------------------------------------------+
double CLiveOrderManagement::FixedPercentOfBalanceV3()
  {
   double Value_Per_Point = MarketInfo(m_strSymbol, MODE_TICKVALUE) / (MarketInfo(m_strSymbol, MODE_TICKSIZE));
   int LotDigits      = 1;
   int Digit_Factor   = 1;
//How to use the Lotsize and Lotstep values below to adjust
//the tradesize for different brokers automatically?
   double Lotsize = MarketInfo(m_strSymbol,MODE_LOTSIZE);

   double Lotstep = MarketInfo(m_strSymbol,MODE_LOTSTEP);
//====================================================================================
//Gather broker trade details 2, 3, 4, 5, 6, 7 m_nDIGITS & volume information

   if(m_nDIGITS == 2 || m_nDIGITS == 4)
      Digit_Factor = 1;
   if(m_nDIGITS == 3 || m_nDIGITS == 5)
      Digit_Factor = 10;
   if(m_nDIGITS == 6)
      Digit_Factor = 100;

   if(m_nDIGITS == 7)
      Digit_Factor = 1000;
   double One_Tick = MarketInfo(m_strSymbol,MODE_TICKVALUE) * Digit_Factor;
   double MaxLot = MarketInfo(m_strSymbol, MODE_MAXLOT);
   double MinLot = MarketInfo(m_strSymbol, MODE_MINLOT);
   if(Lotstep == 0.01)
      LotDigits = 2;
//====================================================================================
//Calculate the trade volume based on the desired stoploss + spread & risk
//double Ask = MarketInfo(m_strSymbol, MODE_ASK);
//double Bid = MarketInfo(m_strSymbol, MODE_BID);
   double fAsk = SymbolInfoDouble(m_strSymbol,SYMBOL_ASK); // Best Buy Offer
   double fBid = SymbolInfoDouble(m_strSymbol,SYMBOL_BID); // Best Buy Offer
   double spread = fAsk - fBid;
//
   double SL =  MathAbs((m_poIndicatorInterface.m_oMVCrossDis.GetMovingAverageSlowValue() - (fBid+fAsk)/2)) ;


   double Risk_In_Money = ((SL+spread)/m_fPOINT/Digit_Factor) * One_Tick;
// %risk = $ loss >>> SL = allowed volume
//To use account balance replace AccountEquity() with  AccountBalance()
   double tradesize = NormalizeDouble(((AccountEquity() * BalanceRiskVolume)/Risk_In_Money),LotDigits);

//Print ("FixedPercentOfBalanceV3 SL: ", SL , " Risk_In_Money : ", Risk_In_Money, " TradeSize : " , tradesize);

   if(tradesize > MaxLot)
      tradesize = MaxLot;
   if(tradesize < MinLot)
      tradesize = MinLot;

   return tradesize;

  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
