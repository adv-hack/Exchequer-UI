-- History, Profit & Loss by Nominal Code
SELECT CAST(CONVERT(VARBINARY(4), REVERSE(SUBSTRING(CONVERT(VARBINARY(4), hiCode),2,4))) AS INTEGER) AS NomCode
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
	  AND (CAST(SUBSTRING(hiCode, 2, 1) AS VARCHAR) <> 'C')
	  AND (CAST(SUBSTRING(hiCode, 2, 1) AS VARCHAR) <> 'D')
--    AND ((hiPeriod = 254) OR (hiPeriod = 255))
ORDER BY CAST(CONVERT(VARBINARY(4), REVERSE(SUBSTRING(CONVERT(VARBINARY(4), hiCode),2,4))) AS INTEGER), hiYear, hiPeriod, hiCurrency