--/////////////////////////////////////////////////////////////////////////////
--// Filename		: isp_PostToHistory.sql
--// Author		: 
--// Date		: 
--// Copyright Notice	: (c) 2015 Advanced Business Software & Solutions Ltd. All rights reserved.
--// Description	: SQL Script to add isp_PostToHistory stored procedure
--//
--/////////////////////////////////////////////////////////////////////////////
--// Version History:
--//	1	: File Creation
--//
--/////////////////////////////////////////////////////////////////////////////

-- TODO Add structured exception handling
-- TODO Remove CONVERT from WHERE clause

IF  EXISTS (
  SELECT 
    * 
  FROM 
    dbo.sysobjects 
  WHERE 
    id = OBJECT_ID(N'[!ActiveSchema!].[isp_PostToHistory]') 
    AND OBJECTPROPERTY(id,N'IsProcedure') = 1
    )
  DROP PROCEDURE [!ActiveSchema!].[isp_PostToHistory]


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [!ActiveSchema!].[isp_PostToHistory](
    @iv_Type                INT
  , @iv_Code                VARBINARY(21)
  , @iv_Purchases           FLOAT
  , @iv_Sales               FLOAT
  , @iv_Cleared             FLOAT
  , @iv_Value1              FLOAT
  , @iv_Value2              FLOAT
  , @iv_Currency            INT
  , @iv_Year                INT
  , @iv_Period              INT
  , @iv_DecimalPlaces       INT
  , @ov_PreviousBalance     FLOAT OUTPUT
  , @ov_ErrorMessageCode    INT   OUTPUT
  )
AS
BEGIN
  SET NOCOUNT ON

  DECLARE 
      @ReturnValue    INT
    , @Error          INT
    , @TraceMessage   VARCHAR(255)
    , @ComputedCode   VARBINARY(20)
    , @DecimalPlaces  INT
    , @PositionId     INT

  SELECT
      @ov_ErrorMessageCode  = 0
    , @ov_PreviousBalance   = 0
    , @ReturnValue          = 0
    , @Error                = 0
    , @TraceMessage         = ''
    , @ComputedCode         = CONVERT(VARBINARY(20), SUBSTRING(@iv_Code, 2, 20), 0)
    , @DecimalPlaces        = 2
    , @PositionId           = 0

  -- Declare and define constants
  DECLARE
      @c_StkStkCode     INT
    , @c_StkBillCode    INT
    , @c_StkDListCode   INT
    , @c_StkGrpCode     INT
    , @c_StkDescCode    INT
    , @c_StkStkQCode    INT
    , @c_StkBillQCode   INT
    , @c_StkDLQCode     INT
    , @c_CuStkHistCode  INT
    , @c_CommitHCode    INT
    , @c_JobGrpCode     INT
    , @c_JobJobCode     INT

  SELECT
      @c_StkStkCode     = 80
    , @c_StkBillCode    = 77
    , @c_StkDListCode   = 88
    , @c_StkGrpCode     = 71
    , @c_StkDescCode    = 68
    , @c_StkStkQCode    = 239
    , @c_StkBillQCode   = 236
    , @c_StkDLQCode     = 247
    , @c_CuStkHistCode  = 69
    , @c_CommitHCode    = 91
    , @c_JobGrpCode     = 75
    , @c_JobJobCode     = 74
      
  SELECT @PositionId = [!ActiveSchema!].ifn_GetHistoryPositionId(
      @iv_Type
    , @iv_Code
    , @iv_Currency
    , @iv_Year
    , @iv_Period
    )

  IF @PositionId = 0
  BEGIN

    EXEC @Error = [!ActiveSchema!].[isp_AddHistory]
        @iv_Type
      , @iv_Code
      , @iv_Currency
      , @iv_Year
      , @iv_Period
      , @ov_PositionId = @PositionId OUTPUT

  END

  -- Update the row
  -- TODO Include determination of hiExCLass when PositionId determined?
  IF @PositionId <> 0
  BEGIN
    SELECT
      @DecimalPlaces = CASE
        WHEN hiExCLass IN (
            @c_StkStkCode
          , @c_StkBillCode
          , @c_StkDListCode
          , @c_StkGrpCode
          , @c_StkDescCode
          , @c_StkStkQCode
          , @c_StkBillQCode
          , @c_CuStkHistCode
          , @c_CommitHCode
          , @c_JobGrpCode
          , @c_JobJobCode
          )
        THEN
          @iv_DecimalPlaces
        ELSE
          @DecimalPlaces
        END
    FROM
      [!ActiveSchema!].[HISTORY]
    WHERE
      PositionId = @PositionId

    BEGIN TRY

      SELECT
        @ov_PreviousBalance = hiPurchases - hiSales
      FROM        
        [!ActiveSchema!].[HISTORY]
      WHERE
        PositionId = @PositionId

      UPDATE 
        [!ActiveSchema!].[HISTORY]
      SET
          hiPurchases = common.ifn_ExchRnd((hiPurchases + common.ifn_ExchRnd(@iv_Purchases, 2)), 2)
        , hiSales     = common.ifn_ExchRnd((hiSales + common.ifn_ExchRnd(@iv_Sales, 2)), 2)
        , hiCleared   = common.ifn_ExchRnd((hiCleared + common.ifn_ExchRnd(@iv_Cleared, @DecimalPlaces)), @DecimalPlaces)
        , hiValue1    = common.ifn_ExchRnd((hiValue1 + common.ifn_ExchRnd(@iv_Value1, @DecimalPlaces)), @DecimalPlaces)
        , hiValue2    = common.ifn_ExchRnd((hiValue2 + common.ifn_ExchRnd(@iv_Value2, @DecimalPlaces)), @DecimalPlaces)
      WHERE
        PositionId = @PositionId

    END TRY

    BEGIN CATCH
     	-- Execute error logging routine
	    EXEC common.isp_RaiseError   @iv_IRISExchequerErrorMessage = 'Procedure [!ActiveSchema!].[isp_PostToHistory]' -- Include optional message...?
		-- SP failed - error raised
		SET @ReturnValue = -1	
    END CATCH
  END

  RETURN @ReturnValue
 
END
GO
