-- Tools Menu Users
SELECT DISTINCT 
       [recordtype]
      ,[uxusername]
FROM [common].[TOOLS]
WHERE recordtype = 'U'
