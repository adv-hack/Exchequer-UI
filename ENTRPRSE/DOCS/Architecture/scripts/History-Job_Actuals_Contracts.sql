-- History, Job Actuals, Contracts
SELECT CHAR([hiExCLass]) AS Class
      ,CAST(CONVERT(VARBINARY(4), REVERSE(SUBSTRING(hiCode, 12, 4))) AS INTEGER) AS Analysis
	  ,CAST(SUBSTRING(hiCode, 2, 10) AS VARCHAR) AS ContractCode
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
FROM [ZZZZ02].[HISTORY]
WHERE hiExCLass = ASCII('K')
--    AND ((hiPeriod = 254) OR (hiPeriod = 255))
ORDER BY CAST(SUBSTRING(hiCode, 2, 6) AS VARCHAR), hiYear, hiPeriod, hiCurrency