-- VRW Report Tree
SELECT reports.rtparentname
      ,reports.[rtrepname]
      ,reports.[rtrepdesc]
      ,reports.[rtfilename]
      ,reports.[rtlastrun]
      ,reports.[rtlastrunuser]
      ,reports.[rtpositionnumber]
      ,reports.[rtindexfix]
      ,reports.[rtallowedit]
      ,reports.[rtfileexists]
FROM [ZZZZ01].[VRWTREE] AS reports
INNER JOIN ZZZZ01.VRWTREE AS headers ON reports.rtparentname = headers.rtrepname
ORDER BY rtparentname, rtpositionnumber