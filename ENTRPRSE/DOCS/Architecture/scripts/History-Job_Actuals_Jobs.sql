-- History, Job Actuals, Jobs
SELECT CHAR([hiExCLass]) AS Class
	  ,CAST(SUBSTRING(hiCode, 2, 10) AS VARCHAR) AS JobCode
      ,CAST(CONVERT(VARBINARY(4), REVERSE(SUBSTRING(hiCode, 12, 4))) AS INTEGER) AS Analysis
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
WHERE hiExCLass = ASCII('[')
--    AND ((hiPeriod = 254) OR (hiPeriod = 255))
ORDER BY CAST(SUBSTRING(hiCode, 2, 6) AS VARCHAR), hiYear, hiPeriod, hiCurrency