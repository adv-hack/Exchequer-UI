--/////////////////////////////////////////////////////////////////////////////
--// Filename		: idx_ExchequerReindexingV0.5.sql
--// Author		: 
--// Date		: 
--// Copyright Notice	: (c) 2015 Advanced Business Software & Solutions Ltd. All rights reserved.
--// Description	: SQL Script to amend indexes
--//
--/////////////////////////////////////////////////////////////////////////////
--// Version History:
--//	1	: File Creation
--//
--/////////////////////////////////////////////////////////////////////////////

SET ARITHABORT ON
GO
SET CONCAT_NULL_YIELDS_NULL ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
SET ANSI_PADDING ON
GO
SET ANSI_WARNINGS ON
GO
SET NUMERIC_ROUNDABORT OFF
GO

-- EXCHQCHK.0, EXCHQNUM.0, EXCHQSS.0, JOBMISC.2, MLOCSTK.1, SETTINGS.0, STOCK.0

IF EXISTS (
  SELECT
    object_id
  FROM
    sys.indexes
  WHERE
    object_id = OBJECT_ID(N'[!ActiveSchema!].[EXCHQCHK]')
    AND name = N'EXCHQCHK_Index0'
  )
BEGIN
	CREATE UNIQUE CLUSTERED INDEX [EXCHQCHK_Index0] ON [!ActiveSchema!].[EXCHQCHK]
	(
		[RecPfix] ASC,
		[SubType] ASC,
		[Exchqchkcode1Computed] ASC,
		[PositionId] ASC
	)WITH
	(
		PAD_INDEX  = OFF,
		FILLFACTOR = 90,
		SORT_IN_TEMPDB = OFF,
		DROP_EXISTING = ON,
		IGNORE_DUP_KEY = OFF,
		ONLINE = OFF
	) ON [PRIMARY]
END
ELSE
BEGIN
	CREATE UNIQUE CLUSTERED INDEX [EXCHQCHK_Index0] ON [!ActiveSchema!].[EXCHQCHK]
	(
		[RecPfix] ASC,
		[SubType] ASC,
		[Exchqchkcode1Computed] ASC,
		[PositionId] ASC
	)WITH
	(
		PAD_INDEX  = OFF,
		FILLFACTOR = 90,
		SORT_IN_TEMPDB = OFF,
		DROP_EXISTING = OFF,
		IGNORE_DUP_KEY = OFF,
		ONLINE = OFF
	) ON [PRIMARY]
END
GO

IF EXISTS (
  SELECT
    object_id
  FROM
    sys.indexes
  WHERE
    object_id = OBJECT_ID(N'[!ActiveSchema!].[EXCHQNUM]')
    AND name = N'EXCHQNUM_IndexCandidate'
  )
BEGIN
	CREATE UNIQUE CLUSTERED INDEX [EXCHQNUM_IndexCandidate] ON [!ActiveSchema!].[EXCHQNUM]
	(
		[ssCountType] ASC,
		[PositionId] ASC
	)WITH
	(
		PAD_INDEX  = OFF,
		FILLFACTOR = 90,
		STATISTICS_NORECOMPUTE  = OFF,
		SORT_IN_TEMPDB = OFF,
		DROP_EXISTING = ON,
		IGNORE_DUP_KEY = OFF,
		ONLINE = OFF,
		ALLOW_ROW_LOCKS  = ON,
		ALLOW_PAGE_LOCKS  = ON
	) ON [PRIMARY]
END
ELSE
BEGIN
	CREATE UNIQUE CLUSTERED INDEX [EXCHQNUM_IndexCandidate] ON [!ActiveSchema!].[EXCHQNUM]
	(
		[ssCountType] ASC,
		[PositionId] ASC
	)WITH
	(
		PAD_INDEX  = OFF,
		FILLFACTOR = 90,
		STATISTICS_NORECOMPUTE  = OFF,
		SORT_IN_TEMPDB = OFF,
		DROP_EXISTING = OFF,
		IGNORE_DUP_KEY = OFF,
		ONLINE = OFF,
		ALLOW_ROW_LOCKS  = ON,
		ALLOW_PAGE_LOCKS  = ON
	) ON [PRIMARY]
END
GO

IF EXISTS (
  SELECT
    object_id
  FROM
    sys.indexes
  WHERE
    object_id = OBJECT_ID(N'[!ActiveSchema!].[EXCHQSS]')
    AND name = N'EXCHQSS_IndexCandidate'
  )
BEGIN
	CREATE UNIQUE CLUSTERED INDEX [EXCHQSS_IndexCandidate] ON [!ActiveSchema!].[EXCHQSS]
	(
		[IDCode] ASC,
		[PositionId] ASC
	)WITH
	(
		PAD_INDEX  = OFF,
		FILLFACTOR = 90,
		STATISTICS_NORECOMPUTE  = OFF,
		SORT_IN_TEMPDB = OFF,
		DROP_EXISTING = ON,
		IGNORE_DUP_KEY = OFF,
		ONLINE = OFF,
		ALLOW_ROW_LOCKS  = ON,
		ALLOW_PAGE_LOCKS  = ON
	) ON [PRIMARY]
END
ELSE
BEGIN
	CREATE UNIQUE CLUSTERED INDEX [EXCHQSS_IndexCandidate] ON [!ActiveSchema!].[EXCHQSS]
	(
		[IDCode] ASC,
		[PositionId] ASC
	)WITH
	(
		PAD_INDEX  = OFF,
		FILLFACTOR = 90,
		STATISTICS_NORECOMPUTE  = OFF,
		SORT_IN_TEMPDB = OFF,
		DROP_EXISTING = OFF,
		IGNORE_DUP_KEY = OFF,
		ONLINE = OFF,
		ALLOW_ROW_LOCKS  = ON,
		ALLOW_PAGE_LOCKS  = ON
	) ON [PRIMARY]
END
GO

IF EXISTS (
  SELECT
    object_id
  FROM
    sys.indexes
  WHERE
    object_id = OBJECT_ID(N'[!ActiveSchema!].[HISTORY]')
    AND name = N'HISTORY_IndexCandidate'
  )
BEGIN
	CREATE UNIQUE CLUSTERED INDEX [HISTORY_IndexCandidate] ON [!ActiveSchema!].[HISTORY]
	(
		[hiExCLass] ASC,
		[hiCodeComputed] ASC,
		[hiCurrency] ASC,
		[hiYear] ASC,
		[hiPeriod] ASC,
		[PositionId] ASC
	)
	WITH
	(
		PAD_INDEX  = OFF,
		FILLFACTOR = 90,
		SORT_IN_TEMPDB = OFF,
		DROP_EXISTING = ON,
		IGNORE_DUP_KEY = OFF,
		ONLINE = OFF
	) ON [PRIMARY]
END
ELSE
BEGIN
	CREATE UNIQUE CLUSTERED INDEX [HISTORY_IndexCandidate] ON [!ActiveSchema!].[HISTORY]
	(
		[hiExCLass] ASC,
		[hiCodeComputed] ASC,
		[hiCurrency] ASC,
		[hiYear] ASC,
		[hiPeriod] ASC,
		[PositionId] ASC
	)
	WITH
	(
		PAD_INDEX  = OFF,
		FILLFACTOR = 90,
		SORT_IN_TEMPDB = OFF,
		DROP_EXISTING = OFF,
		IGNORE_DUP_KEY = OFF,
		ONLINE = OFF
	) ON [PRIMARY]
END
GO

IF EXISTS (
  SELECT
    object_id
  FROM
    sys.indexes
  WHERE
    object_id = OBJECT_ID(N'[!ActiveSchema!].[HISTORY]')
    AND name = N'HISTORY_IndexCandidate2'
  )
BEGIN
	CREATE NONCLUSTERED INDEX [HISTORY_IndexCandidate2] ON [!ActiveSchema!].[HISTORY]
	(
		[hiExCLass] ASC,
		[hiCurrency] ASC,
		[hiPeriod] ASC,
		[hiYear] ASC)
		INCLUDE ([hiCodeComputed])
	WITH
	(
		PAD_INDEX  = OFF,
		FILLFACTOR = 90,
		SORT_IN_TEMPDB = OFF,
		DROP_EXISTING = ON,
		IGNORE_DUP_KEY = OFF,
		ONLINE = OFF
	) ON [PRIMARY]
END
ELSE
BEGIN
	CREATE NONCLUSTERED INDEX [HISTORY_IndexCandidate2] ON [!ActiveSchema!].[HISTORY]
	(
		[hiExCLass] ASC,
		[hiCurrency] ASC,
		[hiPeriod] ASC,
		[hiYear] ASC)
		INCLUDE ([hiCodeComputed])
	WITH
	(
		PAD_INDEX  = OFF,
		FILLFACTOR = 90,
		SORT_IN_TEMPDB = OFF,
		DROP_EXISTING = OFF,
		IGNORE_DUP_KEY = OFF,
		ONLINE = OFF
	) ON [PRIMARY]
END
GO

IF EXISTS (
  SELECT
    object_id
  FROM
    sys.indexes
  WHERE
    object_id = OBJECT_ID(N'[!ActiveSchema!].[JOBMISC]')
    AND name = N'JOBMISC_Index2'
  )
BEGIN
	CREATE UNIQUE CLUSTERED INDEX [JOBMISC_Index2] ON [!ActiveSchema!].[JOBMISC]
	(
		[RecPfix] ASC,
		[SubType] ASC,
		[var_code4] ASC,
		[PositionId] ASC
	)WITH
	(
		PAD_INDEX  = OFF,
		FILLFACTOR = 90,
		SORT_IN_TEMPDB = OFF,
		DROP_EXISTING = ON,
		IGNORE_DUP_KEY = OFF,
		ONLINE = OFF
	) ON [PRIMARY]
END
ELSE
BEGIN
	CREATE UNIQUE CLUSTERED INDEX [JOBMISC_Index2] ON [!ActiveSchema!].[JOBMISC]
	(
		[RecPfix] ASC,
		[SubType] ASC,
		[var_code4] ASC,
		[PositionId] ASC
	)WITH
	(
		PAD_INDEX  = OFF,
		FILLFACTOR = 90,
		SORT_IN_TEMPDB = OFF,
		DROP_EXISTING = OFF,
		IGNORE_DUP_KEY = OFF,
		ONLINE = OFF
	) ON [PRIMARY]
END
GO

IF EXISTS (
  SELECT
    object_id
  FROM
    sys.indexes
  WHERE
    object_id = OBJECT_ID(N'[!ActiveSchema!].[MLOCSTK]')
    AND name = N'MLOCSTK_Index1'
  )
BEGIN
	CREATE UNIQUE CLUSTERED INDEX [MLOCSTK_Index1] ON [!ActiveSchema!].[MLOCSTK]
	(
		[RecPfix] ASC,
		[SubType] ASC,
		[VarCode2Computed] ASC,
		[PositionId] ASC
	)WITH
	(
		PAD_INDEX  = OFF,
		FILLFACTOR = 90,
		SORT_IN_TEMPDB = OFF,
		DROP_EXISTING = ON,
		IGNORE_DUP_KEY = OFF,
		ONLINE = OFF
	) ON [PRIMARY]
END
ELSE
BEGIN
	CREATE UNIQUE CLUSTERED INDEX [MLOCSTK_Index1] ON [!ActiveSchema!].[MLOCSTK]
	(
		[RecPfix] ASC,
		[SubType] ASC,
		[VarCode2Computed] ASC,
		[PositionId] ASC
	)WITH
	(
		PAD_INDEX  = OFF,
		FILLFACTOR = 90,
		SORT_IN_TEMPDB = OFF,
		DROP_EXISTING = OFF,
		IGNORE_DUP_KEY = OFF,
		ONLINE = OFF
	) ON [PRIMARY]
END
GO

IF EXISTS (
  SELECT
    object_id
  FROM
    sys.indexes
  WHERE
    object_id = OBJECT_ID(N'[!ActiveSchema!].[SETTINGS]')
    AND name = N'SETTINGS_Index0'
  )
BEGIN
	CREATE UNIQUE CLUSTERED INDEX [SETTINGS_Index0] ON [!ActiveSchema!].[SETTINGS]
	(
		[f_field_1] ASC,
		[f_field_3] ASC,
		[PositionId] ASC
	)WITH
	(
		PAD_INDEX  = OFF,
		FILLFACTOR = 90,
		SORT_IN_TEMPDB = OFF,
		DROP_EXISTING = ON,
		IGNORE_DUP_KEY = OFF,
		ONLINE = OFF
	) ON [PRIMARY]
END
ELSE
BEGIN
	CREATE UNIQUE CLUSTERED INDEX [SETTINGS_Index0] ON [!ActiveSchema!].[SETTINGS]
	(
		[f_field_1] ASC,
		[f_field_3] ASC,
		[PositionId] ASC
	)WITH
	(
		PAD_INDEX  = OFF,
		FILLFACTOR = 90,
		SORT_IN_TEMPDB = OFF,
		DROP_EXISTING = OFF,
		IGNORE_DUP_KEY = OFF,
		ONLINE = OFF
	) ON [PRIMARY]
END
GO


IF EXISTS (
  SELECT
    object_id
  FROM
    sys.indexes
  WHERE
    object_id = OBJECT_ID(N'[!ActiveSchema!].[STOCK]')
    AND name = N'STOCK_IndexCandidate'
  )
BEGIN
	CREATE UNIQUE CLUSTERED INDEX [STOCK_IndexCandidate] ON [!ActiveSchema!].[STOCK]
	(
		[stCode] ASC,
		[PositionId] ASC
	)WITH
	(
		PAD_INDEX  = OFF,
		FILLFACTOR = 90,
		STATISTICS_NORECOMPUTE  = OFF,
		SORT_IN_TEMPDB = OFF,
		DROP_EXISTING = ON,
		IGNORE_DUP_KEY = OFF,
		ONLINE = OFF,
		ALLOW_ROW_LOCKS  = ON,
		ALLOW_PAGE_LOCKS  = ON
	) ON [PRIMARY]
END
ELSE
BEGIN
	CREATE UNIQUE CLUSTERED INDEX [STOCK_IndexCandidate] ON [!ActiveSchema!].[STOCK]
	(
		[stCode] ASC,
		[PositionId] ASC
	)WITH
	(
		PAD_INDEX  = OFF,
		FILLFACTOR = 90,
		STATISTICS_NORECOMPUTE  = OFF,
		SORT_IN_TEMPDB = OFF,
		DROP_EXISTING = OFF,
		IGNORE_DUP_KEY = OFF,
		ONLINE = OFF,
		ALLOW_ROW_LOCKS  = ON,
		ALLOW_PAGE_LOCKS  = ON
	) ON [PRIMARY]
END
GO

-- CUSTSUPP.0, DETAILS.2, DOCUMENT.3, EXSTKCHK.0, NOMINAL.2

IF EXISTS (
  SELECT
    object_id
  FROM
    sys.indexes
  WHERE
    object_id = OBJECT_ID(N'[!ActiveSchema!].[CUSTSUPP]')
    AND name = N'CUSTSUPP_IndexCandidate'
  )
BEGIN
	CREATE UNIQUE CLUSTERED INDEX [CUSTSUPP_IndexCandidate] ON [!ActiveSchema!].[CUSTSUPP]
	(
		[acCode] ASC,
		[PositionId] ASC
	)WITH
	(
		PAD_INDEX  = OFF,
		FILLFACTOR = 90,
		STATISTICS_NORECOMPUTE  = OFF,
		SORT_IN_TEMPDB = OFF,
		DROP_EXISTING = ON,
		IGNORE_DUP_KEY = OFF,
		ONLINE = OFF,
		ALLOW_ROW_LOCKS  = ON,
		ALLOW_PAGE_LOCKS  = ON
	) ON [PRIMARY]
END
ELSE
BEGIN
	CREATE UNIQUE CLUSTERED INDEX [CUSTSUPP_IndexCandidate] ON [!ActiveSchema!].[CUSTSUPP]
	(
		[acCode] ASC,
		[PositionId] ASC
	)WITH
	(
		PAD_INDEX  = OFF,
		FILLFACTOR = 90,
		STATISTICS_NORECOMPUTE  = OFF,
		SORT_IN_TEMPDB = OFF,
		DROP_EXISTING = OFF,
		IGNORE_DUP_KEY = OFF,
		ONLINE = OFF,
		ALLOW_ROW_LOCKS  = ON,
		ALLOW_PAGE_LOCKS  = ON
	) ON [PRIMARY]
END
GO

IF EXISTS (
  SELECT
    object_id
  FROM
    sys.indexes
  WHERE
    object_id = OBJECT_ID(N'[!ActiveSchema!].[EXSTKCHK]')
    AND name = N'EXSTKCHK_Index0'
  )
BEGIN
	CREATE UNIQUE CLUSTERED INDEX [EXSTKCHK_Index0] ON [!ActiveSchema!].[EXSTKCHK]
	(
		[RecMfix] ASC,
		[SubType] ASC,
		[exstchkvar1Computed] ASC,
		[PositionId] ASC
	)WITH
	(
		PAD_INDEX  = OFF,
		FILLFACTOR = 90,
		PAD_INDEX  = OFF,
		SORT_IN_TEMPDB = OFF,
		DROP_EXISTING = ON,
		IGNORE_DUP_KEY = OFF,
		ONLINE = OFF
	) ON [PRIMARY]
END
ELSE
BEGIN
	CREATE UNIQUE CLUSTERED INDEX [EXSTKCHK_Index0] ON [!ActiveSchema!].[EXSTKCHK]
	(
		[RecMfix] ASC,
		[SubType] ASC,
		[exstchkvar1Computed] ASC,
		[PositionId] ASC
	)WITH
	(
		PAD_INDEX  = OFF,
		FILLFACTOR = 90,
		PAD_INDEX  = OFF,
		SORT_IN_TEMPDB = OFF,
		DROP_EXISTING = OFF,
		IGNORE_DUP_KEY = OFF,
		ONLINE = OFF
	) ON [PRIMARY]
END
GO

IF EXISTS (
  SELECT
    object_id
  FROM
    sys.indexes
  WHERE
    object_id = OBJECT_ID(N'[!ActiveSchema!].[NOMINAL]')
    AND name = N'NOMINAL_IndexCandidate'
  )
BEGIN
	CREATE UNIQUE CLUSTERED INDEX [NOMINAL_IndexCandidate] ON [!ActiveSchema!].[NOMINAL]
	(
		[glParent] ASC,
		[glCode] ASC,
		[PositionId] ASC
	)WITH
	(
		PAD_INDEX  = OFF,
		FILLFACTOR = 90,
		STATISTICS_NORECOMPUTE  = OFF,
		SORT_IN_TEMPDB = OFF,
		DROP_EXISTING = ON,
		IGNORE_DUP_KEY = OFF,
		ONLINE = OFF,
		ALLOW_ROW_LOCKS  = ON,
		ALLOW_PAGE_LOCKS  = ON
	) ON [PRIMARY]
END
ELSE
BEGIN
	CREATE UNIQUE CLUSTERED INDEX [NOMINAL_IndexCandidate] ON [!ActiveSchema!].[NOMINAL]
	(
		[glParent] ASC,
		[glCode] ASC,
		[PositionId] ASC
	)WITH
	(
		PAD_INDEX  = OFF,
		FILLFACTOR = 90,
		STATISTICS_NORECOMPUTE  = OFF,
		SORT_IN_TEMPDB = OFF,
		DROP_EXISTING = OFF,
		IGNORE_DUP_KEY = OFF,
		ONLINE = OFF,
		ALLOW_ROW_LOCKS  = ON,
		ALLOW_PAGE_LOCKS  = ON
	) ON [PRIMARY]
END
GO

IF EXISTS (
  SELECT
    object_id
  FROM
    sys.indexes
  WHERE
    object_id = OBJECT_ID(N'[!ActiveSchema!].[HISTORY]')
    AND name = N'HISTORY_Index_CAA'
  )
BEGIN
	CREATE NONCLUSTERED INDEX [HISTORY_Index_CAA]
        ON [!ActiveSchema!].[HISTORY] ([hiExCLass],[hiYear])
        INCLUDE ([hiCode],[hiCurrency],[hiPeriod],[PositionId]
        )WITH
	(
		PAD_INDEX  = OFF,
		FILLFACTOR = 90,
		STATISTICS_NORECOMPUTE  = OFF,
		SORT_IN_TEMPDB = OFF,
		DROP_EXISTING = ON,
		IGNORE_DUP_KEY = OFF,
		ONLINE = OFF,
		ALLOW_ROW_LOCKS  = ON,
		ALLOW_PAGE_LOCKS  = ON
	) ON [PRIMARY]
END
ELSE
BEGIN
        CREATE NONCLUSTERED INDEX [HISTORY_Index_CAA]
        ON [!ActiveSchema!].[HISTORY] ([hiExCLass],[hiYear])
        INCLUDE ([hiCode],[hiCurrency],[hiPeriod],[PositionId]
	)WITH
	(
		PAD_INDEX  = OFF,
		FILLFACTOR = 90,
		STATISTICS_NORECOMPUTE  = OFF,
		SORT_IN_TEMPDB = OFF,
		DROP_EXISTING = OFF,
		IGNORE_DUP_KEY = OFF,
		ONLINE = OFF,
		ALLOW_ROW_LOCKS  = ON,
		ALLOW_PAGE_LOCKS  = ON
	) ON [PRIMARY]
END
GO

IF EXISTS (
  SELECT
    object_id
  FROM
    sys.indexes
  WHERE
    object_id = OBJECT_ID(N'[!ActiveSchema!].[DOCUMENT]')
    AND name = N'DOCUMENT_Index14_CAA'
  )
BEGIN
	CREATE NONCLUSTERED INDEX [DOCUMENT_Index14_CAA]
        ON [!ActiveSchema!].[DOCUMENT] ([thAcCodeComputed],[thDocType])
        INCLUDE ([thRunNo],[thAcCode],[thNomAuto],[thOurRef],[thFolioNum],[thCurrency],[thYear],[thPeriod],        [thDueDate],[thVATPostDate],[thCustSupp],[thCompanyRate],[thDailyRate],[thOutstanding],[thNetValue],        [thTotalVAT],[thSettleDiscAmount],[thTotalLineDiscount],[thSettleDiscTaken],[thRemitNo],[thVariance],        [thTotalOrdered],[thTotalCost],[thUntilDate],[thRevalueAdj],[thCurrSettled],[thSettledVAT],        [thDeliveryNoteRef],[PostDiscAm],[thControlGL],[thTotalOrderOS],[PositionId]
        )WITH
	(
		PAD_INDEX  = OFF,
		FILLFACTOR = 90,
		STATISTICS_NORECOMPUTE  = OFF,
		SORT_IN_TEMPDB = OFF,
		DROP_EXISTING = ON,
		IGNORE_DUP_KEY = OFF,
		ONLINE = OFF,
		ALLOW_ROW_LOCKS  = ON,
		ALLOW_PAGE_LOCKS  = ON
	) ON [PRIMARY]
END
ELSE
BEGIN
	CREATE NONCLUSTERED INDEX [DOCUMENT_Index14_CAA]
        ON [!ActiveSchema!].[DOCUMENT] ([thAcCodeComputed],[thDocType])
        INCLUDE ([thRunNo],[thAcCode],[thNomAuto],[thOurRef],[thFolioNum],[thCurrency],[thYear],[thPeriod],        [thDueDate],[thVATPostDate],[thCustSupp],[thCompanyRate],[thDailyRate],[thOutstanding],[thNetValue],        [thTotalVAT],[thSettleDiscAmount],[thTotalLineDiscount],[thSettleDiscTaken],[thRemitNo],[thVariance],        [thTotalOrdered],[thTotalCost],[thUntilDate],[thRevalueAdj],[thCurrSettled],[thSettledVAT],        [thDeliveryNoteRef],[PostDiscAm],[thControlGL],[thTotalOrderOS],[PositionId]
	)WITH
	(
		PAD_INDEX  = OFF,
		FILLFACTOR = 90,
		STATISTICS_NORECOMPUTE  = OFF,
		SORT_IN_TEMPDB = OFF,
		DROP_EXISTING = OFF,
		IGNORE_DUP_KEY = OFF,
		ONLINE = OFF,
		ALLOW_ROW_LOCKS  = ON,
		ALLOW_PAGE_LOCKS  = ON
	) ON [PRIMARY]
END
GO

IF EXISTS (
  SELECT
    object_id
  FROM
    sys.indexes
  WHERE
    object_id = OBJECT_ID(N'[!ActiveSchema!].[DETAILS]')
    AND name = N'DETAILS_Index12_CAA'
  )
BEGIN
        CREATE NONCLUSTERED INDEX [DETAILS_Index12_CAA]
        ON [!ActiveSchema!].[DETAILS] ([tlLineType],[tlAcCode],[tlStockCode])
        INCLUDE ([tlFolioNum],[tlLineNo],[tlRunNo],[tlCurrency],[tlYear],[tlPeriod],[tlDepartment],[tlCostCentre],[tlDocType],[tlQty],[tlQtyMul],[tlNetValue],[tlPaymentCode],[tlCost],[tlLineDate],[tlCompanyRate],[tlDailyRate],[tlUsePack],[tlUseOriginalRates]
        )WITH
	(
		PAD_INDEX  = OFF,
		FILLFACTOR = 90,
		STATISTICS_NORECOMPUTE  = OFF,
		SORT_IN_TEMPDB = OFF,
		DROP_EXISTING = ON,
		IGNORE_DUP_KEY = OFF,
		ONLINE = OFF,
		ALLOW_ROW_LOCKS  = ON,
		ALLOW_PAGE_LOCKS  = ON
	) ON [PRIMARY]
END
ELSE
BEGIN
        CREATE NONCLUSTERED INDEX [DETAILS_Index12_CAA]
        ON [!ActiveSchema!].[DETAILS] ([tlLineType],[tlAcCode],[tlStockCode])
        INCLUDE ([tlFolioNum],[tlLineNo],[tlRunNo],[tlCurrency],[tlYear],[tlPeriod],[tlDepartment],[tlCostCentre],[tlDocType],[tlQty],[tlQtyMul],[tlNetValue],[tlPaymentCode],[tlCost],[tlLineDate],[tlCompanyRate],[tlDailyRate],[tlUsePack],[tlUseOriginalRates]
	)WITH
	(
		PAD_INDEX  = OFF,
		FILLFACTOR = 90,
		STATISTICS_NORECOMPUTE  = OFF,
		SORT_IN_TEMPDB = OFF,
		DROP_EXISTING = OFF,
		IGNORE_DUP_KEY = OFF,
		ONLINE = OFF,
		ALLOW_ROW_LOCKS  = ON,
		ALLOW_PAGE_LOCKS  = ON
	) ON [PRIMARY]
END
GO