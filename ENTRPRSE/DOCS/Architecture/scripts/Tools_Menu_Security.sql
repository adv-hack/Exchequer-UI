-- Tools Menu Security
SELECT [recordtype]
      ,[ssusepassword]
      ,[sspassword]
FROM [common].[TOOLS]
WHERE recordtype = 'S'
