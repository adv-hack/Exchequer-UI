-- Tools Menu User Access
SELECT items.[recordtype]
      ,items.[midescription]
      ,users.[uxusername]
      ,items.[mifoliono]
      ,items.[miavailability]
      ,items.[micompany]
      ,items.[miitemtype]
      ,items.[mifilename]
      ,items.[mistartdir]
      ,items.[miparameters]
      ,items.[mihelptext]
      ,items.[miallusers]
      ,items.[miallcompanies]
      ,items.[micomponentname]
      ,items.[miparentcomponentname]
      ,items.[miposition]
      ,users.[uxitemfolio]
FROM [common].[TOOLS] AS items
INNER JOIN common.TOOLS AS users ON users.uxitemfolio = items.mifoliono
WHERE items.recordtype = 'M'
ORDER BY mifoliono, uxusername