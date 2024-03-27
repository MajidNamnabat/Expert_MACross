//+------------------------------------------------------------------+
//|                                        EA_MACross_Parameters.mqh |
//|                                                   Majid Namnabat |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Majid Namnabat"
#property link      "https://www.mql5.com"
#property strict

#include <MD_V_LAST\\EA_MD_Types.mqh>

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
//--- input parameters
//input string      p_strSymbols_List = "EURUSD;XAUUSD;GBPUSD;USDJPY;";  //Symbols List(;) :
input string      p_strSymbols_List = "XAUUSD;";  //Symbols List(;) :
//input string      p_strSymbols_List = "XAUUSD;";  //Symbols List(;) :
input string      p_strTimeFrames_List = "15;";  //TimeFrames List(Minute)(;) :

#ifndef REAL_VPS_SECURE_PARAMETERS
input group           "Profile Parameters #1"   //Break Even Parameters #1
input string d1= "--- Profile Parameters ---";
input bool      prOptimisedProfileLoad = true;

input group           "Open Order Parameters #2"   //Break Even Parameters #1
input string d2= "--- Open Order Parameters ---";

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
input int prMVOpenOrderOptimizeSeries = -1 ;    //MV result of Open Order Optimization ( -1 , 0 - 1)
input ENUM_NORMAL_MV      prFastMVPeriod=ENUM_NORMAL_MV21;   //Fast Moving Average Period
input ENUM_NORMAL_MV      prSlowMVPeriod=ENUM_NORMAL_MV34;  //Slow Moving Average Period
input int      prMVsMinOpenDistance=27;   //Moving Averages Minimum Distance to Open Order
input int      prMVsMaxCloseDistance=5;  //Moving Averages Distance Threshold to Close Order
input ENUM_TREND_DETERMINE_METHOD  prOrderAsTrend = ENUM_TREND_GOLDENCROSS ;

input group           "Close Order Parameters #3"   //Break Even Parameters #1
input string d3= "--- Close Order Parameters ---";

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
input int prTrailingCombinationParameter = -1 ;  // Optimization Tester Trailing (-1 , 0 - 23)
input int prOptTstBrTrDisOptimizationSeries = -1 ; //BreakeEvent and Trailing Profit Distance Combination (-1 , 0 - 49 )
input EnumPatientTime prPatientTime   = CurrentCandle; // Patient According To Candle After New Order
input ENUM_CUSTOM_APPLIED_PRICE     prActiveCloseOrderCurrentCandle = CUR_PRICE_CLOSE ; //Close Order Base Current or Prev Candle & Method of Current MV
/////////////////// Break Even Parameters

input group           "Break Even Parameters #4"   //Break Even Parameters #1
input string d4= "--- Break Even Parameters ---";
input ENUM_BREAKEVEN       prActiveBreakEvenDistance                    = ENUM_BREAKEVEN_DISABLED;    // Risk Free it , 0 Inactive
input int        prBreakEvenPoint                  = 5;       // Pip Distance From Open Price In Set Break Even
input ENUM_TAKEPROFIT_METHOD p_nTakeProfitMethod = ENUM_TAKEPROFIT_DISABLED ; //Take Profit Method 
/////////////////// Trailing Stop Parameters
input group           "Trailing Stop Parameters #5"   //Trailing Stop Parameters #3
input string d5= "--- Trailing Stop Parameters ---";
input ENUM_TRAILINGSTOP_METHOD        prTrailingStopMethod              = ENUM_TRAILINGSTOP_MV ; // Trailing Stop Type  Optimization Use
input ENUM_TRAILING_STOP_ACTIVATION        prProfitToTrailingStop               = ENUM_TRAILING_STOP_FIXED_100;     // Profit In Pip to Trailing Stop
input ENUM_NORMAL_MV prTrailingParameter = 20 ;      // ATRPeriod or TrailingFixedPoint or TrailingMVPeriod
//input int prATRPeriod = 14 ; // ATR Period
//input int prTrailingStopFixedPoint = 20 ;   // Fixed Point Distance From Profit
//input int prTrailStopMVPeriod = 47;
////////////////// Less important Parameters
input group           "Not Important Parameters #6"
input string d6= "--- Not Important Parameters ---";
input ENUM_MA_METHOD   prFastMVType=MODE_EMA; //Fast Moving Average Type EMA/SMA/SMMA/LWMA
input ENUM_MA_METHOD   prSlowMVType=MODE_SMA; //Slow Moving Average Type EMA/SMA/SMMA/LWMA
input double   prBalanceRiskVolume=0.05; //Order Size (In Balance Risk Ratio)
input int      prManualTakeProfit=0;  //Manual Take Profit In Pip
input ENUM_STOPLOSS_TYPE prStopLossType = ENUM_STOPLOSS_BELOW_SLOW_MV ; //StopLoss Type
input ENUM_BRIEF_MV      prStopLossParameter=ENUM_BRIEF_MV21;  //StopLoss Parameter
input ENUM_OPENORDER_RISKANALYSIS p_nOpenOrder_RiskAnalysis = ENUM_OPENORDER_RISKANALYSIS_DLB_BASED; //Open Order Risk Analysis
input int p_nOpenOrder_RiskAnalysis_LevelUp = 90;
input int p_nOpenOrder_RiskAnalysis_LevelDown = 10;
input int p_nOpenOrder_RiskAnalysis_DLBPeriod1 = 1;
input int p_nOpenOrder_RiskAnalysis_DLBPeriod2 = 2;
input int p_nTimeLimit_StopLoss = 0 ; //Time Limit StopLoss
input ENUM_LOT_MANAGEMENT_METHOD prLotManagementMethod = ENUM_LOT_MANAGEMENT_FIXED; // Orders Lot Management Method
input ENUM_INITORDER_SET_RULES prInitOrderSetRule  = ENUM_INITORDER_SET_STOPDISTANCE_ADJUSTMENT ; //Pending Order Based Stop Distance
input bool prBigStop_FixedLot = false; //In BigStop, Fixed Lot
input int p_nTrailingStop_RSI_OverSoldLevel = 32;
input int p_nTrailingStop_RSI_OverBoughtLevel = 69 ;
input ENUM_BRIEF_MV p_nHigherTimeFrame_FastMV = ENUM_BRIEF_MV07;
input ENUM_BRIEF_MV p_nHigherTimeFrame_SlowMV = ENUM_BRIEF_MV21 ;
////////////////// StopLoss Analysis
input group           "StopLoss Analysis Parameters #7"
input string d7= "--- StopLoss Analysis Parameters ---";
input ENUM_EXITSIGNAL_NONMV_METHOD prIs_ExitSignal_NonMVMethod = ENUM_EXITSIGNAL_NONMV_METHOD_ONLY_DIVERGENCE;     //Close Order Based Non MV Cross Methods
input ENUM_STAIRTRADING_MANAGEMENT_METHOD prActiveStairTradingManagement = ENUM_STAIRTRADING_MANAGEMENT_NO_COMPENSATE; //StairTrading Management
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
input int prSignalMACDPeriod = 9; //Signal of MACD Period (Usd In MACD STairTrading)
input int prHoursRest_WhenBigLoss = 36; //StopTrading In Hours After 10% Percent Lost
input double p_fLoss_RiskBalance_Ratio_Rest = 1.75; //Loss_RiskBalance_Ratio_Rest

input ENUM_TIME_TRADE_MANAGEMENT prTimeTradeManager = ENUM_TIME_TRADE_DISABLED; //Time of Trade Management
input double p_fStdRatio = 1.5;

input int p_nMaxSlope_45_Distance = 20;
input int p_nMaxSlope_Stop_Distance = 35;

#else
const string d1= "--- Profile Parameters ---";
const bool      prOptimisedProfileLoad = true;

const string d2= "--- Open Order Parameters ---";

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
const int prMVOpenOrderOptimizeSeries = -1 ;    //MV result of Open Order Optimization ( -1 , 0 - 1)
const ENUM_NORMAL_MV      prFastMVPeriod=ENUM_NORMAL_MV21;   //Fast Moving Average Period
const ENUM_NORMAL_MV      prSlowMVPeriod=ENUM_NORMAL_MV34;  //Slow Moving Average Period
const int      prMVsMinOpenDistance=27;   //Moving Averages Minimum Distance to Open Order
const int      prMVsMaxCloseDistance=5;  //Moving Averages Distance Threshold to Close Order
const ENUM_TREND_DETERMINE_METHOD  prOrderAsTrend = ENUM_TREND_GOLDENCROSS ;

const string d3= "--- Close Order Parameters ---";

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
const int prTrailingCombinationParameter = -1 ;  // Optimization Tester Trailing (-1 , 0 - 23)
const int prOptTstBrTrDisOptimizationSeries = -1 ; //BreakeEvent and Trailing Profit Distance Combination (-1 , 0 - 49 )
const EnumPatientTime prPatientTime   = CurrentCandle; // Patient According To Candle After New Order
const ENUM_CUSTOM_APPLIED_PRICE     prActiveCloseOrderCurrentCandle = CUR_PRICE_CLOSE ; //Close Order Base Current or Prev Candle & Method of Current MV
/////////////////// Break Even Parameters

const ENUM_BREAKEVEN       prActiveBreakEvenDistance                    = ENUM_BREAKEVEN_DISABLED;    // Risk Free it , 0 Inactive
const int        prBreakEvenPoint                  = 5;       // Pip Distance From Open Price In Set Break Even
const ENUM_TAKEPROFIT_METHOD p_nTakeProfitMethod = ENUM_TAKEPROFIT_DISABLED ; //Take Profit Method 

/////////////////// Trailing Stop Parameters
const ENUM_TRAILINGSTOP_METHOD        prTrailingStopMethod              = ENUM_TRAILINGSTOP_MV ; // Trailing Stop Type  Optimization Use
const ENUM_TRAILING_STOP_ACTIVATION        prProfitToTrailingStop               = ENUM_TRAILING_STOP_FIXED_100;     // Profit In Pip to Trailing Stop
const ENUM_NORMAL_MV prTrailingParameter = 20 ;      // ATRPeriod or TrailingFixedPoint or TrailingMVPeriod
//const int prATRPeriod = 14 ; // ATR Period
//const int prTrailingStopFixedPoint = 20 ;   // Fixed Point Distance From Profit
//const int prTrailStopMVPeriod = 47;
////////////////// Less important Parameters
const ENUM_MA_METHOD   prFastMVType=MODE_EMA; //Fast Moving Average Type EMA/SMA/SMMA/LWMA
const ENUM_MA_METHOD   prSlowMVType=MODE_SMA; //Slow Moving Average Type EMA/SMA/SMMA/LWMA
const double   prBalanceRiskVolume=0.05; //Order Size (In Balance Risk Ratio)
const int      prManualTakeProfit=0;  //Manual Take Profit In Pip
const ENUM_STOPLOSS_TYPE prStopLossType = ENUM_STOPLOSS_BELOW_SLOW_MV ; //StopLoss Type
const ENUM_BRIEF_MV      prStopLossParameter=ENUM_BRIEF_MV21;  //StopLoss Parameter
const ENUM_OPENORDER_RISKANALYSIS p_nOpenOrder_RiskAnalysis = ENUM_OPENORDER_RISKANALYSIS_DLB_BASED; //Open Order Risk Analysis
const int p_nOpenOrder_RiskAnalysis_LevelUp = 90;
const int p_nOpenOrder_RiskAnalysis_LevelDown = 10;
const int p_nOpenOrder_RiskAnalysis_DLBPeriod1 = 1;
const int p_nOpenOrder_RiskAnalysis_DLBPeriod2 = 2;

const int p_nTimeLimit_StopLoss = 0 ; //Time Limit StopLoss
const ENUM_LOT_MANAGEMENT_METHOD prLotManagementMethod = ENUM_LOT_MANAGEMENT_FIXED; // Orders Lot Management Method
const ENUM_INITORDER_SET_RULES prInitOrderSetRule  = ENUM_INITORDER_SET_STOPDISTANCE_ADJUSTMENT ; //Pending Order Based Stop Distance
const bool prBigStop_FixedLot = false; //In BigStop, Fixed Lot
const int p_nTrailingStop_RSI_OverSoldLevel = 32;
const int p_nTrailingStop_RSI_OverBoughtLevel = 69 ;
const ENUM_BRIEF_MV p_nHigherTimeFrame_FastMV = ENUM_BRIEF_MV07;
const ENUM_BRIEF_MV p_nHigherTimeFrame_SlowMV = ENUM_BRIEF_MV21 ;
////////////////// StopLoss Analysis

const ENUM_EXITSIGNAL_NONMV_METHOD prIs_ExitSignal_NonMVMethod = ENUM_EXITSIGNAL_NONMV_METHOD_ONLY_DIVERGENCE;     //Close Order Based Non MV Cross Methods
const ENUM_STAIRTRADING_MANAGEMENT_METHOD prActiveStairTradingManagement = ENUM_STAIRTRADING_MANAGEMENT_NO_COMPENSATE; //StairTrading Management

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
const int prSignalMACDPeriod = 9; //Signal of MACD Period (Usd In MACD STairTrading)
const int prHoursRest_WhenBigLoss = 36; //StopTrading In Hours After 10% Percent Lost
const double p_fLoss_RiskBalance_Ratio_Rest = 1.75; //Loss_RiskBalance_Ratio_Rest

const ENUM_TIME_TRADE_MANAGEMENT prTimeTradeManager = ENUM_TIME_TRADE_DISABLED; //Time of Trade Management
const double p_fStdRatio = 1.5;

const int p_nMaxSlope_45_Distance = 20;//20;
const int p_nMaxSlope_Stop_Distance = 35;//35;

#endif
/////////////////// Profile and Change of input paramters not allowed so I create a copy of them as static variable
static ENUM_NORMAL_MV      FastMVPeriod=ENUM_NORMAL_MV21;   //Fast Moving Average Period
static ENUM_NORMAL_MV      SlowMVPeriod=ENUM_NORMAL_MV34;  //Slow Moving Average Period
static ENUM_MA_METHOD   FastMVType=MODE_SMA; //Fast Moving Average Type EMA/SMA/SMMA/LWMA
static ENUM_MA_METHOD   SlowMVType=MODE_SMA; //Slow Moving Average Type EMA/SMA/SMMA/LWMA
static int      MVsMinOpenDistance=27;   //Moving Averages Minimum Distance to Open Order
static int      MVsMaxCloseDistance=5;  //Moving Averages Distance Threshold to Close Order
static ENUM_CUSTOM_APPLIED_PRICE     ActiveCloseOrderCurrentCandle = CUR_PRICE_CLOSE ; //Close Order Base Current or Prev Candle & Method of Current MV
static ENUM_TREND_DETERMINE_METHOD  OrderAsTrend = ENUM_TREND_GOLDENCROSS ;

static ENUM_TRAILINGSTOP_METHOD        TrailingStopMethod              = ENUM_TRAILINGSTOP_MV ; // Trailing Stop Type  Optimization Use
static EnumPatientTime PatientTime   = CurrentCandle; // Patient According To Candle After New Order
static double   BalanceRiskVolume=0.05; //Order Size (In Balance Risk Ratio)
static int      ManualTakeProfit=0;  //Manual Take Profit In Pip

static ENUM_BREAKEVEN         ActiveBreakEvenDistance               = ENUM_BREAKEVEN_DISABLED;      // 0 inactive , Profit In Pip to Break Even
static int        BreakEvenPoint                  = 5;       // Pip Distance From Open Price In Set Break Even
static ENUM_TAKEPROFIT_METHOD m_nTakeProfitMethod = ENUM_TAKEPROFIT_DISABLED ; //Take Profit Method 

static ENUM_TRAILING_STOP_ACTIVATION        ProfitToTrailingStop               = ENUM_TRAILING_STOP_FIXED_100;     // Profit In Pip to Trailing Stop
static int TrailingParameter = 20 ;    // ATRPeriod or TrailingFixedPoint or TrailingMVPeriod
static ENUM_STOPLOSS_TYPE m_nStopLossType = ENUM_STOPLOSS_BELOW_SLOW_MV ; //StopLoss of Order Set and Type
static int      m_nStopLossParameter=0;  //Default Stop Loss in Pip
static ENUM_OPENORDER_RISKANALYSIS m_nOpenOrder_RiskAnalysis = ENUM_OPENORDER_RISKANALYSIS_DLB_BASED;

static int m_nTimeLimit_StopLoss = 0 ; //Time Limit StopLoss

//static int ATRPeriod = 14 ; // ATR Period
//static int TrailingStopFixedPoint = 20 ;   // Fixed Point Distance From Profit
//static int TrailStopMVPeriod = 47;
static ENUM_EXITSIGNAL_NONMV_METHOD m_nIs_ExitSignal_NonMVMethod = ENUM_EXITSIGNAL_NONMV_METHOD_ONLY_DIVERGENCE;
static ENUM_STAIRTRADING_MANAGEMENT_METHOD m_nActiveStairTradingManagement = ENUM_STAIRTRADING_MANAGEMENT_NO_COMPENSATE;
static ENUM_LOT_MANAGEMENT_METHOD m_nLotManagementMethod = ENUM_LOT_MANAGEMENT_FIXED; // Orders Lot Management Method
static int m_nSignalMACDPeriod = 9; //Signal of MACD Period (Usd In MACD STairTrading)
static int m_nHoursRest_WhenBigLoss = 36;
static ENUM_INITORDER_SET_RULES m_nInitOrderSetRule  = ENUM_INITORDER_SET_STOPDISTANCE_ADJUSTMENT ; //Pending Order Based Stop Distance
static ENUM_TIME_TRADE_MANAGEMENT m_nTimeTradeManager = ENUM_TIME_TRADE_DISABLED; //Time of Trade Management
static bool m_nBigStop_FixedLot = false;

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
static string      m_SymbolsList[];  //Symbols List(;) :
static int      m_TimeFramesList[];  //TimeFrames List(Minute)(;) :






////////////////////////////////////////////////////////////
static double m_fLoss_RiskBalance_Ratio_Rest = 1.75;
static double m_fStat_Profit_Avg = 100.0;
static double m_fStat_Profit_Std = 100.0;
static  int m_nHigherTimeFrame_FastMV = 7 ;
static  int m_nHigherTimeFrame_SlowMV = 21 ;
static  int m_nTrailingStop_RSI_OverSoldLevel = 25;
static int m_nTrailingStop_RSI_OverBoughtLevel = 75 ;
static int m_nDivergenceStaturation_RSI_OverBoughtLevel = 69;
static int m_nDivergenceStaturation_RSI_OverSoldLevel = 32;
static int m_nBreakEven_Intelligent_PipDistance_Activation = 3;
static int m_nOpenOrder_RiskAnalysis_RSIUp = 87;
static int m_nOpenOrder_RiskAnalysis_RSIDown = 18;
static int m_nOpenOrder_RiskAnalysis_DLBUp = 90;
static int m_nOpenOrder_RiskAnalysis_DLBDown = 10;

static int m_nOpenOrder_RiskAnalysis_DLBPeriod1 = 1;
static int m_nOpenOrder_RiskAnalysis_DLBPeriod2 = 2;

static double m_fStdRatio = 1.5;
static ENUM_VALIDATION_TYPE m_nIsDoneValidatoin_DuringTesting = ENUM_VALIDATION_FULL;
static int m_nMaxSlope_45_Distance = 20;
static int m_nMaxSlope_Stop_Distance = 35;
//+------------------------------------------------------------------+
