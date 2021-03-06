-- Returns all the Bill of Material items, including the Stock Item
-- details for each one, and showing the Stock Code for the parent
-- Stock Item.
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
	SubType = ASCII('M')
ORDER BY EXCHQCHKcode1	
