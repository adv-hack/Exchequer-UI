-- Company Details
SELECT [RecPfix]
      ,CAST(SUBSTRING([CompanyCode1], 2, 6) AS VARCHAR) AS CompanyCode
      ,[Company_code2] AS CompanyName
      ,CAST(SUBSTRING([Company_code3], 2, 100) AS VARCHAR(100)) AS Path
      ,[CompId]
      ,[CompDemoData]
--		Internal to application, not populated in database      
--      ,[CompDemoSys]
--      ,[CompTKUCount]
--      ,[CompTrdUCount]
--      ,[CompSysESN]
--      ,[CompModId]
--      ,[CompModSynch]
--      ,[CompUCount]
--      ,[CompAnal]
FROM [common].[COMPANY]
WHERE RecPfix = 'C'
