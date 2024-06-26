//+------------------------------------------------------------------+
//|                                               SignalCrossEMA.mqh |
//|                      Copyright © 2010, MetaQuotes Software Corp. |
//|                                        http://www.metaquotes.net |
//|                                              Revision 2010.10.12 |
//+------------------------------------------------------------------+
// wizard description start
//+------------------------------------------------------------------+
//| Description of the class                                         |
//| Title=Signals based on crossover of two EMA                      |
//| Type=Signal                                                      |
//| Name=CrossEMA                                                    |
//| Class=CSignalCrossMV_Dis                                            |
//| Page=                                                            |
//| Parameter=FastPeriod,int,12                                      |
//| Parameter=SlowPeriod,int,24                                      |
//+------------------------------------------------------------------+
// wizard description end
//+------------------------------------------------------------------+
//| Class CSignalCrossMV_Dis.                                           |
//| Appointment: Class trading signals cross two EMA.                |
//|              Derives from class CExpertSignal.                   |
//+------------------------------------------------------------------+
#include <MD_V_LAST\\EA_MD_Types.mqh>
#include <MD_V_LAST\\EA_MD_UtilityFunctions.mqh>

enum EnumMVsTrackerStatus
   {
      UNKNOWNS_STATUS = 0,
      CROSSUP = 1 ,
      CROSSDOWN = 2 ,
      DISTANCE_DECREASE  = 3,
      DISTANCE_INCREASE = 4 ,
      DISTANCE_CONSTANT = 5 ,
      ENUM_MV_INIT = 6
   };

/*enum ENUM_APPLIED_PRICE  
  {
   PRICE_CLOSE,
   PRICE_OPEN,
   PRICE_HIGH,
   PRICE_LOW,
   PRICE_MEDIAN,
   PRICE_TYPICAL,
   PRICE_WEIGHTED
  };*/
   
class CSignalCrossMV_Dis 
  {
protected:
   //--- input parameters
   string            m_strSymbol;
   int               m_nTimeFrame;
   double            m_fPOINT;
   int               m_fast_period;
   int               m_slow_period;
   ENUM_MA_METHOD    m_fast_method;
   ENUM_MA_METHOD    m_slow_method;
   ENUM_APPLIED_PRICE m_candle_applied;
   int            m_mvdistance_inpoint;  
   int            m_end_index;
   EnumMVsTrackerStatus  m_TrackerStatus ; 
   double m_MovingAverageFastValue ;
   double m_MovingAverageSlowValue ;
   bool m_IsCrossOccurred ;
   datetime m_dateCrossOver ; 
   double m_fPriceCrossOver;
   int    m_nBarsCrossOver;
   datetime m_dtFirstCrossOver;
public:
                     CSignalCrossMV_Dis();
                    ~CSignalCrossMV_Dis();
   //--- methods initialize protected data
   void              Setup(string strSymbol, int nTimeFrame);
   void              SetFastMV(int period,ENUM_MA_METHOD method ) { m_fast_period=period;m_fast_method = method;}
   void              SetSlowMV(int period,ENUM_MA_METHOD method) { m_slow_period=period;m_slow_method = method;}
   void              SetCandleApplied(ENUM_CUSTOM_APPLIED_PRICE applied){m_candle_applied = Map2Applied_Price(applied);}
   virtual bool      ValidationSettings();
   //---
   virtual int GetMVDistanceInPoint(){
      return m_mvdistance_inpoint;
   }
   double GetMovingAverageFastValue() { return m_MovingAverageFastValue;}
   double GetMovingAverageSlowValue() { return m_MovingAverageSlowValue;}
   EnumMVsTrackerStatus GetTrackerStatus() {return m_TrackerStatus;}
   bool GetIsCrossOccurred() {return m_IsCrossOccurred;}
   datetime GetdateCrossOver() { return m_dateCrossOver;}
   int GetBars_CrossOver() { return m_nBarsCrossOver; }
   void CheckMACross();
   int BarCountFromCrossOver();
   ENUM_WAVE_TREND GetCurrentCandle_MVTrend();
   datetime GetDate_CrossOver() { return m_dateCrossOver ;}
   double GetPrice_CrossOver() { return m_fPriceCrossOver;}
   void GetHistory_MV_Distance(int& nDistanceList[]);
   datetime GetDate_FirstCrossOver(){return m_dtFirstCrossOver;}
protected:
   //---
   ENUM_APPLIED_PRICE Map2Applied_Price(ENUM_CUSTOM_APPLIED_PRICE ap);
  };
//+------------------------------------------------------------------+
//| Constructor CSignalCrossMV_Dis.                                     |
//| INPUT:  no.                                                      |
//| OUTPUT: no.                                                      |
//| REMARK: no.                                                      |
//+------------------------------------------------------------------+
void CSignalCrossMV_Dis::CSignalCrossMV_Dis()
  {
   m_strSymbol = "";
   m_nTimeFrame = 0;
//--- set default inputs
   m_fast_period =12;
   m_slow_period =24;
   m_fast_method = MODE_EMA;
   m_slow_method = MODE_SMA;
   m_candle_applied = PRICE_CLOSE;
   m_mvdistance_inpoint = 0 ;
   m_end_index = 1 ;
   m_MovingAverageFastValue = 0;
   m_MovingAverageSlowValue = 0;
   m_TrackerStatus = ENUM_MV_INIT;
   m_IsCrossOccurred = false;
   m_dateCrossOver = TimeCurrent();
   m_fPriceCrossOver = -1;
   m_dtFirstCrossOver = 0;
   m_nBarsCrossOver = 0;
  }
//+------------------------------------------------------------------+
//| Destructor CSignalCrossMV_Dis.                                      |
//| INPUT:  no.                                                      |
//| OUTPUT: no.                                                      |
//| REMARK: no.                                                      |
//+------------------------------------------------------------------+
void CSignalCrossMV_Dis::~CSignalCrossMV_Dis()
  {
//---
  }
void    CSignalCrossMV_Dis::Setup(string strSymbol, int nTimeFrame)
{
   m_strSymbol = strSymbol;
   m_nTimeFrame = nTimeFrame;
   m_fPOINT = SymbolInfoDouble(m_strSymbol,SYMBOL_POINT);
   if(IS_ENABLE_LOG) Print("CSignalCrossMV_Dis::Setup " , m_strSymbol , " " , m_fPOINT , " " , GetLastError());

}
//+------------------------------------------------------------------+
//| Validation settings protected data.                              |
//| INPUT:  no.                                                      |
//| OUTPUT: true-if settings are correct, false otherwise.           |
//| REMARK: no.                                                      |
//+------------------------------------------------------------------+
bool CSignalCrossMV_Dis::ValidationSettings()
  {
   if(m_fast_period>=m_slow_period-3)
     {
      printf(__FUNCTION__+": period of slow EMA must be greater than period of fast EMA");
      return(false);
     }
//--- ok
   return(true);
  }
//Technical analysis of the indicators
//MAShift can be 1 or 0 , Cross & Distance Current Candle and Before , or Before and Prev Before
//+------------------------------------------------------------------+
void CSignalCrossMV_Dis::CheckMACross(){

   m_MovingAverageSlowValue=iMA(m_strSymbol,m_nTimeFrame,m_slow_period,0,m_slow_method,m_candle_applied,m_end_index);
   m_MovingAverageFastValue=iMA(m_strSymbol,m_nTimeFrame,m_fast_period,0,m_fast_method,m_candle_applied,m_end_index);
   m_mvdistance_inpoint = (int)MathRound( (m_MovingAverageFastValue-m_MovingAverageSlowValue)/m_fPOINT );       // only Calculate Distance
   
   double MASlowPrev=iMA(m_strSymbol,m_nTimeFrame,m_slow_period,0,m_slow_method,m_candle_applied,m_end_index+1);
   double MAFastPrev=iMA(m_strSymbol,m_nTimeFrame,m_fast_period,0,m_fast_method,m_candle_applied,m_end_index+1);
   int mvdistance_inpoint_prv = (int)MathRound( (MAFastPrev-MASlowPrev)/m_fPOINT );

   double fAsk = SymbolInfoDouble(m_strSymbol,SYMBOL_ASK); // Best Buy Offer
   double fBid = SymbolInfoDouble(m_strSymbol,SYMBOL_BID); // Best Buy Offer
   
   if(MAFastPrev<MASlowPrev && m_MovingAverageFastValue>m_MovingAverageSlowValue  ){
      //if(IS_ENABLE_LOG)  Print (" CheckMACross CROSSUP : Symbol :", m_strSymbol , " Ask:" ,fAsk , " Bid: " , fBid , " DistanceInPoint: " , m_mvdistance_inpoint , " " ,EnumToString(m_TrackerStatus) );

      m_TrackerStatus = CROSSUP;
      m_IsCrossOccurred = true;
      m_dateCrossOver = TimeCurrent();
      m_nBarsCrossOver = iBars(m_strSymbol,m_nTimeFrame);
      if(m_dtFirstCrossOver==0)
       {  
       m_dtFirstCrossOver = TimeCurrent();
       Print("CheckMACross " , TimeCurrent() , "   " , iTime(m_strSymbol,m_nTimeFrame,m_end_index), "  " , MAFastPrev , "  " , MASlowPrev , "  " , m_MovingAverageFastValue , "  " , m_MovingAverageSlowValue);
        }
      m_fPriceCrossOver = fBid;
   }
   else if(MASlowPrev<MAFastPrev && m_MovingAverageSlowValue>m_MovingAverageFastValue ){
      //if(IS_ENABLE_LOG)         Print (" CheckMACross CROSSDOWN : Symbol :", m_strSymbol , " Ask:" ,fAsk , " Bid: " , fBid , " DistanceInPoint: " , m_mvdistance_inpoint , " " ,EnumToString(m_TrackerStatus) );
       m_TrackerStatus = CROSSDOWN;
       m_IsCrossOccurred = true;
       m_dateCrossOver = TimeCurrent();
       m_nBarsCrossOver = iBars(m_strSymbol,m_nTimeFrame);
      if(m_dtFirstCrossOver==0)
       {  
       m_dtFirstCrossOver = TimeCurrent(); 
       //???????????????
       Print("CheckMACross " , TimeCurrent() , "   " , iTime(m_strSymbol,m_nTimeFrame,m_end_index), "  " , MAFastPrev , "  " , MASlowPrev , "  " , m_MovingAverageFastValue , "  " , m_MovingAverageSlowValue);
       }
       m_fPriceCrossOver = fAsk;
   }
   else if (MathAbs(m_mvdistance_inpoint) > MathAbs(mvdistance_inpoint_prv)) {
      m_TrackerStatus = DISTANCE_INCREASE;
   }
   else if(MathAbs(m_mvdistance_inpoint) < MathAbs(mvdistance_inpoint_prv)){
      m_TrackerStatus = DISTANCE_DECREASE;
   }
   else if(MathAbs(m_mvdistance_inpoint) == MathAbs(mvdistance_inpoint_prv)){
      m_TrackerStatus = DISTANCE_CONSTANT;
   }
}

//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
// Converts the ENUM_CUSTOM_APPLIED_PRICE value to ENUM_APPLIED_PRICE value
//+------------------------------------------------------------------+
ENUM_APPLIED_PRICE CSignalCrossMV_Dis::Map2Applied_Price(ENUM_CUSTOM_APPLIED_PRICE ap) 
{
   ENUM_APPLIED_PRICE map_ap = PRICE_CLOSE;
   switch(ap){
      case CUR_PRICE_CLOSE :
         m_end_index = 0;
         map_ap = PRICE_CLOSE ;
      break;
      case CUR_PRICE_MEDIAN :
         m_end_index = 0;
         map_ap = PRICE_MEDIAN ;
      break;
      case PREVIOUS_CANDLE:
         m_end_index = 1;
         map_ap = PRICE_CLOSE ;
      break;
      default:
         m_end_index = 1;
         map_ap = PRICE_CLOSE ;
      break;
   }
   return map_ap;
}
int CSignalCrossMV_Dis::BarCountFromCrossOver()
{
int duration =(int) ( ( TimeCurrent() - m_dateCrossOver ) / 60 ) ; // in minute
int nBarCount = (int)MathFloor( (double) duration/ m_nTimeFrame ) ;
return nBarCount;
}
ENUM_WAVE_TREND CSignalCrossMV_Dis::GetCurrentCandle_MVTrend()
{
   double MASlowPrev=iMA(m_strSymbol,m_nTimeFrame,m_slow_period,0,m_slow_method,m_candle_applied,0);
   double MAFastPrev=iMA(m_strSymbol,m_nTimeFrame,m_fast_period,0,m_fast_method,m_candle_applied,0);
   if(MAFastPrev<MASlowPrev) return ENUM_TREND_BEARISH;
   if(MAFastPrev>MASlowPrev)  return ENUM_TREND_BULLISH;
   return ENUM_TREND_UNKNOWN;
}

void CSignalCrossMV_Dis::GetHistory_MV_Distance(int& nDistanceList[])
{
   int nBarsCount = iBars(m_strSymbol,m_nTimeFrame);
   //Print("GetHistory_MV_Distance" , nBarsCount);
   ArrayResize(nDistanceList,nBarsCount-m_slow_period);
   ArrayFill(nDistanceList,0,ArraySize(nDistanceList),0);
   double fMovingAverageSlowValue;
   double fMovingAverageFastValue;
   for(int n=m_slow_period;n<nBarsCount;n++)
   {
      fMovingAverageSlowValue=iMA(m_strSymbol,m_nTimeFrame,m_slow_period,0,m_slow_method,m_candle_applied,nBarsCount-1-n);
      fMovingAverageFastValue=iMA(m_strSymbol,m_nTimeFrame,m_fast_period,0,m_fast_method,m_candle_applied,nBarsCount-1-n);
      nDistanceList[n-m_slow_period] = (int)MathRound( MathAbs(fMovingAverageSlowValue-fMovingAverageFastValue)/m_fPOINT );       // only Calculate Distance
   }
}