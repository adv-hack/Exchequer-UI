--/////////////////////////////////////////////////////////////////////////////
--// Filename		: isp_SortView.sql
--// Author		: Glen Jones
--// Date		: 4 July 2012
--// Copyright Notice	: (c) 2015 Advanced Business Software & Solutions Ltd. All rights reserved.
--// Description	: SQL Script to add isp_SortView stored procedure.
--//                  Returns data as specified from criteria held in SORTVIEW.
--// Usage: EXEC [!ActiveSchema!].isp_SortView 18, @iv_Year = 2008, @iv_Period = 12 @iv_StockCode = 'C9999', @iv_JobCode = 'ABC1'
--//
--/////////////////////////////////////////////////////////////////////////////
--// Version History:
--//  1	:     4 July 2012 : Glen Jones   : File Creation
--//  2 : 4 December 2013 : Chris Sandow : Added Consumer list type (15)
--//  3 :    29 July 2015 : Glen Jones   : ABSEXCH-16459 : Added Order Payment Status
--//
--/////////////////////////////////////////////////////////////////////////////

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[!ActiveSchema!].[isp_SortView]') 
                                           AND OBJECTPROPERTY(id,N'IsProcedure') = 1 )
  DROP PROCEDURE [!ActiveSchema!].[isp_SortView];
GO

CREATE PROCEDURE [!ActiveSchema!].[isp_SortView] (@iv_ViewId INT
                                                 ,@iv_Year   INT = 0
                                                 ,@iv_Period INT = 0
												 ,@iv_StockCode VARCHAR(20) = ''
												 ,@iv_JobCode   VARCHAR(10) = '')
AS
BEGIN

  DECLARE @Period VARCHAR(3)

  SET NOCOUNT ON;
  
  SET @Period = '1' + RIGHT('00' + CONVERT(VARCHAR, @iv_Period), 2)

-- Debug Purposes
-- DECLARE @iv_ViewID INT = 1

DECLARE @SelectString       VARCHAR(max)
      , @WhereString        VARCHAR(max)
      , @OrderString        VARCHAR(max)
      , @Schema             VARCHAR(max)
      , @FieldId            INT
      , @FieldName          VARCHAR(max)
	  , @FieldDataType      VARCHAR(50)
      , @ComparisonTypeId   INT
      , @ComparisonOperator VARCHAR(max)
      , @ComparisonValue    VARCHAR(max)
      , @IsAscending        BIT
      , @RCount             INT
      , @CRLF               VARCHAR(5)
      , @ListType           INT
      , @UserId             VARCHAR(max)
      
SET @Schema = OBJECT_SCHEMA_NAME(@@PROCID)
SET @SelectString = ''
SET @WhereString  = ''
SET @OrderString  = ''

SELECT @ListType = svrListType
     , @UserId   = svrUserId
FROM   ivw_SortViewHeader
WHERE  svrViewId = @iv_ViewId

SET @CRLF = CHAR(13) + CHAR(10)

IF @ListType = 0 -- Customer
BEGIN
  SET @SelectString = N'SELECT acCode
                          , acCostCentre
                          , acCompany
                          , Balance = ROUND(' + @Schema + '.ifn_GetCustValue(0, ' + CONVERT(VARCHAR, @iv_Year) + ', ' + @Period + ', acCode), 2)
						  , acPhone
                     FROM ' + @Schema + '.CUSTSUPP
                     WHERE acSubType = ''C'' '
END

IF @ListType = 1 -- Supplier
BEGIN
  SET @SelectString = N'SELECT acCode
                          , acCostCentre
                          , acCompany
                          , Balance = ROUND(' + @Schema + '.ifn_GetCustValue(0, ' + CONVERT(VARCHAR, @iv_Year) + ', ' + @Period + ', acCode), 2)
						  , acPhone
                     FROM ' + @Schema + '.CUSTSUPP
                     WHERE acSubType = ''S'' '
END
  
IF @ListType = 4 -- Stock List
BEGIN
  SET @SelectString = N'SELECT stCode
                          , stDescLine1
                          , stQtyInStock
                          , stQtyOnOrder
                          , stShowQtyAsPacks
						  , stSalesUnits
						  , stQtyPicked
						  , stQtyAllocated
						  , stQtyPickedWOR
						  , stQtyAllocWOR
                     FROM ' + @Schema + '.STOCK
                     WHERE 1 = 1 '
END

IF @ListType = 5 -- Stock Reorder
BEGIN
  SET @SelectString = N'SELECT stCode
                          , stQtyOnOrder
						  , stSupplier
						  , stQtyMin
                          , stShowQtyAsPacks
						  , stSalesUnits
						  , stPurchaseUnits
						  , stQtyInStock
						  , stQtyPicked
						  , stQtyAllocated
						  , stQtyPickedWOR
						  , stQtyAllocWOR
						  , stQtyMax
						  , stType
                     FROM ' + @Schema + '.STOCK
                     WHERE 1 = 1 '
END

IF @ListType = 6 -- Stock Take
BEGIN
  SET @SelectString = N'SELECT stCode
                          , stDescLine1
						  , stQtyFreeze
						  , stBinLocation
                          , stShowQtyAsPacks
						  , stSalesUnits
						  , stQtyInStock
						  , stQtyPicked
						  , stQtyAllocated
						  , stQtyPickedWOR
						  , stQtyAllocWOR
                     FROM ' + @Schema + '.STOCK
                     WHERE 1 = 1 '
END

IF @ListType = 7 -- Stock Ledger
BEGIN
  SET @SelectString = N'SELECT tlFolioNum
                          , tlLineNo
                          , tlDocType
                          , tlAcCode
                          , tlOurRef
                          , tlLineDate
                          , tlQty
                          , tlQtyPicked
                          , tlQtyMul
                          , tlQtyDel
                          , tlQtyWoff
                          , tlQtyPickedWO
                          , tlCost
                          , tlPaymentCode
                          , tlPriceMultiplier
                          , tlNetValue
                          , tlUsePack
                          , tlPrxPack
                          , tlQtyPack
                          , tlVATIncValue
                          , tlDiscount
                          , tlDiscFlag
                          , tlDiscount2
                          , tlDiscount2Chr
                          , tlDiscount3
                          , tlDiscount3Chr
                          , tlUseOriginalRates
                          , tlCurrency
                     FROM ' + @Schema + '.DETAILS
                     WHERE tlStockCodeTrans1 = ''' + @iv_StockCode + ''''
END

IF @ListType = 8 -- Job Ledger
BEGIN
  SET @SelectString = N'SELECT JobDet.ActCCode
                          , JobDet.LineORef
                          , JobDet.JDate
                          , JobDet.var_code5 AS AnalCode
                          , JobDet.JDDT
                          , JobDet.Qty
                          , JobDet.Charge
                          , CAST(SUBSTRING(JobDet.var_code10, 1, 1) AS INTEGER) AS ActCurr
                          , JobDet.Cost
                          , JobDet.PCRates1
						  , JobDet.PCRates2
                          , JobDet.JUseORate
                          , JobDet.CurrCharge
                          , JobHead.CurrPrice
                          , JobDet.UpliftTotal
						  , JobDet.PositionId
                     FROM ' + @Schema + '.JOBDET
                     JOIN ' + @Schema + '.JOBHEAD ON JOBHEAD.JobCode = JOBDET.JobCode
					 JOIN ' + @Schema + '.DOCUMENT ON DOCUMENT.thFolioNum = JOBDET.LineFolio
					 JOIN ' + @Schema + '.DETAILS  ON DETAILS.tlFolioNum  = JOBDET.LineFolio
					                              AND DETAILS.tlLineNo    = JOBDET.LineNumber
                     WHERE JOBDET.JobCode = ''' + @iv_JobCode + ''''
END

IF @ListType = 9 -- Main Sales Daybook SortView
BEGIN
  SET @SELECTString = N'SELECT thOurRef
                          , thTransDate
						  , thAcCode
						  , Amount = CASE
                                     WHEN thDocType IN (5, 20, 2, 17, 4, 19, 1, 16) 
				                     THEN ((thNetValue + thTotalVAT) - thTotalLineDiscount - (thSettleDiscAmount * thSettleDiscTaken)) * -1
				                     ELSE CASE 
				                          WHEN thDocType IN (8, 23) THEN thTotalOrderOS
                 					      ELSE (thNetValue + thTotalVAT) - thTotalLineDiscount - (thSettleDiscAmount * thSettleDiscTaken)
				                          END
				                     END
						  , HoldFlag = (thHoldFlag - (thHoldFlag & 160))
						  , thYourRef
						FROM ' + @Schema + '.DOCUMENT
						JOIN ' + @Schema + '.CUSTSUPP ON DOCUMENT.thAcCode = CUSTSUPP.AcCode
						WHERE thRunNo = 0
						AND   LEFT(thOurRef, 1) = ''S'' '
END

IF @ListType = 10 -- Sales Quotes Daybook SortView - SQU(7)
BEGIN
  SET @SELECTString = N'SELECT thOurRef
                          , thTransDate
						  , thAcCode
						  , Amount = (thNetValue + thTotalVAT) - thTotalLineDiscount - (thSettleDiscAmount * thSettleDiscTaken)
						  , HoldFlag = (thHoldFlag - (thHoldFlag & 160))
						  , thYourRef
						FROM ' + @Schema + '.DOCUMENT
						JOIN ' + @Schema + '.CUSTSUPP ON DOCUMENT.thAcCode = CUSTSUPP.AcCode
						WHERE thDocType = 7 '
END

IF @ListType = 11 -- Sales Orders Daybook SortView - RunNo = -40
BEGIN
  SET @SELECTString = N'SELECT thOurRef
                          , thTransDate
						  , thAcCode
						  , Amount = CASE
                                     WHEN thDocType IN (5, 20, 2, 17, 4, 19, 1, 16) 
				                     THEN ((thNetValue + thTotalVAT) - thTotalLineDiscount - (thSettleDiscAmount * thSettleDiscTaken)) * -1
				                     ELSE CASE 
				                          WHEN thDocType IN (8, 23) THEN thTotalOrderOS
                 					      ELSE (thNetValue + thTotalVAT) - thTotalLineDiscount - (thSettleDiscAmount * thSettleDiscTaken)
				                          END
				                     END
						  , HoldFlag = (thHoldFlag - (thHoldFlag & 160))
						  , thYourRef
						  , OrderPaymentStatus
						FROM ' + @Schema + '.DOCUMENT
						JOIN ' + @Schema + '.CUSTSUPP ON DOCUMENT.thAcCode = CUSTSUPP.AcCode
                        CROSS APPLY ( VALUES ( (CASE
                            WHEN thOrderPaymentElement = 1 THEN CASE
                                                                WHEN thOrderPaymentFlags = 0 THEN ''U''
                                                                ELSE CASE
                                                                     WHEN thOrderPaymentFlags & 2 = 2 THEN ''A''
                                                                     ELSE ''''
                                                                     END
                                                                   + CASE
                                                                     WHEN thOrderPaymentFlags & 4 = 4 THEN ''C''
                                                                     ELSE ''''
                                                                     END
                                                                   + CASE
                                                                     WHEN thOrderPaymentFlags & 1 = 1 THEN ''P''
                                                                     ELSE ''''
                                                                     END
                                                                END
                            ELSE ''''
                            END
                            )
                        )
               ) OP (OrderPaymentStatus)
						WHERE thRunNo = -40 '
END

IF @ListType = 12 -- Main Purchase Daybook SortView
BEGIN
  SET @SELECTString = N'SELECT thOurRef
                          , thTransDate
						  , thAcCode
						  , Amount = CASE
                                     WHEN thDocType IN (5, 20, 2, 17, 4, 19, 1, 16) 
				                     THEN ((thNetValue + thTotalVAT) - thTotalLineDiscount - (thSettleDiscAmount * thSettleDiscTaken)) * -1
				                     ELSE CASE 
				                          WHEN thDocType IN (8, 23) THEN thTotalOrderOS
                 					      ELSE (thNetValue + thTotalVAT) - thTotalLineDiscount - (thSettleDiscAmount * thSettleDiscTaken)
				                          END
				                     END
						  , HoldFlag = (thHoldFlag - (thHoldFlag & 160))
						  , thYourRef
						FROM ' + @Schema + '.DOCUMENT
						JOIN ' + @Schema + '.CUSTSUPP ON DOCUMENT.thAcCode = CUSTSUPP.AcCode
						WHERE thRunNo = 0
						AND   LEFT(thOurRef, 1) = ''P'' '
END

IF @ListType = 13 -- Purchase Quotes Daybook SortView - PQU(22)
BEGIN
  SET @SELECTString = N'SELECT thOurRef
                          , thTransDate
						  , thAcCode
						  , Amount = (thNetValue + thTotalVAT) - thTotalLineDiscount - (thSettleDiscAmount * thSettleDiscTaken)
						  , HoldFlag = (thHoldFlag - (thHoldFlag & 160))
						  , thYourRef
						FROM ' + @Schema + '.DOCUMENT
						JOIN ' + @Schema + '.CUSTSUPP ON DOCUMENT.thAcCode = CUSTSUPP.AcCode
						WHERE thDocType = 22 '
END

IF @ListType = 14 -- Purchase Orders Daybook SortView - RunNo = -50
BEGIN
  SET @SELECTString = N'SELECT thOurRef
                          , thTransDate
						  , thAcCode
						  , Amount = CASE
                                     WHEN thDocType IN (5, 20, 2, 17, 4, 19, 1, 16) 
				                     THEN ((thNetValue + thTotalVAT) - thTotalLineDiscount - (thSettleDiscAmount * thSettleDiscTaken)) * -1
				                     ELSE CASE 
				                          WHEN thDocType IN (8, 23) THEN thTotalOrderOS
                 					      ELSE (thNetValue + thTotalVAT) - thTotalLineDiscount - (thSettleDiscAmount * thSettleDiscTaken)
				                          END
				                     END
						  , HoldFlag = (thHoldFlag - (thHoldFlag & 160))
						  , thYourRef
						FROM ' + @Schema + '.DOCUMENT
						JOIN ' + @Schema + '.CUSTSUPP ON DOCUMENT.thAcCode = CUSTSUPP.AcCode
						WHERE thRunNo = -50 '
END

IF @ListType = 15 -- Consumer
BEGIN
  SET @SelectString = N'SELECT acCode
                          , acCostCentre
                          , acCompany
                          , Balance = ROUND(' + @Schema + '.ifn_GetCustValue(0, ' + CONVERT(VARCHAR, @iv_Year) + ', ' + @Period + ', acCode), 2)
						  , acPhone
                     FROM ' + @Schema + '.CUSTSUPP
                     WHERE acSubType = ''U'' '
END

DECLARE curSortViewFilter CURSOR FOR SELECT FieldId
                                          , FieldName
										  , FieldDataType
                                          , ComparisonTypeId
                                          , ComparisonOperator
                                          , ComparisonValue
                                     FROM   ivw_SortViewFilterDetail
                                     WHERE  svrViewId = @iv_ViewId

OPEN curSortViewFilter

FETCH NEXT FROM curSortViewFilter INTO @FieldId
                                     , @FieldName
									 , @FieldDataType
                                     , @ComparisonTypeId
                                     , @ComparisonOperator
                                     , @ComparisonValue
                                     
WHILE @@FETCH_STATUS = 0
BEGIN

  -- Check for YearPeriod filtering and modify accordingly

  IF @FieldName = '(((thYear + 1900) * 100) + thPeriod)'
  BEGIN
    SET @ComparisonValue = RIGHT('0' + @ComparisonValue , 6)
    SET @ComparisonValue = RIGHT(@ComparisonValue, 4) + LEFT(@ComparisonValue, 2)
  END

  SELECT @WhereString = @WhereString 
                    + @CRLF
                    + ' AND ' + CASE 
                                WHEN @FieldName = 'ifn_GetCustValue' THEN 'ROUND(' + @Schema + '.' + @FieldName + '(0, ' + CONVERT(VARCHAR, @iv_Year) + ', ' + @Period + ', acCode), 2)'
                                ELSE @FieldName 
                                END
                    + ' '     + @ComparisonOperator
					+ ' '     + CASE @FieldDataType
					            WHEN 'varchar' THEN CASE @ComparisonTypeId
								                    WHEN 6 THEN '''' + @ComparisonValue + '%'''
													WHEN 7 THEN '''%' + @ComparisonValue + '%'''
													ELSE '''' + @ComparisonValue + ''''
													END
								ELSE @ComparisonValue
								END
								 
                    --+ ' '     + CASE ISNUMERIC(@ComparisonValue)
                    --            WHEN 1 THEN @ComparisonValue
                    --            ELSE CASE @ComparisonTypeId
                    --                 WHEN 6 THEN '''' + @ComparisonValue + '%'''
                    --                 WHEN 7 THEN '''%' + @ComparisonValue + '%'''
                    --                 ELSE '''' + @ComparisonValue + ''''
                    --                 END
                    --            END

  FETCH NEXT FROM curSortViewFilter INTO @FieldId
                                       , @FieldName
									   , @FieldDataType
                                       , @ComparisonTypeId
                                       , @ComparisonOperator
                                       , @ComparisonValue
END

CLOSE curSortViewFilter
DEALLOCATE curSortViewFilter

-- Now do sorting

-- 23rd July 2012: Sorting not relevent at this point, but may be required in the future.  CS/GJ

--DECLARE curSortViewSort CURSOR FOR SELECT RCount = ROW_NUMBER() OVER (ORDER BY FieldId)
--                                        , FieldId
--                                        , FieldName
--                                        , IsAscending
--                                   FROM   ivw_SortViewSortDetail
--                                   WHERE  svrViewId = @iv_ViewId
--                                   ORDER BY RowNo

--OPEN curSortViewSort

--FETCH NEXT FROM curSortViewSort INTO @RCount
--                                   , @FieldId
--                                   , @FieldName
--                                   , @IsAscending
                                     
--WHILE @@FETCH_STATUS = 0
--BEGIN

--  SELECT @OrderString = @OrderString 
--                      + @CRLF
--                      + CASE @Rcount
--                        WHEN 1 THEN ' ORDER BY ' 
--                        ELSE ' , '
--                        END
--                      + CASE @FieldName
--                        WHEN 'ifn_GetCustValue' THEN 'ROUND(' + @Schema + '.' + @FieldName + '(0, ' + CONVERT(VARCHAR, @iv_Year) + ', ' + @Period + ', acCode), 2)'
--                        ELSE @FieldName 
--                        END
--                      + ' ' 
--                      + CASE @IsAscending
--                        WHEN 1 THEN ' '
--                        ELSE ' DESC'
--                        END

--  FETCH NEXT FROM curSortViewSort INTO @Rcount
--                                     , @FieldId
--                                     , @FieldName
--                                     , @IsAscending
--END

--CLOSE curSortViewSort
--DEALLOCATE curSortViewSort

-- Used for Debug purposes
-- PRINT @SelectString + @WhereString + @OrderString

EXEC(@SelectString + @WhereString + @OrderString)

SET NOCOUNT OFF;

END