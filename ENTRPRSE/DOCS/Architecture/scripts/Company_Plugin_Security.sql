-- Company Plug-in Security
SELECT [RecPfix]
	  ,CAST(CONVERT(VARBINARY(4), REVERSE(SUBSTRING(CompanyCode1, 2, 4))) AS INTEGER) AS Idx
      ,[hkId]
      ,[hkSecCode]
      ,[hkDesc]
      ,[hkStuff]
      ,[hkMessage]
      ,[hkVersion]
      ,[hkEncryptedCode]
FROM [common].[COMPANY]
WHERE RecPfix = 'H'
ORDER BY Idx
