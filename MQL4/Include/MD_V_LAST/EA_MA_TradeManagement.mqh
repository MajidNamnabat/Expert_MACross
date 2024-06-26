//+------------------------------------------------------------------+
//|                                        EA_MA_TradeManagement.mqh |
//|                                                   Majid Namnabat |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Majid Namnabat"
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict

#include <EA_UtilityFunction.mqh>
#include <EA_MACross_Types.mqh>
const int STEP_OSCILLATION_COUNT = 3 ;
const int STEP_MIN_BAR_DISTANCE = 5 ;
const int COMPENSATE_MIN_BAR_DISTANCE = 5 ;
enum ENUM_ORDER_STATE  // Enumeration of named constants
  {
   ENUM_ORDER_ZERO=1,
   ENUM_ORDER_BUY=2,
   ENUM_ORDER_SELL=3,
   ENUM_ORDER_BUY_PENDING = 4,
   ENUM_ORDER_SELL_PENDING = 5,
   ENUM_ORDER_UNKNOWN = 6//,
//ENUM_ORDER_NOTALLOWED_LOCK = 5
  };
enum ENUM_ORDER_SIZE
  {
   ENUM_ORDER_SIZE_FULL,
   ENUM_ORDER_SIZE_STEP
  };
enum ENUM_TRACK_ORDER_TRADE
  {
   ENUM_TRACK_ORDER_INIT,
   ENUM_TRACK_ORDER_INIT_PENDING,
   ENUM_TRACK_ORDER_CLOSE,
   ENUM_TRACK_STEP_ORDERED,
   ENUM_TRACK_STEP_COMPENSATED,
   ENUM_TRACK_ORDER_INIT_MODIFY_TICKET
  };
struct stctTradeHistory
  {
   int               m_nInitOrder_Ticket;
   int               m_nLastCompensate_Ticket;
   double            m_fInitialLots;
   int               m_nStepCount;
   double            m_fStepClosePrice;
   datetime          m_dtLastStep_Date;
   datetime          m_dtLastCompensate_Date;
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class EA_MA_TradeManagement
  {
private:
   ENUM_ORDER_STATE  m_nOrderState;
   bool              m_bOpenOrder_Allow;
public:
   stctTradeHistory m_stTradeHistory ;
   void              ResetHistory();
   void              ChangeHistory(ENUM_TRACK_ORDER_TRADE nCommand, double fLots, double fPrice, int nTicket, datetime dtTime, int nCompensateCount = 1);
   double            GetLotOneStep() ;
   //sometime two step is done , after that compensate must all two step , double lots
   int               GetCompensateRemindCount();

   bool               GetInitOrderProfit(double &fProfit, double &fPips);
   bool               Get_StepCloseOrder_PipsDistance(double &fPips);
   double              GetInitOrder_SL();
   bool              Allow_StepTrade();
   bool              Allow_StepCompensate();

   void              SetOrderState(ENUM_ORDER_STATE nOrderState) { m_nOrderState = nOrderState;}
   ENUM_ORDER_STATE  GetOrderState() {return m_nOrderState;}
   int               GetInitOrderTicket() { return m_stTradeHistory.m_nInitOrder_Ticket;}
   int               GetLastStepCompensateTicket() { return m_stTradeHistory.m_nLastCompensate_Ticket; }
   void              Prohibit_OpenOrder() {m_bOpenOrder_Allow = false;}
   void              Allow_OpenOrder() {m_bOpenOrder_Allow = true;}
   bool              Is_OpenOrder_Allow() {return m_bOpenOrder_Allow;}

                     EA_MA_TradeManagement();
                    ~EA_MA_TradeManagement();

   void              DetermineOrderState();
   bool              GetInitOrder_SL_TP(double& SL, double& TP);
   bool              CloseOrder(int nTicket,double fLots,double fClosePrice);
   bool              DeleteOrder(int nTicket);
   int               PartialCloseOrder(int nMagicNum,int nTicket,double fLots,double fClosePrice);
   int               OpenOrder(int nMagicNum,int nCommand,double fOpenPrice, double fLots, double fSLPrice, double fTPPrice,string strComment = NULL);
   bool              IsMustNowRest_CauseBigLoss(int nRestHours, double fBalanceRiskVolume,double fLoss_RiskBalance_Ratio_Rest);
   bool              CheckPending_Activated();
   void              RemoveAllPendings();
   bool              TimeManager_AllowOpen(ENUM_TIME_TRADE_MANAGEMENT nTimeTradeSetting);
   bool              TimeManager_MustCloseOrder(ENUM_TIME_TRADE_MANAGEMENT nTimeTradeSetting);
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
EA_MA_TradeManagement::EA_MA_TradeManagement()
  {
   m_nOrderState = ENUM_ORDER_UNKNOWN;
   m_bOpenOrder_Allow = true;
   m_stTradeHistory.m_fInitialLots=0;
   m_stTradeHistory.m_nStepCount=0;
   m_stTradeHistory.m_fStepClosePrice=0.f;
   m_stTradeHistory.m_nInitOrder_Ticket = -1;
   m_stTradeHistory.m_nLastCompensate_Ticket = -1;
   m_stTradeHistory.m_dtLastStep_Date= -1;
   m_stTradeHistory.m_dtLastCompensate_Date = -1;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
EA_MA_TradeManagement::~EA_MA_TradeManagement()
  {
  }
//+------------------------------------------------------------------+
void EA_MA_TradeManagement::ResetHistory()
  {
   m_stTradeHistory.m_fInitialLots=0;
   m_stTradeHistory.m_nStepCount=0;
   m_stTradeHistory.m_fStepClosePrice=0.f;
   m_stTradeHistory.m_nInitOrder_Ticket = -1;
   m_stTradeHistory.m_nLastCompensate_Ticket = -1;
   m_stTradeHistory.m_dtLastStep_Date= -1;
   m_stTradeHistory.m_dtLastCompensate_Date = -1;

  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void EA_MA_TradeManagement::DetermineOrderState()
  {
   int nSell=0,nBuy=0,nPendingSell=0,nPendingBuy=0,nTotalMarketOrder;
   nTotalMarketOrder = SpecialOrdersTotal(MACROSS_MAGIC_NUM,nBuy,nSell,nPendingBuy,nPendingSell);
   m_nOrderState = (nTotalMarketOrder == 0) ? ENUM_ORDER_ZERO : ENUM_ORDER_UNKNOWN;
   m_nOrderState = (nSell > 0 && nBuy == 0) ? ENUM_ORDER_SELL : m_nOrderState;
   m_nOrderState = (nSell == 0 && nBuy > 0) ? ENUM_ORDER_BUY : m_nOrderState;

   m_nOrderState = (nSell == 0 && nBuy == 0 && nPendingBuy > 0) ? ENUM_ORDER_BUY_PENDING : m_nOrderState;
   m_nOrderState = (nSell == 0 && nBuy == 0 && nPendingSell > 0) ? ENUM_ORDER_SELL_PENDING : m_nOrderState;

//return m_nOrderState;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double            EA_MA_TradeManagement::GetLotOneStep()
  {
//Print ("GetLotOneStep " , m_stTradeHistory.m_fInitialLots);
   return m_stTradeHistory.m_fInitialLots/STEP_OSCILLATION_COUNT;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool EA_MA_TradeManagement::Allow_StepCompensate(void)
  {
   bool bAllowed = (m_stTradeHistory.m_nStepCount > 0);
   if(!bAllowed)
      return false;
   if(m_stTradeHistory.m_dtLastCompensate_Date > 0)
     {
      int nBarElapsed =  GetBarsElapsed(m_stTradeHistory.m_dtLastCompensate_Date);
      bAllowed = nBarElapsed >= COMPENSATE_MIN_BAR_DISTANCE ;
      if(!bAllowed)
         return false;
     }
   return bAllowed;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool EA_MA_TradeManagement::Allow_StepTrade()
  {

   bool bAllowed = m_stTradeHistory.m_nStepCount < STEP_OSCILLATION_COUNT - 1 ;
   if(!bAllowed)
      return false;
   int nBarElapsed =  GetBarsElapsed(m_stTradeHistory.m_dtLastStep_Date);
   bAllowed = nBarElapsed >= STEP_MIN_BAR_DISTANCE ;
   if(!bAllowed)
      return false;
   return bAllowed;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void EA_MA_TradeManagement::ChangeHistory(ENUM_TRACK_ORDER_TRADE nCommand, double fLots, double fPrice, int nTicket, datetime dtTime, int nCompensateCount = 1)
  {
   switch(nCommand)
     {
      case ENUM_TRACK_ORDER_INIT:
         m_stTradeHistory.m_fInitialLots = fLots;
         m_stTradeHistory.m_nStepCount = 0;
         m_stTradeHistory.m_nInitOrder_Ticket = nTicket;
         break;
      case ENUM_TRACK_ORDER_INIT_PENDING:
         m_stTradeHistory.m_fInitialLots = 0.f;
         m_stTradeHistory.m_nStepCount = 0;
         m_stTradeHistory.m_nInitOrder_Ticket = nTicket;
         break;
      case ENUM_TRACK_ORDER_CLOSE:
         m_stTradeHistory.m_nStepCount = 0;
         break;
      case ENUM_TRACK_STEP_ORDERED:
         m_stTradeHistory.m_fStepClosePrice = fPrice;
         m_stTradeHistory.m_dtLastStep_Date = dtTime ;
         m_stTradeHistory.m_nStepCount++;
         break;
      case ENUM_TRACK_STEP_COMPENSATED:
         if(nCompensateCount == 1)
            m_stTradeHistory.m_nStepCount--;
         else
            m_stTradeHistory.m_nStepCount = (m_stTradeHistory.m_nStepCount - nCompensateCount) >= 0 ? m_stTradeHistory.m_nStepCount - nCompensateCount : 0 ;
         m_stTradeHistory.m_nLastCompensate_Ticket = nTicket;
         m_stTradeHistory.m_dtLastCompensate_Date = dtTime ;
         break;
      case ENUM_TRACK_ORDER_INIT_MODIFY_TICKET:
         m_stTradeHistory.m_nInitOrder_Ticket = nTicket;
         //Mistake , 1/3 1/3 must decrease
         //m_stTradeHistory.m_fInitialLots = fLots;
         break;
     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool EA_MA_TradeManagement::GetInitOrder_SL_TP(double& fSL, double& fTP)
  {
   fSL =0.f;
   fTP = 0.f;
   if(OrderSelect(m_stTradeHistory.m_nInitOrder_Ticket, SELECT_BY_TICKET, MODE_TRADES) == false)
     {
      if(IS_ENABLE_LOG) Print("ERROR - Unable to select the order - ",GetLastError());
      return false;
     }
   fSL = OrderStopLoss();
   fTP = OrderTakeProfit();
   return true;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool EA_MA_TradeManagement::CloseOrder(int nTicket,double fLots,double fClosePrice)
  {
   bool bResult = false;
   int nSlippage=3;  //Slippage in pips
   nSlippage = MathMod(Digits,2)==1 ? nSlippage*=10 : nSlippage ;
   for(int j=1; j<10; j++)
     {
      bResult=OrderClose(nTicket,fLots,fClosePrice,nSlippage,Red);
      if(bResult)
        {

         if(IS_ENABLE_LOG) Print("TRADE - CLOSED - Order , Return True ",nTicket," closed at price ",fClosePrice);
         //if(IS_ENABLE_LOG) Print("MVDistancePoint = ",m_MVCrossDis.GetMVDistanceInPoint());


         break;
        }
      else
        {
         if(IS_ENABLE_LOG) Print("ERROR - CLOSED - error closing order ",nTicket," return error: ",GetLastError());
        }
     }
   return bResult;

  }
//+------------------------------------------------------------------+
//| When a Partial of an Order is Closed , An New Order with New Ticket Opened Remind Lot                                                           |
//+------------------------------------------------------------------+
int   EA_MA_TradeManagement::PartialCloseOrder(int nMagicNum,int nTicket,double fLots,double fClosePrice)
  {
   bool bResult = false;
   int nSlippage=3;  //Slippage in pips
   nSlippage = MathMod(Digits,2)==1 ? nSlippage*=10 : nSlippage ;
   int before_close[], i = 0, j = 0, array_size = 0;
   bool new_order = false;
   int nNewTicket = -1 ;
   ResetLastError();
   for(i = OrdersTotal() - 1; i >= 0; i--)
     {
      if(OrderSelect(i, SELECT_BY_POS,MODE_TRADES))
        {
         if(OrderSymbol()==Symbol() && OrderMagicNumber() ==  nMagicNum)                                    // should also include: OrderMagicNumber() == EA_MagicNumber
           {
            if(OrderType() <= 5)
              {
               array_size = ArrayRange(before_close, 0) + 1;
               ArrayResize(before_close, array_size);
               before_close[array_size - 1] = OrderTicket();
              }
           }
        }
     }
   for(j=1; j<10; j++)
     {
      bResult=OrderClose(nTicket,fLots,fClosePrice,nSlippage,Red);
      if(bResult)
        {
         for(i = OrdersTotal() - 1; i >=0; i--)
           {
            if(OrderSelect(i, SELECT_BY_POS,MODE_TRADES))
              {
               if(OrderSymbol() == Symbol() && OrderMagicNumber() ==  nMagicNum)     // should also include: OrderMagicNumber() == EA_MagicNumber
                 {
                  if(OrderType() <= 1)
                    {
                     // only open OP_BUY and OP_SELL orders
                     for(j = 0; j < ArrayRange(before_close, 0); j++)
                       {
                        new_order = false;
                        if(before_close[j] != OrderTicket())
                          { new_order = true; break;}
                       }
                     if(new_order)
                        nNewTicket = (OrderTicket());
                    }
                 }
              }
           }
         if(IS_ENABLE_LOG) Print("TRADE - CLOSED - Order , Return True ",nNewTicket," closed at price ",fClosePrice);
         //if(IS_ENABLE_LOG) Print("MVDistancePoint = ",m_MVCrossDis.GetMVDistanceInPoint());


         break;
        }
      else
        {
         if(IS_ENABLE_LOG) Print("ERROR - CLOSED - error closing order ",nTicket," return error: ",GetLastError());
        }
     }
   return nNewTicket;

  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int EA_MA_TradeManagement::OpenOrder(int nMagicNum,int nCommand,double fOpenPrice,double fLots, double fSLPrice, double fTPPrice , string strComment = NULL)
  {
   int nTicket = -1;
   int nSlippage=3;  //Slippage in pips
   nSlippage = MathMod(Digits,2)==1 ? nSlippage*=10 : nSlippage ;

   if(fLots < 0.01)
     {
      if(IS_ENABLE_LOG) Print("TRADE - NEW - Order Cancel Lots Less than minimum = ",fLots);
      return false;
     }
   ResetLastError();
   for(int i=1; i<10; i++)
     {
      //RefreshRates();
      //if(IS_ENABLE_LOG) Print("OrderSend : " , nCommand ," " , Ask , " " , nSlippage , " ", NormalizeDouble(fSLPrice,Digits) ," " , NormalizeDouble(fTPPrice,Digits) );
      nTicket=OrderSend(Symbol(),nCommand,fLots,fOpenPrice,nSlippage,
                        NormalizeDouble(fSLPrice,Digits), // Stop loss price.
                        NormalizeDouble(fTPPrice,Digits), // Take profit price.
                        strComment,nMagicNum,0,Green);

      if(nTicket>0)
        {
         if(IS_ENABLE_LOG) Print("TRADE - NEW - Order submitted: Command ",nCommand," Volume ",fLots," Open ",nCommand," Slippage ",nSlippage," Stop ",fSLPrice," Take ",fTPPrice);
         //if(IS_ENABLE_LOG) Print("MVDistancePoint = ",m_MVCrossDis.GetMVDistanceInPoint());
         //IsOPenOrder_NextCross=true;
         break;
        }
      else
        {
         if(IS_ENABLE_LOG) Print("ERROR - NEW - error sending order, return error: ",GetLastError());
         RefreshRates();
        }
     }
   return nTicket;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool  EA_MA_TradeManagement::GetInitOrderProfit(double &fProfit, double &fPip)
  {
   if(OrderSelect(m_stTradeHistory.m_nInitOrder_Ticket, SELECT_BY_TICKET, MODE_TRADES) == false)
     {
      if(IS_ENABLE_LOG) Print("ERROR - Unable to select the order - ",GetLastError());
      return false;
      //break;
     }
   fProfit =  OrderProfit();
   fPip = (OrderProfit() - OrderCommission()) / OrderLots() / MarketInfo(OrderSymbol(), MODE_TICKVALUE);

   return true;
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double EA_MA_TradeManagement::GetInitOrder_SL()
  {
   if(OrderSelect(m_stTradeHistory.m_nInitOrder_Ticket, SELECT_BY_TICKET, MODE_TRADES) == false)
     {
      if(IS_ENABLE_LOG) Print("ERROR - Unable to select the order - ",GetLastError());
      return -1.0 ;
     }
   return OrderStopLoss();

  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool EA_MA_TradeManagement::Get_StepCloseOrder_PipsDistance(double &fPips)
  {

   if(m_stTradeHistory.m_fStepClosePrice <= 0.f)
      return false;
   fPips = ((m_stTradeHistory.m_fStepClosePrice - (Bid+Ask)/2)/Point);
   return true;

  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int               EA_MA_TradeManagement::GetCompensateRemindCount()
  {
   return m_stTradeHistory.m_nStepCount ;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool              EA_MA_TradeManagement::IsMustNowRest_CauseBigLoss(int nRestHours, double fBalanceRiskVolume,double fLoss_RiskBalance_Ratio_Rest)
  {
   datetime dtLastOrderCloseTime = 0 ;
   double fProfit = GetProfits(1,dtLastOrderCloseTime);
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
      double fProfit3Last = GetProfits(3,dtLastOrderCloseTime);
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
bool   EA_MA_TradeManagement::CheckPending_Activated()
  {
   if(m_stTradeHistory.m_fInitialLots > 0.000001)
      return true;

   if(OrderSelect(m_stTradeHistory.m_nInitOrder_Ticket, SELECT_BY_TICKET, MODE_TRADES) == false)
     {
      if(IS_ENABLE_LOG) Print("ERROR - Unable to select the order - ",GetLastError());
      return false;
     }
//it is activated
   if(OrderType()== OP_BUY || OrderType()== OP_SELL)
     {
      m_stTradeHistory.m_fInitialLots = OrderLots();
      m_nOrderState = (OrderType()== OP_BUY) ? ENUM_ORDER_BUY : m_nOrderState;
      m_nOrderState = (OrderType()== OP_SELL) ? ENUM_ORDER_SELL : m_nOrderState;
      return true;
     }
   return false;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void EA_MA_TradeManagement::RemoveAllPendings()
  {
   RefreshRates();

   for(int i = 0 ; i < OrdersTotal() ; i++)
     {
      if(OrderSelect(i, SELECT_BY_POS, MODE_TRADES) == false)
        {
         if(IS_ENABLE_LOG) Print("ERROR - Unable to select the order - ",GetLastError());
         break;
        }
      if(OrderSymbol()==Symbol()  && OrderMagicNumber() ==  MACROSS_MAGIC_NUM)
        {
         if(OrderType()==OP_BUYLIMIT || OrderType()==OP_BUYSTOP)
           {
            DeleteOrder(OrderTicket());
           }
         else
            if(OrderType()==OP_SELLLIMIT || OrderType()==OP_SELLSTOP)
              {
               DeleteOrder(OrderTicket());
              }
        }
     }

  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool              EA_MA_TradeManagement::DeleteOrder(int nTicket)
{
   bool bResult = false;
   for(int j=1; j<10; j++)
     {
      bResult=OrderDelete(nTicket);
      if(bResult)
        {
           break;
        }
      else
        {
         if(IS_ENABLE_LOG) Print("ERROR - DELETE ORDER - error deleting order ",nTicket," return error: ",GetLastError());
        }
     }
   return bResult;
}
   bool              EA_MA_TradeManagement::TimeManager_AllowOpen(ENUM_TIME_TRADE_MANAGEMENT nTimeTradeSetting)
   {
      if(DayOfWeek() != 0 && DayOfWeek() != 6 && DayOfWeek() != 5 ) // 5 is Friday
         return true;
      switch(nTimeTradeSetting)
      {
         case ENUM_TIME_TRADE_FRIDAY_ALL_NOT_OPEN :
         case ENUM_TIME_TRADE_HOLIDAY_OFFSET_FRIDAY_NOT_OPEN:
            return false;
            break;
         case ENUM_TIME_TRADE_FRIDAY_AFTERNOON_NOT_OPEN:
         case ENUM_TIME_TRADE_HOLIDAY_OFFSET_FRIDAY_AFTERNOON_NOT_OPEN:
            if(DayOfWeek() == 5 && Hour() > 15 )
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
