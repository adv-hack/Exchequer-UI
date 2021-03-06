--/////////////////////////////////////////////////////////////////////////////
--// Filename		: isp_LastYtd.sql
--// Author		: 
--// Date		: 
--// Copyright Notice	: (c) 2015 Advanced Business Software & Solutions Ltd. All rights reserved.
--// Description	: SQL Script to add isp_LastYtd stored procedure
--//
--/////////////////////////////////////////////////////////////////////////////
--// Version History:
--//	1	: File Creation
--//
--/////////////////////////////////////////////////////////////////////////////

-- STATUS
-- TODO Add structured exception handling
-- TODO Implement CheckKey functionality

IF  EXISTS (
  SELECT 
    * 
  FROM 
    dbo.sysobjects 
  WHERE 
    id = OBJECT_ID(N'[!ActiveSchema!].[isp_LastYtd]') 
    AND OBJECTPROPERTY(id,N'IsProcedure') = 1
  )
  DROP PROCEDURE [!ActiveSchema!].[isp_LastYtd]


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [!ActiveSchema!].[isp_LastYtd](
    @iv_Code        VARBINARY(21)
  , @iv_Type        INT
  , @iv_Currency    INT
  , @iv_Year        INT
  , @iv_Period      INT
  , @iv_Direction   BIT
  , @ov_PositionId  INT   OUTPUT
  , @ov_Status      BIT   OUTPUT
  )
AS

BEGIN

  SET NOCOUNT ON

	-- Declare and initialise variables
	DECLARE 
      @ReturnCode     INT
	  , @Error          INT
    , @TraceMessage   VARCHAR(255)
    , @ComputedCode   VARBINARY(20)
    , @FoundYear      INT
    , @FoundPeriod    INT
    , @RowFound       INT
  
  SELECT
      @ReturnCode     = 0
	  , @Error          = 0
    , @TraceMessage   = ''
    , @ov_PositionId  = 0
    , @ov_Status      = 0
    , @ComputedCode   = CONVERT(VARBINARY(20), SUBSTRING(@iv_Code, 2, 20), 0)
    , @FoundYear      = NULL
    , @FoundPeriod    = NULL
    , @RowFound       = 0
   

	-- Add the T-SQL statements to compute the return value here
  IF @iv_Direction = 1
    BEGIN
      SELECT TOP 1 
          @ov_PositionId  = PositionId
        , @FoundYear      = hiYear
        , @FoundPeriod    = hiPeriod
      FROM 
        [!ActiveSchema!].[HISTORY]
      WHERE ( 
        -- The next four lines are commented out, as they are rendered irrelevant by CheckKey
        --    ( hiExCLass > @iv_Type )  
        -- OR ( ( hiExCLass = @iv_Type )  AND ( hiCodeComputed > @ComputedCode ) )  
        -- OR ( ( hiExCLass = @iv_Type )  AND ( hiCodeComputed = @ComputedCode )  AND ( hiCurrency > @iv_Currency )  )  
        -- OR 
           ( ( hiExCLass = @iv_Type )  AND ( hiCodeComputed = @ComputedCode )  AND ( hiCurrency = @iv_Currency )  AND ( hiYear > @iv_Year )  )  
        OR ( ( hiExCLass = @iv_Type )  AND ( hiCodeComputed = @ComputedCode )  AND ( hiCurrency = @iv_Currency )  AND ( hiYear = @iv_Year )  AND ( hiPeriod >= @iv_Period )  )  
        )  
      ORDER BY 
          hiExCLass 
	      , hiCodeComputed
	      , hiCurrency 
	      , hiYear 
	      , hiPeriod 
    END
  ELSE
    BEGIN
      SELECT TOP 1 
          @ov_PositionId  = PositionId
        , @FoundYear      = hiYear
        , @FoundPeriod    = hiPeriod
      FROM 
        [!ActiveSchema!].[HISTORY]
	    WHERE ( 
        -- The next four lines are commented out, as they are rendered irrelevant by CheckKey
	      --    ( hiExCLass < @iv_Type )  
	      -- OR ( ( hiExCLass = @iv_Type )  AND ( hiCodeComputed < @ComputedCode )  )  
	      -- OR ( ( hiExCLass = @iv_Type )  AND ( hiCodeComputed = @ComputedCode )  AND ( hiCurrency < @iv_Currency )  )  
	      -- OR 
           ( ( hiExCLass = @iv_Type )  AND ( hiCodeComputed = @ComputedCode )  AND ( hiCurrency = @iv_Currency )  AND ( hiYear < @iv_Year )  )  
	      OR ( ( hiExCLass = @iv_Type )  AND ( hiCodeComputed = @ComputedCode )  AND ( hiCurrency = @iv_Currency )  AND ( hiYear = @iv_Year )  AND ( hiPeriod <= @iv_Period )  )  
	      )  
	    ORDER BY 
	        hiExCLass  DESC 
		    , hiCodeComputed DESC 
		    , hiCurrency  DESC 
		    , hiYear  DESC 
		    , hiPeriod  DESC 
    END

  IF @ov_PositionId <> 0
    SET @RowFound = 1

  IF  (
            (@RowFound = 1)
        -- The next five lines represent the redundant (at least, *here*)
        -- CheckKey functionality, which is now incorporated in the WHERE clause for the GETGE
        -- and GETLE queries, above, simplifying the execution plans and improving performance
        -- AND (
        --           @iv_Type = @FoundType
        --       AND @ComputedCode = @FoundCode
        --       AND @iv_Currency = @FoundCurrency
        --       )
        AND (
                (
                      (@FoundYear <= @iv_Year)
                  AND (@iv_Direction = 0)
                  )
              OR
                (
                      (@FoundYear >= @iv_Year)
                  AND (@iv_Direction = 1)
                  )
              )
        AND (
                  (@FoundPeriod = @iv_Period)
              OR  (@iv_Direction = 1)
              )
        )
    BEGIN
      SET @ov_Status = 1
    END

  IF @ov_Status = 1 AND @iv_Direction = 1
    BEGIN
      IF [!ActiveSchema!].ifn_GetHistoryPositionId(
              @iv_Type
            , @iv_Code
            , @iv_Currency
            , @FoundYear
            , @iv_Period
            ) = 0
        BEGIN
          SET @ov_Status = 0
        END
    END

	-- Return the result of the function
  SET NOCOUNT OFF

  RETURN @ReturnCode

END
GO
