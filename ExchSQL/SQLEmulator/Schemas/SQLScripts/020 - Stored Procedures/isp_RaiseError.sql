--/////////////////////////////////////////////////////////////////////////////
--// Filename		: isp_RaiseError.sql
--// Author		: Nilesh Desai
--// Date		: 7 July 2008
--// Copyright Notice	: (c) 2015 Advanced Business Software & Solutions Ltd. All rights reserved.
--// Description	: SQL Script to add isp_RaiseError stored procedure
--// Usage : EXEC [common].[isp_RaiseError] 
--//
--/////////////////////////////////////////////////////////////////////////////
--// Version History:
--//	1	: File Creation
--//
--/////////////////////////////////////////////////////////////////////////////

IF EXISTS ( SELECT	TOP 1 1
		    FROM    dbo.sysobjects 
		    WHERE	id = OBJECT_ID(N'[common].[isp_RaiseError]') 
			AND		OBJECTPROPERTY(id,N'IsProcedure') = 1
  )

DROP PROCEDURE [common].[isp_RaiseError]

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [common].[isp_RaiseError](  @iv_IRISExchequerErrorMessage NVARCHAR(1000) = ''
                                          , @iv_ErrorNumber      INT			= 0
                                          , @iv_ErrorCode        VARCHAR(10)    = 'E_GENERAL'
                                          , @iv_ErrorSeverity    INT            = 16
                                          , @iv_ErrorMessage     NVARCHAR(1000) = '')

AS
BEGIN
  DECLARE @ErrorMessage   NVARCHAR(1000)
        , @DisplayMessage NVARCHAR(1000)
        , @ErrorNumber    INT
        , @ErrorSeverity  INT
        , @ErrorState     INT
        , @ErrorLine      INT
        , @ErrorProcedure NVARCHAR(400)
        , @ReturnValue    INT

  -- Assign variables to error-handling functions to 
  -- capture information for RAISERROR.

  SELECT @ErrorNumber    = ISNULL(ERROR_NUMBER(), @iv_ErrorNumber)
       , @ErrorSeverity  = ISNULL(ERROR_SEVERITY(), @iv_ErrorSeverity)
       , @ErrorState     = ISNULL(ERROR_STATE(), 1)
       , @ErrorLine      = ISNULL(ERROR_LINE(), 1)
       , @ErrorMessage   = ISNULL(ERROR_MESSAGE(),  '')
       , @ErrorProcedure = ISNULL(ERROR_PROCEDURE(), '')

  -- Imbed procedure name in error message if applicable.
  IF(@ErrorProcedure IS NULL)
  BEGIN
    SELECT @ErrorProcedure = ''
  END
  ELSE
  BEGIN
    SELECT @ErrorProcedure = N' Procedure ' + RTRIM(@ErrorProcedure) + ','
  END

  IF (@ErrorMessage = '')
  BEGIN
    SELECT @ErrorMessage = @iv_ErrorMessage
  END

  -- Get Message Info.
  SELECT @DisplayMessage = ''

  -- Get USer define message defined in table the fetch and display that message
  /* write code in this block : for fetch and display user define error messages 
	 if we find user define message then set error message to variable @DisplayMessage
  */	

  -- Building the message string which will contain original
  SELECT @DisplayMessage =	@DisplayMessage + 
							CASE WHEN LEN(LTRIM(RTRIM(@DisplayMessage))) > 0 THEN ' - ' ELSE '' END + 
							@iv_IRISExchequerErrorMessage + 
							CASE WHEN LEN(LTRIM(RTRIM(@iv_IRISExchequerErrorMessage))) > 0 THEN ' - ' ELSE '' END + 
							@ErrorMessage
						   

  -- parameter of RAISERROR.
  RAISERROR (   @DisplayMessage
	          , @ErrorSeverity 
              --@ErrorState,  this always seems to be 0, which apparently is out of the range of 1..127
              , 1               -- let's just always pass in a 1, apparently not used by SQL
              , @ErrorNumber    -- parameter: original error number.
              , @ErrorSeverity  -- parameter: original error severity.
              , @ErrorState     -- parameter: original error state.
              , @ErrorProcedure -- parameter: original error procedure name.
              , @ErrorLine		-- parameter: original error line number.
            )   WITH NOWAIT

  -- If we want to Log the an Error [Store into a table]
  /* write code in this block for logging an error to table */		
  RETURN 0
END



