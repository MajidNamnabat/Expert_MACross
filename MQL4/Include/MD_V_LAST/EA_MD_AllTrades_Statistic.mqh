//+------------------------------------------------------------------+
//|                                              TradesStatistic.mqh |
//|                                                  Majid Namanabat |
//|                                                maj.nam@gmail.com |
//+------------------------------------------------------------------+
/*
   This is Journal and I thought Journal in money managemenet is necessary
*/
#property copyright "Majid Namanabat"
#property link      "maj.nam@gmail.com"
#property version   "1.00"
#property strict
#include <MD_V_LAST\\EA_MD_UtilityFunctions.mqh>
#include <MD_V_LAST\\EA_StatisticCalculator.mqh>
#include <MD_V_LAST\\EA_MD_SymbolTradesStatistic.mqh>

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class CAllTradesStatistic
  {
public:

                     CAllTradesStatistic();
                    ~CAllTradesStatistic();
   CSymbolTradesStatistic m_oSymbolTradesStatistic[];
   int               m_nTradeCount;
   int               m_nBreakEvened;
   int               m_nTrailed;
   CStatisticCalculator m_oWinTradesStat;
   CStatisticCalculator m_oWinPipDistance;
   CStatisticCalculator m_oSLPipDistance;

   CStatisticCalculator m_oLossTradeStat;
   CStatisticCalculator m_oAllTradeStat;
   double            m_fWinRatio;
   double            m_fProfitFactor;
   double            m_fInitialDeposit;
   double            m_fNetProfit;
   CStatisticCalculator m_oCommission;

   void              OrderOpened(string strSymbol, int nTimeFrame, int nCommand, int nTicket, double fLots, double fOpenPrice, datetime dtOpenTime, double fFMV_Value, double fSMV_Value, int nSLDistance_InPip);
   void              OrderClosed(string strSymbol,  int nTicket);
   void              HistoryScanner(string strSymbol = "");
   void              TrailingActivated(string strSymbol,  int nTicket);
   void              BreakEvenActivated(string strSymbol,  int nTicket);
   void              CalcStatistics(ENUM_ORDERS_INVESTIGATE_STATE nInvestigateMethod, int nSTIndex = -1);
   void              CalcMaximumDrawDownPercent_Offline();
   void              Insert_Symbol_TF(string strSymbol, int nTimeFrame, bool isAnalyse_ShortTermTrades,datetime dtExpert_TimeInit);
   ENUM_FEELING      GetShortTermFeeling(string strSymbol, int nTimeFrame);
private:
   void              UpdateStatistics(string strSymbol, int nTicket, double fCommision);
   int               FindSymbol_TF(string strSymbol, int nTimeFrame);
   int               FindSymbol_Ticket(string strSymbol, int nTicket);
   datetime          m_dtExpert_TimeInit;
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
CAllTradesStatistic::CAllTradesStatistic()
  {
   m_nTradeCount = -1;
   m_fProfitFactor =0;
   m_fWinRatio = 0;
   m_fInitialDeposit = 0.f;
   double fBalance = AccountInfoDouble(ACCOUNT_BALANCE);
   m_nBreakEvened = 0;
   m_nTrailed = 0;
   m_dtExpert_TimeInit = 0;
   m_fNetProfit = 0;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
CAllTradesStatistic::~CAllTradesStatistic()
  {
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CAllTradesStatistic::OrderOpened(string strSymbol, int nTimeFrame, int nCommand, int nTicket, double fLots, double fOpenPrice, datetime dtOpenTime,double fFMV_Value, double fSMV_Value, int nSLDistance_InPip)
  {
   int nSTIndex = FindSymbol_TF(strSymbol,nTimeFrame);
   if(nSTIndex < 0)
     {
      return;
     }
   m_oSymbolTradesStatistic[nSTIndex].OrderOpened(nCommand,nTicket,fLots,fOpenPrice,dtOpenTime,fFMV_Value,fSMV_Value,nSLDistance_InPip);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CAllTradesStatistic::OrderClosed(string strSymbol, int nTicket)
  {
   int nSTIndex = FindSymbol_Ticket(strSymbol,nTicket);
   if(nSTIndex < 0)
     {
      return;
     }
   if(m_oSymbolTradesStatistic[nSTIndex].OrderClosed(nTicket) && OrderSelect(nTicket,SELECT_BY_TICKET,MODE_HISTORY))
     {
      //Print("CAllTradesStatistic::OrderClosed ", "Order Closed Return TRUE ");
      UpdateStatistics(OrderSymbol(),OrderTicket(),OrderCommission());
     }
  }


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CAllTradesStatistic::HistoryScanner(string strSymbol = "")
  {


   int nTicket = SelectMostRecentClosedIn24H(strSymbol, MACROSS_MAGIC_NUM , m_dtExpert_TimeInit);
   if(nTicket<0)
     {
      return;
     }
   if(OrderSelect(nTicket, SELECT_BY_TICKET, MODE_HISTORY))
     {
      int nSTIndex = FindSymbol_Ticket(OrderSymbol(),nTicket);
      if(nSTIndex < 0)
        {
         Print("CAllTradesStatistic::UpdateStatistics ERROR !!! nSTIndex < 0");
         return;
        }
      int nIndex = m_oSymbolTradesStatistic[nSTIndex].FindOrder(nTicket);
      if(nIndex < 0)
        {
         Print("CAllTradesStatistic::UpdateStatistics ERROR !!! nIndex < 0");
         return;
      }
      //Print("HistoryScanner " , EnumToString(m_oSymbolTradesStatistic[nSTIndex].m_oTrades[nIndex].m_nOrderActive) , " " , MathAbs(OrderCommission()) );
      ENUM_ORCLOSE_STATUS nStatus ;
      if(m_oSymbolTradesStatistic[nSTIndex].m_oTrades[nIndex].m_nOrderActive != ENUM_ORDER_FLAG_HISTORY && ( OrderType()==OP_BUY || OrderType()==OP_SELL))
        {
         ENUM_ORCLOSE_STATUS nCloseAction = m_oSymbolTradesStatistic[nSTIndex].m_oTrades[nIndex].m_nCloseAction;
         nStatus = (nCloseAction != ENUM_ORCLOSE_STATUS_TRAILING && nCloseAction != ENUM_ORCLOSE_STATUS_BREAKEVEN && OrderProfit()<=0) ? ENUM_ORCLOSE_STATUS_SL : nCloseAction;
         nStatus = (nCloseAction != ENUM_ORCLOSE_STATUS_TRAILING && nCloseAction != ENUM_ORCLOSE_STATUS_BREAKEVEN && OrderProfit()>0) ? ENUM_ORCLOSE_STATUS_CLOSE : nStatus;

         if(IS_ENABLE_LOG)
            Print("HistoryScanner ", nTicket, "  ",nIndex);
         m_oSymbolTradesStatistic[nSTIndex].OrderHistoried(nStatus,OrderTicket(),nIndex,OrderLots(),OrderOpenPrice(),OrderClosePrice(),OrderCloseTime(),OrderProfit()+OrderCommission()+OrderSwap(),OrderCommission());
         UpdateStatistics(OrderSymbol(),OrderTicket(),OrderCommission());
        }
     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CAllTradesStatistic::UpdateStatistics(string strSymbol, int nTicket, double fCommision)
  {
   int nSTIndex = FindSymbol_Ticket(strSymbol,nTicket);
   if(nSTIndex < 0)
     {
         Print("CAllTradesStatistic::UpdateStatistics ERROR !!! nSTIndex < 0");
         return;
     }
   int nIndex = m_oSymbolTradesStatistic[nSTIndex].FindOrder(nTicket);
   if(nIndex < 0)
     {
      Print("CAllTradesStatistic::UpdateStatistics ERROR !!! nIndex < 0");
      return;
     }
   m_oAllTradeStat.Update(m_oSymbolTradesStatistic[nSTIndex].m_oTrades[nIndex].m_fProfit);
   m_nTradeCount = m_oAllTradeStat.m_nCount;
   double fBalance = AccountInfoDouble(ACCOUNT_BALANCE);
   double fProfit = m_oSymbolTradesStatistic[nSTIndex].m_oTrades[nIndex].m_fProfit;
   if(fProfit>0)
     {
      m_oWinTradesStat.Update(fProfit);
      m_oWinPipDistance.Update(m_oSymbolTradesStatistic[nSTIndex].m_oTrades[nIndex].m_nCloseDistance);
      //Print("CAllTradesStatistic::UpdateStatistics " , EnumToString(m_oSymbolTradesStatistic[nSTIndex].m_oTrades[nIndex].m_nCloseAction));
      if(m_oSymbolTradesStatistic[nSTIndex].m_oTrades[nIndex].m_nCloseAction ==ENUM_ORCLOSE_STATUS_BREAKEVEN)
         m_nBreakEvened++;
      if(m_oSymbolTradesStatistic[nSTIndex].m_oTrades[nIndex].m_nCloseAction ==ENUM_ORCLOSE_STATUS_TRAILING)
         m_nTrailed++;

     }
   else
      if(fProfit<0)
        {
         m_oLossTradeStat.Update(MathAbs(fProfit));

        }
   m_oSLPipDistance.Update(m_oSymbolTradesStatistic[nSTIndex].m_oTrades[nIndex].m_nOpenSLDistance);
   m_oCommission.Update(fCommision);
   if(m_oSymbolTradesStatistic[nSTIndex].IsAnalyse_ShortTermTrades())
     {
      CalcStatistics(ENUM_ORDERS_INVESTIGATE_SYMBOL_ONLY, nSTIndex);

      m_oSymbolTradesStatistic[nSTIndex].m_nShortTermFeeling = m_oSymbolTradesStatistic[nSTIndex].Trades_ShortTime_Analyse(m_fInitialDeposit);
     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CAllTradesStatistic::Insert_Symbol_TF(string strSymbol, int nTimeFrame, bool isAnalyse_ShortTermTrades,datetime dtExpert_TimeInit)
  {
   m_dtExpert_TimeInit = dtExpert_TimeInit;
   int nSymbolTF = FindSymbol_TF(strSymbol,nTimeFrame);
   if(nSymbolTF>=0)
     {
      m_oSymbolTradesStatistic[nSymbolTF].Setup(strSymbol,nTimeFrame,isAnalyse_ShortTermTrades);
      return;
     }
   ArrayResize(m_oSymbolTradesStatistic,ArraySize(m_oSymbolTradesStatistic)+1);
   int nLastIndex = ArraySize(m_oSymbolTradesStatistic)-1;
   m_oSymbolTradesStatistic[nLastIndex].Setup(strSymbol,nTimeFrame,isAnalyse_ShortTermTrades);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int CAllTradesStatistic::FindSymbol_TF(string strSymbol, int nTimeFrame)
  {
   for(int n=ArraySize(m_oSymbolTradesStatistic)-1; n>=0; n--)
     {
      if(m_oSymbolTradesStatistic[n].m_strSymbol == strSymbol && m_oSymbolTradesStatistic[n].m_nTimeFrame == nTimeFrame)
         return n;
     }
   return -1;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int   CAllTradesStatistic::FindSymbol_Ticket(string strSymbol, int nTicket)
  {
   for(int n=ArraySize(m_oSymbolTradesStatistic)-1; n>=0; n--)
     {
      if(m_oSymbolTradesStatistic[n].m_strSymbol == strSymbol && m_oSymbolTradesStatistic[n].FindOrder(nTicket)>=0)
        {
         return n;
        }
     }
   return -1;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void              CAllTradesStatistic::TrailingActivated(string strSymbol, int nTicket)
  {
   int nSTIndex = FindSymbol_Ticket(strSymbol,nTicket);
   if(nSTIndex < 0)
     {
      Print("CAllTradesStatistic::TrailingActivated ERROR !!! nSTIndex < 0");
      return;
     }
   m_oSymbolTradesStatistic[nSTIndex].TrailingActivated(nTicket);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void              CAllTradesStatistic::BreakEvenActivated(string strSymbol, int nTicket)
  {
   int nSTIndex = FindSymbol_Ticket(strSymbol,nTicket);
   if(nSTIndex < 0)
     {
      Print("CAllTradesStatistic::BreakEvenActivated ERROR !!! nSTIndex < 0");
      return;
     }
   m_oSymbolTradesStatistic[nSTIndex].BreakEvenActivated(nTicket);
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CAllTradesStatistic::CalcStatistics(ENUM_ORDERS_INVESTIGATE_STATE nInvestigateMethod, int nSTIndex = -1)
  {
   if(IS_ENABLE_LOG)
     {
      string row = StringFormat("CalcStatistics %d;%d;%.2f;%.2f",
                                m_oWinTradesStat.m_nCount, m_oLossTradeStat.m_nCount, m_oWinTradesStat.m_fSum,
                                m_oLossTradeStat.m_fSum);
      Print(row);
     }
   if((m_oWinTradesStat.m_nCount + m_oLossTradeStat.m_nCount)>0)
      m_fWinRatio = (double) m_oWinTradesStat.m_nCount / (m_oWinTradesStat.m_nCount + m_oLossTradeStat.m_nCount) ;
   else
      m_fWinRatio = 0.f;
   if((m_oWinTradesStat.m_fSum + m_oLossTradeStat.m_fSum)>0)
     {
      m_fNetProfit = (m_oWinTradesStat.m_fSum - m_oLossTradeStat.m_fSum);
      m_fInitialDeposit = AccountInfoDouble(ACCOUNT_BALANCE) - m_fNetProfit;
      //m_fProfitFactor = (double) AccountInfoDouble(ACCOUNT_BALANCE) / m_fInitialDeposit ;
      //profit factor = gross profits / gross losses
      if(MathAbs(m_oLossTradeStat.m_fSum)>0)
        {
         m_fProfitFactor = (double) m_oWinTradesStat.m_fSum / MathAbs(m_oLossTradeStat.m_fSum) ;
        }
      else
        {
         m_fProfitFactor = 10.f;
        }

     }
   else
     {
      m_fProfitFactor =  0.f;
      m_fInitialDeposit = AccountInfoDouble(ACCOUNT_BALANCE);
     }
   if(nInvestigateMethod == ENUM_ORDERS_INVESTIGATE_ALL)
     {
      for(int n=ArraySize(m_oSymbolTradesStatistic)-1; n>=0; n--)
        {
         m_oSymbolTradesStatistic[n].CalcStatistics();
        }
     }
   else
      if(nSTIndex >=0)
        {
         m_oSymbolTradesStatistic[nSTIndex].CalcStatistics();
        }
  }
//+------------------------------------------------------------------+
ENUM_FEELING CAllTradesStatistic::GetShortTermFeeling(string strSymbol, int nTimeFrame)
  {
   int nSTIndex = FindSymbol_TF(strSymbol,nTimeFrame);
   if(nSTIndex < 0)
     {
      return ENUM_FEELING_UNKNOWN;
     }
   return m_oSymbolTradesStatistic[nSTIndex].m_nShortTermFeeling;
  }
//+------------------------------------------------------------------+
