//+------------------------------------------------------------------+
//|                                                     MACD_Div.mqh |
//|                                                   Majid Namnabat |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Majid Namnabat"
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
#include <EA_MACross_Types.mqh>
#include <EA_UtilityFunction.mqh>

enum ENUM_ALLOW_DIVERGENCE_DETECTION
  {
   ENUM_ALLOW_DIVERGENCE_T1 = 1,    //In One Wave Between Highest & Current
   ENUM_ALLOW_DIVERGENCE_T2 = 2,    //In One Wave Between Nearest High & Current
   ENUM_ALLOW_DIVERGENCE_NONSTANDARD = 4,    // In Two Wave
   ENUM_ALLOW_DIVERGENCE_EXTENTION1 = 8,
   ENUM_ALLOW_DIVERGENCE_RSI_T1 = 16
  };
// two bit : positive or negative
// six bit : types
enum ENUM_DIVERGENCE_CLASS
  {
   ENUM_DIVERGENCE_NONE = 0,
   ENUM_DIVERGENCE_UNKNOWN = -1,
   ENUM_DIVERGENCE_NEGATIVE_T1  = char(1) | (1 << 3),//0x01001
   ENUM_DIVERGENCE_POSITIVE_T1  = char(2) | (1 << 3),//0x1010 , 0x010110 // return 24 
   ENUM_DIVERGENCE_NEGATIVE_T2  = char(1) | (1 << 4),
   ENUM_DIVERGENCE_POSITIVE_T2  = char(2) | (1 << 4),
   ENUM_DIVERGENCE_NONSTANDARD_NEGATIVE = (char(1) | (1 << 5)),
   ENUM_DIVERGENCE_NONSTANDARD_POSITIVE = (char(2) | (1 << 5)),
   ENUM_DIVERGENCE_NEGATIVE_EXT1 = (char(1) | (1 << 6)),           //The indicator is decreasing
   ENUM_DIVERGENCE_POSITIVE_EXT1 = (char(2) | (1 << 6)),           //The indicator is increasing //return 80 01001110 64+8+4+2 
   ENUM_DIVERGENCE_NEGATIVE_RSI_T1 = (char(1) | (1 << 7)),
   ENUM_DIVERGENCE_POSITIVE_RSI_T1 = (char(2) | (1 << 7))
  };
#define    nCheckBarsMax     102    // number of bars to check divergence + 2 candle of prv and prvprv
const int    Extremum_LeftBarSize = 4;
const int    Extremum_RightBarSize = 4;
const int    INVALID_VALUE = -999999999;
const double    MACD_THRESHOLD_RATIO_MAX = 0.0f;
struct SExtremum
  {
   int               PriceBar;
   int               ExtremumBar;
   datetime          ExtremumTime;
   double            IndicatorValue;
   double            PriceValue;
   int               IndicatorWaveEndBar;
   int               IndicatorWaveStartBar;
  };

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class EA_MACD_Div
  {
private:
   int               macd_fast;
   int               macd_slow;
   int               macd_signal;
   //double div_oscErr; // allowable error along divergence line (oscilator)
   //double div_priceErr; // allowable error along divergence line (PPS), iATR(nCheckBars)*err
   SExtremum         m_extremums[];
   double            m_fMACD[nCheckBarsMax];
   double            m_fMACD_MinimumLevel ;
   double            m_fMACD_MaximumLevel ;
   int               m_nExtCount;
   int      m_nSelTimeFrame ;
   int      m_nAllowCheckTypes ;
   double   m_fMACD_Point;
   void              AddExtremum(double indval,
                                 double pval,
                                 int indbar,
                                 int pbar,
                                 datetime et,
                                 int wstart,
                                 int wend
                                )
     {
      if(m_nExtCount>=ArraySize(m_extremums))
        {
         ArrayResize(m_extremums,ArraySize(m_extremums)+5);
        }
      m_extremums[m_nExtCount].IndicatorValue=indval;
      m_extremums[m_nExtCount].PriceValue=pval;
      m_extremums[m_nExtCount].ExtremumBar=indbar;
      m_extremums[m_nExtCount].PriceBar=pbar;
      m_extremums[m_nExtCount].ExtremumTime=et;
      m_extremums[m_nExtCount].IndicatorWaveEndBar = wend;
      m_extremums[m_nExtCount].IndicatorWaveStartBar = wstart;
      m_nExtCount++;
     };
   bool              IsArrayMinimum(const double& arr[], int leftwin, int rightwin, int center) ;
   bool              IsLocalExtremum(const double& arr[], int leftwin, int rightwin, int center) ;
   double            GetCandleValue(const double& arr[],int index);
   bool              FindExtermums();
   bool              IsExistAndDrawNegativeDiv(int nExtIndex,ENUM_DIVERGENCE_CLASS divClass);
   bool              IsExistAndDrawPositiveDiv(int nExtIndex,ENUM_DIVERGENCE_CLASS divClass);
   int               IsExistAndValidNearExtremum();
   void              FillPriceTimeExtremum(int nExtInd,ENUM_WAVE_TREND trendDirection);
   ENUM_DIVERGENCE_CLASS CheckDivergenceExtention(ENUM_WAVE_TREND trendDirection);
   ENUM_DIVERGENCE_CLASS CheckDivergenceRSI(int nExtIndex, ENUM_WAVE_TREND trendDirection);
   bool              IsAllowCheck(ENUM_DIVERGENCE_CLASS divClass);
   void              DrawExtermum(ENUM_WAVE_TREND trendDirection,int nExtInd);
   bool              m_bIsCheckRSI ;
public:
                     EA_MACD_Div();
                    ~EA_MACD_Div();
   bool              Init(ENUM_WAVE_TREND & trendDirection);
   bool              Reset();
   ENUM_DIVERGENCE_CLASS Check(ENUM_WAVE_TREND trendDirection);
   void              SetPeriod(int nPeriod) {m_nSelTimeFrame = nPeriod ; }
   void              SetAllowCheckTypes(int nAllowType) { m_nAllowCheckTypes = nAllowType;}
   double            GetMACD_Prv2();
   void              Set_IsCheckRSI(bool bIsCheckRSI) { m_bIsCheckRSI = bIsCheckRSI;}

  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
EA_MACD_Div::EA_MACD_Div()
  {
   macd_fast     = 5;     // fast EMA
   macd_slow     = 34;     // slow EMA
   macd_signal   = 5;      // signal SMA
//div_oscErr    = 4.0;    // allowable error along divergence line (oscilator)
//div_priceErr  = 0.4;    // allowable error along divergence line (PPS), iATR(nCheckBars)*err
   m_nExtCount = 0 ;
   ArraySetAsSeries(m_fMACD,true);
   ArrayFill(m_fMACD,0,ArraySize(m_fMACD),INVALID_VALUE);
   m_nSelTimeFrame = LowerPeriod();
   m_nAllowCheckTypes = 0;
   m_fMACD_MinimumLevel = INVALID_VALUE;
   m_fMACD_MaximumLevel = INVALID_VALUE ;
   m_fMACD_Point = 0.0f;
   m_bIsCheckRSI = false ;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
EA_MACD_Div::~EA_MACD_Div()
  {

  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool EA_MACD_Div::Reset()
  {
   macd_fast     = 5;     // fast EMA
   macd_slow     = 34;     // slow EMA
   macd_signal   = 5;      // signal SMA
//div_oscErr    = 4.0;    // allowable error along divergence line (oscilator)
//div_priceErr  = 0.4;    // allowable error along divergence line (PPS), iATR(nCheckBars)*err

   m_nExtCount = 0 ;
   ArraySetAsSeries(m_fMACD,true);
   ArrayFill(m_fMACD,0,ArraySize(m_fMACD),INVALID_VALUE);
   m_nSelTimeFrame = LowerPeriod();
   m_nAllowCheckTypes = 0;
   m_fMACD_MaximumLevel = INVALID_VALUE ;
   m_fMACD_MinimumLevel = INVALID_VALUE ;
   m_fMACD_Point = 0.0f;
   m_bIsCheckRSI = false ;

   return true;
  }  
//+------------------------------------------------------------------+
//|first work with PrvPrv Candle : Experience
// second : Candle or MACD must be Pick in local one neighbour , may be two candle or two MACD toghether mark Pick   , but another must be determine this is Pick                                                              |
//+------------------------------------------------------------------+
bool EA_MACD_Div::Init(ENUM_WAVE_TREND & trendDirection)
  {
   double fMACDVal;
   int nMaxIndex;
   bool bIsPositive ;
   bool bIsAccept_Analysing = false;
   //////////////////////
   /*datetime datePrvPrv = iTime(NULL,m_nSelTimeFrame , 2 );
            int YY=TimeYear(  datePrvPrv );   // Year
         int MN=TimeMonth( datePrvPrv );   // Month         
         int DD=TimeDay(   datePrvPrv );   // Day
         int HH=TimeHour(  datePrvPrv );   // Hour         
    if(YY == 2021 && MN == 3 && ( DD >= 17 || DD <= 25 ) )
    {
      DrawArrowCheckCandle(120,trendDirection == ENUM_TREND_BULLISH ? ENUM_OBJECT_ABOVE_CANDLE : ENUM_OBJECT_BELOW_CANDLE,2,m_nSelTimeFrame);
    }*/
   //////////////////
   int nAllBarCount = iBars(NULL,m_nSelTimeFrame);
   int nBarIntervalCount = 0 ;
   if(nAllBarCount < macd_slow + 1)
      return false;
   m_fMACD[0] = INVALID_VALUE;
   m_fMACD[1] = iMACD(NULL, m_nSelTimeFrame, macd_fast, macd_slow, macd_signal, PRICE_CLOSE, MODE_MAIN, 1);
   m_fMACD[2] = iMACD(NULL, m_nSelTimeFrame, macd_fast, macd_slow, macd_signal, PRICE_CLOSE, MODE_MAIN, 2);
   m_fMACD[3]  = iMACD(NULL, m_nSelTimeFrame, macd_fast, macd_slow, macd_signal, PRICE_CLOSE, MODE_MAIN, 3);

   nMaxIndex = 2;
   if(m_fMACD[2] < INVALID_VALUE + 1)
      return false;
    if(m_fMACD[2] > 0 && trendDirection == ENUM_TREND_UNKNOWN )  
    {
      trendDirection = ENUM_TREND_BULLISH ;
    }
    else if(m_fMACD[2] < 0 && trendDirection == ENUM_TREND_UNKNOWN)
    {
      trendDirection = ENUM_TREND_BEARISH ;
    }
   /*&& &&  */
   if(m_fMACD[2] > 0 && trendDirection == ENUM_TREND_BEARISH)
     {
      return false;
     }
   else
      if(m_fMACD[2] < 0 && trendDirection == ENUM_TREND_BULLISH)
        {
         return false;
        }
   
   if(m_fMACD[2] > 0)
     {
      bIsPositive = true;
      //Shadow not very important , body is more important // but not very tight , work with high
      /*if( iHigh(NULL,m_nSelTimeFrame,2) < iHigh(NULL,m_nSelTimeFrame,1)- 1*_Point) 
         return false;
      
      if( iHigh(NULL,m_nSelTimeFrame,2) < iHigh(NULL,m_nSelTimeFrame,3)- 1*_Point) 
         return false;
      */
      //High Between Two Candle , Consecutive , not important
      bIsAccept_Analysing = false ; 
      if(iHigh(NULL,m_nSelTimeFrame,3) <= iHigh(NULL,m_nSelTimeFrame,2)   && iHigh(NULL,m_nSelTimeFrame,2) >= iHigh(NULL,m_nSelTimeFrame,1))
         bIsAccept_Analysing = true ; 
      /*if(iHigh(NULL,m_nSelTimeFrame,3) > iHigh(NULL,m_nSelTimeFrame,2)   && iHigh(NULL,m_nSelTimeFrame,2) > iHigh(NULL,m_nSelTimeFrame,1))
         return false;
      */
      if( m_fMACD[3] <= m_fMACD[2]   &&  m_fMACD[2] >= m_fMACD[1] && iHigh(NULL,m_nSelTimeFrame,2) >= iHigh(NULL,m_nSelTimeFrame,1) )
         bIsAccept_Analysing = true ; 
      if(!bIsAccept_Analysing)
         return false;
      /*
      Experience : make mistanke MACD lagging , next macd show influence of Previous Candle
      if( m_fMACD[3] > m_fMACD[2]   &&  m_fMACD[2] > m_fMACD_Candle1  )
         return false;
      */
      //except macd prvprv peak
     }
   else if (m_fMACD[2] < 0)
     {
      bIsPositive = false;
      //باید حداقل مینیمم کندل پایین تر یا کوچکتر از کندل بعدی باشد. کندل بعدی بالاتر یا بزرگتر باز شود
      //next candle must open or low must greater or above
      /*
      if( iLow(NULL,m_nSelTimeFrame,2) > iLow(NULL,m_nSelTimeFrame,1) + 1 * _Point) //Shadow not very important , body is more important // but not very tight , work with high
         return false;
      
      if( iLow(NULL,m_nSelTimeFrame,2) > iLow(NULL,m_nSelTimeFrame,3) + 1 * _Point) //Shadow not very important , body is more important // but not very tight , work with high
         return false;
      */ 
      //Low Between Two Candles , Trend 
      bIsAccept_Analysing = false ; 
      if(iLow(NULL,m_nSelTimeFrame,3) >= iLow(NULL,m_nSelTimeFrame,2)  && iLow(NULL,m_nSelTimeFrame,2) <= iLow(NULL,m_nSelTimeFrame,1)  )
         bIsAccept_Analysing = true;     
      /*if(iLow(NULL,m_nSelTimeFrame,3) < iLow(NULL,m_nSelTimeFrame,2)  && iLow(NULL,m_nSelTimeFrame,2) < iLow(NULL,m_nSelTimeFrame,1)  )
         return false;     
      */
      
      if( MathAbs(m_fMACD[3]) <= MathAbs(m_fMACD[2]) &&  MathAbs(m_fMACD[2]) >= MathAbs(m_fMACD[1]) && iLow(NULL,m_nSelTimeFrame,2) <= iLow(NULL,m_nSelTimeFrame,1) )
         bIsAccept_Analysing = true;
      /*if( MathAbs(m_fMACD[3]) > MathAbs(m_fMACD[2]) &&  MathAbs(m_fMACD[2]) > MathAbs(m_fMACD_Candle1)  )
         return false;
      */
      if(!bIsAccept_Analysing)
         return false;
     }
//Print ("EA_MACD_Div::Init " , bIsPositive );
   m_fMACD_MinimumLevel = MathAbs(m_fMACD[2]);
   m_fMACD_MaximumLevel = MathAbs(m_fMACD[2]);
   for(int n=3; n < nCheckBarsMax ; n++)
     {
      nBarIntervalCount = Bars(NULL,m_nSelTimeFrame, iTime(NULL, m_nSelTimeFrame,nAllBarCount -1), iTime(NULL, m_nSelTimeFrame,n));
      if(nBarIntervalCount < (macd_slow + 1))
         break;
      fMACDVal  = iMACD(NULL, m_nSelTimeFrame, macd_fast, macd_slow, macd_signal, PRICE_CLOSE, MODE_MAIN, n);
      if(bIsPositive)
        {
         if(fMACDVal > 0 || MathAbs(fMACDVal) < (MACD_THRESHOLD_RATIO_MAX * m_fMACD_MaximumLevel))
           {
            m_fMACD[n]
               = fMACDVal;
            if(MathAbs(fMACDVal) > m_fMACD_MaximumLevel)
              {
               m_fMACD_MaximumLevel = MathAbs(fMACDVal);
               nMaxIndex = n;
              }
            if(MathAbs(fMACDVal) < m_fMACD_MinimumLevel)
              {
               m_fMACD_MinimumLevel = MathAbs(fMACDVal) ;
              }
           }
         else
            break;
        }
      else
        {
         if(fMACDVal < 0 || (fMACDVal > 0 &&  MathAbs(fMACDVal) < (MACD_THRESHOLD_RATIO_MAX * m_fMACD_MaximumLevel)))
           {
            m_fMACD[n]
               = fMACDVal;
            if(MathAbs(fMACDVal) > m_fMACD_MaximumLevel)
              {
               m_fMACD_MaximumLevel = MathAbs(fMACDVal);
               nMaxIndex = n;
              }

            if(MathAbs(fMACDVal) < m_fMACD_MinimumLevel)
              {
               m_fMACD_MinimumLevel = MathAbs(fMACDVal) ;
              }
           }
         else
            break;
        }
     }
     ///////////////////////////////////
     // MACD Levels are different in different TimeFrames , So I assume window size is 4 cm or 40 mm , so half of it is positive
     m_fMACD_Point =  (m_fMACD_MaximumLevel / 2 ) / 40 ;  
     //Print ("MACD_Div : Init , m_fMACD_Point : ", m_fMACD_Point , " m_fMACD_MaximumLevel " , m_fMACD_MaximumLevel);
      /*
      if(m_fMACD[2] > 0 && m_fMACD[2] < m_fMACD_Candle1-15*m_fMACD_Point && m_fMACD_Candle1 > INVALID_VALUE + 1) 
         return false;     
      //except macd prvprv peak
      if(m_fMACD[2] < 0 && MathAbs(m_fMACD[2]) < MathAbs(m_fMACD_Candle1)-15*m_fMACD_Point && m_fMACD_Candle1 > INVALID_VALUE + 1) 
         return false;
      if(m_fMACD[2] > 0 && m_fMACD[2] < m_fMACD[3]-15*m_fMACD_Point) 
         return false;     
      //except macd prvprv peak
      if(m_fMACD[2] < 0 && MathAbs(m_fMACD[2]) < MathAbs(m_fMACD[3])-15*m_fMACD_Point ) 
         return false;
      */
     // DrawArrowCheckCandle(120,trendDirection == ENUM_TREND_BULLISH ? ENUM_OBJECT_ABOVE_CANDLE : ENUM_OBJECT_BELOW_CANDLE,2,m_nSelTimeFrame);
//Print ("EA_MACD_Div::Init FindExtermums");
   FindExtermums();
   return true;
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
  double            EA_MACD_Div::GetMACD_Prv2()
  {
     double fMACD = iMACD(NULL, m_nSelTimeFrame, macd_fast, macd_slow, macd_signal, PRICE_CLOSE, MODE_MAIN, 2);
      return fMACD;
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
ENUM_DIVERGENCE_CLASS EA_MACD_Div::Check(ENUM_WAVE_TREND trendDirection)
  {

   int LocalStart = 0 ;
   int nMaxIndex = 0, nMinIndex = 0;
   ENUM_DIVERGENCE_CLASS nDivergenceClass = ENUM_DIVERGENCE_NONE;
   bool isValid_Div_T1 = false;
//Print ("MACD_DIv : Check " , trendDirection , " " , m_fMACD[2] , " " , m_nExtCount );
   switch(trendDirection)
     {
      case  ENUM_TREND_BULLISH : //search for Negative Divergence , Expect MACD positive , RSI Negative
         if(m_fMACD[2] < INVALID_VALUE + 1)
           {
            //if(IS_ENABLE_LOG) Print("DivCheck2 ENUM_TREND_BULLISH: Lower Time MACD inaccessible ");
            return ENUM_DIVERGENCE_NONE;
           }
         if(m_fMACD[2] < 0)
           {
            //if(IS_ENABLE_LOG) Print("DivCheck2 ENUM_TREND_BULLISH: m_fMACD[2] < 0 !important! : ", m_fMACD[2]);
            return ENUM_DIVERGENCE_NONE;
           }
         if(m_nExtCount == 0)
            return ENUM_DIVERGENCE_NONE;
         //Print ("MACD:Check Before If 1 ");
         if((m_extremums[0].IndicatorValue > m_fMACD[2])) //Search Negative Divergence , Negative is possible is first extremum
           {
            //Check Extremum is valid or not
            //Print ("DivCheck ENUM_TREND_BULLISH: First Valid Check : " ,m_extremums[0].ExtremumBar ," " , m_extremums[0].IndicatorWaveStartBar ," " ,m_extremums[0].IndicatorWaveEndBar );
            isValid_Div_T1 = m_extremums[0].ExtremumBar > m_extremums[0].IndicatorWaveStartBar+1 && m_extremums[0].ExtremumBar < m_extremums[0].IndicatorWaveEndBar-1 ;
            if(isValid_Div_T1)
               //Maximum Bar is valid in this Extremum ,
              {
               //So First Check Tak Maximum of this Extremum ( Possible Wave 3 ) for Div
               FillPriceTimeExtremum(0,trendDirection);
               //if(IS_ENABLE_LOG) Print("DivCheck : Second Valid Check : ",m_extremums[0].PriceBar," ", m_extremums[0].PriceValue," ",m_extremums[0].ExtremumTime);
               if(IsAllowCheck(ENUM_DIVERGENCE_NEGATIVE_T1) && IsExistAndDrawNegativeDiv(0,ENUM_DIVERGENCE_NEGATIVE_T1))
                 {
                  return ENUM_DIVERGENCE_NEGATIVE_T1;
                 }
               //No Elliot Principle search For Other Max in Window From Highest Wave 1 to Current Bar in Extremum 0
               if(IsAllowCheck(ENUM_DIVERGENCE_NEGATIVE_T2))
                 {
                  //Print ("ENUM_TREND_BULLISH:Check Before If 2 ");
                  int extremumNewIndex = IsExistAndValidNearExtremum() ;
                  if(extremumNewIndex > 0)
                    {
                     FillPriceTimeExtremum(extremumNewIndex,trendDirection);
                     DrawExtermum(trendDirection,extremumNewIndex);
                     //if(IS_ENABLE_LOG) Print("DivCheck2 : Find NearExtremum ", extremumNewIndex, "Time : ", m_extremums[extremumNewIndex].ExtremumTime);
                     if(IsExistAndDrawNegativeDiv(extremumNewIndex,ENUM_DIVERGENCE_NEGATIVE_T2))
                       {
                        return ENUM_DIVERGENCE_NEGATIVE_T2;
                       }
                    }
                 }
              }
            //Now Analyse between Max Prv Wave Max with This
            if(IsAllowCheck(ENUM_DIVERGENCE_NONSTANDARD_NEGATIVE) && m_nExtCount > 1 && m_extremums[1].IndicatorWaveStartBar > m_extremums[0].IndicatorWaveEndBar)
              {
               if(IsExistAndDrawNegativeDiv(1,ENUM_DIVERGENCE_NONSTANDARD_NEGATIVE))
                 {
                  return ENUM_DIVERGENCE_NONSTANDARD_NEGATIVE;
                 }
              }
           }
         break;
      case ENUM_TREND_BEARISH : //search for Positive Divergence , Expect MACD negative
         if(m_fMACD[2] < INVALID_VALUE + 1)
           {
            //if(IS_ENABLE_LOG) Print("DivCheck2 ENUM_TREND_BEARISH : Lower Time MACD inaccessible ");
            return ENUM_DIVERGENCE_NONE;
           }
         if(m_fMACD[2] > 0)
           {
            //if(IS_ENABLE_LOG) Print("DivCheck2 ENUM_TREND_BEARISH : m_fMACD[2] > 0 !important!  ", m_fMACD[2]);
            return ENUM_DIVERGENCE_NONE;

           }
         if(m_nExtCount == 0)
            return ENUM_DIVERGENCE_NONE;
         if((m_fMACD[2] < 0 && MathAbs(m_extremums[0].IndicatorValue) > MathAbs(m_fMACD[2]))) //Search Negative Divergence , Negative is possible is first extremum
           {
            //Check Extremum is valid or not
            //Print ("DivCheck ENUM_TREND_BEARISH: First Valid Check : " ,m_extremums[0].ExtremumBar ," " , m_extremums[0].IndicatorWaveStartBar ," " ,m_extremums[0].IndicatorWaveEndBar );
            isValid_Div_T1 = m_extremums[0].ExtremumBar > m_extremums[0].IndicatorWaveStartBar+1 && m_extremums[0].ExtremumBar < m_extremums[0].IndicatorWaveEndBar-1 ;
            if(isValid_Div_T1)
               //Maximum Bar is valid in this Extremum ,
              {
               //So First Check Tak Maximum of this Extremum ( Possible Wave 3 ) for Div
               FillPriceTimeExtremum(0,trendDirection);
               //if(IS_ENABLE_LOG) Print("DivCheck ENUM_TREND_BEARISH: Second Valid Check : ",m_extremums[0].PriceBar," ", m_extremums[0].PriceValue," ",m_extremums[0].ExtremumTime);
               if(IsAllowCheck(ENUM_DIVERGENCE_POSITIVE_T1) && IsExistAndDrawPositiveDiv(0,ENUM_DIVERGENCE_POSITIVE_T1))
                 {
                 //Print ("EA_MACD_Div::Check Allow Check ENUM_DIVERGENCE_POSITIVE_T1 " );
                  return ENUM_DIVERGENCE_POSITIVE_T1;
                 }
               //No Elliot Principle search For Other Max in Window From Highest Wave 1 to Current Bar in Extremum 0
               if(IsAllowCheck(ENUM_DIVERGENCE_POSITIVE_T2))
                 {
                  int extremumNewIndex = IsExistAndValidNearExtremum() ;
                  if(extremumNewIndex > 0)
                    {
                     FillPriceTimeExtremum(extremumNewIndex,trendDirection);
                     //DrawExtermum(trendDirection,extremumNewIndex);
                     //if(IS_ENABLE_LOG) Print("DivCheck2 ENUM_TREND_BEARISH: Find NearExtremum ", extremumNewIndex, "Time : ", m_extremums[extremumNewIndex].ExtremumTime);
                     if(IsExistAndDrawPositiveDiv(extremumNewIndex,ENUM_DIVERGENCE_POSITIVE_T2))
                       {
                        return ENUM_DIVERGENCE_POSITIVE_T2;
                       }
                    }
                 }
              }
            //Now Analyse between Max Prv Wave Max with This
            if(IsAllowCheck(ENUM_DIVERGENCE_NONSTANDARD_POSITIVE) && m_nExtCount > 1 && m_extremums[1].IndicatorWaveStartBar > m_extremums[0].IndicatorWaveEndBar)
              {
               if(IsExistAndDrawPositiveDiv(1,ENUM_DIVERGENCE_NONSTANDARD_POSITIVE))
                 {
                  return ENUM_DIVERGENCE_NONSTANDARD_POSITIVE;
                 }
              }
           }

         break;
     }
//Print (" Check: CheckDivergenceExtention"  );
   nDivergenceClass = CheckDivergenceExtention(trendDirection) ;
   if(nDivergenceClass != ENUM_DIVERGENCE_NONE)
      return nDivergenceClass ;
//Print (" Check: " , isValid_Div_T1 );
   if(isValid_Div_T1)
     {
      nDivergenceClass = CheckDivergenceRSI(0,trendDirection) ;
      if(nDivergenceClass != ENUM_DIVERGENCE_NONE)
         return nDivergenceClass ;
     }
   return nDivergenceClass;
  }
//+------------------------------------------------------------------+
//| Search For Local Extremum , Different Than                                                                  |
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int EA_MACD_Div::IsExistAndValidNearExtremum()
  {
   bool bIsLocalExtremum  = false;
   for(int n=3 + Extremum_RightBarSize ; n <= m_extremums[0].ExtremumBar - Extremum_LeftBarSize ; n++)
     {
      bIsLocalExtremum = IsLocalExtremum(m_fMACD,Extremum_LeftBarSize,Extremum_RightBarSize,n);
      if(bIsLocalExtremum)  // not = because last Max is better
        {
         //if(IS_ENABLE_LOG) Print("IsExistAndValidNearExtremum Find");
         AddExtremum(m_fMACD[n],-1.f,n,-1,-1,m_extremums[0].IndicatorWaveStartBar,m_extremums[0].IndicatorWaveEndBar);
         return m_nExtCount-1;
        }

     }

   return -1;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool EA_MACD_Div::IsLocalExtremum(const double& arr[], int leftwin, int rightwin, int center)
  {
   for(int n=center-1; n<center+leftwin; n++) // First Big Window Then Low Then Big Window
     {
      if(MathAbs(arr[n]) > MathAbs(arr[center]))
         return false;
     }
   for(int n=center+1; n<center+rightwin; n++)
     {
      if(MathAbs(arr[n]) > MathAbs(arr[center]))
         return false;
     }

   return true;

  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool EA_MACD_Div::IsArrayMinimum(const double& arr[], int leftwin, int rightwin, int center)
  {
   for(int n=center+leftwin; n<center; n++) // First Big Window Then Low Then Big Window
     {
      if(GetCandleValue(arr,n) < GetCandleValue(arr,center))
         return false;
     }
   for(int n=center+1; n<center+rightwin; n++)
     {
      if(GetCandleValue(arr,n) < GetCandleValue(arr,center))
         return false;
     }

   return true;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool EA_MACD_Div::FindExtermums()
  {
   int nRightLess = 0, nLeftLess = 0;
   double fMaxVal = 0.f;
   int nMaxBarIndex = -1 ;
   int nWaveStartBar = 2 ;
   int nWaveEndBar = -1;
   for(int n=3; n < nCheckBarsMax ; n++)
     {
      //Print ("MACD Value :", m_fMACD[n] , " Time " ,iTime(NULL, m_nSelTimeFrame , n));
      if(m_fMACD[n] < INVALID_VALUE+1)
        {
         nWaveEndBar  = n - 1 ;
         if(nWaveStartBar > 0)
           {
            AddExtremum(fMaxVal,-1.f,nMaxBarIndex,-1,-1,nWaveStartBar, nWaveEndBar);
            //if(IS_ENABLE_LOG) Print("Wave End : MaxBar :" , nMaxBarIndex , " MaxValue " ,fMaxVal , "  nWaStartBar : ",nWaveStartBar , " EndBar : ",nWaveEndBar , " Time " , iTime(NULL, m_nSelTimeFrame ,nWaveEndBar) );
            nWaveStartBar = -1;
           }
         break ;
        }
      if(MathAbs(m_fMACD[n]) >  fMaxVal)  // not = because last Max is better
        {
         fMaxVal = MathAbs(m_fMACD[n]);
         nMaxBarIndex = n ;
        }
      if(((m_fMACD[2] > 0 && m_fMACD[n] < 0) ||
          (m_fMACD[2] < 0 && m_fMACD[n] > 0)) && nWaveStartBar > 0 && n > nWaveStartBar)  //One Wave Finished
        {
         nWaveEndBar = n-1 ;
         AddExtremum(fMaxVal,-1.f,nMaxBarIndex,-1,-1,nWaveStartBar, nWaveEndBar);
         //if(IS_ENABLE_LOG) Print("Wave Direct: MaBar :" , nMaxBarIndex , " MaxValue " ,fMaxVal , "  StartBar : ",nWaveStartBar , "  EndBar : ",nWaveEndBar , " Time " , iTime(NULL, m_nSelTimeFrame , nWaveEndBar));
         nMaxBarIndex = -1;
         fMaxVal = 0.f;
         nWaveStartBar = -1;
         if(m_nExtCount>=2)   // Maximum Two Consecutive MACD Wave is enough
            break;

        }
      else
         if(nWaveStartBar == -1 && ((m_fMACD[2] > 0 && m_fMACD[n] > 0) ||
                                    (m_fMACD[2] < 0 && m_fMACD[n] < 0)))
           {
            nWaveStartBar = n;
           }
     }
   return true;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void EA_MACD_Div::FillPriceTimeExtremum(int nExtInd, ENUM_WAVE_TREND trendDirection)
  {
   int nExtremem_Period = Extremum_LeftBarSize+Extremum_RightBarSize+1 ;
   if(trendDirection == ENUM_TREND_BULLISH)
     {
      m_extremums[nExtInd].PriceBar = iHighest(NULL,m_nSelTimeFrame,MODE_HIGH,nExtremem_Period,m_extremums[nExtInd].ExtremumBar-Extremum_LeftBarSize-1);
      m_extremums[nExtInd].PriceValue = iHigh(NULL,m_nSelTimeFrame,m_extremums[nExtInd].PriceBar);
      m_extremums[nExtInd].ExtremumTime =iTime(NULL,m_nSelTimeFrame,m_extremums[nExtInd].PriceBar);
     }
   else
      if(trendDirection == ENUM_TREND_BEARISH)
        {
         m_extremums[nExtInd].PriceBar = iLowest(NULL,m_nSelTimeFrame,MODE_LOW,nExtremem_Period,m_extremums[nExtInd].ExtremumBar-Extremum_LeftBarSize-1);
         m_extremums[nExtInd].PriceValue = iLow(NULL,m_nSelTimeFrame,m_extremums[nExtInd].PriceBar);
         m_extremums[nExtInd].ExtremumTime =iTime(NULL,m_nSelTimeFrame,m_extremums[nExtInd].PriceBar);
        }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool EA_MACD_Div::IsExistAndDrawNegativeDiv(int nExtIndex,ENUM_DIVERGENCE_CLASS divClass)
  {
   string objName;
   if(m_extremums[nExtIndex].IndicatorValue >= m_fMACD[2] && m_extremums[nExtIndex].PriceValue < iHigh(NULL,m_nSelTimeFrame,2) 
        /* && (m_fMACD[2] > m_fMACD_Candle1 || m_fMACD_Candle1 < INVALID_VALUE + 1) */
      )       //Negative Divergence
     {
     // Check RSI 
     //Print ("IsExistAndDrawNegativeDiv RSI Value : ", m_bIsCheckRSI , " " );
     if(m_bIsCheckRSI)
     {
      double fRSIExtremum = iRSI(NULL,m_nSelTimeFrame,14,PRICE_CLOSE,m_extremums[nExtIndex].ExtremumBar);
      //Print ("IsExistAndDrawNegativeDiv RSI Value : ", fRSIExtremum);
      if(fRSIExtremum < 78 )
         return false;
     }
     // Find Max MACD beteen three last Candle
     int nMACDValueMaxIndex = 2 ;
     if(MathAbs(m_fMACD[1]) > MathAbs(m_fMACD[2]) && MathAbs(m_fMACD[1]) > MathAbs(m_fMACD[3]))
         nMACDValueMaxIndex = 1 ; 
     if(MathAbs(m_fMACD[3]) > MathAbs(m_fMACD[2]) && MathAbs(m_fMACD[3]) > MathAbs(m_fMACD[1]))
         nMACDValueMaxIndex = 3 ; 
     
     if(IsLocalExtremum(m_fMACD,Extremum_LeftBarSize,Extremum_RightBarSize,nMACDValueMaxIndex))
     {
      //if(IS_ENABLE_LOG) Print("DivCheck2 : FindDivergence : ", EnumToString(divClass)," PriceBar :", m_extremums[nExtIndex].PriceBar, " ExtremumTime ", m_extremums[nExtIndex].ExtremumTime);
      if(IS_DRAW_DIVERGENCE)
        {
         objName = "Text"+IntegerToString(MathRand())+IntegerToString(MathRand());
         if(!ObjectCreate(0,objName,OBJ_TEXT,0,iTime(NULL,m_nSelTimeFrame,m_extremums[nExtIndex].PriceBar),iHigh(NULL,m_nSelTimeFrame,m_extremums[nExtIndex].PriceBar)+20*_Point))
           {
            Print(__FUNCTION__,
                  ": failed to create \"OBJ_TEXT\" sign! Error code = ",GetLastError());
           }
         //--- set anchor type
         ObjectSetString(0,objName,OBJPROP_TEXT,"X");
         //--- set a sign color
         ObjectSetInteger(0,objName,OBJPROP_COLOR,clrYellow);
         //--- set the slope angle of the text
         ObjectSetDouble(0,objName,OBJPROP_ANGLE,-90.0);
        }
       return true;
      }
     }
   return false;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool EA_MACD_Div::IsExistAndDrawPositiveDiv(int nExtIndex, ENUM_DIVERGENCE_CLASS divClass)
  {
   string objName;
   if(MathAbs(m_extremums[nExtIndex].IndicatorValue) >= MathAbs(m_fMACD[2]) && m_extremums[nExtIndex].PriceValue > iLow(NULL,m_nSelTimeFrame,2) 
       /* && (MathAbs(m_fMACD[2]) >= MathAbs(m_fMACD_Candle1) || m_fMACD_Candle1 < INVALID_VALUE + 1)*/)     //Positive Divergence
     {
     if(m_bIsCheckRSI)
     {
      double fRSIExtremum = iRSI(NULL,m_nSelTimeFrame,14,PRICE_CLOSE,m_extremums[nExtIndex].ExtremumBar);
      //Print ("IsExistAndDrawPositiveDiv RSI Value : ", fRSIExtremum);
      if(fRSIExtremum > 22 )
         return false;
     }
      //if(IS_ENABLE_LOG) Print("DivCheck2 : FindDivergence : ", EnumToString(divClass)," PriceBar :", m_extremums[nExtIndex].PriceBar, " ExtremumTime ", m_extremums[nExtIndex].ExtremumTime);
     int nMACDValueMaxIndex = 2 ;
     if(MathAbs(m_fMACD[1]) > MathAbs(m_fMACD[2]) && MathAbs(m_fMACD[1]) > MathAbs(m_fMACD[3]))
         nMACDValueMaxIndex = 1 ; 
     if(MathAbs(m_fMACD[3]) > MathAbs(m_fMACD[2]) && MathAbs(m_fMACD[3]) > MathAbs(m_fMACD[1]))
         nMACDValueMaxIndex = 3 ; 
     
     if(IsLocalExtremum(m_fMACD,Extremum_LeftBarSize,Extremum_RightBarSize,nMACDValueMaxIndex))
      {
       if(IS_DRAW_DIVERGENCE)
        {
         objName = "Text"+IntegerToString(MathRand())+IntegerToString(MathRand());
         if(!ObjectCreate(0,objName,OBJ_TEXT,0,iTime(NULL,m_nSelTimeFrame,m_extremums[nExtIndex].PriceBar),iLow(NULL,m_nSelTimeFrame,m_extremums[nExtIndex].PriceBar)-20*_Point))
           {
            Print(__FUNCTION__,
                  ": failed to create \"OBJ_TEXT\" sign! Error code = ",GetLastError());
           }
         //--- set anchor type
         ObjectSetString(0,objName,OBJPROP_TEXT,"X");
         //--- set a sign color
         ObjectSetInteger(0,objName,OBJPROP_COLOR,clrYellow);
         //--- set the slope angle of the text
         ObjectSetDouble(0,objName,OBJPROP_ANGLE,-90.0);
        }
       return true;
       }
     }
   return false;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double EA_MACD_Div::GetCandleValue(const double& arr[],int index)
  {
   if(m_fMACD[index] > INVALID_VALUE  +  1)
      return MathAbs(m_fMACD[index]);
//m_fHLCAMedian[index] = (High[index]+ Close[index] + Low[index]) / 3;
//m_fHLCAMedian[index] = (High[index]+ Close[index] + Low[index]) / 3;
   return m_fMACD[index];
  }
//+------------------------------------------------------------------+
//| Decrease Increasing MACDs in Main FrameTime                                                                 |
//+------------------------------------------------------------------+
ENUM_DIVERGENCE_CLASS EA_MACD_Div::CheckDivergenceExtention(ENUM_WAVE_TREND trendDirection)
  {
   if(trendDirection == ENUM_TREND_BULLISH && !IsAllowCheck(ENUM_DIVERGENCE_NEGATIVE_EXT1))
      return ENUM_DIVERGENCE_NONE;
   if(trendDirection == ENUM_TREND_BEARISH && !IsAllowCheck(ENUM_DIVERGENCE_POSITIVE_EXT1))
      return ENUM_DIVERGENCE_NONE;

   double      fMainMacd[4];
   ENUM_DIVERGENCE_CLASS divClass = ENUM_DIVERGENCE_NONE;
   fMainMacd[1] = iMACD(NULL, 0, macd_fast, macd_slow, macd_signal, PRICE_CLOSE, MODE_MAIN, 1);
   fMainMacd[2] = iMACD(NULL, 0, macd_fast, macd_slow, macd_signal, PRICE_CLOSE, MODE_MAIN, 2);
   fMainMacd[3] = iMACD(NULL, 0, macd_fast, macd_slow, macd_signal, PRICE_CLOSE, MODE_MAIN, 3);
   double fObjPosition = 0.f;
   string objName;
   switch(trendDirection)
     {
      case  ENUM_TREND_BULLISH : //search for Negative Divergence , Expect MACD positive
         if(fMainMacd[1] > 0 && fMainMacd[2] > 0 &&  fMainMacd[3] > 0 &&
            fMainMacd[3] > fMainMacd[2] && fMainMacd[2] > fMainMacd[1] &&
            High[1] > High[3]) // High Last Balatar az Before
           {
            divClass = ENUM_DIVERGENCE_NEGATIVE_EXT1;
            fObjPosition = High[1]+20*_Point;
           }
         break;
      case ENUM_TREND_BEARISH :
         if(fMainMacd[1] < 0 && fMainMacd[2] < 0 &&  fMainMacd[3] < 0 &&
            MathAbs(fMainMacd[3]) > MathAbs(fMainMacd[2]) && MathAbs(fMainMacd[2]) > MathAbs(fMainMacd[1]) &&
            Low[1] < Low[3])  // Low Last Payin tar az Before
           {
            divClass = ENUM_DIVERGENCE_POSITIVE_EXT1;
            fObjPosition = Low[1]-20*_Point;
           }
         break;
     }
   if(divClass != ENUM_DIVERGENCE_NONE)
     {
      //if(IS_ENABLE_LOG) Print("DivCheck2 : FindDivergence : ", EnumToString(divClass)," PriceBar :", 1, " ExtremumTime ",Time[2]);
      if(IS_DRAW_DIVERGENCE)
        {
         objName = "Text"+IntegerToString(MathRand())+IntegerToString(MathRand());
         if(!ObjectCreate(0,objName,OBJ_TEXT,0,Time[2],fObjPosition))
           {
            Print(__FUNCTION__,
                  ": failed to create \"OBJ_TEXT\" sign! Error code = ",GetLastError());
           }
         //--- set anchor type
         ObjectSetString(0,objName,OBJPROP_TEXT,"E1");
         //--- set a sign color
         ObjectSetInteger(0,objName,OBJPROP_COLOR,clrYellow);
         //--- set the slope angle of the text
         ObjectSetDouble(0,objName,OBJPROP_ANGLE,-90.0);
        }
     }

   return divClass;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
ENUM_DIVERGENCE_CLASS EA_MACD_Div::CheckDivergenceRSI(int nExtIndex, ENUM_WAVE_TREND trendDirection)
  {
   if(trendDirection == ENUM_TREND_BULLISH && !IsAllowCheck(ENUM_DIVERGENCE_NEGATIVE_RSI_T1))
     {
      //if(IS_ENABLE_LOG) Print("NotAllowed :" , m_nSelTimeFrame , " " , m_nAllowCheckTypes , "  " , (m_nAllowCheckTypes & ENUM_ALLOW_DIVERGENCE_RSI_T1) == 1 );
      return ENUM_DIVERGENCE_NONE;
     }
   if(trendDirection == ENUM_TREND_BEARISH && !IsAllowCheck(ENUM_DIVERGENCE_POSITIVE_RSI_T1))
     {
      //if(IS_ENABLE_LOG) Print("NotAllowed :" , m_nSelTimeFrame , " " , m_nAllowCheckTypes , "  " , (m_nAllowCheckTypes & ENUM_ALLOW_DIVERGENCE_RSI_T1) == 1 );
      return ENUM_DIVERGENCE_NONE;
     }

   ENUM_DIVERGENCE_CLASS divClass = ENUM_DIVERGENCE_NONE;

   double fRSI_Prv = iRSI(NULL, 0, 14,PRICE_CLOSE, 2);
   double fRSI_Extremum = iRSI(NULL, 0, 14,PRICE_CLOSE, m_extremums[nExtIndex].PriceBar);
//Print ("CheckDivergenceRSI : RSI_Prv : " , (int)fRSI_Prv , " fRSI_Extremum : " , (int)fRSI_Extremum , " PriceBar " , m_extremums[nExtIndex].PriceBar , " " , EnumToString(trendDirection) , " Extremum Price Value : " , m_extremums[nExtIndex].PriceValue , " LowOrHigh[2] : " , trendDirection == ENUM_TREND_BULLISH ? High[2] : Low[2]   );
   double fObjPosition = 0.f;
   string objName;

   switch(trendDirection)
     {
      case  ENUM_TREND_BULLISH : //search for Negative Divergence , Expect MACD positive
         if(fRSI_Extremum >= fRSI_Prv && m_extremums[nExtIndex].PriceValue < High[2])    //Negative Divergence
           {
            divClass = ENUM_DIVERGENCE_NEGATIVE_RSI_T1;
            fObjPosition = High[2]+20*_Point;
           }
         break;
      case ENUM_TREND_BEARISH :
         if(fRSI_Extremum <= fRSI_Prv && m_extremums[nExtIndex].PriceValue > Low[2])     //Positive Divergence
           {
            divClass = ENUM_DIVERGENCE_POSITIVE_RSI_T1;
            fObjPosition = Low[2]-20*_Point;
           }
         break;
     }

   if(divClass != ENUM_DIVERGENCE_NONE)
     {
      //if(IS_ENABLE_LOG) Print("CheckDivergenceRSI : FindDivergence : ", EnumToString(divClass)," PriceBar :", m_extremums[nExtIndex].PriceValue, " ExtremumTime ",Time[2]);
      if(IS_DRAW_DIVERGENCE)
        {
         objName = "Text"+IntegerToString(MathRand())+IntegerToString(MathRand());
         if(!ObjectCreate(0,objName,OBJ_TEXT,0,Time[2],fObjPosition))
           {
            Print(__FUNCTION__,
                  ": failed to create \"OBJ_TEXT\" sign! Error code = ",GetLastError());
           }
         //--- set anchor type
         ObjectSetString(0,objName,OBJPROP_TEXT,"RS");
         //--- set a sign color
         ObjectSetInteger(0,objName,OBJPROP_COLOR,clrYellow);
         //--- set the slope angle of the text
         ObjectSetDouble(0,objName,OBJPROP_ANGLE,-90.0);
        }
     }

   return divClass;

  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool EA_MACD_Div::IsAllowCheck(ENUM_DIVERGENCE_CLASS divClass)
  {
  //Print (" EA_MACD_Div::IsAllowCheck " , EnumToString(divClass), " " , divClass , " " , m_nAllowCheckTypes , " " , (m_nAllowCheckTypes & ENUM_ALLOW_DIVERGENCE_T1));
   switch(divClass)
     {
      case ENUM_DIVERGENCE_NEGATIVE_T1:
      case ENUM_DIVERGENCE_POSITIVE_T1:
      {
         //Print (" EA_MACD_Div::IsAllowCheck :" , (m_nAllowCheckTypes & ENUM_ALLOW_DIVERGENCE_T1) != 0);
         return (m_nAllowCheckTypes & ENUM_ALLOW_DIVERGENCE_T1) != 0 ;
         break;
      }
      case ENUM_DIVERGENCE_NEGATIVE_T2:
      case ENUM_DIVERGENCE_POSITIVE_T2:
      {
         //Print (" EA_MACD_Div::IsAllowCheck :" , (m_nAllowCheckTypes & ENUM_ALLOW_DIVERGENCE_T2) != 0);
         return (m_nAllowCheckTypes & ENUM_ALLOW_DIVERGENCE_T2) != 0;
         break;
      }
      case ENUM_DIVERGENCE_NEGATIVE_EXT1:
      case ENUM_DIVERGENCE_POSITIVE_EXT1:
      {
         //Print (" EA_MACD_Div::IsAllowCheck :" , (m_nAllowCheckTypes & ENUM_ALLOW_DIVERGENCE_EXTENTION1) != 0 );
         return (m_nAllowCheckTypes & ENUM_ALLOW_DIVERGENCE_EXTENTION1) != 0;
         break;
      }
      case ENUM_DIVERGENCE_NONSTANDARD_NEGATIVE:
      case ENUM_DIVERGENCE_NONSTANDARD_POSITIVE:
      {
         //Print (" EA_MACD_Div::IsAllowCheck : " , (m_nAllowCheckTypes & ENUM_ALLOW_DIVERGENCE_NONSTANDARD) != 0);
         return (m_nAllowCheckTypes & ENUM_ALLOW_DIVERGENCE_NONSTANDARD) != 0;
         break;
      }
      case ENUM_DIVERGENCE_NEGATIVE_RSI_T1:
      case ENUM_DIVERGENCE_POSITIVE_RSI_T1:
      {
         //Print (" EA_MACD_Div::IsAllowCheck : " , (m_nAllowCheckTypes & ENUM_ALLOW_DIVERGENCE_RSI_T1) != 0);
         return (m_nAllowCheckTypes & ENUM_ALLOW_DIVERGENCE_RSI_T1) != 0;
         break;
      }
      default :
         if(IS_ENABLE_LOG) Print("Not Detectable divClass ");
         break;

     }
   return true;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void  EA_MACD_Div::DrawExtermum(ENUM_WAVE_TREND trendDirection,int nExtInd)
  {
   if(!IS_DRAW_TEXT)
      return ;
   string objName = "Text"+IntegerToString(MathRand())+IntegerToString(MathRand());
   double fObjPosition = 0.f;
   switch(trendDirection)
     {
      case  ENUM_TREND_BULLISH : //search for Negative Divergence , Expect MACD positive
         fObjPosition = iHigh(NULL,m_nSelTimeFrame,m_extremums[nExtInd].ExtremumBar) + 20 * _Point ;
         break;
      case ENUM_TREND_BEARISH :
         fObjPosition = iLow(NULL,m_nSelTimeFrame,m_extremums[nExtInd].ExtremumBar) - 20 * _Point ;
         break;
     }
   if(!ObjectCreate(0,objName,OBJ_TEXT,0,iTime(NULL,m_nSelTimeFrame,m_extremums[nExtInd].PriceBar),fObjPosition))
     {
      Print(__FUNCTION__,
            ": failed to create \"OBJ_TEXT\" sign! Error code = ",GetLastError());
     }
//--- set anchor type
   ObjectSetString(0,objName,OBJPROP_TEXT,"X");
//--- set a sign color
   ObjectSetInteger(0,objName,OBJPROP_COLOR,clrYellow);
//--- set the slope angle of the text
   ObjectSetDouble(0,objName,OBJPROP_ANGLE,-90.0);

  }
///////////////////study{
/*
https://www.mql5.com/en/articles/3460
This article is good , mathmatical and serious .
But : only continuous  peaks are investigate I guess ? Are hamintor hast.
https://www.mql5.com/en/articles/3686
use it accelerator of Bill Willimas , Profit Factor and Draw Down is very good ,
But : in chart it has problem  Some wave not ertebat ba ham , but determine as devergence ,
 I want to determine and Trend and pass it to this class , Also Candle Stick Patterns is first alarm .

 خودم فکر می کنم باید واگرایی در یک تایم پایین تر بررسی شود
 تجربه ترید خود این می گوید.
 نشان دهنده ضعف است که می تواند در تایم بالاتر بعدا ظاهر شود.

  Both have an Extremum function get one index and two count from left and right determine extermum is or not.
   also ArrayMinimum and ArrayMaximum that return highest and lowest in a range index

  about MACD oscillator

  IMPORTANT : IMPORTANT : One of the rules for determining the divergence using MACD is the following: the oscillator bars must not cross the zero level. The below screenshot shows that in this case divergence is not obvious, so chances of having a profitable trade are low.

   Unlike the previous indicators, this one generates fewer signals. But it is a trend indicator, and therefore it informs about global changes in the market. Despite all advantages, the market entry needs to be confirmed by the Price Action analysis or candlestick patterns.

https://www.mql5.com/en/articles/5703

Classification of Divergence is good and necessary

Using ADX Custom , really its chart is very good , check in different TimeFrame and Symbols and Profit Factor is good and Positive
I think it is interesting , really investigate , the programming is weak but Deeply analyse and underestand of Indicators.
اجنه می گویند حرف گوش کنم این را استفاده نمایم.
فکر می کنم برنامه نویسی آن هم ساده هست کار سختی نیست.

S1 : I must read this paper carefully.

*/
//+------------------------------------------------------------------+
/*
بنظرم حالت اکستنشن یعنی اینکه
کاهنده یا افزاینده باشد باید در تایم فریم خود اصلی بررسی شود نه پایین تر

ببین می خواهم یک نقاط مناسب خروج پیدا کن

اما الان فقط یک سری نقاط مناسب نوسانگیری دارد د
دستم را می گیرد

باید اگر مدیریت سرمایه اجازه داد در سود مناسبی بودم (این درست هست یا نه نمی دونم)
اما مثلا  پله ای در این نقطه بفروشم. بعد چنددرصد پایین تر دوباره سوار شوم

این نوسانگیری هست

ببین من در الیوت از مکد برای تعیین نقاط اکسترموم درجه امواج شناسایی امواج استفاده می کنم
الان هم باید همینطور باشد مکد را بزنم نقاط ماکزیمم مینیمم در بیاورم

بهینه سازی
ابتدا بر روی کندل قبلی کار می کردم اما بنظرم اشتباه است
باید کندل قبلی که بسته شد کندل قبلش  مشخص باشد که یک اکسترمم هست یا نه هم از نظر اندیکاتور هم از نظر قیمتی
برای همین بنظرم کلا سیستم را روی دو تا کندل قبل بردم
درستش هم همین هستم واگرایی تاخیر دارد و روی دو تا کندل قبل مشخص می گردد نه فقط یکی
 
*/

//+------------------------------------------------------------------+
