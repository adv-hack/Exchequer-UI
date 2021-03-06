-- Company Options
SELECT [RecPfix]
      ,CAST(SUBSTRING([CompanyCode1], 2, 6) AS VARCHAR) AS OptCode
      ,CAST(SUBSTRING([Company_code3], 2, 100) AS VARCHAR) AS OptPath
      ,[OptPWord]
      ,[OptBackup]
      ,[OptRestore]
      ,[OptHidePath]
      ,[OptHideBackup]
      ,[OptWin9xCmd]
      ,[OptWinNTCmd]
      ,[OptShowCheckUsr]
      ,[optSystemESN]
      ,[OptSecurity]
      ,[OptShowExch]
      ,[OptBureauModule]
      ,[OptBureauAdminPWord]
      ,[OptShowViewCompany]
FROM common.[COMPANY]
WHERE RecPfix = 'S'