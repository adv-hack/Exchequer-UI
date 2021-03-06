--/////////////////////////////////////////////////////////////////////////////
--// Filename		: ifn_HexToInt.sql
--// Author		: Nilesh Desai 
--// Date		: 14th July 2008 
--// Copyright Notice	: (c) 2015 Advanced Business Software & Solutions Ltd. All rights reserved.
--// Description	: SQL Script to add ifn_HexToInt function to get Int Value for given Hex
--// Execute     : SELECT [common].[ifn_HexToInt] (25)
--//
--/////////////////////////////////////////////////////////////////////////////
--// Version History:
--//	1	: File Creation
--//
--/////////////////////////////////////////////////////////////////////////////

IF  EXISTS ( SELECT TOP 1 1  
			 FROM	dbo.sysobjects 
			 WHERE	id = OBJECT_ID(N'[common].[ifn_IntToHex]') 
			 AND xtype in (N'FN', N'IF', N'TF')
			)

	DROP FUNCTION [common].[ifn_IntToHex]

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [common].[ifn_IntToHex](@intValue as int)		-- @Hex As varbinary(4) Output)
RETURNS VARBINARY(4) as
BEGIN
      DECLARE @HexDigits as char(16)
      DECLARE @Hex as varchar(16)
      DECLARE @HexBinary as VARBINARY(4)

      SET @HexDigits = '0123456789ABCDEF'
      
      SET @Hex = ''
      WHILE @intValue > 16
         BEGIN
           SET @Hex = SubString(@HexDigits, (@intValue % 16) + 1, 1) + @Hex
           SET @intValue = @intValue / 16
         End
      
      SET @Hex = SubString(@HexDigits, @intValue + 1, 1) + @Hex

	  SET @Hex = SPACE(4-LEN(@Hex)) + @Hex						-- Adding Space before 
	
	  SET @Hex = REPLACE( @Hex, ' ', '0')						-- Addind '0' before hex values
	
	  SET @HexBinary = CONVERT(VARBINARY(4), @Hex)

      RETURN @HexBinary
END
