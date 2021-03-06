-- Bank Reconciliation Header
SELECT RecPfix
      ,SubType
	  ,CAST(CONVERT(VARBINARY(4), REVERSE(SUBSTRING(varCode1, 2, 4))) AS INTEGER) AS IDX_brGLCode
	  ,CAST(SUBSTRING(varCode1, 6, 10) AS VARCHAR) AS IDX_brBankUserID
	  ,CAST(CONVERT(VARBINARY(4), REVERSE(SUBSTRING(varCode3, 16, 4))) AS INTEGER) AS IDX_brIntRef
      ,BrStatDate
      ,BrStatRef
      ,BrBankAcc
      ,BrBankCurrency
      ,BrBankUserID
      ,BrCreateDate
      ,BrCreateTime
      ,BrStatBal
      ,BrOpenBal
      ,BrCloseBal
      ,BrStatus
      ,BrIntRef
      ,BrGLCode
      ,BrStatFolio
      ,BrReconDate
      ,BrReconRef
      ,BrInitSeq
FROM [ZZZZ01].[MLOCSTK]
WHERE RecPfix = 'K' AND SubType = '1'