--/////////////////////////////////////////////////////////////////////////////
--// Filename		: isp_PostToYearToDate.sql
--// Author		: 
--// Date		: 
--// Copyright Notice	: (c) 2015 Advanced Business Software & Solutions Ltd. All rights reserved.
--// Description	: SQL Script to add isp_PostToYearToDate stored procedure
--//
--/////////////////////////////////////////////////////////////////////////////
--// Version History:
--//	1	: File Creation
--//
--/////////////////////////////////////////////////////////////////////////////

-- TODO Add structured exception handling

IF  EXISTS (
  SELECT 
    * 
  FROM 
    dbo.sysobjects 
  WHERE 
    id = OBJECT_ID(N'[!ActiveSchema!].[isp_PostToYearToDate]') 
    AND OBJECTPROPERTY(id,N'IsProcedure') = 1
    )
  DROP PROCEDURE [!ActiveSchema!].[isp_PostToYearToDate]


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [!ActiveSchema!].[isp_PostToYearToDate](
    @iv_Type              INT
  , @iv_Code              VARBINARY(21)
  , @iv_Purchases         FLOAT
  , @iv_Sales             FLOAT
  , @iv_Cleared           FLOAT
  , @iv_Value1            FLOAT
  , @iv_Value2            FLOAT
  , @iv_Currency          INT
  , @iv_Year              INT
  , @iv_Period            INT
  , @iv_DecimalPlaces     INT
  , @ov_ErrorMessageCode  INT OUTPUT
  )
AS
BEGIN
  SET NOCOUNT ON

  DECLARE 
      @ReturnCode       INT
    , @Error            INT
    , @TraceMessage     VARCHAR(255)
    , @PreviousBalance  FLOAT
    , @PositionId       INT
    , @Status           BIT
    , @Year             INT
    , @AdjustedYear     INT

  SELECT
      @ov_ErrorMessageCode  = 0
    , @ReturnCode           = 0
    , @Error                = 0
    , @TraceMessage         = ''
    , @PreviousBalance      = 0
    , @PositionId           = 0
    , @Status               = 0
    , @Year                 = 0
    , @AdjustedYear         = 0
  
  EXEC @Error = [!ActiveSchema!].[isp_PostToHistory]
      @iv_Type
    , @iv_Code
    , @iv_Purchases
    , @iv_Sales
    , @iv_Cleared
    , @iv_Value1
    , @iv_Value2
    , @iv_Currency
    , @iv_Year
    , @iv_Period
    , @iv_DecimalPlaces
    , @ov_PreviousBalance = @PreviousBalance OUTPUT
    , @ov_ErrorMessageCode = @ov_ErrorMessageCode OUTPUT

  SET @AdjustedYear = [!ActiveSchema!].[ifn_AdjustYear](@iv_Year, 1)

  EXEC @Error = [!ActiveSchema!].[isp_LastYtd]
      @iv_Code
    , @iv_Type
    , @iv_Currency
    , @AdjustedYear
    , @iv_Period
    , 1
    , @ov_PositionId  = @PositionId OUTPUT
    , @ov_Status      = @Status     OUTPUT

  IF @Status = 1
    BEGIN
      SELECT
        @Year = hiYear
      FROM 
        [!ActiveSchema!].[HISTORY]
      WHERE
        PositionId = @PositionId

      EXEC @Error = [!ActiveSchema!].[isp_PostToYearToDate]
          @iv_Type
        , @iv_Code
        , @iv_Purchases
        , @iv_Sales
        , @iv_Cleared
        , @iv_Value1
        , @iv_Value2
        , @iv_Currency
        , @Year
        , @iv_Period
        , @iv_DecimalPlaces
        , @ov_ErrorMessageCode = @ov_ErrorMessageCode OUTPUT
    END

  RETURN @ReturnCode

END
GO
