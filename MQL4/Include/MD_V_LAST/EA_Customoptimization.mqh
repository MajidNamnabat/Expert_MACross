//=====================================================================
//	Library for creation of custom optimization criteria
//	of Expert Advisor.
//=====================================================================

//---------------------------------------------------------------------
#property copyright 	"Dima S., 2010 م."
#property link      	"dimascub@mail.com"
//---------------------------------------------------------------------

//=====================================================================
//	Connected libraries:
//=====================================================================
#include	<Object.mqh>
#include	<Arrays\List.mqh>
#include	<Arrays\ArrayObj.mqh>

//---------------------------------------------------------------------

//=====================================================================
//	The base class for creation of custom optimization criteria:
//=====================================================================
class TCustomCriterion : public CObject
  {
protected:
   int               criterion_level;                                 // type criteria ( 0 - simple, complex, etc. )

public:
   int               GetCriterionLevel();
   virtual double    GetCriterion();                                  // get the value of optimization result
  };
//---------------------------------------------------------------------

//---------------------------------------------------------------------
//	Get type of criterion
//---------------------------------------------------------------------
int  TCustomCriterion::GetCriterionLevel()
  {
   return(this.criterion_level);
  }
//---------------------------------------------------------------------
//	Get value of the optimization result:
//---------------------------------------------------------------------
double  TCustomCriterion::GetCriterion()
  {
   return(0.0);
  }
//---------------------------------------------------------------------

//=====================================================================
//	The class for creation of "simple" custom optimization criteria:
//	ٌ ًهçَëüٍàٍîى ( Criterion ):
//=====================================================================
class TSimpleCriterion : public TCustomCriterion
  {
protected:
   ENUM_STATISTICS   stat_param_type;

public:
   ENUM_STATISTICS   GetCriterionType();                              // get type of the optimized statistical parameter

public:
   virtual double    GetCriterion();                                  // get the value of optimization result
                     TSimpleCriterion(ENUM_STATISTICS _stat);
  };
//---------------------------------------------------------------------

//---------------------------------------------------------------------
//	Constructor:
//---------------------------------------------------------------------
TSimpleCriterion::TSimpleCriterion(ENUM_STATISTICS _stat)
   :
stat_param_type(_stat)
  {
   this.criterion_level=0;
  }
//---------------------------------------------------------------------
//	Get type of the optimized statistical parameter:
//---------------------------------------------------------------------
ENUM_STATISTICS  TSimpleCriterion::GetCriterionType()
  {
   return(this.stat_param_type);
  }
//---------------------------------------------------------------------
//	Get value of the optimization result:
//---------------------------------------------------------------------
double  TSimpleCriterion::GetCriterion()
  {
   return(TesterStatistics(this.stat_param_type));
  }
//---------------------------------------------------------------------

//=====================================================================
//	The class for creation of "simple" custom optimization criteria
//	with result ( 1 / Criterion ):
//=====================================================================
class TSimpleDivCriterion : public TSimpleCriterion
  {
public:
   virtual double    GetCriterion();                                  // get the value of optimization result
                     TSimpleDivCriterion(ENUM_STATISTICS _stat);
  };
//---------------------------------------------------------------------

//---------------------------------------------------------------------
//	Constructor:
//---------------------------------------------------------------------
TSimpleDivCriterion::TSimpleDivCriterion(ENUM_STATISTICS _stat)
   :
TSimpleCriterion(_stat)
  {
  }
//---------------------------------------------------------------------
//	Get value of the optimization result:
//---------------------------------------------------------------------
double  TSimpleDivCriterion::GetCriterion()
  {
   double   temp=TesterStatistics(this.stat_param_type);
   if(temp>0.0)
     {
      return(1.0/temp);
     }
   return(0.0);
  }
//---------------------------------------------------------------------

//=====================================================================
//	The class for creation of "simple" custom optimization criteria
//	with result ( Koeff * Criterion ):
//=====================================================================
class TSimpleMulCriterion : public TSimpleCriterion
  {
private:
   double            koeff;

public:
   virtual double    GetCriterion();                                   // get value of the optimization result
                     TSimpleMulCriterion(ENUM_STATISTICS _stat,double _koeff);
  };
//---------------------------------------------------------------------

//---------------------------------------------------------------------
//	Constructor:
//---------------------------------------------------------------------
TSimpleMulCriterion::TSimpleMulCriterion(ENUM_STATISTICS _stat,double _koeff)
   :
TSimpleCriterion(_stat),
koeff(_koeff)
  {
  }
//---------------------------------------------------------------------
//	Get value of the optimization result:
//---------------------------------------------------------------------
double  TSimpleMulCriterion::GetCriterion()
  {
   return(koeff*TesterStatistics(this.stat_param_type));
  }
//---------------------------------------------------------------------

//=====================================================================
//	The class for creation of "simple" custom optimization criteria
//	ٌ ًهçَëüٍàٍîى ( Koeff - Criterion ):
//=====================================================================
class TSimpleSubCriterion : public TSimpleCriterion
  {
private:
   double            koeff;

public:
   virtual double    GetCriterion();                                  // get the value of optimization result
                     TSimpleSubCriterion(ENUM_STATISTICS _stat,double _koeff);
  };
//---------------------------------------------------------------------

//---------------------------------------------------------------------
//	Constructor:
//---------------------------------------------------------------------
TSimpleSubCriterion::TSimpleSubCriterion(ENUM_STATISTICS _stat,double _koeff)
   :
TSimpleCriterion(_stat),
koeff(_koeff)
  {
  }
//---------------------------------------------------------------------
//	Get value of the optimization result:
//---------------------------------------------------------------------
double  TSimpleSubCriterion::GetCriterion()
  {
   return(koeff-TesterStatistics(this.stat_param_type));
  }
//---------------------------------------------------------------------

//=====================================================================
//	The class for creation of "simple" custom optimization criteria
//	ٌ ًهçَëüٍàٍîى Koeff1 * ( Koeff2 - Criterion ):
//=====================================================================
class TSimpleMulSubCriterion : public TSimpleCriterion
  {
private:
   double            koeff1;
   double            koeff2;

public:
   virtual double    GetCriterion();                                  // get the value of optimization result
                     TSimpleMulSubCriterion(ENUM_STATISTICS _stat,double _koeff1,double _koeff2);
  };
//---------------------------------------------------------------------

//---------------------------------------------------------------------
//	Constructor:
//---------------------------------------------------------------------
TSimpleMulSubCriterion::TSimpleMulSubCriterion(ENUM_STATISTICS _stat,double _koeff1,double _koeff2)
   :
TSimpleCriterion(_stat),
koeff1(_koeff1),
koeff2(_koeff2)
  {
  }
//---------------------------------------------------------------------
//	Get value of the optimization result:
//---------------------------------------------------------------------
double  TSimpleMulSubCriterion::GetCriterion()
  {
   return(koeff1 *(koeff2-TesterStatistics(this.stat_param_type)));
  }
//---------------------------------------------------------------------

//=====================================================================
//	The class for creation of "simple" custom optimization criteria:
//	with result ( Criterion ) and limits for the bottom:
//=====================================================================
class TSimpleMinCriterion : public TSimpleCriterion
  {
   double            min_stat_param;

public:
   virtual double    GetCriterion();                                  // get the value of optimization result
                     TSimpleMinCriterion(ENUM_STATISTICS _stat,double _min);
  };
//---------------------------------------------------------------------

//---------------------------------------------------------------------
//	Constructor:
//---------------------------------------------------------------------
TSimpleMinCriterion::TSimpleMinCriterion(ENUM_STATISTICS _stat,double _min)
   :
TSimpleCriterion(_stat),
min_stat_param(_min)
  {
  }
//---------------------------------------------------------------------
//	Get value of the optimization result:
//---------------------------------------------------------------------
double  TSimpleMinCriterion::GetCriterion()
  {
   double   temp=TesterStatistics(this.stat_param_type);
   if(temp<this.min_stat_param)
     {
      return(-1.0);
     }
   return(temp);
  }
//---------------------------------------------------------------------

//=====================================================================
//	The class for creation of "simple" custom optimization criteria:
//	with result ( Criterion ) and limits from the top:
//=====================================================================
class TSimpleMaxCriterion : public TSimpleCriterion
  {
   double            max_stat_param;

public:
   virtual double    GetCriterion();                                  // get the value of optimization result
                     TSimpleMaxCriterion(ENUM_STATISTICS _stat,double _max);
  };
//---------------------------------------------------------------------

//---------------------------------------------------------------------
//	Constructor:
//---------------------------------------------------------------------
TSimpleMaxCriterion::TSimpleMaxCriterion(ENUM_STATISTICS _stat,double _max)
   :
TSimpleCriterion(_stat),
max_stat_param(_max)
  {
  }
//---------------------------------------------------------------------
//	Get value of the optimization result:
//---------------------------------------------------------------------
double  TSimpleMaxCriterion::GetCriterion()
  {
   double   temp=TesterStatistics(this.stat_param_type);
   if(temp>this.max_stat_param)
     {
      return(-1.0);
     }
   return(temp);
  }
//---------------------------------------------------------------------

//	STAT_INITIAL_DEPOSIT - Value of the initial deposit - double
//	STAT_WITHDRAWAL - Amount of assets withdraw from the account - double
//	STAT_PROFIT - Gross profit at the end of testing, sum of STAT_GROSS_PROFIT and STAT_GROSS_LOSS (STAT_GROSS_LOSS is always less than or equal to zero) - double
//	STAT_GROSS_PROFIT - Gross profit, the sum of all profit (positive) trades. Value is bigger or equal to zero - double
//	STAT_GROSS_LOSS - Gross loss, the sum of all unprofitable (negative) trades. The value is less than or equal to zero - double
//	STAT_MAX_PROFITTRADE - Maximal profit – maximal value among all profit trades. Value is bigger or equal to zero - double
//	STAT_MAX_LOSSTRADE - Maximal loss – minimal value among all unprofitable trades. The value is less than or equal to zero - double
//	STAT_CONPROFITMAX - Maximal profit in a sequence of profit trades. Value is bigger or equal to zero - double
//	STAT_CONPROFITMAX_TRADES - Number of trades that have formed STAT_CONPROFITMAX (maximal profit in a sequence of profit trades) - int
//	STAT_MAX_CONWINS - Total profit in the longest sequence of profit trades - double
//	STAT_MAX_CONPROFIT_TRADES - Number of trades in the longest sequence of profitable trades STAT_MAX_CONWINS - int
//	STAT_CONLOSSMAX - Maximal loss in a sequence of unprofitable trades. The value is less than or equal to zero - double
//	STAT_CONLOSSMAX_TRADES - Number of trades that have formed STAT_CONLOSSMAX (maximal loss in a sequence of unprofitable trades) - int
//	STAT_MAX_CONLOSSES - Gross loss in the longest series of unprofitable trades - double
//	STAT_MAX_CONLOSS_TRADES - Number of trades in the longest sequence of unprofitable trades STAT_MAX_CONLOSSES - int
//	STAT_BALANCEMIN - Minimal value of balance - double
//	STAT_BALANCE_DD - Maximum drawdown of balance in money. During trading, the balance can undergo a lot of drawdowns, the largest value is taken. - double
//	STAT_BALANCEDD_PERCENT - Drawdown of balance in percentage terms that have been registered at the moment of maximal drawdown of balance in money (STAT_BALANCE_DD). - double
//	STAT_BALANCE_DDREL_PERCENT - Maximal drawdown of balance in percentage terms. During trading, the balance can undergo a lot of drawdowns, for each of them the relative value of drawdown percentage terms is registered. The maximal value is returned - double
//	STAT_BALANCE_DD_RELATIVE - Drawdown of balance in money that have been registered at the moment of maximal drawdown of balance in percentage terms (STAT_BALANCE_DDREL_PERCENT). - double
//	STAT_EQUITYMIN - Minimal value of equity - double
//	STAT_EQUITY_DD - Maximal drawdown of equity in money. During trading, the equity can undergo a lot of drawdowns, the maximal value is taken. - double
//	STAT_EQUITYDD_PERCENT - Drawdown of equity in percentage terms at the moment of maximal drawdown in money (STAT_EQUITY_DD). - double
//	STAT_EQUITY_DDREL_PERCENT - Maximal drawdown of equity in percentage terms. During trading, the equity can undergo a lot of drawdowns, for each of them the relative drawdown in percentage terms is registered. The maximal value is returned - double
//	STAT_EQUITY_DD_RELATIVE - Drawdown of equity in money at the miment of maximal drawdown of equity in percentage terms (STAT_EQUITY_DDREL_PERCENT). - double
//	STAT_EXPECTED_PAYOFF - Expected payoff - double
//	STAT_PROFIT_FACTOR - Profit factor – STAT_GROSS_PROFIT/STAT_GROSS_LOSS ratio. If STAT_GROSS_LOSS=0, then the profit factor takes the DBL_MAX value - double
//	STAT_RECOVERY_FACTOR - Recovery factor – STAT_PROFIT/STAT_BALANCE_DD ratio - double
//	STAT_SHARPE_RATIO - Sharpe ratio - double
//	STAT_MAX_MARGINLEVEL - Maximal registered value of margin level - double
//	STAT_CUSTOM_ONTESTER - Value of calculated custom optimization criterion returned by the OnTester() function - double
//	STAT_DEALS - Number of performed deals - int
//	STAT_TRADES - Number of trades - int
//	STAT_PROFIT_TRADES - Profitable trades - int
//	STAT_LOSS_TRADES - Unprofitable trades - int
//	STAT_SHORT_TRADES - Short trades - int
//	STAT_LONG_TRADES - Long trades - int
//	STAT_PROFIT_SHORTTRADES - Profitable short trades - int
//	STAT_PROFIT_LONGTRADES - Profitable long trades - int
//	STAT_PROFITTRADES_AVGCON - Average duration of sequence of profitable trades - int
//	STAT_LOSSTRADES_AVGCON - Average duration of sequence of unprofitable trades - int


//=====================================================================
//	The class for creation of custom criteria of optimization based on
//	the coefficient of safe trade system (CSTS):
//=====================================================================
class TTSSFCriterion : public TCustomCriterion
  {
public:
   virtual double    GetCriterion();                                  // get the value of optimization result
  };
//---------------------------------------------------------------------

//---------------------------------------------------------------------
//	Get value of the optimization result:
//---------------------------------------------------------------------
double  TTSSFCriterion::GetCriterion()
  {
   int nTotalTrades = (int)TesterStatistics(STAT_PROFIT_TRADES)+(int)TesterStatistics(STAT_LOSS_TRADES);
   double   avg_win=TesterStatistics(STAT_GROSS_PROFIT)/TesterStatistics(STAT_PROFIT_TRADES);
   double   avg_loss = TesterStatistics( STAT_LOSS_TRADES ) > 0 ? (-TesterStatistics( STAT_GROSS_LOSS ) / TesterStatistics( STAT_LOSS_TRADES )) : 0.0f;
   double   win_perc = nTotalTrades > 0 ? 100.0 * TesterStatistics( STAT_PROFIT_TRADES ) / nTotalTrades : 0;

//	Calculate the safe ratio:
   double   teor=(110.0-win_perc)/(win_perc-10.0)+1.0;

//	Calculate the real ratio:
   double   real=avg_loss > 0 ? avg_win/avg_loss : avg_win;

//	CSTS:
   double   tssf=real/teor;
   if(tssf > 1.0f) tssf = 1.0f;
   return(tssf);
  }
//---------------------------------------------------------------------

//=====================================================================
//	The class for creation of custom criteria of optimization based on
//	the coefficient of safe trade system (CSTS):
//=====================================================================
class TKellyCriterion : public TCustomCriterion
  {
   double            min_stat_param; 
public:
   virtual double    GetCriterion();                                  // get the value of optimization result
   TKellyCriterion(double _min);
  };
//---------------------------------------------------------------------
TKellyCriterion::TKellyCriterion(double _min)
   :
min_stat_param(_min)
  {
  }
//---------------------------------------------------------------------
//	Get value of the optimization result:
//---------------------------------------------------------------------
double  TKellyCriterion::GetCriterion()
  {
  
   //https://www.investopedia.com/articles/trading/04/091504.asp
   double w=((TesterStatistics(STAT_PROFIT_TRADES)+TesterStatistics(STAT_LOSS_TRADES))>0)?TesterStatistics(STAT_PROFIT_TRADES)/(TesterStatistics(STAT_PROFIT_TRADES)+TesterStatistics(STAT_LOSS_TRADES)):0; // winning probability
   double   avg_win=TesterStatistics(STAT_GROSS_PROFIT)/TesterStatistics(STAT_PROFIT_TRADES);
   double   avg_loss = TesterStatistics( STAT_LOSS_TRADES ) > 0 ? -TesterStatistics( STAT_GROSS_LOSS ) / TesterStatistics( STAT_LOSS_TRADES ) : 0;
    
   double r=((avg_loss!=0))?avg_win/avg_loss:avg_win; // Win/loss ratio;
   double Kelly=(r!=0)?w-((1-w)/r):0; // Kelly Criterion
   
   if(Kelly < min_stat_param) return -0.1;
   
   return(Kelly);

  }
//---------------------------------------------------------------------
//=====================================================================
/*
You could try googling Optimal F (by Ralph Vince). Also google "ralph vince experiment" I think this is strongly related to Kelly and fractional Kelly but more focused on trading.

What's interesting about Optimal F (& Kelly) is that it will not make an unworkable system workable, but it can make a workable system unworkable (=unprofitable), specifically if you reinvest too much compared to the profit factor of the system.

EDIT: for clarity. Optimal f is at the peak value of a profit curve. Either side of it gives a less optimal result. Re-investing too much (ie going past the optimal point) can take a winning system into a losing system. If your estimate of profit factor is too high then you will calculate too high a trade size and the system will become unprofitable. Arguably you are now not using Optimal F. The point is that in the real world you have to calculate based on the existing data.

*/
//=====================================================================
class TOptimalFCriterion : public TCustomCriterion
  {
   double            min_stat_param; 
public:
   virtual double    GetCriterion();                                  // get the value of optimization result
   TOptimalFCriterion(double _min);
  };
//---------------------------------------------------------------------
TOptimalFCriterion::TOptimalFCriterion(double _min)
   :
min_stat_param(_min)
  {
  }
//---------------------------------------------------------------------
//	Get value of the optimization result:
//---------------------------------------------------------------------
double  TOptimalFCriterion::GetCriterion()
  {
  
   //https://www.mql5.com/en/forum/138048
   double w=((TesterStatistics(STAT_PROFIT_TRADES)+TesterStatistics(STAT_LOSS_TRADES))>0)?TesterStatistics(STAT_PROFIT_TRADES)/(TesterStatistics(STAT_PROFIT_TRADES)+TesterStatistics(STAT_LOSS_TRADES)):0; // winning probability
   double L2W_Ratio = ((TesterStatistics(STAT_PROFIT_TRADES)+TesterStatistics(STAT_LOSS_TRADES))>0)?TesterStatistics(STAT_LOSS_TRADES)/(TesterStatistics(STAT_PROFIT_TRADES)+TesterStatistics(STAT_LOSS_TRADES)):0; // Loss Total number / Trade Total number
   
   double   avg_win=TesterStatistics(STAT_GROSS_PROFIT)/TesterStatistics(STAT_PROFIT_TRADES);
   double   avg_loss = TesterStatistics( STAT_LOSS_TRADES ) > 0 ? -TesterStatistics( STAT_GROSS_LOSS ) / TesterStatistics( STAT_LOSS_TRADES ) : 0;
   
   double P2L_Ratio = avg_loss > 0 ? avg_win / avg_loss : avg_win;
   
   
   double   win_perc = 100.0 * TesterStatistics( STAT_PROFIT_TRADES ) / TesterStatistics( STAT_TRADES );

   double OptimalF = P2L_Ratio > 0 ? ((P2L_Ratio + 1) * w - 1)/P2L_Ratio : 0.0f;

   return(OptimalF);

  }
//---------------------------------------------------------------------

//=====================================================================
//	The base class for managing the array of custom parameters:
//=====================================================================
class TCustomCriterionArray : public CArrayObj
  {
public:
   virtual double    GetCriterion();                                  // get the value of optimization result
   virtual double    GetCriterion(int index);
  };
//---------------------------------------------------------------------

//---------------------------------------------------------------------
//	Get value of the optimization result:
//---------------------------------------------------------------------
double  TCustomCriterionArray::GetCriterion()
  {
   double   temp=1.0;
   int         count=this.Total();
   if(count==0)
     {
      return(0.0);
     }
   for(int i=0; i<count; i++)
     {
      temp*=(( TCustomCriterion*)(this.At(i))).GetCriterion();
      if(temp<0.0)
        {
         return(temp);
        }
     }

   return(temp);
  }
//---------------------------------------------------------------------
double    TCustomCriterionArray::GetCriterion(int index)
{
   double temp = 0.f;
   int         count=this.Total();
    if(index >= count || count ==0)
        return(temp); 
   temp=(( TCustomCriterion*)(this.At(index))).GetCriterion();
   return(temp);
}