--/////////////////////////////////////////////////////////////////////////////
--// Filename		: isp_Enable_Triggers.sql
--// Author		: Chris Sandow
--// Date		: 15 February 2012
--// Copyright Notice	: (c) 2015 Advanced Business Software & Solutions Ltd. All rights reserved.
--// Description	: SQL Script to create stored procedure for the 6.10 release
--//
--/////////////////////////////////////////////////////////////////////////////
--// Version History:
--//	1	 15 February 2012:	File Creation - Chris Sandow
--//	2	 07 January  2013:  Updated Trigger Select - James Waygood
--//
--/////////////////////////////////////////////////////////////////////////////

-- Remove the existing script
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[common].[isp_Enable_Triggers]') AND type in (N'P', N'PC'))
  DROP PROCEDURE [common].[isp_Enable_Triggers]
go

CREATE PROCEDURE [common].[isp_Enable_Triggers]
    @enable BIT = 1
AS
    DECLARE
        @sql VARCHAR(500),
        @tableName VARCHAR(128),
        @triggerName VARCHAR(128),
        @tableSchema VARCHAR(128)

    -- List of all triggers and tables that exist on them
    DECLARE triggerCursor CURSOR
        FOR
	SELECT 
		sysobjects.name AS TriggerName 
		,OBJECT_NAME(parent_obj) AS TableName 
		,s.name AS TableSchema 
	FROM sysobjects 
		INNER JOIN sys.tables t 
			ON sysobjects.parent_obj = t.object_id 
		INNER JOIN sys.schemas s 
			ON t.schema_id = s.schema_id 
	WHERE sysobjects.type = 'TR' 
	ORDER BY OBJECT_NAME(parent_obj), sysobjects.name 

    OPEN triggerCursor

    FETCH NEXT FROM triggerCursor
    INTO @triggerName, @tableName, @tableSchema

    WHILE ( @@FETCH_STATUS = 0 )
        BEGIN
            IF @enable = 1
                SET @sql = 'ENABLE TRIGGER ['
                    + @triggerName + '] ON '
                    + @tableSchema + '.[' + @tableName + ']'
            ELSE
                SET @sql = 'DISABLE TRIGGER ['
                    + @triggerName + '] ON '
                    + @tableSchema + '.[' + @tableName + ']'

            PRINT 'Executing Statement - ' + @sql
            EXECUTE ( @sql )
            FETCH NEXT FROM triggerCursor
            INTO @triggerName, @tableName,  @tableSchema
        END

    CLOSE triggerCursor
    DEALLOCATE triggerCursor
