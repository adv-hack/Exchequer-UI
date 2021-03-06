--/////////////////////////////////////////////////////////////////////////////
--// Filename		: acc_GetStringCorrection.sql
--// Author		: James Waygood 
--// Date		: 8th November 2013 
--// Copyright Notice	: (c) 2015 Advanced Business Software & Solutions Ltd. All rights reserved.
--// Description	: Correction to GetString function
--//
--/////////////////////////////////////////////////////////////////////////////
--// Version History:
--//	1	: File Creation
--//
--/////////////////////////////////////////////////////////////////////////////

ALTER TABLE [!ActiveSchema!].[EXCHQCHK] DROP COLUMN
	[Exchqchkcode1Trans1], [Exchqchkcode1Trans2], [Exchqchkcode1Trans3]
  , [Exchqchkcode1Trans4], [Exchqchkcode3Trans1], [Exchqchkcode3Trans3], [CCDescTrans]
GO

ALTER TABLE [!ActiveSchema!].[EXSTKCHK] DROP COLUMN
	[Exstchkvar1Trans1], [Exstchkvar2Trans1], [AccCodeTrans], [LetterLinkData1Trans1]
  , [LetterLinkData1Trans2]
GO

ALTER TABLE [!ActiveSchema!].[MLOCSTK] DROP COLUMN
	[varCode1Trans1], [varCode2Trans1], [BrPayRefTrans1]
GO

ALTER TABLE [!ActiveSchema!].[JOBMISC] DROP COLUMN
	[var_code1Trans1]
GO

ALTER TABLE [!ActiveSchema!].[JOBDET] DROP COLUMN
	[var_code8Trans1], [var_code9Trans1]
GO

ALTER TABLE [!ActiveSchema!].[DOCUMENT] DROP COLUMN
	[thLongYourRefTrans], [thBatchLinkTrans]
GO

ALTER TABLE [!ActiveSchema!].[DETAILS] DROP COLUMN
	[tlStockCodeTrans1]
GO

--Add Binary Coverted Computed Columns for EXCHQCHK
ALTER TABLE [!ActiveSchema!].[EXCHQCHK] ADD
	[Exchqchkcode1Trans1]	AS CAST(SUBSTRING([EXCHQCHKcode1], 2, CAST(SUBSTRING([EXCHQCHKcode1], 1,1) AS INT)) AS VARCHAR(MAX)),
	[Exchqchkcode1Trans2]	AS CAST(SUBSTRING([EXCHQCHKcode1], 10, CAST(SUBSTRING([EXCHQCHKcode1], 9,1) AS INT)) AS VARCHAR(MAX)),
	[Exchqchkcode1Trans3]	AS CAST(SUBSTRING([EXCHQCHKcode1], 7, CAST(SUBSTRING([EXCHQCHKcode1], 6,1) AS INT)) AS VARCHAR(MAX)),
	[Exchqchkcode1Trans4]	AS CAST(SUBSTRING([EXCHQCHKcode1], 4, CAST(SUBSTRING([EXCHQCHKcode1], 3,1) AS INT)) AS VARCHAR(MAX)),
	[Exchqchkcode3Trans1]	AS CAST(SUBSTRING([EXCHQCHKcode3], 10, CAST(SUBSTRING([EXCHQCHKcode3], 9,1) AS INT)) AS VARCHAR(MAX)),
	[Exchqchkcode3Trans3]	AS CAST(SUBSTRING([EXCHQCHKcode3], 2, CAST(SUBSTRING([EXCHQCHKcode3], 1,1) AS INT)) AS VARCHAR(MAX)),
	[CCDescTrans]			AS CAST(SUBSTRING([EXCHQCHKcode3] + CCDesc, 2, CAST(SUBSTRING([EXCHQCHKcode3] + CCDesc, 1,1) AS INT)) AS VARCHAR(MAX))
GO

--Add Binary Coverted Computed Columns for EXSTKCHK
ALTER TABLE [!ActiveSchema!].[EXSTKCHK] ADD
	[Exstchkvar1Trans1]		AS CAST(SUBSTRING([Exstchkvar1], 2, CAST(SUBSTRING([Exstchkvar1], 1,1) AS INT)) AS VARCHAR(MAX)),
	[Exstchkvar2Trans1]		AS CAST(SUBSTRING([Exstchkvar2], 2, CAST(SUBSTRING([Exstchkvar2], 1,1) AS INT)) AS VARCHAR(MAX)),
	[AccCodeTrans]			AS CAST(SUBSTRING([AccCode], 2, CAST(SUBSTRING([AccCode], 1,1) AS INT)) AS VARCHAR(MAX)),
	[LetterLinkData1Trans1]	AS CAST(SUBSTRING([LetterLinkData1], 2, CAST(SUBSTRING([LetterLinkData1], 1,1) AS INT)) AS VARCHAR(MAX)),
	[LetterLinkData1Trans2]	AS CAST(SUBSTRING([LetterLinkData1], (63), CAST(SUBSTRING([LetterLinkData1], 62,1) AS INT)) AS VARCHAR(MAX))
GO

--Add Binary Coverted Computed Columns for MLOCSTK
ALTER TABLE [!ActiveSchema!].[MLOCSTK] ADD
	[varCode1Trans1] AS CAST(SUBSTRING([varCode1], 2, CAST(SUBSTRING([varCode1], 1,1) AS INT)) AS VARCHAR(MAX)),
	[varCode2Trans1] AS CAST(SUBSTRING([varCode2], 2, CAST(SUBSTRING([varCode2], 1,1) AS INT)) AS VARCHAR(MAX)),
	[BrPayRefTrans1] AS CAST(SUBSTRING([BrPayRef], 2, CAST(SUBSTRING([BrPayRef], 1,1) AS INT)) AS VARCHAR(MAX))
GO

--Add Binary Coverted Computed Columns for JOBMISC
ALTER TABLE [!ActiveSchema!].[JOBMISC] ADD
	[var_code1Trans1] AS CAST(SUBSTRING([var_code1], 2, CAST(SUBSTRING([var_code1], 1,1) AS INT)) AS VARCHAR(MAX))
GO

--Add Binary Coverted Computed Columns for JOBDET
ALTER TABLE [!ActiveSchema!].[JOBDET] ADD
	[var_code8Trans1] AS CAST(SUBSTRING([var_code8], 2, CAST(SUBSTRING([var_code8], 1,1) AS INT)) AS VARCHAR(MAX)),
	[var_code9Trans1] AS CAST(SUBSTRING([var_code9], 2, CAST(SUBSTRING([var_code9], 1,1) AS INT)) AS VARCHAR(MAX))
GO

--Add Binary Coverted Computed Columns for Document
ALTER TABLE [!ActiveSchema!].[DOCUMENT] ADD
	[thLongYourRefTrans] AS CAST(SUBSTRING([thLongYourRef], 2, CAST(SUBSTRING([thLongYourRef], 1,1) AS INT)) AS VARCHAR(MAX)),
	[thBatchLinkTrans] AS CAST(SUBSTRING([thBatchLink], 2, CAST(SUBSTRING([thBatchLink], 1,1) AS INT)) AS VARCHAR(MAX))
GO

--Add Binary Coverted Computed Columns for Details
ALTER TABLE [!ActiveSchema!].[DETAILS] ADD
	[tlStockCodeTrans1] AS CAST(SUBSTRING([tlStockCode], 2, CAST(SUBSTRING([tlStockCode], 1,1) AS INT)) AS VARCHAR(MAX))
GO