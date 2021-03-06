-- Multibuy Discounts
SELECT [mbdOwnerType]
      ,[mbdAcCode]
      ,[mbdStockCode]
      ,[mbdBuyQtyString]
      ,[mbdCurrency]
      ,[mbdDiscountType]
      ,[mbdStartDate]
      ,[mbdEndDate]
      ,[mbdUseDates]
      ,[mbdBuyQty]
      ,[mbdRewardValue]
FROM ZZZZ01.[MULTIBUY]
ORDER BY mbdAcCode, mbdStockCode
