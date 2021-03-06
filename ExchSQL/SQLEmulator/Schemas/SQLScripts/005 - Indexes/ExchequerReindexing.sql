--/////////////////////////////////////////////////////////////////////////////
--// Filename		: ExchequerReindexing.sql
--// Author		: 
--// Date		: 
--// Copyright Notice	: (c) 2015 Advanced Business Software & Solutions Ltd. All rights reserved.
--// Description	: SQL Script to rebuild indexes
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

-- Beyond Dispute
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
		[hiPeriod] ASC --,
--		[PositionId] ASC
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
		[hiPeriod] ASC --,
--		[PositionId] ASC
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


--IF EXISTS (
--  SELECT 
--    object_id
--  FROM 
--    sys.indexes 
--  WHERE 
--    object_id = OBJECT_ID(N'[!ActiveSchema!].[HISTORY]') 
--    AND name = N'HISTORY_IndexCandidate0'
--  )
--BEGIN
--	CREATE UNIQUE NONCLUSTERED INDEX [HISTORY_IndexCandidate0] ON [!ActiveSchema!].[HISTORY] 
--	(
--		[hiExCLass] DESC,
--		[hiCodeComputed] DESC,
--		[hiCurrency] DESC,
--		[hiYear] DESC,
--		[hiPeriod] DESC,
--		[PositionId] DESC
--	)
--	WITH 
--	(
--		PAD_INDEX  = OFF,
--    FILLFACTOR = 90, 
--		SORT_IN_TEMPDB = OFF, 
--		DROP_EXISTING = ON, 
--		IGNORE_DUP_KEY = OFF, 
--		ONLINE = OFF
--	) ON [PRIMARY]
--END
--ELSE
--BEGIN
--	CREATE UNIQUE NONCLUSTERED INDEX [HISTORY_IndexCandidate0] ON [!ActiveSchema!].[HISTORY] 
--	(
--		[hiExCLass] DESC,
--		[hiCodeComputed] DESC,
--		[hiCurrency] DESC,
--		[hiYear] DESC,
--		[hiPeriod] DESC,
--		[PositionId] DESC
--	)
--	WITH 
--	(
--		PAD_INDEX  = OFF,
--    FILLFACTOR = 90, 
--		SORT_IN_TEMPDB = OFF, 
--		DROP_EXISTING = OFF, 
--		IGNORE_DUP_KEY = OFF, 
--		ONLINE = OFF
--	) ON [PRIMARY]
--END
--GO


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


--IF EXISTS (
--  SELECT 
--    object_id
--  FROM 
--    sys.indexes 
--  WHERE 
--    object_id = OBJECT_ID(N'[!ActiveSchema!].[SETTINGS]') 
--    AND name = N'SETTINGS_Index0'
--  )
--BEGIN
--	CREATE UNIQUE CLUSTERED INDEX [SETTINGS_Index0] ON [!ActiveSchema!].[SETTINGS] 
--	(
--		[FSRecType] ASC,
--		[FSLookUp] ASC,
--		[PositionId] ASC
--	)WITH 
--	(
--		PAD_INDEX  = OFF,
--    FILLFACTOR = 90, 
--		SORT_IN_TEMPDB = OFF, 
--		DROP_EXISTING = ON, 
--		IGNORE_DUP_KEY = OFF, 
--		ONLINE = OFF
--	) ON [PRIMARY]
--END
--ELSE
--BEGIN
--	CREATE UNIQUE CLUSTERED INDEX [SETTINGS_Index0] ON [!ActiveSchema!].[SETTINGS] 
--	(
--		[FSRecType] ASC,
--		[FSLookUp] ASC,
--		[PositionId] ASC
--	)WITH 
--	(
--		PAD_INDEX  = OFF,
--    FILLFACTOR = 90, 
--		SORT_IN_TEMPDB = OFF, 
--		DROP_EXISTING = OFF, 
--		IGNORE_DUP_KEY = OFF, 
--		ONLINE = OFF
--	) ON [PRIMARY]
--END
--GO


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



-- Suggested compromises, i.e. CUSTSUPP.0, DETAILS.2, DOCUMENT.3, EXSTKCHK.0, NOMINAL.2

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
    object_id = OBJECT_ID(N'[!ActiveSchema!].[DETAILS]') 
    AND name = N'DETAILS_Index2'
  )
BEGIN
	CREATE UNIQUE CLUSTERED INDEX [DETAILS_Index2] ON [!ActiveSchema!].[DETAILS] 
	(
		[tlGLCode] ASC,
		[tlNominalMode] ASC,
		[tlCurrency] ASC,
		[tlYear] ASC,
		[tlPeriod] ASC,
		[tlRunNo] ASC,
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
	CREATE UNIQUE CLUSTERED INDEX [DETAILS_Index2] ON [!ActiveSchema!].[DETAILS] 
	(
		[tlGLCode] ASC,
		[tlNominalMode] ASC,
		[tlCurrency] ASC,
		[tlYear] ASC,
		[tlPeriod] ASC,
		[tlRunNo] ASC,
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
    object_id = OBJECT_ID(N'[!ActiveSchema!].[DOCUMENT]') 
    AND name = N'DOCUMENT_IndexCandidate'
  )
BEGIN
	CREATE UNIQUE CLUSTERED INDEX [DOCUMENT_IndexCandidate] ON [!ActiveSchema!].[DOCUMENT] 
	(
		[thFolioNum] ASC,
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
	CREATE UNIQUE CLUSTERED INDEX [DOCUMENT_IndexCandidate] ON [!ActiveSchema!].[DOCUMENT] 
	(
		[thFolioNum] ASC,
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


-- Suggested default to Clustered on Index_Identity for other tables

IF EXISTS (
  SELECT 
    object_id
  FROM 
    sys.indexes 
  WHERE 
    object_id = OBJECT_ID(N'[!ActiveSchema!].[EBUSDETL]') 
    AND name = N'EBUSDETL_Index_Identity'
  )
BEGIN
	CREATE UNIQUE CLUSTERED INDEX [EBUSDETL_Index_Identity] ON [!ActiveSchema!].[EBUSDETL] 
	(
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
	CREATE UNIQUE CLUSTERED INDEX [EBUSDETL_Index_Identity] ON [!ActiveSchema!].[EBUSDETL] 
	(
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
    object_id = OBJECT_ID(N'[!ActiveSchema!].[EBUSDOC]') 
    AND name = N'EBUSDOC_Index_Identity'
  )
BEGIN
	CREATE UNIQUE CLUSTERED INDEX [EBUSDOC_Index_Identity] ON [!ActiveSchema!].[EBUSDOC] 
	(
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
	CREATE UNIQUE CLUSTERED INDEX [EBUSDOC_Index_Identity] ON [!ActiveSchema!].[EBUSDOC] 
	(
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
    object_id = OBJECT_ID(N'[!ActiveSchema!].[EBUSLKUP]') 
    AND name = N'EBUSLKUP_Index_Identity'
  )
BEGIN
	CREATE UNIQUE CLUSTERED INDEX [EBUSLKUP_Index_Identity] ON [!ActiveSchema!].[EBUSLKUP] 
	(
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
	CREATE UNIQUE CLUSTERED INDEX [EBUSLKUP_Index_Identity] ON [!ActiveSchema!].[EBUSLKUP] 
	(
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
    object_id = OBJECT_ID(N'[!ActiveSchema!].[EBUSNOTE]') 
    AND name = N'EBUSNOTE_Index_Identity'
  )
BEGIN
	CREATE UNIQUE CLUSTERED INDEX [EBUSNOTE_Index_Identity] ON [!ActiveSchema!].[EBUSNOTE] 
	(
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
	CREATE UNIQUE CLUSTERED INDEX [EBUSNOTE_Index_Identity] ON [!ActiveSchema!].[EBUSNOTE] 
	(
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
    object_id = OBJECT_ID(N'[!ActiveSchema!].[JOBCTRL]') 
    AND name = N'JOBCTRL_Index_Identity'
  )
BEGIN
	CREATE UNIQUE CLUSTERED INDEX [JOBCTRL_Index_Identity] ON [!ActiveSchema!].[JOBCTRL] 
	(
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
	CREATE UNIQUE CLUSTERED INDEX [JOBCTRL_Index_Identity] ON [!ActiveSchema!].[JOBCTRL] 
	(
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
    object_id = OBJECT_ID(N'[!ActiveSchema!].[JOBDET]') 
    AND name = N'JOBDET_Index_Identity'
  )
BEGIN
	CREATE UNIQUE CLUSTERED INDEX [JOBDET_Index_Identity] ON [!ActiveSchema!].[JOBDET] 
	(
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
	CREATE UNIQUE CLUSTERED INDEX [JOBDET_Index_Identity] ON [!ActiveSchema!].[JOBDET] 
	(
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
    object_id = OBJECT_ID(N'[!ActiveSchema!].[JOBHEAD]') 
    AND name = N'JOBHEAD_Index_Identity'
  )
BEGIN
	CREATE UNIQUE CLUSTERED INDEX [JOBHEAD_Index_Identity] ON [!ActiveSchema!].[JOBHEAD] 
	(
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
	CREATE UNIQUE CLUSTERED INDEX [JOBHEAD_Index_Identity] ON [!ActiveSchema!].[JOBHEAD] 
	(
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
    object_id = OBJECT_ID(N'[!ActiveSchema!].[NOMVIEW]') 
    AND name = N'NOMVIEW_Index_Identity'
  )
BEGIN
	CREATE UNIQUE CLUSTERED INDEX [NOMVIEW_Index_Identity] ON [!ActiveSchema!].[NOMVIEW] 
	(
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
	CREATE UNIQUE CLUSTERED INDEX [NOMVIEW_Index_Identity] ON [!ActiveSchema!].[NOMVIEW] 
	(
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
    object_id = OBJECT_ID(N'[!ActiveSchema!].[PAPRSIZE]') 
    AND name = N'PAPRSIZE_Index_Identity'
  )
BEGIN
	CREATE UNIQUE CLUSTERED INDEX [PAPRSIZE_Index_Identity] ON [!ActiveSchema!].[PAPRSIZE] 
	(
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
	CREATE UNIQUE CLUSTERED INDEX [PAPRSIZE_Index_Identity] ON [!ActiveSchema!].[PAPRSIZE] 
	(
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
    object_id = OBJECT_ID(N'[!ActiveSchema!].[SCHEDULE]') 
    AND name = N'SCHEDULE_Index_Identity'
  )
BEGIN
	CREATE UNIQUE CLUSTERED INDEX [SCHEDULE_Index_Identity] ON [!ActiveSchema!].[SCHEDULE] 
	(
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
	CREATE UNIQUE CLUSTERED INDEX [SCHEDULE_Index_Identity] ON [!ActiveSchema!].[SCHEDULE] 
	(
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
    object_id = OBJECT_ID(N'[!ActiveSchema!].[SchemaVersion]') 
    AND name = N'SchemaVersion_Index0'
  )
BEGIN
	CREATE UNIQUE CLUSTERED INDEX [SchemaVersion_Index0] ON [!ActiveSchema!].[SchemaVersion] 
	(
		[SchemaName] ASC,
		[Version] ASC
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
	CREATE UNIQUE CLUSTERED INDEX [SchemaVersion_Index0] ON [!ActiveSchema!].[SchemaVersion] 
	(
		[SchemaName] ASC,
		[Version] ASC
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
    object_id = OBJECT_ID(N'[!ActiveSchema!].[VRWSEC]') 
    AND name = N'VRWSEC_Index_Identity'
  )
BEGIN
	CREATE UNIQUE CLUSTERED INDEX [VRWSEC_Index_Identity] ON [!ActiveSchema!].[VRWSEC] 
	(
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
	CREATE UNIQUE CLUSTERED INDEX [VRWSEC_Index_Identity] ON [!ActiveSchema!].[VRWSEC] 
	(
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
    object_id = OBJECT_ID(N'[!ActiveSchema!].[VRWTREE]') 
    AND name = N'VRWTREE_Index_Identity'
  )
BEGIN
	CREATE UNIQUE CLUSTERED INDEX [VRWTREE_Index_Identity] ON [!ActiveSchema!].[VRWTREE] 
	(
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
	CREATE UNIQUE CLUSTERED INDEX [VRWTREE_Index_Identity] ON [!ActiveSchema!].[VRWTREE] 
	(
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

