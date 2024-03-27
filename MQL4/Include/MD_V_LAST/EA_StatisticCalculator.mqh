//+------------------------------------------------------------------+
//|                                          StatisticCalculator.mqh |
//|                                                  Majid Namanabat |
//|                                                maj.nam@gmail.com |
//+------------------------------------------------------------------+
#property copyright "Majid Namanabat"
#property link      "maj.nam@gmail.com"
#property version   "1.00"
#property strict
class CStatisticCalculator
  {
private:
   double            m_fSumPow;
   void              UpdateMean(double fInsertedVal);
   void              UpdateStd(double fInsertedVal);

public:
   double            m_fMean;
   double            m_fSum;
   double            m_fStd;
   double            m_fVar;
   int               m_nCount;
                     CStatisticCalculator();
                    ~CStatisticCalculator();

   void              Update(double fInsertedVal);
   void              Reset();
   void              UpdateBatch(int& nValueList[]);
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
CStatisticCalculator::CStatisticCalculator()
  {
   Reset();
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CStatisticCalculator::Reset()
  {
   m_fMean = 0.f;
   m_fStd = 0.f;
   m_fVar = 0.f;
   m_nCount = 0;
   m_fSumPow = 0;
   m_fSum = 0;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
CStatisticCalculator::~CStatisticCalculator()
  {
  }
//+------------------------------------------------------------------+
void CStatisticCalculator::UpdateMean(double fInsertedVal)
  {
   m_fSum +=fInsertedVal;
   m_fMean = (m_fSum)/(m_nCount+1);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CStatisticCalculator::UpdateStd(double fInsertedVal)
  {
// 1 , 2 , 2.5 , 3
//Mean+-1Std : 2*34.1, 1Std-2Std : 2*13.6 , 2-2.5Std : 2.1% , 3Std:%99.7 of Datas
//m_fMean Must Update First
   m_fSumPow += (fInsertedVal-m_fMean)*(fInsertedVal-m_fMean);
   if(m_nCount>0)
     {
      m_fVar = m_fSumPow / m_nCount;  //nCount - 1
      m_fStd = MathSqrt(m_fVar);
     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CStatisticCalculator::Update(double fInsertedVal)
  {
   UpdateMean(fInsertedVal);
   UpdateStd(fInsertedVal);
   m_nCount++;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CStatisticCalculator::UpdateBatch(int& nValueList[])
  {
   for(int n=0;n<ArraySize(nValueList);n++)
   {
      //Print("UpdateBatch " , n , "  " ,nValueList[n]);
      m_fSum += (double) nValueList[n];
   }
      m_fMean = (m_fSum)/(m_nCount + ArraySize(nValueList));
   for(int n=0;n<ArraySize(nValueList);n++)
   {
      m_fSumPow += ((double) nValueList[n]-m_fMean)*((double) nValueList[n]-m_fMean);
   }
   if((m_nCount+ArraySize(nValueList)-1)>0)
     {
      m_fVar = m_fSumPow / (m_nCount+ArraySize(nValueList)-1);  //nCount - 1
      m_fStd = MathSqrt(m_fVar);
     }
    m_nCount+=ArraySize(nValueList);
  }
//+------------------------------------------------------------------+
