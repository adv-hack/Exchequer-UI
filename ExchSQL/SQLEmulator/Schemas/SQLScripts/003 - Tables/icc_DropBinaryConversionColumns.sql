--/////////////////////////////////////////////////////////////////////////////
--// Filename		: icc_AddBinaryConversionColumns.sql
--// Author		: 
--// Date		: 
--// Copyright Notice	: (c) 2015 Advanced Business Software & Solutions Ltd. All rights reserved.
--// Description	: SQL Script to remove computed columns for binary fields 
--//
--/////////////////////////////////////////////////////////////////////////////
--// Version History:
--//	1	: File Creation
--//
--/////////////////////////////////////////////////////////////////////////////

IF  EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[!ActiveSchema!].[EXCHQCHK]') AND name = 'Exchqchkcode1Trans1')
BEGIN
ALTER TABLE [!ActiveSchema!].[EXCHQCHK]
	DROP COLUMN [Exchqchkcode1Trans1]
END
GO

IF  EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[!ActiveSchema!].[EXCHQCHK]') AND name = 'Exchqchkcode1Trans2')
BEGIN
ALTER TABLE [!ActiveSchema!].[EXCHQCHK]
	DROP COLUMN [Exchqchkcode1Trans2]
END
GO

IF  EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[!ActiveSchema!].[EXCHQCHK]') AND name = 'Exchqchkcode1Trans3')
BEGIN
ALTER TABLE [!ActiveSchema!].[EXCHQCHK]
	DROP COLUMN [Exchqchkcode1Trans3]
END
GO

IF  EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[!ActiveSchema!].[EXCHQCHK]') AND name = 'Exchqchkcode1Trans4')
BEGIN
ALTER TABLE [!ActiveSchema!].[EXCHQCHK]
	DROP COLUMN [Exchqchkcode1Trans4]
END
GO

IF  EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[!ActiveSchema!].[EXCHQCHK]') AND name = 'Exchqchkcode1Trans5')
BEGIN
ALTER TABLE [!ActiveSchema!].[EXCHQCHK]
	DROP COLUMN [Exchqchkcode1Trans5]
END
GO

IF  EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[!ActiveSchema!].[EXCHQCHK]') AND name = 'Exchqchkcode1Trans6')
BEGIN
ALTER TABLE [!ActiveSchema!].[EXCHQCHK]
	DROP COLUMN [Exchqchkcode1Trans6]
END
GO

IF  EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[!ActiveSchema!].[EXCHQCHK]') AND name = 'Exchqchkcode1Trans7')
BEGIN
ALTER TABLE [!ActiveSchema!].[EXCHQCHK]
	DROP COLUMN [Exchqchkcode1Trans7]
END
GO

IF  EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[!ActiveSchema!].[EXCHQCHK]') AND name = 'Exchqchkcode1Trans8')
BEGIN
ALTER TABLE [!ActiveSchema!].[EXCHQCHK]
	DROP COLUMN [Exchqchkcode1Trans8]
END
GO

IF  EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[!ActiveSchema!].[EXCHQCHK]') AND name = 'Exchqchkcode2Trans1')
BEGIN
ALTER TABLE [!ActiveSchema!].[EXCHQCHK]
	DROP COLUMN [Exchqchkcode2Trans1]
END
GO

IF  EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[!ActiveSchema!].[EXCHQCHK]') AND name = 'Exchqchkcode3Trans1')
BEGIN
ALTER TABLE [!ActiveSchema!].[EXCHQCHK]
	DROP COLUMN [Exchqchkcode3Trans1]
END
GO

IF  EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[!ActiveSchema!].[EXCHQCHK]') AND name = 'Exchqchkcode3Trans2')
BEGIN
ALTER TABLE [!ActiveSchema!].[EXCHQCHK]
	DROP COLUMN [Exchqchkcode3Trans2]
END
GO

IF  EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[!ActiveSchema!].[EXCHQCHK]') AND name = 'Exchqchkcode3Trans3')
BEGIN
ALTER TABLE [!ActiveSchema!].[EXCHQCHK]
	DROP COLUMN [Exchqchkcode3Trans3]
END
GO

IF  EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[!ActiveSchema!].[EXCHQCHK]') AND name = 'QtyUsedTrans')
BEGIN
ALTER TABLE [!ActiveSchema!].[EXCHQCHK]
	DROP COLUMN [QtyUsedTrans]
END
GO

IF  EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[!ActiveSchema!].[EXCHQCHK]') AND name = 'SettledValTrans')
BEGIN
ALTER TABLE [!ActiveSchema!].[EXCHQCHK]
	DROP COLUMN [SettledValTrans]
END
GO

IF  EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[!ActiveSchema!].[EXCHQCHK]') AND name = 'CCDescTrans')
BEGIN
ALTER TABLE [!ActiveSchema!].[EXCHQCHK]
	DROP COLUMN [CCDescTrans]
END
GO

--Drop Existing Binary Computed Columns from EXSTKCHK
IF  EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[!ActiveSchema!].[EXSTKCHK]') AND name = 'Exstchkvar1Trans1')
BEGIN
ALTER TABLE [!ActiveSchema!].[EXSTKCHK]
	DROP COLUMN [Exstchkvar1Trans1]
END
GO

IF  EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[!ActiveSchema!].[EXSTKCHK]') AND name = 'Exstchkvar1Trans2')
BEGIN
ALTER TABLE [!ActiveSchema!].[EXSTKCHK]
	DROP COLUMN [Exstchkvar1Trans2]
END
GO

IF  EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[!ActiveSchema!].[EXSTKCHK]') AND name = 'Exstchkvar2Trans1')
BEGIN
ALTER TABLE [!ActiveSchema!].[EXSTKCHK]
	DROP COLUMN [Exstchkvar2Trans1]
END
GO

IF  EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[!ActiveSchema!].[EXSTKCHK]') AND name = 'LetterLinkData1Trans1')
BEGIN
ALTER TABLE [!ActiveSchema!].[EXSTKCHK]
	DROP COLUMN [LetterLinkData1Trans1]
END
GO

IF  EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[!ActiveSchema!].[EXSTKCHK]') AND name = 'AccCodeTrans')
BEGIN
ALTER TABLE [!ActiveSchema!].[EXSTKCHK]
	DROP COLUMN [AccCodeTrans]
END
GO

IF  EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[!ActiveSchema!].[EXSTKCHK]') AND name = 'LetterLinkData1Trans2')
BEGIN
ALTER TABLE [!ActiveSchema!].[EXSTKCHK]
	DROP COLUMN [LetterLinkData1Trans2]
END
GO

IF  EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[!ActiveSchema!].[EXSTKCHK]') AND name = 'LetterLinkData2Trans1')
BEGIN
ALTER TABLE [!ActiveSchema!].[EXSTKCHK]
	DROP COLUMN [LetterLinkData2Trans1]
END
GO

--Drop Existing Binary Computed Columns from MLOCSTK
IF  EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[!ActiveSchema!].[MLOCSTK]') AND name = 'varCode1Trans1')
BEGIN
ALTER TABLE [!ActiveSchema!].[MLOCSTK]
	DROP COLUMN [varCode1Trans1]
END
GO

IF  EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[!ActiveSchema!].[MLOCSTK]') AND name = 'varCode2Trans1')
BEGIN
ALTER TABLE [!ActiveSchema!].[MLOCSTK]
	DROP COLUMN [varCode2Trans1]
END
GO

IF  EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[!ActiveSchema!].[MLOCSTK]') AND name = 'BrPayRefTrans1')
BEGIN
ALTER TABLE [!ActiveSchema!].[MLOCSTK]
	DROP COLUMN [BrPayRefTrans1]
END
GO

--Drop Existing Binary Computed Columns from JOBMISC
IF  EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[!ActiveSchema!].[JOBMISC]') AND name = 'var_code1Trans1')
BEGIN
ALTER TABLE [!ActiveSchema!].[JOBMISC]
	DROP COLUMN [var_code1Trans1]
END
GO

--Drop Existing Binary Computed Columns from JOBDET
IF  EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[!ActiveSchema!].[JOBDET]') AND name = 'var_code1Trans1')
BEGIN
ALTER TABLE [!ActiveSchema!].[JOBDET]
	DROP COLUMN [var_code1Trans1]
END
GO

IF  EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[!ActiveSchema!].[JOBDET]') AND name = 'var_code1Trans2')
BEGIN
ALTER TABLE [!ActiveSchema!].[JOBDET]
	DROP COLUMN [var_code1Trans2]
END
GO

IF  EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[!ActiveSchema!].[JOBDET]') AND name = 'var_code8Trans1')
BEGIN
ALTER TABLE [!ActiveSchema!].[JOBDET]
	DROP COLUMN [var_code8Trans1]
END
GO

IF  EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[!ActiveSchema!].[JOBDET]') AND name = 'var_code9Trans1')
BEGIN
ALTER TABLE [!ActiveSchema!].[JOBDET]
	DROP COLUMN [var_code9Trans1]
END
GO

--Drop Existing Binary Computed Columns from DOCUMENT
IF  EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[!ActiveSchema!].[DOCUMENT]') AND name = 'thLongYourRefTrans')
BEGIN
ALTER TABLE [!ActiveSchema!].[DOCUMENT]
	DROP COLUMN [thLongYourRefTrans]
END
GO

IF  EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[!ActiveSchema!].[DOCUMENT]') AND name = 'thBatchLinkTrans')
BEGIN
ALTER TABLE [!ActiveSchema!].[DOCUMENT]
	DROP COLUMN [thBatchLinkTrans]
END
GO

--Drop Existing Binary Computed Columns from DETAILS
IF  EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[!ActiveSchema!].[DETAILS]') AND name = 'tlStockCodeTrans1')
BEGIN
ALTER TABLE [!ActiveSchema!].[DETAILS]
	DROP COLUMN [tlStockCodeTrans1]
END
GO

IF  EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[!ActiveSchema!].[DETAILS]') AND name = 'tlStockCodeTrans2')
BEGIN
ALTER TABLE [!ActiveSchema!].[DETAILS]
	DROP COLUMN [tlStockCodeTrans2]
END
GO

IF  EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[!ActiveSchema!].[DETAILS]') AND name = 'tlAcCodeTrans')
BEGIN
ALTER TABLE [!ActiveSchema!].[DETAILS]
	DROP COLUMN [tlAcCodeTrans]
END
GO