--/////////////////////////////////////////////////////////////////////////////
--// Filename		: icc_AddBinaryConversionColumns.sql
--// Author		: 
--// Date		: 
--// Copyright Notice	: (c) 2015 Advanced Business Software & Solutions Ltd. All rights reserved.
--// Description	: SQL Script to add computed columns for binary fields
--//
--/////////////////////////////////////////////////////////////////////////////
--// Version History:
--//	1	: File Creation
--//
--/////////////////////////////////////////////////////////////////////////////

--Add Binary Coverted Computed Columns for EXCHQCHK
ALTER TABLE [!ActiveSchema!].[EXCHQCHK] ADD
	[Exchqchkcode1Trans1]	AS common.GetString([EXCHQCHKcode1],(1)),
	[Exchqchkcode1Trans2]	AS common.GetString([EXCHQCHKcode1],(9)),
	[Exchqchkcode1Trans3]	AS common.GetString([EXCHQCHKcode1],(6)),
	[Exchqchkcode1Trans4]	AS common.GetString([EXCHQCHKcode1],(3)),
	[Exchqchkcode1Trans5]	AS common.GetFolio([EXCHQCHKcode1],(1)),
	[Exchqchkcode1Trans6]	AS common.EntCompLineNo(CAST(SUBSTRING([EXCHQCHKcode1], (6), (4)) AS CHAR(4)), (16), [RecPfix], [SubType]),
	[Exchqchkcode1Trans7]	AS CAST(SUBSTRING(EXCHQCHKcode1, (2), (6)) AS VARCHAR),
	[Exchqchkcode1Trans8]	AS CAST(SUBSTRING(EXCHQCHKcode1, (2), (3)) AS VARCHAR),
	[Exchqchkcode2Trans1]	AS CAST(SUBSTRING(EXCHQCHKcode2, (2), (8)) AS VARCHAR),
	[Exchqchkcode3Trans1]	AS common.GetString([EXCHQCHKcode3],(9)),
	[Exchqchkcode3Trans2]	AS common.GetFolio([EXCHQCHKcode3],(1)),
	[Exchqchkcode3Trans3]	AS common.GetString([EXCHQCHKcode3],(1)),
	[CCDescTrans]			AS common.GetString([EXCHQCHKcode3] + CCDesc,(1)),
	[QtyUsedTrans]			AS common.EntDoubleRecType1([EXCHQCHKcode3],[QtyUsed],[RecPfix],[SubType]), 
	[SettledValTrans]		AS common.EntDoubleRecType2([EXCHQCHKcode3],[SettledVal],[RecPfix],[SubType])
GO

--Add Binary Coverted Computed Columns for EXSTKCHK
ALTER TABLE [!ActiveSchema!].[EXSTKCHK] ADD
	[Exstchkvar1Trans1]		AS common.GetString([Exstchkvar1],(1)),
	[Exstchkvar1Trans2]		AS common.GetFolio([Exstchkvar1],(1)),
	[Exstchkvar2Trans1]		AS common.GetString([Exstchkvar2],(1)),
	[AccCodeTrans]			AS common.GetString([AccCode],(1)),
	[LetterLinkData1Trans1]	AS common.GetString([LetterLinkData1],(1)),
	[LetterLinkData1Trans2]	AS common.GetString([LetterLinkData1],(62)),
	[LetterLinkData2Trans1]	AS CAST(SUBSTRING(LetterLinkdata2,(13),(8)) AS CHAR(8))
GO

--Add Binary Coverted Computed Columns for MLOCSTK
ALTER TABLE [!ActiveSchema!].[MLOCSTK] ADD
	[varCode1Trans1] AS common.GetString([varCode1],(1)),
	[varCode2Trans1] AS common.GetString([varCode2],(1)),
	[BrPayRefTrans1] AS common.GetString([BrPayRef],(1))
GO

--Add Binary Coverted Computed Columns for JOBMISC
ALTER TABLE [!ActiveSchema!].[JOBMISC] ADD
	[var_code1Trans1] AS common.GetString([var_code1],(1))
GO

--Add Binary Coverted Computed Columns for JOBDET
ALTER TABLE [!ActiveSchema!].[JOBDET] ADD
	[var_code1Trans1] AS CAST(SUBSTRING([var_code1], (2), (6)) AS CHAR(6)), 
	[var_code1Trans2] AS CAST(SUBSTRING([var_code1], (8), (8)) AS CHAR(8)), 
	[var_code8Trans1] AS common.GetString([var_code8],(1)), 
	[var_code9Trans1] AS common.GetString([var_code9],(1))
GO

--Add Binary Coverted Computed Columns for Document
ALTER TABLE [!ActiveSchema!].[DOCUMENT] ADD
	[thLongYourRefTrans] AS common.GetString([thLongYourRef],(1)),
	[thBatchLinkTrans] AS common.GetString([thBatchLink],(1))
GO

--Add Binary Coverted Computed Columns for Details
ALTER TABLE [!ActiveSchema!].[DETAILS] ADD
	[tlStockCodeTrans1] AS common.GetString([tlStockCode],(1)),
	[tlStockCodeTrans2] AS CAST(SUBSTRING(tlStockCode, 8, 13) AS VARCHAR(13)),
	[tlAcCodeTrans] AS tlacCode collate SQL_Latin1_General_CP1_CI_AS
GO
