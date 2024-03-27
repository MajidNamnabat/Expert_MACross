//+------------------------------------------------------------------+
//|                                              OptimizatonTest.mqh |
//|                                                   Majid Namnabat |
//|                                                maj.nam@gmail.com |
//+------------------------------------------------------------------+
#property copyright "Majid Namnabat"
#property link      "maj.nam@gmail.com"
#include <EA_CustomOptimization.mqh>
#include <EA_MACross_Types.mqh>

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
enum ENUM_OPTIMIZATION_LEVEL
{
   ENUM_OPTIMIZATION_DISABLED = 0, 
   ENUM_OPTIMIZATION_OPENORDER_1 = 1,
   ENUM_OPTIMIZATION_OPENORDER_OPENDISTANCE_DET ,
   ENUM_OPTIMIZATION_OPENORDER_OPENDISTANCE_FASTMETHOD_DET ,
   ENUM_OPTIMIZATION_OPENORDER_PENDINGORSPOT ,
   ENUM_OPTIMIZATION_CLOSEORDER_1 ,
   ENUM_OPTIMIZATION_DETAILS_1 
};
const ENUM_OPTIMIZATION_LEVEL m_nOptimizationLevel = ENUM_OPTIMIZATION_CLOSEORDER_1;
struct stctTrailingCombination   
   {
      ENUM_TRAILINGSTOP_METHOD Type;
      int                  nParamVal;
   };
struct stctOptTstMVCombination
   {
      ENUM_NORMAL_MV FastPeriod ;
      ENUM_NORMAL_MV SlowPeriod ;
      ENUM_MA_METHOD FastMethod;
      ENUM_MA_METHOD SlowMethod;
      int MinOpenDistance;
      int SuitableCloseDistance;
      EnumCustom_Applied_Price AppliedPrice;
   };
struct stctOptTstBrTrDisCombination
   {
      int BreakeEvenDis ;
      int TrailingDis ;
   };
struct stctMVPeriodCombination
   {
      ENUM_NORMAL_MV FastMBVPeriod ;
      ENUM_NORMAL_MV SlowMVPeriod ;
   };
const int trailParamsArray_Size = 18;
stctTrailingCombination trailParams[] = {{ENUM_TRAILINGSTOP_MV,3},{ENUM_TRAILINGSTOP_MV,5},
                                            {ENUM_TRAILINGSTOP_MV,7},{ENUM_TRAILINGSTOP_MV,9},
                                            {ENUM_TRAILINGSTOP_MV,21},{ENUM_TRAILINGSTOP_MV,34},

                                            {ENUM_TRAILINGSTOP_ATR15,7},/*{ATR15,12},*/{ENUM_TRAILINGSTOP_ATR15,13},{ENUM_TRAILINGSTOP_ATR15,21},{ENUM_TRAILINGSTOP_ATR15,26},{ENUM_TRAILINGSTOP_ATR15,30},
                                            /*{ATR20,7},{ATR20,12},*/{ENUM_TRAILINGSTOP_ATR20,13},{ENUM_TRAILINGSTOP_ATR20,21},{ENUM_TRAILINGSTOP_ATR20,26},
                                            {ENUM_TRAILINGSTOP_ATR20,30},{ENUM_TRAILINGSTOP_FIXEDPOINT,15},{ENUM_TRAILINGSTOP_FIXEDPOINT,20},
                                            {ENUM_TRAILINGSTOP_FIXEDPOINT,25}};
//const int    optMvs_Size = 11; 
/*
1 : 13,30
2 : 21,30
3 : 13,34
4 : 21,34 ?
5 : 26,34 ?

6 : 13,50 ?

5 : 21,34
6 : 26,34
9 : 21,50
10 : 26,50

*/
stctOptTstMVCombination optMvs[] = {{ENUM_NORMAL_MV21,ENUM_NORMAL_MV50,MODE_EMA,MODE_SMA,180,80,PREVIOUS_CANDLE},
                                    {ENUM_NORMAL_MV13,ENUM_NORMAL_MV30,MODE_EMA,MODE_SMA,180,80,PREVIOUS_CANDLE},
                                    {ENUM_NORMAL_MV09,ENUM_NORMAL_MV50,MODE_LWMA,MODE_SMA,340,80,PREVIOUS_CANDLE},}; //2
                                        
const int optBrTrDis_Size = 33;
stctOptTstBrTrDisCombination optBrTrDis[] ;
//const int  optMVPeriods_Size = 31;
stctMVPeriodCombination optMVPeriods[];
/////////////////////////////////////////////////////////////////
TCustomCriterionArray   *criterion_Ptr;
   const int MIN_TRADES_COUNT = 50 ;
   const double MIN_PROFIT_FACTOR = 1.05;
   const double MIN_KELLY_FACTOR  = 0.03;
   const int MIN_NET_PROFIT = 20;   // 15 MinTrade & 50000 Balance

//+------------------------------------------------------------------+
//| LoadArray function                                             |
//+------------------------------------------------------------------+
void LoadArrays() {
   int nBreakeEvenDis[] = {0,30,50,70, 90 , 110, 130};
   int nTrailingStopDis[] = { 60 ,  80  ,  100 , 120 ,  140 , 160 , 180 , 200 , 220 , 240};
   //int commonMVPeriods[12] = {8,9,10,12,13,20,21,26,30,34,50,55};
   //int commonMVPeriods[] = {9,12,21,26,30,34,50,55}; //simple & fast
   int commonMVPeriods[] = {9,12,13,21,26,30,34,50}; //simple & fast
   int commonMVPeriods_Fast[] = {9,13,21,26,30,34}; //simple & fast
   int commonMVPeriods_Slow[] = {21,26,30,34,50}; //simple & fast
   int nCounter = 0;
   int n1,n2;
   //first count
   ArrayResize(optBrTrDis,36,0);
   for ( n1 = 0 ; n1 < 6 ; n1++) {
      for ( n2 = 0 ; n2 < 6 ; n2++) {
         if(nBreakeEvenDis[n1] >= nTrailingStopDis[n2])
            continue;
         optBrTrDis[nCounter].BreakeEvenDis = nBreakeEvenDis[n1] ;
         optBrTrDis[nCounter].TrailingDis= nTrailingStopDis[n2] ;
         nCounter++;
         
      }
   }
    ArrayResize(optBrTrDis,nCounter,0);
   Print ("LoadArrays optBrTrDis Size : ", ArraySize(optBrTrDis)," nCounter = " , nCounter);
   
   nCounter = 0; 
   /*
   ArrayResize(optMVPeriods,ArraySize(commonMVPeriods)*ArraySize(commonMVPeriods),0);
   for ( n1 = 2 ; n1 < ArraySize(commonMVPeriods) ; n1++) {
      for ( n2 = 0 ; n2 < ArraySize(commonMVPeriods) ; n2++) {
         if((commonMVPeriods[n2] >= commonMVPeriods[n1] - 5)  )
            continue;
         optMVPeriods[nCounter].SlowMVPeriod= commonMVPeriods[n1] ;
         optMVPeriods[nCounter].FastMBVPeriod = commonMVPeriods[n2] ;
         nCounter++;
      }
   }
   */
      ArrayResize(optMVPeriods,ArraySize(commonMVPeriods_Fast)*ArraySize(commonMVPeriods_Slow),0);
   for ( n1 = 2 ; n1 < ArraySize(commonMVPeriods_Slow) ; n1++) {
      for ( n2 = 0 ; n2 < ArraySize(commonMVPeriods_Fast) ; n2++) {
         if((commonMVPeriods_Fast[n2] >= commonMVPeriods_Slow[n1] - 5)  )
            continue;
         optMVPeriods[nCounter].SlowMVPeriod= (ENUM_NORMAL_MV)commonMVPeriods_Slow[n1] ;
         optMVPeriods[nCounter].FastMBVPeriod = (ENUM_NORMAL_MV)commonMVPeriods_Fast[n2] ;
         nCounter++;
      }
   }

   ArrayResize(optMVPeriods,nCounter,0);
   Print ("LoadArrays optMVPeriods Size : ", ArraySize(optMVPeriods)," nCounter = " , nCounter);
   

}
