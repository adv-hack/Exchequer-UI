-- History, Customer/Supplier History
SELECT CAST(SUBSTRING(hiCode, 2, 6) AS VARCHAR) AS CustCode
      ,CAST(CONVERT(VARBINARY(4), REVERSE(SUBSTRING(CONVERT(VARBINARY(4), hiCode), 8, 4))) AS INTEGER) AS NomCode
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
WHERE hiExCLass = ASCII('U')
--    AND ((hiPeriod = 254) OR (hiPeriod = 255))
ORDER BY CAST(SUBSTRING(hiCode, 2, 6) AS VARCHAR), hiYear, hiPeriod, hiCurrency