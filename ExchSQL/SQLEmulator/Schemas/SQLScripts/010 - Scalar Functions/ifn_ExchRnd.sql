--/////////////////////////////////////////////////////////////////////////////
--// Filename		: ifn_ExchRnd.sql
--// Author		: 
--// Date		: 
--// Copyright Notice	: (c) 2015 Advanced Business Software & Solutions Ltd. All rights reserved.
--// Description	: SQL Script to add ifn_ExchRnd function
--//
--/////////////////////////////////////////////////////////////////////////////
--// Version History:
--//	1	: File Creation
--//
--/////////////////////////////////////////////////////////////////////////////

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/* ================================================================
   Description:	ifn_ExchRnd - Exchequer Rounding Function
   ================================================================ */
DECLARE @SQL varchar(max)

IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Common].[ifn_ExchRnd]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
	SET @SQL = 'CREATE FUNCTION [Common].[ifn_ExchRnd]
(
	-- Parameters for the function
	@p1		float,
	@p2		Int
)
RETURNS float
AS
BEGIN
	-- Return variable
	DECLARE @Result	float

	SET @Result = ROUND(CAST(@p1 AS DECIMAL(21,10)), @p2)
	-- Return the result of the function
	RETURN @Result

END'
END

EXEC (@SQL)
GO


