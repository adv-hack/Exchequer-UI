-- Returns all the Bill of Material items for a specified Stock Folio Number
-- (see the final part of the WHERE clause, and replace 313 with the folio
-- number of the required stock item).
SELECT RecPfix
      ,SubType
      ,StockItem.stCode
      ,CAST(CONVERT(VARBINARY(4), REVERSE(SUBSTRING(CONVERT(VARBINARY(4), EXCHQCHKcode1),2,4))) AS INTEGER) AS StockFolio
      ,CAST(CONVERT(VARBINARY(4), REVERSE(SUBSTRING(CONVERT(VARBINARY(4), EXCHQCHKcode3),2,4))) AS INTEGER) AS BillFolio
      ,QtyUsed
      ,QtyCost
      ,QCurrency
      ,FullStkCode
      ,FreeIssue
      ,QtyTime
      ,BOMItems.*
FROM ZZZZ01.EXCHQCHK
INNER JOIN ZZZZ01.STOCK AS StockItem ON CAST(CONVERT(VARBINARY(4), REVERSE(SUBSTRING(CONVERT(VARBINARY(4), EXCHQCHKcode1),2,4))) AS INTEGER) = StockItem.stFolioNum
INNER JOIN ZZZZ01.STOCK AS BOMItems ON CAST(CONVERT(VARBINARY(4), REVERSE(SUBSTRING(CONVERT(VARBINARY(4), EXCHQCHKcode3),2,4))) AS INTEGER) = BOMItems.stFolioNum
WHERE 
	RecPfix = 'B' AND
	SubType = ASCII('M') AND
	CAST(CONVERT(VARBINARY(4), REVERSE(SUBSTRING(CONVERT(VARBINARY(4), EXCHQCHKcode1),2,4))) AS INTEGER) = 313
ORDER BY EXCHQCHKcode1	
