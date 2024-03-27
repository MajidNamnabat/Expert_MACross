//+------------------------------------------------------------------+
//|                                             EA_MACross_Types.mqh |
//|                                                   Majid Namnabat |
//|                                                maj.nam@gmail.com |
//+------------------------------------------------------------------+
#property copyright "Majid Namnabat"
#property link      "maj.nam@gmail.com"
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
/*
// V3 Add Breake Even and Trailing Stop : Result : BreakEven not seems good but Trailing is good
// V4 Change Money Management Algorithm
// V5 : Suggest1 : implement Golden Cross Or Death Cross to determine Trend and Order Only in Trend : Result : implement 
//      Suggest2 : implement MV Slow in Higher Time to Determine Trend and Order Only in Trend
//      Suggest3 : Filter Tightly Get Order to decrease it and  , TestBench in 15M eurusd is Lost and Net < 1
//V6  
         Suggest1 : Lot Increase to 0.05 also  weight it if in Golden Cross , 
         Suggest 2 : Also as Trend High Time also Find        : Done
         Suggest 3 : https://www.mql5.com/en/articles/286
                     This link can be used to Criteria on Trades Count and ...
                     https://www.mql5.com/en/docs/optimization_frames/parametergetrange
                     This link sample working with Result View 
//V7     Suggest 1 : Time enter , etc. when order open at least two candle or one candle wait       , it is important and principle یک اصل ثابت شده               
         Suggest 2 : Program Optimization Done on EURUSD , one profile for this symbol is defined , then manaully check order open and close (viewing)            
//       Suggest 3 : https://www.mql5.com/en/articles/1498 , Use This link to write Optimization result in file
         For Suggest 1 : You can use : https://stackoverflow.com/questions/46436041/a-datetime-arithmetic-in-mql4
         Suggest 4 : Also u can test Optima-F and compare Kelly ,       
         This link is https://www.mql5.com/en/forum/138048 good

//V8     Suggest 1 : Read Paper about StopLoss with ATR  : Done
         Suggest 2 : https://www.mql5.com/en/articles/1347
         Use this hint to Generate Selected Parameter File and Then Use it to Optimization and Test
         Suggest 3 : Monitoring , Not Good , StopLoss Must set , if Goto Under Slow, or Under Fast , or Under Golden,
V9
         S1 : try Optimize BreakEven and Trailing to increase Profit , I thought This system is closed and Money Management is good work, 
               // If profit decrease not need BreakeEven and Trailing
               R1 : In Result 430pip profit is good point to BreakeEven, Profit Decrease limited and Factor Increase, Why ?
               I think Advanced Money Management Algorithm is need, etc. in 470pip , 50% save and continue half , Peleie amal kardan 
               R2 : BreakeEven 70 80pip , param increase to .59 , profit dec 8000$ , instersting
               R3 : guess , Trailing is good only in Hayajan wave
               R4 : Trailing only Above 410,420 , By deactive BreakeEven may be profitable , 10900$ , .40
               
               R5 : Monitoring Close Order System is very bad, MVes is High Period, Very Very Slow Reaction,
               R6 : ببین من مانیتور کردم بهترین این است پریودهای بالا انتخاب کرده است اصلا خیلی وقت ها اشتباه تشخیص می دهد می گیرد. بستن ها بعضی وقتها بسیار بد است
               امتیاز خوب است یکی دو تا خیلی بزرگ می گیرد و آن بالا می برد.
               بنظرمن واقعا هنوز ضعیف است و اصلا بریک اون و تریلینگ اینجا نمی تواند کاربرد داشته باشد.
               ببین شروع وقتی انجام می شود که تقاطع انجام شود و فاصله ای زیاد شود. الان پریودها زیاد است. وقتی با تریلینگ یا بریک می بندد عموما زود می بندد
               بعد دیگر نمی تواند باز کند تا دوباره تقاطع اتفاق بیفتد
               
               واقعیت این است که میزان سود بنظر من اصلا ذره ای مهم نیست. واقعا می گویم. چون یکهو شانسی یکی خیلی بزرگ می شود بقیه الکی بی معنی
               سیستم باید معنی دار منطقی سعی کند کار کند . من که اینطور فکر می کنم.
               
               
                
         S2 : try Optimize HigherPeriod Trend Detection Algo. Fast Become EMA , and Period 9 is good , also H1 next H4 : Done
         S3 : try Clean , Class and Entity Object Oriented , and Multi File Program,
         S4 : try Test & Optimize in Other Symbols and Other TimeFrams
         S5 : try Live and begin to Live Test
         S6 : Work More on MM algorithm , Pelei Save Sood, Statistic of Orders, Max and Average of Expected Profit ? 
              What is really Expected Payoff
              Totally I think this system is trend-based , so good in open order. but in close order is weak.
         S7 : Track Distance of MVs, when become less than a threshold from Maximum , Trailing Close Order    , Not Trailing , MVMinClose Become This. not recommend.
         S8 : Ardalan use some simple candle patterns, also Get Profit. interesting !!
         S9 : first of all only work on 3 , 9 Periods , as ardalan, Try to optimize it . One Indicator Download only detect Current Trend, Work in Trend Direction
         Some time is work normal speed , it is work good, but in greedy waves work badly.
         Also ATR , or some other indicator determine greedy or normal or fear trend
         
         S10 : MT5 has many options , CandleStick Patterns can detect , Object Oriented , Trailing Stop with Parabolic Sar , Smart Money Management
         More Complicated , I don't know is it 
         ارزش برای بیشتر وقت گذاشتن یا نه
         خودم واقعا اینطور هست که راضی نیستم.
         باید جدی نگیرم این تشویق ها و ....
         زمان زیادی خواهد برد و کار زیادی هم میخواهد
         S11 : https://www.mql5.com/en/blogs/post/729722
         This link provide crossover mv with many options , triple mv , macd , rsi filter
V10 :
         S12 :
            https://www.mql5.com/en/articles/2279
            NEURAL NETWORK: SELF-OPTIMIZING EXPERT ADVISOR PRONBLEMS ALGOLIB USED is MQL5 , first project must moved to MQL5
            آموزش ساخت شبکه های عصبی خود بهینه گر 
         S13 : Now I want to Logical Buy Order , Low Trade , But Logical , I investigate worth and best , MV logical 12 , 24  , Time  H1 , also investigate Candle Patterns , RSI and MACD, 
         S14 : Track MVs , can open order after distance decrease and next increase , not only one after each cross.
         P15 : Higher Trend , Problem SomeTime Cause, Very Late and In the finish of Cross New Order Open :
               : Time of Cross Save then if Threshold is gozasht not get. 
               : In Time Bala Yeknavaxt hast ,  Or then MV become near Distance of Max become less , not get or combination of all
         
         S16 : if RSI > 70 and Candle Bearish Close Trade , Good , but SomeTimes Close Very Near , Also sometimes TreeCandle so RSI is decrease not above 70
         Status :
            now very soon trade closed , become short trades , because of candles , but amalkard close is smarter , near to top than previous.
            S16 is wrong , when RSI was above 70 , bearish candle not work , ..... 
            CandleStick need confirmation also ???
            
            Now Remind : Think about characterictics , Trend shib , start price from CrossOver until Close or Open.
                         RSI Divergence or MACD Divergence is also important
                         Modiriyat Position besorate Pelei now
            
                         I must investigate positions close and new until underestand 
                         
                         Also P15 must change I think , count bar is not good , if Distance Above Min , and Trend not , Lock until Next Cross
                         
پله ای ترید منطقی.
تحقیق درباره تشخیص هیجان، شیب، همه چیز احتمالاتی هست. یک سیستم هوشمند اداپتیو احتمال بیرون دادن داشتن.
ببین نوسان ذات بازار است می توان استفاده کرد
مثلا trailing در rsi پایین بنظرم جواب نمیدهد.
کاراکتریستیک هم مهم است، شیب، و... 
واگرایی macd معتبرتر است همین احتمالاتی هست. باید وارد کنی واگرایی را.  
به سمت کلاسیفیکیشن و هوشمند سیستم استفاده حرکت، کم کم بنظرم سیستم دارد بسته میشود، نمی خواهم شلوغ کنم. اما انالیز بررسی لازم است.
حد ضررها بنظرم مشکل دارند. شاید باید مفهوم تثبیت نفوذ را پیاده سازی نمایی. 
کندل استیک انها که تایید نیاز دارند مشخص شدن، یک سیستم هوشمند احتمالاتی نیاز دارم، همان شبکه های عصبی هم باشند خوب است.
واگرایی هر واگرایی عمل نخواهد کرد. 
 با استفاده ایچیموکو مخالفم، چون نمی فهممش، با ریز آن آشنا نیستم
          
Global Suggest
//      1.Close Order Base of Current not Previous : Done
//      2.Intelligence of Determine Paramter Increase, Adaptable according to TimeFrame
//      3. Characteristic of each wave is special, Clustering it. Not use only one condition, Use multiple batch of conditions to determine Clusters,
//         Also Decition Tree and Clustering Can be used to Determine Conditions.
//      4. Candle Form and Pattern Also Can be Determined , but in reverse not in Trend Contious, May be in Reversal and Save Profit can be used
// V6 : Serious Change 
//        Before This Current Candle and Prev ?! Used , Now Changed to Prev and Prev Prev  

//V12 & V13 After RoboForex
Suggest : May Be Stop Increase With MV Slow , May Be Good
Suggest : Trailing Become Active accoring to R:R is good
من می خواهم از بازار سودم را بکنم و بروم
دیگر کاری ندارم

Suggest1 :
   When SL has high dis from opentime , 1 - position is risky so rational to patient to become suitable position
                                        2 - The Distance from MV is high it is rational to comeback to it
   So in this saturation it is rational to Buy Limit or Sell Limit near to SL gozashte shavad

Suggest2 : You can set TP of Order in R:R 2.5 or 2 or 3 : No Profit Must Roshd
            Or Move StopLoss to R:R ratios : Not Bad If Stop is important

Suggest3 : Standard MoneyManagement is Risk 2.5% of all sarmaye in each trade maximum , now is 5% , it is wrong really.
         Result : Cause Really Percent DrawDown Decrease , Percent DrawDown above 25 or 20% is not meaning

Suggest4 : TotalTrade so Profit is Low , Extend to Four or Six Main Arz , This is Computer , opposite human can work night 24H ,
           Can process high, Use it.
            Rational
Suggest5:
https://www.mql5.com/en/articles/3856
RANDOM DECISION FOREST IN REINFORCEMENT LEARNING
it is in MQL5
///// Search About Suggest 4 , First:
Alain Verleyen 2013.01.09 21:23 #14      EN
Hello everybody,

Everything depends on the algorithm used in trading. If using ticks or is working on new bars.

It seems quite possible to have an EA addressing multiple pairs provided is based on the new bars. Just use the iOpen, iClose, etc ... However I found that for this to work we need pairs used with these functions must appear in the Market Watch window. Also, it is best to place the EA on EURUSD, pair that is generating the most ticks.

For EA multipairs taking decisons opening position from ticks then MT4 can not handle it (since that does not receive the ticks of a pair). Against by MT5 can manage this, because there is a technique to receive ticks from several pairs by an EA placed on a single chart (https://www.mql5.com/en/articles/159).
//////////// Second


AI Suggest5 : First Classify Chart Characteristic , then AI model using , it is important .
             Second AI Model For Each Open Trade Say Open It Or Not Open It . Use Not For Each Candle Or Divergence .... 
Suggest6 :
   In Consecutive Wins , RiskRatio Increase with a weight .
   Based on Advise , Increase Lot In Profitable Trades
   : No 
Suggest7 :
الگوریتم : اگر محافظه کار شدیم، یر به یر فعال می شود، اگر جسور شدیم، یر به یر غیرفعال میشود، به ترتیب در سطوح یر به یر و ... همینطور گذاشته می شود.
BreakEven , 
Also Insert MoneyManagement RR Ratio , Based 
Must Implement

Suggest8 :
   Stop loss is based on closed candle in the daily chart.
 Stop Based Close , علی صافی تاجبخش زیاد دیدم
 XAUUSD Specially
 Must Implement
 
    
*/          
enum MMMode{ Fixed, Percentage };



enum ENUM_WAVE_TREND
   {
      ENUM_TREND_BULLISH = 1,
      ENUM_TREND_BEARISH = 2 , 
      ENUM_TREND_NEURAL = 3 ,
      ENUM_TREND_UNKNOWN = 4
   };

enum ENUM_TRAILINGSTOP_METHOD
   {
   ENUM_TRAILINGSTOP_ATR15 = 1 ,
   ENUM_TRAILINGSTOP_ATR20 = 2 ,
   ENUM_TRAILINGSTOP_ATR = 3,
   ENUM_TRAILINGSTOP_PARABOLIC_SAR = 4,
   ENUM_TRAILINGSTOP_MV = 5,
   ENUM_TRAILINGSTOP_FIXEDPOINT = 6,
   };
//Experience : In Time 15 , Long MV answer , so Golden not don done and lately Done , So Locked and Prohibit Orders , So Trade Count Very Very Low   
enum ENUM_TREND_DETERMINE_METHOD
   {
   ENUM_TREND_DETERMINE_NONE = 0,
   ENUM_TREND_GOLDENCROSS = 1,         
   ENUM_TREND_HIGHER_TIMEFRAME = 2 ,
   ENUM_TREND_GOLDENCROSS_HIGHER = 3 ,
   ENUM_TREND_WEEKLY_CANDLE = 4

   };
enum EnumPatientTime
   {
      HuryUp = 0 ,
      CurrentCandle = 1 ,
      OneCandleInMiddle = 2 ,
      TwoCandleInMiddle = 3 ,
      ThreeCandleInMiddle = 4
   };
enum ENUM_CUSTOM_APPLIED_PRICE
   {
      PREVIOUS_CANDLE = 0,
      CUR_PRICE_MEDIAN = 2 ,
      CUR_PRICE_CLOSE = 1 ,
   };
enum ENUM_STOPLOSS_TYPE
   {
      ENUM_STOPLOSS_NONE = 0 ,
      ENUM_STOPLOSS_BELOW_SLOW_MV = 1,
      ENUM_STOPLOSS_BELOW_SLOW_MV_UPDATEBLE = 2,
      ENUM_STOPLOSS_BELOW_CUSTOM_MV = 3,
      ENUM_STOPLOSS_BELOW_CUSTOM_MV_CLOSE_BASED = 4,
      ENUM_STOPLOSS_BELOW_CUSTOM_MV_UPDATEBLE = 5,
      ENUM_STOPLOSS_BELOW_CUSTOM_MV_UPDATEBLE_CLOSE_BASED = 6,
      ENUM_STOPLOSS_FIXED_POINT = 7
   };
enum ENUM_STAIRTRADING_MANAGEMENT_METHOD
   {
      ENUM_STAIRTRADING_MANAGEMENT_NONE,
      ENUM_STAIRTRADING_MANAGEMENT_NO_COMPENSATE,
      ENUM_STAIRTRADING_MANAGEMENT_SIMPLE_COMPENSATE,
      ENUM_STAIRTRADING_MANAGEMENT_STC_COMPENSATE,
      ENUM_STAIRTRADING_MANAGEMENT_MACD_SIGNAL_COMPENSATE
   
   };
enum ENUM_LOT_MANAGEMENT_METHOD
   {
      ENUM_LOT_MANAGEMENT_FIXED ,
      ENUM_LOT_MANAGEMENT_SL_BELOW_SMV
   };   
enum ENUM_EXITSIGNAL_NONMV_METHOD
   {
     ENUM_EXITSIGNAL_NONMV_METHOD_DISABLE,
     ENUM_EXITSIGNAL_NONMV_METHOD_CANDLESTICK_AND_DIVERGENCE,
     ENUM_EXITSIGNAL_NONMV_METHOD_ONLY_DIVERGENCE,
     ENUM_EXITSIGNAL_NONMV_METHOD_SIGNAL,
     ENUM_EXITSIGNAL_NONMV_METHOD_DIVERGENCE_SATURATION
   };
   
enum ENUM_BREAKEVEN
   {
      ENUM_BREAKEVEN_DISABLED = 0 ,
      ENUM_BREAKEVEN_INTELLIGENT = -1 ,
      ENUM_BREAKEVEN_FIXED_N2 = -2 ,
      ENUM_BREAKEVEN_FIXED_20 = 20 ,
      ENUM_BREAKEVEN_FIXED_35 = 35 ,

      ENUM_BREAKEVEN_FIXED_25 = 25 ,

      ENUM_BREAKEVEN_FIXED_30 = 30 ,
      ENUM_BREAKEVEN_FIXED_40 = 40 ,
      ENUM_BREAKEVEN_FIXED_50 = 50 ,
      ENUM_BREAKEVEN_FIXED_N4 = -4 ,
   }; 
enum ENUM_TAKEPROFIT_METHOD
   {
      ENUM_TAKEPROFIT_DISABLED = 0,
      ENUM_TAKEPROFIT_MM_R_HR = -10,
      ENUM_TAKEPROFIT_MM_R_R  = -2 ,
      ENUM_TAKEPROFIT_R_R_50 = -14 ,
      ENUM_TAKEPROFIT_R_R_100 = -6 ,
      ENUM_TAKEPROFIT_R_R_200 = -13 ,
      ENUM_TAKEPROFIT_STATISTICS = -5 ,      

      ENUM_TAKEPROFIT_R_R_25 = -9 ,
      ENUM_TAKEPROFIT_FIXED_100 = 100 ,
      ENUM_TAKEPROFIT_FIXED_150 = 150
   };
enum ENUM_TRAILING_STOP_ACTIVATION
   {
      ENUM_TRAILING_STOP_DISABLED = 0 , 
      ENUM_TRAILING_STOP_RSI_SATURATION = -1,
      ENUM_TRAILING_STOP_SAR_METHOD = -2,
      ENUM_TRAILING_STOP_FIXED_75 = 75 ,
      ENUM_TRAILING_STOP_FIXED_100 = 100 ,
      ENUM_TRAILING_STOP_FIXED_150 = 150 ,
      ENUM_TRAILING_STOP_FIXED_200 = 200 ,
      ENUM_TRAILING_STOP_FIXED_250 = 250 
      
   };
enum ENUM_INITORDER_SET_RULES
   {
      ENUM_INITORDER_SET_ALLSPOT,
      ENUM_INITORDER_SET_ALLPENDING,
      ENUM_INITORDER_SET_STOPDISTANCE_ADJUSTMENT,
      ENUM_INITORDER_SET_HFTREND_ADJUSTMENT
   };
enum ENUM_NORMAL_MV
   {
      ENUM_NORMAL_MV09 = 9,
      ENUM_NORMAL_MV12 = 12,
      ENUM_NORMAL_MV13 = 13,
      ENUM_NORMAL_MV20 = 20,
      ENUM_NORMAL_MV21 = 21,
      ENUM_NORMAL_MV26 = 26,
      ENUM_NORMAL_MV30 = 30,
      ENUM_NORMAL_MV34 = 34,
      ENUM_NORMAL_MV50 = 50,
   };
enum ENUM_BRIEF_MV
   {
      ENUM_BRIEF_MV07 = 7,
      ENUM_BRIEF_MV09 = 9,
      ENUM_BRIEF_MV13 = 13,
     ENUM_BRIEF_MV21 = 21,
      ENUM_BRIEF_MV26 = 26,
      ENUM_BRIEF_MV30 = 30,
      ENUM_BRIEF_MV34 = 34,
      ENUM_BRIEF_MV50 = 50,
   };

enum ENUM_TIME_TRADE_MANAGEMENT
   {
      ENUM_TIME_TRADE_DISABLED = 0 ,
      ENUM_TIME_TRADE_FRIDAY_ALL_NOT_OPEN = 1 ,
      ENUM_TIME_TRADE_FRIDAY_AFTERNOON_NOT_OPEN = 2 ,
      ENUM_TIME_TRADE_HOLIDAY_OFFSET = 4 ,
      ENUM_TIME_TRADE_HOLIDAY_OFFSET_FRIDAY_NOT_OPEN = 5 ,
      ENUM_TIME_TRADE_HOLIDAY_OFFSET_FRIDAY_AFTERNOON_NOT_OPEN = 6 ,
   };
enum ENUM_ORDERS_INVESTIGATE_STATE
{
   ENUM_ORDERS_INVESTIGATE_ALL,
   ENUM_ORDERS_INVESTIGATE_SYMBOL_ONLY
};

enum ENUM_OPENORDER_RISKANALYSIS
{
   ENUM_OPENORDER_RISKANALYSIS_DISABLE,
   ENUM_OPENORDER_RISKANALYSIS_RSI_BASED,
   ENUM_OPENORDER_RISKANALYSIS_DLB_BASED,
   ENUM_OPENORDER_RISKANALYSIS_DIVERGENCE_BASED,
};
enum ENUM_RISK_DEGREE
{
   ENUM_RISK_VERY_HIGH,
   ENUM_RISK_HIGH,
   ENUM_RISK_NORMAL,
   ENUM_RISK_LOW,
   ENUM_RISK_VERY_LOW,
};
enum ENUM_VALIDATION_TYPE
{
   ENUM_VALIDATION_DISABLE,
   ENUM_VALIDATION_FULL,
   ENUM_VALIDATION_STATISTICS_ONLY
};
// This defines the magic number for this EA. A magic number can be 
// assigned to an order, so that orders opened by this EA have this magic 
// number. This is how we distinguish between orders opened by this EA, 
// and those opened by the user or other EAs.
// Ref: http://articles.mql4.com/145
const ulong MACROSS_MAGIC_NUM = 20210302;
const int SYMBOL_CALC_MODE_FOREX = 0;  // Defined in MQL5 not in MQL4
const bool IS_DRAW_TEXT = false ;
const bool IS_DRAW_DIVERGENCE = false;
const bool IS_DRAW_ARROW_CANDLE = false;
const int FIXEDPOINT_BELOW_CLOSEBASED_SL = 25;
//--- during optimization



/*
// Experience Optimization EA
// MA_SMMA Smoothed Method Not Used for SlowMV Type 100% Proved
// StopLossType Parameter Set To SlowMA , deactivate it , increase profit but increase GrossLoss and DD significantly.
// MA_SMA for Fast MV : not answered
// MA_LWMA also answered for Fast, it's similar to EMA, More Profit and Param Than EMA
// Step2 : Optimize OpenDistance 1 Step ,
// Negative Param : f : MODE_LWMA s :MODE_EMA remove it.
// Open Distance : 30,55,LWMA,SMA Start from 28 , 29 more stable in best result, 
// Close Distance : 18 best 
// 34,55,LWMA,SMA : OpenDis 26 ,27, 28 best , Close Distance : 14 best more stable in best result
// 26,55,EMA,SMA Open : 29,30,31b best , CloseDis  10 best , Step3 : 11b
// Finish : insert best values to array MV
// Step3 Close and Current Or Prev Candle : 
   Prev Candle :  
   PatientTime OneCandleInMiddle or CurrentCandle is not profitable , I select OneCandleInMiddle premanantly
   
   30,55,LWMA,SMA , DisClose 19b,16 best in Prev, but 

   CURMEDIAN and TYPICAL  in 11,12b , param is better , ( I think MEDIAN and TYPICAL is same , MEDIAN is more show , so only MEDIAN is engough to test)
   34,55,LWMA,SMA : MEDIAN is select , DisClose 11b,12
   Step 4 : Finish insert best values to array MV , Test Order As Trend with this MV and all MVs,
   Not Good , GoldenCross and HigherHighFrame not good
   
*/
/*
 // Experience , 
   تجربه باز کردن دستور ساده است فهمیدن روند ساده است
   اما بستن آن و مدیریت کردن آن بسیار سخت و دشوار است
   با سود بستن آن منظورم هست
   
*/ 

/* 
آمدم کندل استیک و ار اس ای تایم پایین را افزودم
این افزودن کارایی مثبت در تایم پانزده دقیقه سبب شد
اما در تایم یک ساعته اثر منفی گذاشت
واقعیت این است که شخصیت هر تایم دارد
پانزده دقیقه نوسان زیاد دارد تایم 5 دقیقه واقعا روی آن تاثیر دارد
اما پانزده دقیقه واگرایی برای تایم یک ساعته باعث کوتاه شدن سودها و تشخیص اشتباه می شود.

*/
