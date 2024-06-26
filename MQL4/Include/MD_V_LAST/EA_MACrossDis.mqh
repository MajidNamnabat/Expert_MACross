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
#include <EA_MACross_Types.mqh>
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

public:
                     CSignalCrossMV_Dis();
                    ~CSignalCrossMV_Dis();
   //--- methods initialize protected data
   void              SetFastMV(int period,ENUM_MA_METHOD method ) { m_fast_period=period;m_fast_method = method;}
   void              SetSlowMV(int period,ENUM_MA_METHOD method) { m_slow_period=period;m_slow_method = method;}
   void              SetCandleApplied(EnumCustom_Applied_Price applied){m_candle_applied = Map2Applied_Price(applied);}
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
   void CheckMACross();
   int BarCountFromCrossOver();
   ENUM_WAVE_TREND GetCurrentCandle_MVTrend();
   datetime GetDate_CrossOver() { return m_dateCrossOver ;}
   double GetPrice_CrossOver() { return m_fPriceCrossOver;}
   void GetHistory_MV_Distance(int& nDistanceList[]);
protected:
   //---
   ENUM_APPLIED_PRICE Map2Applied_Price(EnumCustom_Applied_Price ap);
  };
//+------------------------------------------------------------------+
//| Constructor CSignalCrossMV_Dis.                                     |
//| INPUT:  no.                                                      |
//| OUTPUT: no.                                                      |
//| REMARK: no.                                                      |
//+------------------------------------------------------------------+
void CSignalCrossMV_Dis::CSignalCrossMV_Dis()
  {

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

   m_MovingAverageSlowValue=iMA(Symbol(),0,m_slow_period,0,m_slow_method,m_candle_applied,m_end_index);
   m_MovingAverageFastValue=iMA(Symbol(),0,m_fast_period,0,m_fast_method,m_candle_applied,m_end_index);
   m_mvdistance_inpoint = (int)MathRound( (m_MovingAverageFastValue-m_MovingAverageSlowValue)/_Point );       // only Calculate Distance
   
   double MASlowPrev=iMA(Symbol(),0,m_slow_period,0,m_slow_method,m_candle_applied,m_end_index+1);
   double MAFastPrev=iMA(Symbol(),0,m_fast_period,0,m_fast_method,m_candle_applied,m_end_index+1);
   int mvdistance_inpoint_prv = (int)MathRound( (MAFastPrev-MASlowPrev)/_Point );

   if(MAFastPrev<MASlowPrev && m_MovingAverageFastValue>m_MovingAverageSlowValue  ){
      m_TrackerStatus = CROSSUP;
      m_IsCrossOccurred = true;
      m_dateCrossOver = TimeCurrent();
      m_fPriceCrossOver = Bid;
   }
   else if(MASlowPrev<MAFastPrev && m_MovingAverageSlowValue>m_MovingAverageFastValue ){
      m_TrackerStatus = CROSSDOWN;
       m_IsCrossOccurred = true;
       m_dateCrossOver = TimeCurrent();
       m_fPriceCrossOver = Ask;
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
// Converts the EnumCustom_Applied_Price value to ENUM_APPLIED_PRICE value
//+------------------------------------------------------------------+
ENUM_APPLIED_PRICE CSignalCrossMV_Dis::Map2Applied_Price(EnumCustom_Applied_Price ap) 
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
int nBarCount = (int)MathFloor( (double) duration/ Period() ) ;
return nBarCount;
}
ENUM_WAVE_TREND CSignalCrossMV_Dis::GetCurrentCandle_MVTrend()
{
   double MASlowPrev=iMA(Symbol(),0,m_slow_period,0,m_slow_method,m_candle_applied,0);
   double MAFastPrev=iMA(Symbol(),0,m_fast_period,0,m_fast_method,m_candle_applied,0);
   if(MAFastPrev<MASlowPrev) return ENUM_TREND_BEARISH;
   if(MAFastPrev>MASlowPrev)  return ENUM_TREND_BULLISH;
   return ENUM_TREND_UNKNOWN;
}

void CSignalCrossMV_Dis::GetHistory_MV_Distance(int& nDistanceList[])
{
   int nBarsCount = iBars(Symbol(),Period());
   //Print("GetHistory_MV_Distance" , nBarsCount);
   ArrayResize(nDistanceList,nBarsCount-m_slow_period);
   ArrayFill(nDistanceList,0,ArraySize(nDistanceList),0);
   double fMovingAverageSlowValue;
   double fMovingAverageFastValue;
   for(int n=m_slow_period;n<nBarsCount;n++)
   {
      fMovingAverageSlowValue=iMA(Symbol(),0,m_slow_period,0,m_slow_method,m_candle_applied,nBarsCount-1-n);
      fMovingAverageFastValue=iMA(Symbol(),0,m_fast_period,0,m_fast_method,m_candle_applied,nBarsCount-1-n);
      nDistanceList[n-m_slow_period] = (int)MathRound( MathAbs(fMovingAverageSlowValue-fMovingAverageFastValue)/_Point );       // only Calculate Distance
   }
}