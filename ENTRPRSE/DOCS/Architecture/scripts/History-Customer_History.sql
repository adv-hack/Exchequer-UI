-- History, Customer
SELECT CHAR([hiExCLass]) AS Class
      ,CAST(SUBSTRING(hiCode, 2, 6)  AS VARCHAR) As Code
      ,[hiCurrency]
      ,[hiYear]
      ,[hiPeriod]
      ,[hiSales]
      ,[hiPurchases]
      ,[hiBudget]
      ,[hiCleared]
      ,[hiBudget2]
      ,[hiValue1]
      ,[hiValue2]
      ,[hiValue3]
FROM [ZZZZ01].[HISTORY]
WHERE hiExCLass = ASCII('U')
ORDER BY CAST(SUBSTRING(hiCode, 2, 6)  AS VARCHAR), hiYear, hiPeriod, hiCurrency