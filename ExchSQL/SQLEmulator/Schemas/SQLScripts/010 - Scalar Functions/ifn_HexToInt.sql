--/////////////////////////////////////////////////////////////////////////////
--// Filename		: ifn_HexToInt.sql
--// Author		: Nilesh Desai 
--// Date		: 14th July 2008 
--// Copyright Notice	: (c) 2015 Advanced Business Software & Solutions Ltd. All rights reserved.
--// Description	: SQL Script to add ifn_HexToInt function to get Hex Value for given Int
--// Execute		: SELECT [common].[ifn_HexToInt] (0x30303139)
--//
--/////////////////////////////////////////////////////////////////////////////
--// Version History:
--//	1	: File Creation
--//
--/////////////////////////////////////////////////////////////////////////////

IF  EXISTS ( SELECT TOP 1 1  
			 FROM	dbo.sysobjects 
			 WHERE	id = OBJECT_ID(N'[common].[ifn_HexToInt]') 
			 AND xtype in (N'FN', N'IF', N'TF')
			)

	DROP FUNCTION [common].[ifn_HexToInt]

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [common].[ifn_HexToInt] ( @Hex varchar(16) )
RETURNS INT
AS BEGIN
    DECLARE @i      tinyint,
            @Nibble tinyint,
            @ch     char(1),
            @Result bigint

    SET @i      = 1                                                     -- Init nibble counter
    SET @Result = 0                                                     -- Init output parameter

    SET @Hex     = UPPER( LTRIM( RTRIM( @Hex ) ) )                      -- Convert to uppercase

    WHILE (@i <= LEN(@Hex))
    BEGIN
        SET @ch = SUBSTRING(@Hex, @i, 1)

        IF      (@ch >= '0' AND @ch <= '9') SET @Nibble = ASCII(@ch) - ASCII('0')
        ELSE IF (@ch >= 'A' AND @ch <= 'F') SET @Nibble = ASCII(@ch) - ASCII('A') +10
        ELSE RETURN NULL                                                -- Invalid Hex disgit

        IF( @Result > 0x7FFFFFFFFFFFFFF)
        BEGIN
            SET @Result = @Result & 0x7FFFFFFFFFFFFFF                   -- Set MSB, of 15 nibbles, OFF
            SET @Result = @Result * 16 + @Nibble +0x8000000000000000    -- Shift left 4Bits, Add last nibble and convert to negetive number.
        END
        ELSE BEGIN
           SET @Result = @Result *16 +@Nibble                           -- Shift left 4Bits, Add nibble.
        END

        SET @i = @i +1                                                  -- Next nibble.
    END -- While

    RETURN ( @Result )
END -- Function

