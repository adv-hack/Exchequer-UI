-- History, Profit & Loss by Cost Centre/Department
SELECT CHAR([hiExCLass]) AS Class
      ,CAST(SUBSTRING(hiCode, 2, 1) AS VARCHAR) AS CCDep
      ,CAST(SUBSTRING(hiCode, 7, 3) AS VARCHAR) AS CCDep1
      ,CAST(SUBSTRING(hiCode, 11, 3) AS VARCHAR) AS CCDep1
      ,CAST(CONVERT(VARBINARY(4), REVERSE(SUBSTRING(CONVERT(VARBINARY(4), hiCode), 3, 4))) AS INTEGER) AS NomCode
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
INNER JOIN ZZZZ01.NOMINAL ON CAST(CONVERT(VARBINARY(4), REVERSE(SUBSTRING(CONVERT(VARBINARY(4), hiCode), 3, 4))) AS INTEGER) = NOMINAL.glCode
WHERE hiExCLass = ASCII('A')
	  AND ((CAST(SUBSTRING(hiCode, 2, 1) AS VARCHAR) = 'C')
	       OR (CAST(SUBSTRING(hiCode, 2, 1) AS VARCHAR) = 'D'))
      AND (CAST(SUBSTRING(hiCode, 7, 3) AS VARCHAR) <> '')	       
--    AND ((hiPeriod = 254) OR (hiPeriod = 255))
ORDER BY CAST(CONVERT(VARBINARY(4), REVERSE(SUBSTRING(CONVERT(VARBINARY(4), hiCode),2,4))) AS INTEGER), hiYear, hiPeriod, hiCurrency
