--/////////////////////////////////////////////////////////////////////////////
--// Filename		: isp_OLE_AccountAgedBalance.sql
--// Author		: 
--// Date		: 
--// Copyright Notice	: (c) 2015 Advanced Business Software & Solutions Ltd. All rights reserved.
--// Description	: SQL Script to add isp_OLE_AccountAgedBalance stored procedure
--//
--/////////////////////////////////////////////////////////////////////////////
--// Version History:
--//	1	: File Creation
--//
--/////////////////////////////////////////////////////////////////////////////

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[!ActiveSchema!].[isp_OLE_AccountAgedBalance]') AND type in (N'P', N'PC'))
	drop procedure [!ActiveSchema!].[isp_OLE_AccountAgedBalance]
go

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [!ActiveSchema!].[isp_OLE_AccountAgedBalance]
	(
	@strAccountCode					varchar(6)		= '',
	@strAccountType					char(1)			= 'C',
	@datEffectiveDate				datetime		= null,
	@strAgeBy						char(1)			= 'M',	-- D = Days, W = Weeks, M = Months
	@intAgeingInterval				int				= 1
	)
as

set nocount on

/*
--
-- Debug code
-------------
declare
	@strAccountCode					varchar(max)	= '',
	@strAccountType					char(1)			= 'S',
	@datEffectiveDate				datetime		= getdate,
	@strAgeBy						char(1)			= 'M',	-- D = Days, W = Weeks, M = Months
	@intAgeingInterval				int				= 1
*/

--
-- System settings
------------------

-- Determine whether to
-- 1. Use TransDate or DueDate for report date and ageing date
-- 2. Use Company Rate or Daily Rate for currency conversion
-- Note: I've checked whether performance would be improved by moving these out into the sp parameters but
-- even though execution plan states a cost of 3% it makes no difference to real world timings
declare @bitUseTransDate			bit
declare @bitUseCompanyCurrencyRate	bit
select
	@bitUseTransDate = s.StaUIDate,
	@bitUseCompanyCurrencyRate =
		case s.TotalConv
			when 'V' then 0
			else 1
		end
from
	[!ActiveSchema!].exchqss s
where
	IDCode=0x03535953			-- Translates to SYS

--
-- Internal variables
---------------------

-- Convert AgeBy to int to match parameters for AgedDebtor function so can re-use without modification
declare @intAgeBy int
set @intAgeBy =
	case @strAgeBy
		when 'D' then 1
		when 'W' then 2
		when 'M' then 3
	end

-- Want a temp table so will always return a row if customer code exists, and
-- never return a row if doesn't exist. This allows the validation to be done in the same routine
declare @tblTemp table
	(
	[Code]	varchar(6),
	[P0]	float,
	[P1]	float,
	[P2]	float,
	[P3]	float,
	[P4]	float
	)

-- Put a row in if account exists
insert into @tblTemp
select
	acCode,
	0,
	0,
	0,
	0,
	0
from
	[!ActiveSchema!].CUSTSUPP cs
where
	cs.acCode = @strAccountCode
	and cs.acCustSupp = @strAccountType

--
-- Main data routine
--------------------
update @tblTemp
set
	[P0] = isnull([0],0),
	[P1] = isnull([1],0),
	[P2] = isnull([2],0),
	[P3] = isnull([3],0),
	[P4] = isnull([4],0)
from
(
select
	-1 * common.EntDocSign(d.thDocType) * common.ifn_ExchRnd
		(
			common.ifn_Report_GetTransactionTotal
			(
				d.thNetValue,
				d.thTotalVAT,
				d.thTotalLineDiscount,
				-- Revalue adjustment not included if using company rate and no value
				-- for company rate against the transaction
				case @bitUseCompanyCurrencyRate 
					when 1 then 
						case d.thCompanyRate
							when 0 then 0
							else d.thRevalueAdj
						end
					else d.thRevalueAdj
				end,							
				d.thSettleDiscAmount,
				d.thSettleDiscTaken,
				d.thVariance,
				d.PostDiscAm,
				common.EntDocSign(d.thDoctype) * d.thAmountSettled,
				1,
				case @bitUseCompanyCurrencyRate
					when 1 then
						case d.thCompanyRate
							when 0 then curr.CompanyRate
							else d.thCompanyRate
						end
					else
						case d.thDailyRate
							when 0 then curr.DailyRate
							else d.thDailyRate
						end
				end,
				curr.TriInverted,
				isnull(curr.TriRate,1),
				curr.IsFloating
			),2)																as OutstandingTotal,
	-- AgedPeriod for OLE differs than same calculation for AgedDebtors report in that
	-- period 0 and 1 i.e. Not Due and Current are both reported as 0, and every column
	-- for OLE is value 1 less than corresponding AgedDebtor value.
	case common.ifn_Report_AgedDebtors_Consolidated_GetAgedPeriod
			(
			isnull(@datEffectiveDate, getdate()),
			case @bitUseTransDate
				when 1 then convert(datetime,d.thTransDate,103)
				else convert(datetime,d.thDueDate,103)
			end,
			@intAgeBy,
			@intAgeingInterval
			)
			when 0 then 0
			when 1 then 0
			when 2 then 1
			when 3 then 2
			when 4 then 3
			when 5 then 4
	end 																				as AgeColumn
from
	[!ActiveSchema!].DOCUMENT d
inner join [!ActiveSchema!].CUSTSUPP c
	on c.acCode = d.thAcCode
inner join [!ActiveSchema!].CURRENCY curr
	on curr.CurrencyCode = d.thCurrency
where
	-- Customer code
	d.thAcCodeComputed = @strAccountCode

	-- Document type is as specified, C for customer, S for supplier
	and d.thCustSupp = @strAccountType

	-- Run number non negative
	and (d.thRunNo >= 0)

	-- Document type not SQU or PQU
	and (d.thDocType not in (7,22))

	-- Document hold not set.
	and
		(
			d.thRunNo > 0
		or
			(not d.thHoldFlag in (1, 33, 129))
		)

	-- Exclude auto transactions
	and d.thNomAuto = 1
) as SourceTable
PIVOT
(
SUM(OutstandingTotal)
for AgeColumn in ([0],[1],[2],[3],[4])
)
as PivotTable


--
-- Data return
--------------
select
	P0,
	P1,
	P2,
	P3,
	P4
from
	@tblTemp




go
