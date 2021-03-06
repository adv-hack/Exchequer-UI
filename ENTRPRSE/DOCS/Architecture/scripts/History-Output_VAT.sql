-- History, Output VAT
SELECT CHAR([hiExCLass]) AS Class
      ,CAST(SUBSTRING(hiCode, 2, 1)  AS VARCHAR) As Code
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
WHERE hiExCLass = ASCII('O')
ORDER BY hiCode, hiYear, hiPeriod, hiCurrency