//+------------------------------------------------------------------+
//|                                          CandleStickPatterns.mqh |
//|                                                   Majid Namnabat |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Majid Namnabat"
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
//URL : https://www.mql5.com/en/articles/101

#include <MD_V_LAST\\EA_Candlesticktype.mqh>
const int   ShortTrend_CandlePattern_PeriodSMA   =10;         // Period of averaging
/*
One Byte Counter
1		001 //1 
2		010 //2
3		100 //4
4	3bit	101 //5 8 shift walue 1 BYTE + 3 Bit + 1 Bit + 1 Bit + 1 Bit
5		110 //6
		
BULL	1bit	1   12 shift value
BEAR		
		
REVERSE	1bit	 11 shift value
CONTINUE		

Confirmation is not required 1
is suggested  2
*/
enum ENUM_CANDLE_PATTERNS  // candlestick patterns
  {
   ERROR_OCCURED                        = -1,
   
   //One Candle
   CANDLE_PATTERN_HAMMER_BULLISH                         = (1 << 12) | (1 << 11) | (1 << 8) | (char)1,
   CANDLE_PATTERN_INVERTED_HAMMER_BULLISH                = (1 << 12) | (1 << 11) | (1 << 8) | (char)2,
   CANDLE_PATTERN_HANGING_MAN_BEARISH                    = (0 << 12) | (1 << 11) | (1 << 8) | (char)3  ,
   CANDLE_PATTERN_KICKING_CONTINUATION_BULLISH           = (1 << 13) | (1 << 12) | (0 << 11) | (1 << 8) | (char)4 ,
   CANDLE_PATTERN_KICKING_CONTINUATION_BEARISH           = (1 << 13) | (0 << 12) | (0 << 11) | (1 << 8) | (char)5  ,
   //Two Candle
   CANDLE_PATTERN_SHOOTING_STAR_BEARISH                  = (0 << 12) | (1 << 11) | (2 << 8) | (char)6  ,
   CANDLE_PATTERN_BELT_HOLD_BULISH                       = (1 << 12) | (1 << 11) | (2 << 8) | (char)7,
   CANDLE_PATTERN_BELT_HOLD_BEARISH                      = (0 << 12) | (1 << 11) | (2 << 8) | (char)8 ,
   CANDLE_PATTERN_ENGULFING_BEARISH                      = (0 << 12) | (1 << 11) | (2 << 8) | (char)9 ,
   CANDLE_PATTERN_ENGULFING_BULLISH                      = (1 << 12) | (1 << 11) | (2 << 8) | (char)10 ,
   CANDLE_PATTERN_HARAMICROSS_BEARISH                    = (0 << 12) | (1 << 11) | (2 << 8) | (char)11 ,
   CANDLE_PATTERN_HARAMICROSS_BULLISH                    = (1 << 12) | (1 << 11) | (2 << 8) | (char)12,
   CANDLE_PATTERN_HARAMI_BEARISH                         = (0 << 12) | (1 << 11) | (2 << 8) | (char)13 ,
   CANDLE_PATTERN_HARAMI_BULLISH                         = (1 << 12) | (1 << 11) | (2 << 8) | (char)14,
   CANDLE_PATTERN_DOJI_BEARISH                           = (0 << 12) | (1 << 11) | (2 << 8) | (char)15,
   CANDLE_PATTERN_DOJI_BULISH                            = (1 << 12) | (1 << 11) | (2 << 8) | (char)16,
   CANDLE_PATTERN_PIERCING_LINE_BULISH                   = (1 << 13) | (1 << 12) | (1 << 11) | (2 << 8) | (char)17,
   CANDLE_PATTERN_DARK_CLOUD_COVER_BEARISH               = (1 << 13) | (0 << 12) | (1 << 11) | (2 << 8) | (char)18,
   CANDLE_PATTERN_MEETING_LINES_BEARISH                  = (0 << 12) | (1 << 11) | (2 << 8) | (char)19 ,
   CANDLE_PATTERN_MEETING_LINES_BULLISH                  = (1 << 12) | (1 << 11) | (2 << 8) | (char)20,
   CANDLE_PATTERN_MATCHING_LOW_BULLISH                   = (1 << 12) | (1 << 11) | (2 << 8) | (char)21, 
   CANDLE_PATTERN_HOMING_PIGEON_BULISH                   = (1 << 12) | (1 << 11) | (2 << 8) | (char)22,
   CANDLE_PATTERN_ONNECK_LINE_CONTINUATION_BEARISH       = (0 << 12) | (0 << 11) | (2 << 8) | (char)23 ,
   CANDLE_PATTERN_INNECK_LINE_CONTINUATION_BEARISH       = (0 << 12) | (0 << 11) | (2 << 8) | (char)24 ,
   CANDLE_PATTERN_THRUSTING_LINE_CONTINUATION_BEARISH    = (0 << 12) | (0 << 11) | (2 << 8) | (char)25 ,
   //THREE CANDLE
   CANDLE_PATTERN_ABANDONED_BABY_BULISH                  = (1 << 12) | (1 << 11) | (4 << 8) | (char)26,
   CANDLE_PATTERN_ABANDONED_BABY_BEARISH                 = (0 << 12) | (1 << 11) | (4 << 8) | (char)27  ,
   CANDLE_PATTERN_MORNING_STAR_BULISH                    = (1 << 12) | (1 << 11) | (4 << 8) | (char)28 ,
   CANDLE_PATTERN_EVENING_STAR_BEARISH                   = (0 << 12) | (1 << 11) | (4 << 8) | (char)29  ,
   CANDLE_PATTERN_MORNING_DOJI_STAR_BULISH               = (1 << 12) | (1 << 11) | (4 << 8) | (char)30 ,
   CANDLE_PATTERN_EVENING_DOJI_STAR_BEARISH              = (0 << 12) | (1 << 11) | (4 << 8) | (char)31  ,    
   CANDLE_PATTERN_UPSIDE_GAP_TWO_CROWS_BEARISH           = (0 << 12) | (1 << 11) | (4 << 8) | (char)32  ,
   CANDLE_PATTERN_TWO_CROWS_BEARISH                      = (0 << 12) | (1 << 11) | (4 << 8) | (char)33  ,
   CANDLE_PATTERN_THREE_STAR_IN_SOUTH_BULISH             = (1 << 12) | (1 << 11) | (4 << 8) | (char)34 ,
   CANDLE_PATTERN_DELIBERATION_BEARISH                   = (0 << 12) | (1 << 11) | (4 << 8) | (char)35  ,
   CANDLE_PATTERN_THREE_BLACK_CROWS_BEARISH              = (1 << 13) | (0 << 12) | (1 << 11) | (4 << 8) | (char)36  ,
   CANDLE_PATTERN_THREE_WHITE_SOLDIERS_BULISH            = (1 << 13) | (1 << 12) | (1 << 11) | (4 << 8) | (char)37,

   CANDLE_PATTERN_THREE_OUTSIDE_UP_BULISH                = (1 << 13) | (1 << 12) | (1 << 11) | (4 << 8) | (char)38 ,
   CANDLE_PATTERN_THREE_OUTSIDE_DOWN_BEARISH             = (1 << 13) | (0 << 12) | (1 << 11) | (4 << 8) | (char)39  ,
   CANDLE_PATTERN_THREE_INSIDE_UP_BULISH                 = (1 << 13) | (1 << 12) | (1 << 11) | (4 << 8) | (char)40 ,
   CANDLE_PATTERN_THREE_INSIDE_DOWN_BEARISH              = (1 << 13) | (0 << 12) | (1 << 11) | (4 << 8) | (char)41  ,
   CANDLE_PATTERN_THREE_STARS_BULISH                     = (1 << 12) | (1 << 11) | (4 << 8) | (char)42 ,
   CANDLE_PATTERN_THREE_STARS_BEARISH                    = (0 << 12) | (1 << 11) | (4 << 8) | (char)43  ,
   CANDLE_PATTERN_IDENTICAL_THREE_CROWS_BEARISH          = (1 << 13) | (0 << 12) | (1 << 11) | (4 << 8) | (char)44  ,
   CANDLE_PATTERN_UNIQUE_THREE_RIVER_BOTTOM_BULISH       = (1 << 13) | (1 << 12) | (1 << 11) | (4 << 8) | (char)45,
   CANDLE_PATTERN_DOWNSIDE_GAP_THREE_METHODS_CONTINUATION_BEARISH  = (0 << 12) | (0 << 11) | (4 << 8) | (char)46  ,
   CANDLE_PATTERN_UPSIDE_GAP_THREE_METHODS_CONTINUATION_BULISH     = (1 << 12) | (0 << 11) | (4 << 8) | (char)47 ,
   CANDLE_PATTERN_DOWNSIDE_TASUKI_GAP_CONTINUATION_BEARISH         = (0 << 12) | (0 << 11) | (4 << 8) | (char)48  ,
   CANDLE_PATTERN_UPSIDE_TASUKI_GAP_CONTINUATION_BULISH            = (1 << 12) | (0 << 11) | (4 << 8) | (char)49  ,   
   //FOUR CANDLES
   CANDLE_PATTERN_CONCEALING_BABY_SWALLOW_BULISH         = (1 << 13) | (1 << 12) | (1 << 11) | (5 << 8) | (char)50  ,
   CANDLE_PATTERN_THREE_LINE_STRIKE_CONTINUATION_BULISH  = (1 << 12) | (0 << 11) | (5 << 8) | (char)51  ,
   CANDLE_PATTERN_THREE_LINE_STRIKE_CONTINUATION_BEARISH = (0 << 12) | (0 << 11) | (5 << 8) | (char)52 ,
   // FIVE CANDLES
   CANDLE_PATTERN_BREAKAWAY_BEARISH                      = (0 << 12) | (1 << 11) | (6 << 8) | (char)53 ,
   CANDLE_PATTERN_BREAKAWAY_BULISH                       = (1 << 12) | (1 << 11) | (6 << 8) | (char)54,

   UNKNOWN_PATTERN                      = -2 
  };
class CandleStickPatterns
  {
private:

public:
                     CandleStickPatterns();
                    ~CandleStickPatterns();
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
CandleStickPatterns::CandleStickPatterns()
  {
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
CandleStickPatterns::~CandleStickPatterns()
  {
  }
//+------------------------------------------------------------------+
ENUM_CANDLE_PATTERNS DetermmineCandlestickPatterns(bool forex , string symbol,ENUM_TIMEFRAMES period,const datetime &time[]) {
      CANDLE_STRUCTURE cand[5];
      //Print ("DetermmineCandlestickPatterns Calling!!! ");
      if(!RecognizeCandle(symbol,period,time[1],ShortTrend_CandlePattern_PeriodSMA,cand[4]))
      {
         Print ("DetermmineCandlestickPatterns time[1] ERROR_OCCURED");
         return ERROR_OCCURED;
      }
      if(!RecognizeCandle(symbol,period,time[2],ShortTrend_CandlePattern_PeriodSMA,cand[3]))
      {
         Print ("DetermmineCandlestickPatterns time[1] ERROR_OCCURED");
         return ERROR_OCCURED; 
      }
      if(!RecognizeCandle(symbol,period,time[3],ShortTrend_CandlePattern_PeriodSMA,cand[2]))
      {
         Print ("DetermmineCandlestickPatterns time[1] ERROR_OCCURED");
         return ERROR_OCCURED; 
      }
      if(!RecognizeCandle(symbol,period,time[4],ShortTrend_CandlePattern_PeriodSMA,cand[1]))
      {
         Print ("DetermmineCandlestickPatterns time[1] ERROR_OCCURED");
         return ERROR_OCCURED; 
      }
      if(!RecognizeCandle(symbol,period,time[5],ShortTrend_CandlePattern_PeriodSMA,cand[0]))
      {
         Print ("DetermmineCandlestickPatterns time[1] ERROR_OCCURED");
         return ERROR_OCCURED;  
      }
  

      //--    
/* Check patterns on one candlestick */
 
      //------      
      // Inverted Hammer, the bullish model
      if(cand[4].trend==DOWN && // check direction of trend
         cand[4].type==CAND_INVERT_HAMMER) // the "Inverted Hammer" check
        {
            return CANDLE_PATTERN_INVERTED_HAMMER_BULLISH;
        }
      // Hanging Man, the bearish model
      if(cand[4].trend==UPPER && // check direction of trend
         cand[4].type==CAND_HAMMER) // the "Hammer" check
        {
            return CANDLE_PATTERN_HANGING_MAN_BEARISH;
        }
      //------      
      // Hammer, the bullish model
      if(cand[4].trend==DOWN && // check direction of trend
         cand[4].type==CAND_HAMMER) // the "Hammer" check
        {
            return CANDLE_PATTERN_HAMMER_BULLISH;
        }
      
      /* Check of patters with two candlesticks */
      

      //------      
      // Shooting Star, the bearish model
      if(cand[3].trend==UPPER && cand[4].trend==UPPER && // check direction of trend
         cand[4].type==CAND_INVERT_HAMMER) // the "Inverted Hammer" check
        {
         
         if(forex) //if it's forex
           {
            if(cand[3].close<=cand[4].open) // close 1 is less than or equal to open 1
              {
               return CANDLE_PATTERN_SHOOTING_STAR_BEARISH;
              }
           }
         else
           {
            if(cand[3].close<cand[4].open && cand[3].close<cand[4].close) // 2 candlestick is cut off from 1
              {
               return CANDLE_PATTERN_SHOOTING_STAR_BEARISH;
              }
           }
        }
      // ------      
      // Belt Hold, the bullish
      if(cand[4].trend==DOWN && cand[4].bull && !cand[3].bull && // check direction of trend and direction of candlestick
         cand[4].type==CAND_MARIBOZU_LONG && // the "long Maribozu" check
         cand[3].bodysize<cand[4].bodysize && cand[4].close<cand[3].close) // body of the first candlestick is smaller than body of the second one, close price of the second candlestick is lower than the close price of the first one
        {
         if(!forex)// if it's not forex
           {
            return CANDLE_PATTERN_BELT_HOLD_BULISH;
           }
        }
      // Belt Hold, the bearish model
      if(cand[4].trend==UPPER && !cand[4].bull && cand[3].bull && // check direction of trend and direction of candlestick
         cand[4].type==CAND_MARIBOZU_LONG && // the "long Maribozu" check
         cand[3].bodysize<cand[4].bodysize && cand[4].close>cand[3].close) // body of the first candlestick is lower than body of the second one; close price of the second candlestick is higher than that of the first one
        {
         return CANDLE_PATTERN_BELT_HOLD_BEARISH;
        }
      //------      
      // Engulfing, the bullish model
      if(cand[3].trend==DOWN && !cand[3].bull && cand[4].trend==DOWN && cand[4].bull && // check direction of trend and direction of candlestick
         cand[3].bodysize<cand[4].bodysize) // body of the third candlestick is bigger than that of the second one
        {
         if(forex)// if it's forex
           {
            if(cand[3].close>=cand[4].open && cand[3].open<cand[4].close) // body of the first candlestick is inside of body of the second one
              {
               return CANDLE_PATTERN_ENGULFING_BULLISH;
              }
           }
         else
           {
            if(cand[3].close>cand[4].open && cand[3].open<cand[4].close) // body of the first candlestick inside of body of the second candlestick
              {
                return CANDLE_PATTERN_ENGULFING_BULLISH;
              }
           }
        }
      // Engulfing, the bearish model
      //Print (EnumToString(cand[3].trend)," " , EnumToString(cand[4].trend)," ", cand[3].bull ," " , cand[4].bull ," " , cand[3].bodysize , " " , cand[4].bodysize , " ");
      if(cand[3].trend==UPPER && cand[3].bull && cand[4].trend==UPPER && !cand[4].bull && // check direction and direction of candlestick
         cand[3].bodysize<cand[4].bodysize) // body of the third candlestick is bigger than that of the second one
        {
         //Print ("CandleStickPatterns Engulfing Condition Input ", cand[3].close , "  " , cand[4].open , "  " , cand[3].open , "  " ,cand[4].close);
         if(forex)// if it's forex
           {
            if(cand[3].close<=cand[4].open && cand[3].open>cand[4].close) // body of the first candlestick is inside of body of the second one
              {
               return CANDLE_PATTERN_ENGULFING_BEARISH;
              }
           }
         else
           {
            if(cand[3].close<cand[4].open && cand[3].open>cand[4].close) // close 1 is lower or equal to open 2; or open 1 is higher or equal to close 2
              {
               return CANDLE_PATTERN_ENGULFING_BEARISH;
              }
           }
        }
      //------      
      // Harami Cross, the bullish model
      if(cand[3].trend==DOWN && !cand[3].bull && // check direction of trend and direction of candlestick
         (cand[3].type==CAND_LONG || cand[3].type==CAND_MARIBOZU_LONG) && cand[4].type==CAND_DOJI) // check of "long" first candlestick and Doji candlestick
        {
         if(forex)// if it's forex
           {
            if(cand[3].close<=cand[4].open && cand[3].close<=cand[4].close && cand[3].open>cand[4].close) // Doji is inside of body of the first candlestick
              {
                  return CANDLE_PATTERN_HARAMICROSS_BULLISH;
              }
           }
         else
           {
            if(cand[3].close<cand[4].open && cand[3].close<cand[4].close && cand[3].open>cand[4].close) // Doji is inside of body of the first candlestick
              {
               return CANDLE_PATTERN_HARAMICROSS_BULLISH;
              }
           }
        }
      // Harami Cross, the bearish model
      if(cand[3].trend==UPPER && cand[3].bull && // check direction of trend and direction of candlestick
         (cand[3].type==CAND_LONG || cand[3].type==CAND_MARIBOZU_LONG) && cand[4].type==CAND_DOJI) // check of "long" candlestick and Doji
        {
         
         if(forex)// if it's forex
           {
            if(cand[3].close>=cand[4].open && cand[3].close>=cand[4].close && cand[3].close>=cand[4].close) // Doji is inside of body of the first candlestick
              {
               return CANDLE_PATTERN_HARAMICROSS_BEARISH;
              }
           }
         else
           {
            if(cand[3].close>cand[4].open && cand[3].close>cand[4].close && cand[3].open<cand[4].close) // Doji is inside of body of the first candlestick
              {
               return CANDLE_PATTERN_HARAMICROSS_BEARISH;
              }
           }
        }
      //------      
      // Harami, the bullish model
      if(cand[3].trend==DOWN  &&  !cand[3].bull  &&  cand[4].bull &&// check direction of trend and direction of candlestick
         (cand[3].type==CAND_LONG || cand[3].type==CAND_MARIBOZU_LONG) &&  // check of "long" first candlestick
         cand[4].type!=CAND_DOJI && cand[3].bodysize>cand[4].bodysize) // the second candlestick is not Doji and body of the first candlestick is bigger than that of the second one
        {
         
         if(forex)// if it's forex
           {
            if(cand[3].close<=cand[4].open && cand[3].close<=cand[4].close && cand[3].open>cand[4].close) // body of the second candlestick is inside of body of the first candlestick
              {
               return CANDLE_PATTERN_HARAMI_BULLISH;
              }
           }
         else
           {
            if(cand[3].close<cand[4].open && cand[3].close<cand[4].close && cand[3].open>cand[4].close) // body of the second candlestick is inside of body of the first one
              {
               return CANDLE_PATTERN_HARAMI_BULLISH;
              }
           }
        }
      // Harami, the bearish model
      if(cand[3].trend==UPPER && cand[3].bull && !cand[4].bull && // check direction of trend and direction of candlestick
         (cand[3].type==CAND_LONG|| cand[3].type==CAND_MARIBOZU_LONG) && // check of "long" first candlestick
         cand[4].type!=CAND_DOJI && cand[3].bodysize>cand[4].bodysize) // the second candlestick is not Doji and body of the first candlestick is bigger than that of the second one
        {
         if(forex)// if it's forex
           {
            if(cand[3].close>=cand[4].open && cand[3].close>=cand[4].close && cand[3].close>=cand[4].close) // Doji is inside of body of the first candlestick
              {
               return CANDLE_PATTERN_HARAMI_BEARISH;
              }
           }
         else
           {
            if(cand[3].close>cand[4].open && cand[3].close>cand[4].close && cand[3].open<cand[4].close) // Doji is inside of body of the first candlestick
              {
               return CANDLE_PATTERN_HARAMI_BEARISH;
              }
           }
        }
      //------      
      // Doji Star, the bullish model
      if(cand[3].trend==DOWN && !cand[3].bull && // check direction of trend and direction of candlestick
         (cand[3].type==CAND_LONG || cand[3].type==CAND_MARIBOZU_LONG) && cand[4].type==CAND_DOJI) // check first "long" candlestick and 2 doji
        {
         if(forex)// if it's forex
           {
            if(cand[3].close>=cand[4].open) // Open price of Doji is lower or equal to close price of the first candlestick
              {
               return CANDLE_PATTERN_DOJI_BULISH;
              }
           }
         else
           {
            if(cand[3].close>cand[4].open && cand[3].close>cand[4].close) // Body of Doji is cut off the body of the first candlestick
              {
               return CANDLE_PATTERN_DOJI_BULISH;
              }
           }
        }
      // Doji Star, the bearish model
      if(cand[3].trend==UPPER && cand[3].bull && // check direction of trend and direction of candlestick
         (cand[3].type==CAND_LONG || cand[3].type==CAND_MARIBOZU_LONG) && cand[4].type==CAND_DOJI) // check first "long" candlestick and 2 doji
        {
         if(forex)// if it's forex
           {
            if(cand[3].close<=cand[4].open) // // open price of Doji is higher or equal to close price of the first candlestick
              {
                return CANDLE_PATTERN_DOJI_BEARISH;
              }
           }
         else
           {
            if(cand[3].close<cand[4].open && cand[3].close<cand[4].close) // // body of Doji is cut off the body of the first candlestick
              {
                return CANDLE_PATTERN_DOJI_BEARISH;
              }
           }
        }
      //------      
      // Piercing Line, the bull model
      if(cand[3].trend==DOWN && !cand[3].bull && cand[4].trend==DOWN && cand[4].bull && // check direction of trend and direction of candlestick
         (cand[3].type==CAND_LONG || cand[3].type==CAND_MARIBOZU_LONG) && (cand[4].type==CAND_LONG || cand[4].type==CAND_MARIBOZU_LONG) && // check of "long" candlestick
         cand[4].close>(cand[3].close+cand[3].open)/2)// close price of the second candle is higher than the middle of the first one
        {
         if(forex)// if it's forex
           {
            if(cand[3].close>=cand[4].open && cand[4].close<=cand[3].open)
              {
               return CANDLE_PATTERN_PIERCING_LINE_BULISH;
              }
           }
         else
           {
            if(cand[4].open<cand[3].low && cand[4].close<=cand[3].open) // open price of the second candle is lower than LOW price of the first one 
              {
               return CANDLE_PATTERN_PIERCING_LINE_BULISH;
              }
           }
        }
      // Dark Cloud Cover, the bearish model
      if(cand[3].trend==UPPER && cand[3].bull && cand[4].trend==UPPER && !cand[4].bull && // check direction and direction of candlestick
         (cand[3].type==CAND_LONG || cand[3].type==CAND_MARIBOZU_LONG) && (cand[4].type==CAND_LONG || cand[4].type==CAND_MARIBOZU_LONG) && // check of "long" candlestick
         cand[4].close<(cand[3].close+cand[3].open)/2)// close price of 2-nd candlestick is lower than the middle of the body of the 1-st one
        {
         if(forex)// if it's forex
           {
            if(cand[3].close<=cand[4].open && cand[4].close>=cand[3].open)
              {
               return CANDLE_PATTERN_DARK_CLOUD_COVER_BEARISH;
              }
           }
         else
           {
            if(cand[3].high<cand[4].open && cand[4].close>=cand[3].open)
              {
               return CANDLE_PATTERN_DARK_CLOUD_COVER_BEARISH;
              }
           }
        }
      //------      
      // Meeting Lines the bull model / آًٌٍه÷à‏ùèهٌے ٌâه÷è لû÷üے ىîنهëü
      if(cand[3].trend==DOWN && !cand[3].bull && cand[4].trend==DOWN && cand[4].bull && // check direction of trend and direction of candlestick
         (cand[3].type==CAND_LONG || cand[3].type==CAND_MARIBOZU_LONG) && (cand[4].type==CAND_LONG || cand[4].type==CAND_MARIBOZU_LONG) && // check of "long" candlestick
         cand[3].close==cand[4].close && cand[3].bodysize<cand[4].bodysize && cand[3].low>cand[4].open) // close prices are equal, size of the first candlestick is smaller than that of the second one; open price of the second one is lower than minimum of the first one
        {
         if(!forex)// if it's not forex
           {
           return CANDLE_PATTERN_MEETING_LINES_BULLISH;
           }
        }
      // Meeting Lines, the bearish model
      if(cand[3].trend==UPPER && cand[3].bull && cand[4].trend==UPPER && !cand[4].bull && // check direction and direction of candlestick
         (cand[3].type==CAND_LONG || cand[3].type==CAND_MARIBOZU_LONG) && // check of "long" candlestick
         cand[3].close==cand[4].close && cand[3].bodysize<cand[4].bodysize && cand[3].high<cand[4].open) // // close prices are equal, size of the first one is smaller than that of the second one, open price of the second one is higher than the maximum of the first one
        {
         if(!forex)// if it's not forex
           {
              return CANDLE_PATTERN_MEETING_LINES_BEARISH;
           }
        }
      //------      
      // Matching Low, the bullish model
      if(cand[3].trend==DOWN && !cand[3].bull && cand[4].trend==DOWN && !cand[4].bull && // check direction of trend and direction of candlestick
         cand[3].close==cand[4].close && cand[3].bodysize>cand[4].bodysize) // close price are equal, size of the first one is greater than that of the second one
        {
         if(!forex)// if it's not forex
           {
               return CANDLE_PATTERN_MATCHING_LOW_BULLISH;
           }
        }
      //------      
      // Homing Pigeon, the bullish model
      if(cand[3].trend==DOWN && !cand[3].bull && cand[4].trend==DOWN && !cand[4].bull && // check direction of trend and direction of candlestick
         (cand[3].type==CAND_LONG || cand[3].type==CAND_MARIBOZU_LONG) && // check of "long" candlestick
         cand[3].close<cand[4].close  &&  cand[3].open>cand[4].open) // body of the second candlestick is inside of body of the first one
        {
         if(!forex)// if it's not forex
           {
               return CANDLE_PATTERN_HOMING_PIGEON_BULISH ; 
           }
        }
/* Continuation Models */
 
      //------      
      // Kicking, the bull model
      if(!cand[3].bull && cand[4].bull && // check direction of trend and direction of candlestick
         cand[3].type==CAND_MARIBOZU_LONG && cand[4].type==CAND_MARIBOZU_LONG && // two maribozu
         cand[3].open<cand[4].open) // gap between them
        {
         if(!forex)// if it's not forex
           {
            return CANDLE_PATTERN_KICKING_CONTINUATION_BULLISH;
           }
        }
      // Kicking, the bearish model
      if(cand[3].bull && !cand[4].bull && // check direction of trend and direction of candlestick
         cand[3].type==CAND_MARIBOZU_LONG && cand[4].type==CAND_MARIBOZU_LONG && // two maribozu
         cand[3].open>cand[4].open) // gap between them
        {
         if(!forex)// if it's not forex
           {
                        return CANDLE_PATTERN_KICKING_CONTINUATION_BEARISH;
           }
        }
      //------ Check of module of the neck line
      if(cand[3].trend==DOWN && !cand[3].bull && cand[4].bull && // check direction of trend and direction of candlestick
         (cand[3].type==CAND_LONG || cand[3].type==CAND_MARIBOZU_LONG)) // first candlesticks is "long"
        {
         // On Neck Line, the bearish model
         if(cand[4].open<cand[3].low && cand[4].close==cand[3].low) // second candlestick is opened below the first one and is closed at the minimum level of the first one
           {
            if(!forex)// if it's not forex
              {
               return CANDLE_PATTERN_ONNECK_LINE_CONTINUATION_BEARISH;
              }
           }
         else
           {
            // In Neck Line, the bear model
            if(cand[3].trend==DOWN && !cand[3].bull && cand[4].bull && // check direction of trend and direction of candlestick
               (cand[3].type==CAND_LONG || cand[3].type==CAND_MARIBOZU_LONG) && // first candlestick is "long"
               cand[3].bodysize>cand[4].bodysize && // body of the second candlestick is smaller than body of the first one
               cand[4].open<cand[3].low && cand[4].close>=cand[3].close && cand[4].close<(cand[3].close+cand[3].bodysize*0.01)) // second candlestick is opened below the first one and is closed slightly higher the closing of the first one
              {
               if(!forex)// if it's not forex
                 {
                  return CANDLE_PATTERN_INNECK_LINE_CONTINUATION_BEARISH;
                 }
              }
            else
              {
               // Thrusting Line, the bearish model
               if(cand[3].trend==DOWN && !cand[3].bull && cand[4].bull && // check direction of trend and direction of candlestick
                  (cand[3].type==CAND_LONG || cand[3].type==CAND_MARIBOZU_LONG) && // first candlestick is "long"
                  cand[4].open<cand[3].low && cand[4].close>cand[3].close && cand[4].close<(cand[3].open+cand[3].close)/2) // the second candlestick is opened below the first one and is closed above the closing of the first one, bu below its middle
                 {
                  if(!forex)// if it's not forex
                    {
                     return CANDLE_PATTERN_THRUSTING_LINE_CONTINUATION_BEARISH;
                    }
                 }
              }
           }
        }

/* Check of patterns with three candlesticks */

      //------      
      // The Abandoned Baby, the bullish model
      if(cand[2].trend==DOWN && !cand[2].bull && cand[4].trend==DOWN && cand[4].bull && // check direction of trend and direction of candlestick
         (cand[2].type==CAND_LONG || cand[2].type==CAND_MARIBOZU_LONG) && (cand[4].type==CAND_LONG || cand[4].type==CAND_MARIBOZU_LONG) && // check of "long" candlestick
         cand[3].type==CAND_DOJI && // check if the second candlestick is Doji
         cand[4].close<cand[2].open && cand[4].close>cand[2].close) // the third one is closed inside of body of the first one
        {
         if(!forex)// if it's not forex
           {
            if(cand[2].low>cand[3].high && cand[4].low>cand[3].high) // gap between candlesticks
              {
               return CANDLE_PATTERN_ABANDONED_BABY_BULISH;
              }
           }
        }
      // The Abandoned Baby, the bearish model
      if(cand[2].trend==UPPER && cand[2].bull && cand[4].trend==UPPER && !cand[4].bull && // check direction of trend and direction of candlestick
         (cand[2].type==CAND_LONG || cand[2].type==CAND_MARIBOZU_LONG) && (cand[4].type==CAND_LONG || cand[4].type==CAND_MARIBOZU_LONG) && // check of "long" candlestick
         cand[3].type==CAND_DOJI && // check if the second candlestick is Doji
         cand[4].close>cand[2].open && cand[4].close<cand[2].close) // // the third one is closed inside of body of the second one
        {
         if(!forex)// if it's not forex
           {
            if(cand[2].high<cand[3].low && cand[4].high<cand[3].low) // gap between candlesticks
              {
               return CANDLE_PATTERN_ABANDONED_BABY_BEARISH;
              }
           }
        }
      // ------      
      // Morning star, the bullish model
      if(cand[2].trend==DOWN && !cand[2].bull && cand[4].trend==DOWN && cand[4].bull && // check direction of trend and direction of candlestick
         (cand[2].type==CAND_LONG || cand[2].type==CAND_MARIBOZU_LONG) && (cand[4].type==CAND_LONG || cand[4].type==CAND_MARIBOZU_LONG) && // check of "long" candlestick
         cand[3].type==CAND_SHORT && // check of "short" candlestick
         cand[4].close>cand[2].close && cand[4].close<cand[2].open) // the third candlestick is closed inside of body of the first one
        {
         if(forex)// if it's forex
           {
            if(cand[3].open<=cand[2].close) // Open price of the second candlestick is lower than the closing of the first one
              {
               return CANDLE_PATTERN_MORNING_STAR_BULISH;
              }
           }
         else // other market
           {
            if(cand[3].open<cand[2].close && cand[3].close<cand[2].close) // distance from the second candlestick to the first one
              {
               return CANDLE_PATTERN_MORNING_STAR_BULISH;
              }
           }
        }
      // Evening star, the bearish model
      if(cand[2].trend==UPPER && cand[2].bull && cand[4].trend==UPPER && !cand[4].bull && // check direction of trend and direction of candlestick
         (cand[2].type==CAND_LONG || cand[2].type==CAND_MARIBOZU_LONG) && (cand[4].type==CAND_LONG || cand[4].type==CAND_MARIBOZU_LONG) && // check of "long" candlestick
         cand[3].type==CAND_SHORT && // check of "short" candlestick
         cand[4].close<cand[2].close && cand[4].close>cand[2].open) // the third candlestick is closed inside of body of the first one
        {
         if(forex)// if it's forex
           {
            if(cand[3].open>=cand[2].close) // open price of the second candlestick is higher than that of the first one
              {
               return CANDLE_PATTERN_EVENING_STAR_BEARISH;
              }
           }
         else // other market
           {
            if(cand[3].open>cand[2].close && cand[3].close>cand[2].close) // gap between candlesticks
              {
               return CANDLE_PATTERN_EVENING_STAR_BEARISH;
              }
           }
        }
      //------      
      // Morning Doji Star, the bullish model
      if(cand[2].trend==DOWN && !cand[2].bull && cand[4].trend==DOWN && cand[4].bull && // check direction of trend and direction of candlestick
         (cand[2].type==CAND_LONG || cand[2].type==CAND_MARIBOZU_LONG) && (cand[4].type==CAND_LONG || cand[4].type==CAND_MARIBOZU_LONG) && // check of "long" candlestick
         cand[3].type==CAND_DOJI && // check of "doji"
         cand[4].close>cand[2].close && cand[4].close<cand[2].open) // the third candlestick is closed inside of body of the first one
        {
         if(forex)// if it's forex
           {
            if(cand[3].open<=cand[2].close) // open price of Doji is lower or equal to the close price of the first candlestick
              {
               return CANDLE_PATTERN_MORNING_DOJI_STAR_BULISH ; 
              }
           }
         else // other market
           {
            if(cand[3].open<cand[2].close) // gap between Doji and the first candlestick
              {
               return CANDLE_PATTERN_MORNING_DOJI_STAR_BULISH ; 
              }
           }
        }
      // Evening Doji Star, the bearish model
      if(cand[2].trend==UPPER && cand[2].bull && cand[4].trend==UPPER && !cand[4].bull && // check direction of trend and direction of candlestick
         (cand[2].type==CAND_LONG || cand[2].type==CAND_MARIBOZU_LONG) && (cand[4].type==CAND_LONG || cand[4].type==CAND_MARIBOZU_LONG) && // check of "long" candlestick
         cand[3].type==CAND_DOJI && // check of "doji"
         cand[4].close<cand[2].close && cand[4].close>cand[2].open) // the third candlestick is closed inside of body of the first one
        {
         if(forex)// if it's forex
           {
            if(cand[3].open>=cand[2].close) // open price of Doji is higher or equal to close price of the first candlestick
              {
               return CANDLE_PATTERN_EVENING_DOJI_STAR_BEARISH;
              }
           }
         else // other market
           {
            if(cand[3].open>cand[2].close) // gap between Doji and the first candlestick
               // check of close 2 and open 3
              {
               return CANDLE_PATTERN_EVENING_DOJI_STAR_BEARISH;
              }
           }
        }
      //------      
      // Upside Gap Two Crows, the bearish model
      if(cand[2].trend==UPPER && cand[2].bull && cand[3].trend==UPPER && !cand[3].bull && cand[4].trend==UPPER && !cand[4].bull && // check direction of trend and direction of candlestick
         (cand[2].type==CAND_LONG || cand[2].type==CAND_MARIBOZU_LONG)  &&  // check of "long" candlestick
         cand[2].close<cand[3].close && cand[2].close<cand[4].close && // distance of the second and third candlesticks from the first one
         cand[3].open<cand[4].open && cand[3].close>cand[4].close) // the third candlestick absorbs the second one
        {
         if(!forex)// if it's not forex
           {
            return CANDLE_PATTERN_UPSIDE_GAP_TWO_CROWS_BEARISH ;
           }
        }
      //------      
      // Two Crows, the bearish model
      if(cand[2].trend==UPPER && cand[2].bull && cand[3].trend==UPPER && !cand[3].bull && cand[4].trend==UPPER && !cand[4].bull && // check direction of trend and direction of candlestick
         (cand[2].type==CAND_LONG|| cand[2].type==CAND_MARIBOZU_LONG) &&(cand[4].type==CAND_LONG|| cand[4].type==CAND_MARIBOZU_LONG) && // check of "long" candlestick
         cand[2].close<cand[3].close && // distance between the second and first candlesticks
         cand[4].open>cand[3].close && // the third candlestick is opened higher than the close price of the second one
         cand[4].close<cand[2].close) // the third candlestick is closed below the close price of the first one
        {
         if(!forex)// if it's not forex
           {
            return CANDLE_PATTERN_UPSIDE_GAP_TWO_CROWS_BEARISH ;
           }
        }
      //------      
      // Three Star in the South, the bullish model
      if(cand[2].trend==DOWN && !cand[2].bull && !cand[3].bull && !cand[4].bull && // check direction of trend and direction of candlestick
         (cand[2].type==CAND_LONG || cand[2].type==CAND_MARIBOZU_LONG) && (cand[4].type==CAND_MARIBOZU || cand[4].type==CAND_SHORT) && // check of "long" candlestick and "maribozu"
         cand[2].bodysize>cand[3].bodysize && cand[2].low<cand[3].low && cand[4].low>cand[3].low && cand[4].high<cand[3].high)
        {
         if(forex)// if it's forex
           {
            return CANDLE_PATTERN_THREE_STAR_IN_SOUTH_BULISH;
           }
         else // other market
           {
            if(cand[2].close<cand[3].open && cand[3].close<cand[4].open) // opening inside the previous candlestick
              {
            return CANDLE_PATTERN_THREE_STAR_IN_SOUTH_BULISH;
              }
           }
        }
      // Deliberation, the bear model
      if(cand[2].trend==UPPER && cand[2].bull && cand[3].bull && cand[4].bull && // check direction of trend and direction of candlestick
         (cand[2].type==CAND_LONG || cand[2].type==CAND_MARIBOZU_LONG) && (cand[3].type==CAND_LONG || cand[3].type==CAND_MARIBOZU_LONG) && // check of "long" candlestick
         (cand[4].type==CAND_SPIN_TOP || cand[4].type==CAND_SHORT)) // the third candlestick is the spin or start
        {
         if(forex)// if it's forex
           {
            return CANDLE_PATTERN_DELIBERATION_BEARISH;
           }
         else // other market
           {
            if(cand[2].close>cand[3].open && cand[3].close<=cand[4].open) // opening inside the previous candlestick
               // check of close 2 and open 3
              {
            return CANDLE_PATTERN_DELIBERATION_BEARISH;
              }
           }
        }
      //------      
      // Three White Soldiers, the bullish model
      if(cand[2].trend==DOWN && cand[2].bull && cand[3].bull && cand[4].bull && // check direction of trend and direction of candlestick
         (cand[2].type==CAND_LONG || cand[2].type==CAND_MARIBOZU_LONG) && (cand[3].type==CAND_LONG || cand[3].type==CAND_MARIBOZU_LONG) && // check of "long" candlestick or "maribozu"
         (cand[4].type==CAND_LONG || cand[4].type==CAND_MARIBOZU_LONG)) // check of "long" candlestick and "maribozi"
        {
         if(forex)// if it's forex
           {
            return CANDLE_PATTERN_THREE_WHITE_SOLDIERS_BULISH;
           }
         else // other market
           {
            if(cand[2].close>cand[3].open && cand[3].close>cand[4].open) // opening inside the previous candlestick
              {
            return CANDLE_PATTERN_THREE_WHITE_SOLDIERS_BULISH;
              }
           }
        }
      // Three Black Crows, the bearish model
      if(cand[2].trend==UPPER && !cand[2].bull && !cand[3].bull && !cand[4].bull && // check direction of trend and direction of candlestick
         (cand[2].type==CAND_LONG || cand[2].type==CAND_MARIBOZU_LONG) && (cand[3].type==CAND_LONG || cand[3].type==CAND_MARIBOZU_LONG) && // check of "long" candlestick or "maribozu"
         (cand[4].type==CAND_LONG || cand[4].type==CAND_MARIBOZU_LONG) && // check "long" candlestick and "maribozu"
         cand[2].close<cand[3].open  &&  cand[3].close<cand[4].open) // opening inside the previous candlestick
        {
         if(!forex) // not forex
           {
            return CANDLE_PATTERN_THREE_BLACK_CROWS_BEARISH;
           }
        }
      //------      
      // Three Outside Up, the bullish model
      if(cand[2].trend==DOWN && !cand[2].bull && cand[3].trend==DOWN && cand[3].bull && cand[4].bull && // check direction of trend and direction of candlestick
         cand[3].bodysize>cand[2].bodysize && // body of the second candlestick is bigger than that of the first one
         cand[4].close>cand[3].close) // the third day is closed higher than the second one
        {
         if(forex)// if it's forex
           {
            if(cand[2].close>=cand[3].open && cand[2].open<cand[3].close) // body of the first candlestick is inside of body of the second one
              {
               return CANDLE_PATTERN_THREE_OUTSIDE_UP_BULISH;
              }
           }
         else
           {
            if(cand[2].close>cand[3].open && cand[2].open<cand[3].close) // body of the first candlestick inside of body of the second candlestick
              {
               return CANDLE_PATTERN_THREE_OUTSIDE_UP_BULISH;
              }
           }
        }
      // Three Outside Down, the bearish model
      if(cand[2].trend==UPPER && cand[2].bull && cand[3].trend==UPPER && !cand[3].bull && !cand[4].bull && // check direction of trend and direction of candlestick
         cand[3].bodysize>cand[2].bodysize && // body of the second candlestick is bigger than that of the first one
         cand[4].close<cand[3].close) // the third day is closed lower than the second one
        {
         if(forex)// if it's forex
           {
            if(cand[2].close<=cand[3].open && cand[2].open>cand[3].close) // body of the first candlestick is inside of body of the second one
              {
               return CANDLE_PATTERN_THREE_OUTSIDE_DOWN_BEARISH;
              }
           }
         else
           {
            if(cand[2].close<cand[3].open && cand[2].open>cand[3].close) // body of the first candlestick is inside of body of the second one
              {
               return CANDLE_PATTERN_THREE_OUTSIDE_DOWN_BEARISH;
              }
           }
        }
      //------      
      // Three Inside Up, the bullish model
      if(cand[2].trend==DOWN && !cand[2].bull && cand[3].bull && cand[4].bull && // check direction of trend and direction of candlestick
         (cand[2].type==CAND_LONG || cand[2].type==CAND_MARIBOZU_LONG) && // check of "long" first candle
         cand[2].bodysize>cand[3].bodysize && // body of the first candlestick is bigger than that of the second one
         cand[4].close>cand[3].close) // the third day is closed higher than the second one
        {
         if(forex)// if it's forex
           {
            if(cand[2].close<=cand[3].open && cand[2].close<=cand[3].close && cand[2].open>cand[3].close) // body of the second candlestick is inside of body of the first candlestick
              {
               return CANDLE_PATTERN_THREE_INSIDE_UP_BULISH;
      
              }
           }
         else
           {
            if(cand[2].close<cand[3].open && cand[2].close<cand[3].close && cand[2].open>cand[3].close) // body of the second candlestick is inside of body of the first one
              {
               return CANDLE_PATTERN_THREE_INSIDE_UP_BULISH;
              
              }
           }
        }
      // Three Inside Down, the bearish model
      if(cand[2].trend==UPPER && cand[2].bull && !cand[3].bull && !cand[4].bull && // check direction of trend and direction of candlestick
         (cand[2].type==CAND_LONG || cand[2].type==CAND_MARIBOZU_LONG) && // check of "long" first candle
         cand[2].bodysize>cand[3].bodysize && // body of the first candlestick is bigger than that of the second one
         cand[4].close<cand[3].close) // the third day is closed lower than the second one
        {
         if(forex)// if it's forex
           {
            if(cand[2].close>=cand[3].open && cand[2].close>=cand[3].close && cand[2].close>=cand[3].close) // inside of body of the first candlestick
              {
               return CANDLE_PATTERN_THREE_INSIDE_DOWN_BEARISH;

              }
           }
         else
           {
            if(cand[2].close>cand[3].open && cand[2].close>cand[3].close && cand[2].open<cand[3].close) // inside of body of the first candlestick
              {
               return CANDLE_PATTERN_THREE_INSIDE_DOWN_BEARISH;

              }
           }
        }
      //------      
      // Tri Star, the bullish model
      if(cand[2].trend==DOWN && // check direction of trend
         cand[2].type==CAND_DOJI && cand[3].type==CAND_DOJI && cand[4].type==CAND_DOJI) // check of Doji
        {
         if(forex)// if it's forex
           {
               return CANDLE_PATTERN_THREE_STARS_BULISH;
            
           }
         else
           {
            if(cand[3].open!=cand[2].close && cand[3].close!=cand[4].open) // the second candlestick is on the other level
              {
               return CANDLE_PATTERN_THREE_STARS_BULISH;

              }
           }
        }
      // Tri Star, the bearish model
      if(cand[2].trend==UPPER && // check direction of trend
         cand[2].type==CAND_DOJI && cand[3].type==CAND_DOJI && cand[4].type==CAND_DOJI) // check of Doji
        {
         if(forex)// if it's forex
           {
            return CANDLE_PATTERN_THREE_STARS_BEARISH;
           
           }
         else
           {
            if(cand[3].open!=cand[2].close && cand[3].close!=cand[4].open) // the second candlestick is on the other level
              {
               return CANDLE_PATTERN_THREE_STARS_BEARISH;
   
              }
           }
        }
      //------      
      // Identical Three Crows, the bearish model
      if(cand[2].trend==UPPER && !cand[2].bull && !cand[3].bull && !cand[4].bull && // check direction of trend and direction of candlestick
         (cand[2].type==CAND_LONG || cand[2].type==CAND_MARIBOZU_LONG) && (cand[3].type==CAND_LONG || cand[3].type==CAND_MARIBOZU_LONG) && // check of "long" candlestick or "maribozu"
         (cand[4].type==CAND_LONG || cand[4].type==CAND_MARIBOZU_LONG)) // check of "long" candlestick and "maribozi"
        {
         if(forex)// if it's forex
           {
            return CANDLE_PATTERN_IDENTICAL_THREE_CROWS_BEARISH;
           }
         else // other market
           {
            if(cand[2].close>=cand[3].open && cand[3].close>=cand[4].open) // open price is smaller or equal to close price of the previous candlestick
              {
               return CANDLE_PATTERN_IDENTICAL_THREE_CROWS_BEARISH;
              }
           }
        }
      //------      
      // Unique Three River Bottom, the bullish model
      if(cand[2].trend==DOWN && !cand[2].bull && !cand[3].bull && cand[4].bull && // check direction of trend and direction of candlestick
         (cand[2].type==CAND_LONG || cand[2].type==CAND_MARIBOZU_LONG) && cand[4].type==CAND_SHORT && // check of "long" candlestick or "maribozu" or the third day is short
         cand[3].open<cand[2].open && cand[3].close>cand[2].close && cand[3].low<cand[2].low && // body of the second candlestick is inside the first one, and its minimum is lower than the first one
         cand[4].close<cand[3].close) // the third candlestick is lower than the second one
        {
         if(!forex)// not forex
           {
            return CANDLE_PATTERN_UNIQUE_THREE_RIVER_BOTTOM_BULISH;
           }
        }
/* Continuation Models */
 
      //------      
      // Upside Gap Three Methods, the bullish model
      if(cand[2].trend==UPPER && cand[2].bull && cand[3].bull && !cand[4].bull && // check direction of trend and direction of candlestick
         (cand[2].type==CAND_LONG || cand[2].type==CAND_MARIBOZU_LONG) && (cand[3].type==CAND_LONG || cand[3].type==CAND_MARIBOZU_LONG) && // the first two candles are "long"
         cand[3].open>cand[2].close && // gap between the second and first candlesticks
         cand[4].open>cand[3].open && cand[4].open<cand[3].close && cand[4].close<cand[2].close) // the third candlestick is opened inside the second one and it fills the gap
        {
         if(!forex)// not forex
           {
            return CANDLE_PATTERN_UPSIDE_GAP_THREE_METHODS_CONTINUATION_BULISH;
           }
        }
      //------      
      // Downside Gap Three Methods, the bearish model
      if(cand[2].trend==DOWN && !cand[2].bull && !cand[3].bull && cand[4].bull && // check direction of trend and direction of candlestick
         (cand[2].type==CAND_LONG || cand[2].type==CAND_MARIBOZU_LONG) && (cand[3].type==CAND_LONG || cand[3].type==CAND_MARIBOZU_LONG) && // the first two candles are "long"
         cand[3].open<cand[2].close && // gap between the first and second candlesticks
         cand[4].open<cand[3].open && cand[4].open>cand[3].close && cand[4].close>cand[2].close) // the third candlestick is opened inside the second one and fills the gap
        {
         if(!forex)// not forex
           {
            return CANDLE_PATTERN_DOWNSIDE_GAP_THREE_METHODS_CONTINUATION_BEARISH;
           }
        }
      //------      
      // Upside Tasuki Gap, the bullish model
      if(cand[2].trend==UPPER && cand[2].bull && cand[3].bull && !cand[4].bull && // check direction of trend and direction of candlestick
         cand[2].type!=CAND_DOJI && cand[3].type!=CAND_DOJI && // the first two candlesticks are not Doji
         cand[3].open>cand[2].close && // gap between the second and first candlesticks
         cand[4].open>cand[3].open && cand[4].open<cand[3].close && cand[4].close<cand[3].open && cand[4].close>cand[2].close) // the third candlestick is opened inside the second one and is closed inside the gap
        {
         if(!forex)// not forex
           {
            return CANDLE_PATTERN_UPSIDE_TASUKI_GAP_CONTINUATION_BULISH;
           }
        }
      //------      
      // Downside Tasuki Gap, the Bearish model
      if(cand[2].trend==DOWN && !cand[2].bull && !cand[3].bull && cand[4].bull && // check direction of trend and direction of candlestick
         cand[2].type!=CAND_DOJI && cand[3].type!=CAND_DOJI && // the first two candlesticks are not Doji
         cand[3].open<cand[2].close && // gap between the first and second candlesticks
         cand[4].open<cand[3].open && cand[4].open>cand[3].close && cand[4].close>cand[3].open && cand[4].close<cand[2].close) // the third candlestick is opened isnside the second one, and is closed within the gap
        {
         if(!forex)// not forex
           {
            return CANDLE_PATTERN_DOWNSIDE_TASUKI_GAP_CONTINUATION_BEARISH;
           }
        }
/* Check of patterns with four candlesticks */
/* Check of patterns with four candles */

      //------      
      // Concealing Baby Swallow, the bullish model
      if(cand[1].trend==DOWN && !cand[1].bull && !cand[2].bull && !cand[3].bull && !cand[4].bull && // check direction of trend and direction of candlestick
         cand[1].type==CAND_MARIBOZU_LONG && cand[2].type==CAND_MARIBOZU_LONG && cand[3].type==CAND_SHORT && // check of "maribozu"
         cand[3].open<cand[2].close && cand[3].high>cand[2].close && // the third candlestick with a lower gap, maximum is inside the second candlestick
         cand[4].open>cand[3].high && cand[4].close<cand[3].low) // the fourth candlestick fully consumes the third one
        {
         if(!forex)// not forex
           {
            return CANDLE_PATTERN_CONCEALING_BABY_SWALLOW_BULISH ;
           }
        }
      //------      
      // Three-line strike, the bullish model
      if(cand[1].trend==UPPER && cand[1].bull && cand[2].bull && cand[3].bull && !cand[4].bull && // check direction of trend and direction of candlestick
         (cand[1].type==CAND_LONG || cand[1].type==CAND_MARIBOZU_LONG) && (cand[2].type==CAND_LONG || cand[2].type==CAND_MARIBOZU_LONG) && // check of "long" candlestick or "maribozu"
         (cand[3].type==CAND_LONG || cand[3].type==CAND_MARIBOZU_LONG) && // check "long" candlestick and "maribozu"
         cand[2].close>cand[1].close && cand[3].close>cand[2].close && cand[4].close<cand[1].open) // closing of the second candlestick is above the first one,closing of the third one is above the second one; the fourth candlestick is closed below the first one
        {
         if(forex)// if it's forex
           {
            if(cand[4].open>=cand[3].close) // the fourth candlestick is opened above or on the same level with the third one
              {
               return CANDLE_PATTERN_THREE_LINE_STRIKE_CONTINUATION_BULISH ;
              }
           }
         else // other market
           {
            if(cand[4].open>cand[3].close) // the fourth candlestick is opened above the third one
              {
               return CANDLE_PATTERN_THREE_LINE_STRIKE_CONTINUATION_BULISH ;
              }
           }
        }
      //------      
      // Three-line strike, the bearish model
      if(cand[1].trend==DOWN && !cand[1].bull && !cand[2].bull && !cand[3].bull && cand[4].bull && // check direction of trend and direction of candlestick
         (cand[1].type==CAND_LONG || cand[1].type==CAND_MARIBOZU_LONG) && (cand[2].type==CAND_LONG || cand[2].type==CAND_MARIBOZU_LONG) && // check of "long" candlestick or "maribozu"
         (cand[3].type==CAND_LONG || cand[3].type==CAND_MARIBOZU_LONG) && // check "long" candlestick and "maribozu"
         cand[2].close<cand[1].close && cand[3].close<cand[2].close && cand[4].close>cand[1].open) // closing of the second one is below the first, third is below the second, fourth is closed above the first one
        {
         if(forex)// if it's forex
           {
            if(cand[4].open<=cand[3].close) // the fourth candlestick is opened below or on the same level with the third one
              {
               return CANDLE_PATTERN_THREE_LINE_STRIKE_CONTINUATION_BEARISH ;
              }
           }
         else // other market
           {
            if(cand[4].open<cand[3].close) // the fourth candlestick is opened below the third one
              {
                return CANDLE_PATTERN_THREE_LINE_STRIKE_CONTINUATION_BEARISH ;
              }
           }
        }
/* Check of patterns with five candlesticks */
/* Check of patterns with five candles */
      //------      
      // Breakaway, the bullish model
      if(cand[0].trend==DOWN && !cand[0].bull && !cand[1].bull && !cand[3].bull && cand[4].bull && // check direction of trend and direction of candlestick
         (cand[0].type==CAND_LONG|| cand[0].type==CAND_MARIBOZU_LONG) &&  // check of "long" first candlestick
         cand[1].type==CAND_SHORT && cand[1].open<cand[0].close && // the second "candlestick" is "short" and is cut off the first one
         cand[2].type==CAND_SHORT && cand[3].type==CAND_SHORT && // the third and fourth candlesticks are "short"
         (cand[4].type==CAND_LONG || cand[4].type==CAND_MARIBOZU_LONG) && cand[4].close<cand[0].close && cand[4].close>cand[1].open) // the fifth one is "long", white and is closed inside the gap
        {
         if(!forex)// not forex
           {
            return CANDLE_PATTERN_BREAKAWAY_BULISH;
           }
        }
      // Breakaway, the bearish model
      if(cand[0].trend==UPPER && cand[0].bull && cand[1].bull && cand[3].bull && !cand[4].bull && // check direction of trend and direction of candlestick
         (cand[0].type==CAND_LONG|| cand[0].type==CAND_MARIBOZU_LONG) &&  // check of "long" first candlestick
         cand[1].type==CAND_SHORT && cand[1].open<cand[0].close && // the second "candlestick" is "short" and is cut off the first one
         cand[2].type==CAND_SHORT && cand[3].type==CAND_SHORT && // the third and fourth candlesticks are "short"
         (cand[4].type==CAND_LONG || cand[4].type==CAND_MARIBOZU_LONG) && cand[4].close>cand[0].close && cand[4].close<cand[1].open) // the fifth candlestick is "long" and is closed inside the gap
        {
         if(!forex)// not forex
           {
            return CANDLE_PATTERN_BREAKAWAY_BEARISH ;
           }
        }

      return UNKNOWN_PATTERN;
      
      
}