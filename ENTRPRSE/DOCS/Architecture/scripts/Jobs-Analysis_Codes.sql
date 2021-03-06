-- Job Analysis Codes
SELECT CAST(SUBSTRING([var_code1], 2, 10) AS VARCHAR) AS Code
      ,[JAName] AS Description
      ,[JAType] AS [Analysis Type]
      ,[Analysis Type Name] = CASE JAType
						WHEN 1 THEN 'Revenue'
						WHEN 2 THEN 'Overhead'
						WHEN 3 THEN 'Materials'
						WHEN 4 THEN 'Labour'
						ELSE 'Unknown'
					END
      ,[AnalHed] AS [Analysis Category]
      -- CJS 2011-10-18: The following breakdown of the analysis categories is based
      --                 on my investigation of the Exchequer code, and is not
      --                 guaranteed to be completely accurate. Caveat lector!
      ,[Analysis Category Name] = CASE AnalHed
									WHEN  1 THEN 'Revenue'	
									WHEN  2 THEN 'Labour (hours)'	
									WHEN  3 THEN 'Direct Expense 1'	
									WHEN  4 THEN 'Direct Expense 2'	
									WHEN  5 THEN 'Stock Issues'	
									WHEN  6 THEN 'Overheads'	
									WHEN  7 THEN 'Receipts'	
									WHEN  8 THEN 'Work in Progress'	
									WHEN  9 THEN 'Retention S/L'
									WHEN 10 THEN 'Retention P/L'	
									WHEN 11 THEN 'Sub Labour'
									WHEN 12 THEN 'Sub Materials'	
									WHEN 13 THEN 'Overheads 2'
									WHEN 14 THEN 'Sales Deductions	'
									WHEN 15 THEN 'Sales Applications'	
									WHEN 16 THEN 'Purchase Apps'
									WHEN 17 THEN 'Purchase Deductions'
									WHEN 99 THEN 'Profit'	
							 END
      ,[WIPNom1] AS [WiP G/L Code]
      ,[WIPNom2] AS [P&L G/L Code]
      ,[JATag]
      ,[JLinkLT]
      ,[CISTaxRate]
      ,[UpliftP]
      ,[UpliftGL]
      ,[RevenueType]
      ,[JADetType]
      ,[JACalcB4Ret]
      ,[JADeduct]
      ,[JADedApply]
      ,[JARetType]
      ,[JARetValue]
      ,[JARetExp]
      ,[JARetExpInt]
      ,[JARetPres]
      ,[JADedComp]
      ,[JAPayCode]
FROM [ZZZZ01].[JOBMISC]
WHERE RecPfix = 'J' AND SubType = 'A'