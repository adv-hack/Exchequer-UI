-- Bank Statement Header
SELECT [RecPfix]
      ,[SubType]
      ,[EbAccNOM]
      ,[EbStatRef]
      ,[EbStatInd]
      ,[EbSourceFile]
      ,[EbIntRef]
      ,[EbStatDate]
FROM [ZZZZ01].[MLOCSTK]
WHERE RecPfix = 'K' AND SubType = '4'
