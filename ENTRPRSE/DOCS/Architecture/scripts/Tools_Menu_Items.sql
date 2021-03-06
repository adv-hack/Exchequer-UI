-- Tools Menu Items
SELECT [recordtype]
      ,CAST(CONVERT(VARBINARY(4), REVERSE(SUBSTRING(Toolscode1, 2, 4))) AS INTEGER) AS IdxByFolio
      ,CAST(SUBSTRING([Toolscode2], 2, 50) AS VARCHAR) AS IdxByComponentName
      ,CAST(SUBSTRING([Toolscode3], 2, 60) AS VARCHAR) AS IdxAddOrder
      ,[PositionId]
      ,[mifoliono]
      ,[miavailability]
      ,[micompany]
      ,[miitemtype]
      ,ItemType = CASE miitemtype
					 WHEN 'I' THEN 'Menu Item'
					 WHEN 'M' THEN 'Sub-menu'
					 WHEN 'R' THEN 'Report'
					 WHEN 'S' THEN 'Separator'
					 ELSE 'Unknown'
				  END
      ,[midescription]
      ,[mifilename]
      ,[mistartdir]
      ,[miparameters]
      ,[mihelptext]
      ,[miallusers]
      ,[miallcompanies]
      ,[micomponentname]
      ,[miparentcomponentname]
      ,[miposition]
FROM [common].[TOOLS]
WHERE recordtype = 'M'
ORDER BY IdxByFolio