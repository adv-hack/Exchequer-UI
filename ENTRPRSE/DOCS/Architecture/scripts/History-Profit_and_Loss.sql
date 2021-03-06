-- History, Profit & Loss
SELECT CAST(SUBSTRING(hiCode, 2, 20)  AS VARCHAR) As Code
	  ,CAST(CONVERT(VARBINARY(4), REVERSE(SUBSTRING(CONVERT(VARBINARY(4), hiCode),2,4))) AS INTEGER) AS NomCode
	  ,CONVERT(VARBINARY(4), REVERSE(SUBSTRING(CONVERT(VARBINARY(4), hiCode),2,4))) AS NomCodeBin
	  ,CAST(SUBSTRING(hiCode, 2, 1) AS VARCHAR) + CAST(SUBSTRING(hiCode, 7, 10) AS VARCHAR) AS CCode
      ,CHAR([hiExCLass]) AS Class
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
WHERE hiExCLass = ASCII('A')
--    AND ((hiPeriod = 254) OR (hiPeriod = 255))
ORDER BY hiCode, hiYear, hiPeriod, hiCurrency