--/////////////////////////////////////////////////////////////////////////////
--// Filename		: isp_Enable_Foreign_Keys.sql
--// Author		: Chris Sandow
--// Date		: 15 February 2012
--// Copyright Notice	: (c) 2015 Advanced Business Software & Solutions Ltd. All rights reserved.
--// Description	: SQL Script to create stored procedure for the 6.10 release
--//
--/////////////////////////////////////////////////////////////////////////////
--// Version History:
--//	1	 15 February 2012:	File Creation - Chris Sandow
--//
--/////////////////////////////////////////////////////////////////////////////

-- Remove the existing script
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[common].[isp_Enable_Foreign_Keys]') AND type in (N'P', N'PC'))
  DROP PROCEDURE [common].[isp_Enable_Foreign_Keys]
go

CREATE PROCEDURE [common].[isp_Enable_Foreign_Keys]
    @enable BIT = 1
AS
    DECLARE
        @sql VARCHAR(500),
        @tableName VARCHAR(128),
        @tableSchema VARCHAR(128),
        @foreignKeyName VARCHAR(128)

    -- Collect all the foreign keys and table names
    DECLARE foreignKeyCursor CURSOR
    FOR SELECT
        ref.constraint_name AS FK_Name,
        fk.table_name AS FK_Table,
        fk.table_schema AS FK_Schema
    FROM
        INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS ref
        INNER JOIN INFORMATION_SCHEMA.TABLE_CONSTRAINTS fk
    ON ref.constraint_name = fk.constraint_name
    ORDER BY
        fk.table_schema,
        fk.table_name,
        ref.constraint_name

    OPEN foreignKeyCursor

    FETCH NEXT FROM foreignKeyCursor
    INTO @foreignKeyName, @tableName, @tableSchema

    WHILE ( @@FETCH_STATUS = 0 )
        BEGIN
            IF @enable = 1
                SET @sql = 'ALTER TABLE ['
                    + @tableSchema + '].['
                    + @tableName + '] CHECK CONSTRAINT ['
                    + @foreignKeyName + ']'
            ELSE
                SET @sql = 'ALTER TABLE ['
                    + @tableSchema + '].['
                    + @tableName + '] NOCHECK CONSTRAINT ['
                    + @foreignKeyName + ']'

        EXECUTE(@sql)
        FETCH NEXT FROM foreignKeyCursor
        INTO @foreignKeyName, @tableName, @tableSchema
    END

    CLOSE foreignKeyCursor
    DEALLOCATE foreignKeyCursor

