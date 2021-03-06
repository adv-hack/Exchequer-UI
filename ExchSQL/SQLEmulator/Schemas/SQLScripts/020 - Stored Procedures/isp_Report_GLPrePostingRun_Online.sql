--/////////////////////////////////////////////////////////////////////////////
--// Filename		: isp_Report_GLPrePostingRun_Online.sql
--// Author		: 
--// Date		: 
--// Copyright Notice	: (c) 2015 Advanced Business Software & Solutions Ltd. All rights reserved.
--// Description	: SQL Script to add isp_Report_GLPrePostingRun_Online stored procedure
--//
--/////////////////////////////////////////////////////////////////////////////
--// Version History:
--//	1	: File Creation
--//  2 : PKR. 11/01/2016. ABSEXCH-17096. Added thIntrastatOutOfPeriod for Intrastat.
--//  3 : PKR. 27/01/2016. ABSEXCH-17160. Removed thIntrastatOutOfPeriod. Added tlVATCode.
--//  4 : JW   21/06/2016. ABSEXCH-17613. Changed inner join to left outer join on CUSTSUPP
--/////////////////////////////////////////////////////////////////////////////

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[!ActiveSchema!].[isp_Report_GLPrePostingRun_Online]') AND type in (N'P', N'PC'))
	drop procedure [!ActiveSchema!].[isp_Report_GLPrePostingRun_Online]
go

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [!ActiveSchema!].[isp_Report_GLPrePostingRun_Online]
	(	
	@intReportMode					int				= 0,		-- See comment below
	@intPostingRunNumber			int				= 0
	)
as

-- ReportMode is one of
-- 0 – All			(SIN,SRC,SCR,SJI,SJC,SRF,SRI,SOR,SDN,SBT,PIN,PPY,PCR,PJI,PJC,PRF,PPI,POR,PDN,PBT)
-- 1 – Sales		(SIN,SRC,SCR,SJI,SJC,SRF,SRI,SOR,SDN,SBT)
-- 2 – Purchase		(PIN,PPY,PCR,PJI,PJC,PRF,PPI,POR,PDN,PBT)
-- 3 – Nominal		(NMT)
-- 4 - Stock Adj	(ADJ)
-- Plus 30 (NOM) for All and 31 (RUN) to all

--
-- Select the data
------------------

-- If any fields are added to the output or the source is changed (i.e. from details to document) 
-- the fields MUST be added to the <TABLENAME>_Index10_Report_GLPrePosting index INCLUDE fields otherwise
-- performance may be seriously degraded.

select 
	dt.tlGLCode, 
	n.glName, 
	d.thOurRef,
	case dt.tlDocType
		when 31 then ''
		else dt.tlLineDate
	end											as tlLineDate,
	dt.tlDocType,
	dt.tlAcCode,	
	dt.tlPeriod, 
	dt.tlYear,
	dt.tlDescription,
	common.ifn_ExchRnd(dt.tlPreviousBalance,2)	as PreviousBalance,
	dt.tlNetValue,						
	dt.tlCurrency,
	dt.tlCompanyRate,
	dt.tlDailyRate,
	dt.tlUseOriginalRates,
	dt.tlDiscount,
	dt.tlDiscFlag,       
	dt.tlDiscount2Chr,
	dt.tlDiscount2, 
	dt.tlDiscount3Chr,    
	dt.tlDiscount3,             
	dt.tlQtyMul,                
	dt.tlQty,                   
	dt.tlUsePack,
	dt.tlShowCase,
	dt.tlPrxPack,
	dt.tlQtyPack,
	dt.tlPriceMultiplier,
	dt.tlPaymentCode,	
	dt.tlCostCentre,
	dt.tlDepartment,
	dt.tlJobCode,
	dt.tlAnalysisCode,
  dt.tlVATCode,
  cs.acECMember
from 
	-- Using a query hint for the removal of doubt. Index is definately optimal (assuming no changes, as noted above)
	-- though, without the query hint, in some cases the execution plan will ignore it
	-- and employs a table scan which is seriously sub optimal.
	[!ActiveSchema!].DETAILS dt with (index([DETAILS_Index10_Report_GLPrePosting]))					-- Query hint. See comment above.
left outer join																			-- Need a left join as not everything will have a corresponding DOCUMENT entry
	[!ActiveSchema!].DOCUMENT d with (index([DOCUMENT_Index10_Report_GLPrePosting]))					-- Query hint. See comment above.
	on dt.tlOurRef = d.thOurRef 
	and dt.tlFolioNum = d.thFolioNum 	
	and dt.tlRunNo = d.thRunNo 
inner join
	[!ActiveSchema!].NOMINAL n on dt.tlGLCode = n.glCode
inner join 
	[!ActiveSchema!].CURRENCY curr on curr.CurrencyCode = dt.tlCurrency
left outer join
	[!ActiveSchema!].CUSTSUPP cs on cs.acCode = d.thAcCode
where
	-- Folio number greater than or equal zero
	dt.tlFolioNum >= 0
	
	-- GLCode must be non-zero
	and dt.tlGLCode > 0
	
	-- Must be currency zero if doc type is RUN
	and 
	(
		(dt.tlDocType = 31 and dt.tlCurrency = 0)
		or (dt.tlDocType <> 31)
	)

	-- Match on run number in header or detail		
	and
	(
		dt.tlRunNo = @intPostingRunNumber			
		and 
		(
			dt.tlDocType = 31 or d.thRunNo = @intPostingRunNumber
		)		
	)

	-- Report mode dictates which doc types can appear. Note we have added 30 (NOM) to 0 and 31 (RUN) to all
	-- Whilst this looks a bit horrid it, perhaps surprisingly, performs better across the range of variables
	-- than creating a temp table and doing an inner join	
	and
	 charindex(',' + cast(dt.tlDocType as varchar) + ',', 
		(
		case @intReportMode
			when 0 then ',0,1,2,3,4,5,6,8,9,10,15,16,17,18,19,20,21,22,23,24,25,30,31,'
			when 1 then ',0,1,2,3,4,5,6,8,9,10,31,'				-- SIN(0), SRC(1), SCR(2), SJI(3), SJC(4), SRF(5), SRI(6), SOR(8), SDN(9), SBT(10)
			when 2 then ',15,16,17,18,19,20,21,23,24,25,31,'	-- PIN(15),PPY(16),PCR(17),PJI(18),PJC(19),PRF(20),PPI(21),POR(23),PDN(24),PBT(25)
			when 3 then ',30,31,'								-- NMT(30)
			when 4 then ',35,31,'								-- ADJ(35)
		end
		)) >0
	
	-- Not on hold unless a prior run
	and
	(
		(@intPostingRunNumber > 0) 
		or
		(@intPostingRunNumber = 0 and isnull(d.thHoldFlag,0) in (0, 3, 32, 35))
	)		
order by 
	dt.tlGLCode,
	dt.tlLineDate,
	dt.tlOurRef,	
	dt.PositionId

-- Including the optimize option to create an exection plan which is optimal for
-- all posting run numbers. If this is omitted then an execution plan for a non zero
-- posting run is seriously sub optimal when run again with @intPostingRunNumber = 0
-- but a plan for @intPostingRunNumber = 0 is perfectly good for @intPostingRunNumber > 0
option 
	(optimize for (@intReportMode=0, @intPostingRunNumber = 0))

go