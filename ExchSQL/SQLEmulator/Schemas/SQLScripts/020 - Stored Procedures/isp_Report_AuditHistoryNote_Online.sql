--/////////////////////////////////////////////////////////////////////////////
--// Filename		: isp_Report_AuditHistoryNote_Online.sql
--// Author		: 
--// Date		: 
--// Copyright Notice	: (c) 2015 Advanced Business Software & Solutions Ltd. All rights reserved.
--// Description	: SQL Script to add isp_Report_AuditHistoryNote_Online stored procedure
--//
--/////////////////////////////////////////////////////////////////////////////
--// Version History:
--//	1	: File Creation
--//
--/////////////////////////////////////////////////////////////////////////////

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[!ActiveSchema!].[isp_Report_AuditHistoryNote_Online]') AND type in (N'P', N'PC'))
	drop procedure [!ActiveSchema!].[isp_Report_AuditHistoryNote_Online]
go

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [!ActiveSchema!].[isp_Report_AuditHistoryNote_Online]
	(	
	@intOwnerType					tinyint,
	@datStartDate					varchar(8)		= '',			-- YYYYMMDD format
	@datEndDate						varchar(8)		= '',			-- YYYYMMDD format
	@intOrderBy						tinyint			= 0
	)
as

-- OwnerType
-- 0: Customer
-- 1: Supplier
-- 2: Transaction
-- 3: Stock
-- 4: Job

-- OrderBy
-- 0: OwnerCode + Date
-- 1: Date + OwnerCode


-- May split into separate stored procedures dependant upon execution plan caching and performance

-- Note specifed collate in order by as the NoteLine field is a different collation to other fields
-- within the table

--
-- Owner Types 0 and 1 (0: Customer, 1: Supplier)
-------------------------------------------------
if (@intOwnerType = 0 or @intOwnerType = 1)
	begin
		select
			e.Exchqchkcode2Trans1									as NoteDate,			
			right(rtrim(ltrim(e.NoteLine)), 8)						as NoteTime,
			e.Exchqchkcode1Trans7									as OwnerCode,			
			e.NoteLine 
		from 
			[!ActiveSchema!].EXCHQCHK e		
		inner join					
			[!ActiveSchema!].CUSTSUPP cs on e.Exchqchkcode1Trans7 = cs.acCode 
		where
			-- Subtype
			e.SubType = 65
			
			-- Customer or supplier
			and cs.acCustSupp =
				case @intOwnerType 
					when 0 then 'C'
					when 1 then 'S'
				end
				
			-- Start and End Date
			and 
			(
				(@datStartDate = '' or @datStartDate <= e.Exchqchkcode2Trans1)
				and 
				(@datEndDate = '' or @datEndDate >= e.Exchqchkcode2Trans1)				
			)
			
			-- Note type
			and e.NType = 3
			
		order by
			case @intOrderBy
				when 0 then 
					-- OwnerCode then Date
					e.Exchqchkcode1Trans7				collate SQL_Latin1_General_CP1_CI_AS + 
					e.Exchqchkcode2Trans1				collate SQL_Latin1_General_CP1_CI_AS + 
					right(rtrim(ltrim(e.NoteLine)), 8)	collate SQL_Latin1_General_CP1_CI_AS
				when 1 then 
					-- Date then OwnerCode
					e.Exchqchkcode2Trans1				collate SQL_Latin1_General_CP1_CI_AS + 
					right(rtrim(ltrim(e.NoteLine)), 8)	collate SQL_Latin1_General_CP1_CI_AS +  
					e.Exchqchkcode1Trans7				collate SQL_Latin1_General_CP1_CI_AS
			end
	end
--
-- Owner Type 2: Transactions
-----------------------------
else if @intOwnerType = 2
	begin
		select
			t.NoteDate,
			right(rtrim(ltrim(t.NoteLine)), 8)						as NoteTime,
			d.thOurRef												as OwnerCode,
			t.NoteLine 		
		from 
			[!ActiveSchema!].TransactionNote t
		inner join
			[!ActiveSchema!].DOCUMENT d on t.NoteFolio = d.thFolioNum 
		where		
			-- Start and End Date		
			(
				(@datStartDate = '' or @datStartDate <= t.NoteDate)
				and 
				(@datEndDate = '' or @datEndDate >= t.NoteDate)
			)
			
			-- Note type
			and t.NoteType = 3
			
		order by
			case @intOrderBy
				when 0 then 
				 	-- OwnerCode then Date
					d.thOurRef							collate SQL_Latin1_General_CP1_CI_AS + 
					t.NoteDate							collate SQL_Latin1_General_CP1_CI_AS + 
					right(rtrim(ltrim(t.NoteLine)), 8)	collate SQL_Latin1_General_CP1_CI_AS
				when 1 then 
					-- Date then OwnerCode
					t.NoteDate							collate SQL_Latin1_General_CP1_CI_AS +
					right(rtrim(ltrim(t.NoteLine)), 8)	collate SQL_Latin1_General_CP1_CI_AS +
					d.thOurRef 							collate SQL_Latin1_General_CP1_CI_AS	
			end
	end
	
--
-- Owner Type 3: Stock
----------------------
else if @intOwnerType = 3
	begin
		select
			e.Exchqchkcode2Trans1									as NoteDate,			
			right(rtrim(ltrim(e.NoteLine)), 8)						as NoteTime,
			s.stCode												as OwnerCode,			
			e.NoteLine 
		from 
			[!ActiveSchema!].EXCHQCHK e		
		inner join					
			[!ActiveSchema!].STOCK s on e.Exchqchkcode1Trans5 = s.stFolioNum 
		where
			-- Subtype
			e.SubType = 83
			
			-- Start and End Date
			and 
			(
				(@datStartDate = '' or @datStartDate <= e.Exchqchkcode2Trans1)
				and 
				(@datEndDate = '' or @datEndDate >= e.Exchqchkcode2Trans1)				
			)
			
			-- Note type
			and e.NType = 3
			
		order by
			case @intOrderBy
				
				when 0 then 
				-- OwnerCode then Date
					s.stCode							collate SQL_Latin1_General_CP1_CI_AS + 
					e.Exchqchkcode2Trans1				collate SQL_Latin1_General_CP1_CI_AS + 
					right(rtrim(ltrim(e.NoteLine)), 8)	collate SQL_Latin1_General_CP1_CI_AS
				when 1 then 
					-- Date then OwnerCode
					e.Exchqchkcode2Trans1				collate SQL_Latin1_General_CP1_CI_AS + 
					right(rtrim(ltrim(e.NoteLine)), 8)	collate SQL_Latin1_General_CP1_CI_AS + 
					s.stCode							collate SQL_Latin1_General_CP1_CI_AS
			end
	end
	
--
-- Owner Type 4: Job
--------------------
else if @intOwnerType = 4
	begin
		select
			e.Exchqchkcode2Trans1									as NoteDate,			
			right(rtrim(ltrim(e.NoteLine)), 8)						as NoteTime,
			j.JobCode 												as OwnerCode,			
			e.NoteLine 
		from 
			[!ActiveSchema!].EXCHQCHK e		
		inner join					
			[!ActiveSchema!].JOBHEAD j on e.Exchqchkcode1Trans5 = j.JobFolio 
		where
			-- Subtype
			e.SubType = 74
			
			-- Start and End Date
			and 
			(
				(@datStartDate = '' or @datStartDate <= e.Exchqchkcode2Trans1)
				and 
				(@datEndDate = '' or @datEndDate >= e.Exchqchkcode2Trans1)				
			)
			
			-- Note type
			and e.NType = 3
			
		order by
			case @intOrderBy			
				when 0 then
					-- OwnerCode then Date 
					j.JobCode							collate SQL_Latin1_General_CP1_CI_AS +
					e.Exchqchkcode2Trans1 				collate SQL_Latin1_General_CP1_CI_AS +
					right(rtrim(ltrim(e.NoteLine)), 8)	collate SQL_Latin1_General_CP1_CI_AS
				when 1 then 
					-- Date then OwnerCode
					e.Exchqchkcode2Trans1				collate SQL_Latin1_General_CP1_CI_AS + 
					right(rtrim(ltrim(e.NoteLine)), 8)	collate SQL_Latin1_General_CP1_CI_AS + 
					j.JobCode							collate SQL_Latin1_General_CP1_CI_AS 
			end
	end


go