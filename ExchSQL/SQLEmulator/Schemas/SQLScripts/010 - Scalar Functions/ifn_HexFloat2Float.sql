--/////////////////////////////////////////////////////////////////////////////
--// Filename		: ifn_HexFloat2Float.sql
--// Author		: 
--// Date		: 
--// Copyright Notice	: (c) 2015 Advanced Business Software & Solutions Ltd. All rights reserved.
--// Description	: SQL Script to add ifn_HexFloat2Float function
--//
--/////////////////////////////////////////////////////////////////////////////
--// Version History:
--//	1	: File Creation
--//
--/////////////////////////////////////////////////////////////////////////////

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[common].[ifn_HexFloat2Float]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
	drop function [common].[ifn_HexFloat2Float]
go

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create function [common].[ifn_HexFloat2Float]
(
	@strRawHexBinary	char(16),		-- NOTE. Do not include the leading 0x
	@bitReverseBytes	bit	
)
RETURNS FLOAT
AS
BEGIN

-- Reverse bytes if required
-- e.g. 3F F4 00 00 00 00 00 00 is stored as
--      00 00 00 00 00 00 F4 3F
declare @strNewValue	varchar(16)
if @bitReverseBytes = 1
begin	
	set @strNewValue=''	
	declare @intCounter	int
	set @intCounter = 8

	while @intCounter>=0
	begin
		set @strNewValue = @strNewValue + substring(@strRawHexBinary, (@intCounter * 2) + 1,2) 
		set @intCounter = @intCounter - 1
	end	
end

-- Convert the raw string into a binary
declare @binBinaryFloat	binary(8)
set @binBinaryFloat = convert(binary(8),'0x' + isnull(@strNewValue, @strRawHexBinary),1)

-- Sourced from http://www.sqlteam.com/forums/topic.asp?TOPIC_ID=81849	
RETURN	SIGN(CAST(@binBinaryFloat AS BIGINT))
	* (1.0 + (CAST(@binBinaryFloat AS BIGINT) & 0x000FFFFFFFFFFFFF) * POWER(CAST(2 AS FLOAT), -52))
	* POWER(CAST(2 AS FLOAT), (CAST(@binBinaryFloat AS BIGINT) & 0x7ff0000000000000) / 0x0010000000000000 - 1023)
	
	
END