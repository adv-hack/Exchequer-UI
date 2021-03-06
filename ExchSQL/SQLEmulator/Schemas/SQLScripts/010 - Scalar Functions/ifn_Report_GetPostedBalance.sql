--/////////////////////////////////////////////////////////////////////////////
--// Filename		: ifn_Report_GetPostedBalance.sql
--// Author		: 
--// Date		: 
--// Copyright Notice	: (c) 2015 Advanced Business Software & Solutions Ltd. All rights reserved.
--// Description	: SQL Script to add ifn_Report_GetPostedBalance function
--//
--/////////////////////////////////////////////////////////////////////////////
--// Version History:
--//	1	: File Creation
--//
--/////////////////////////////////////////////////////////////////////////////

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[!ActiveSchema!].[ifn_Report_GetPostedBalance]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
	drop function [!ActiveSchema!].[ifn_Report_GetPostedBalance]
go

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create function [!ActiveSchema!].[ifn_Report_GetPostedBalance]
	(	
	@strAccountCode			varchar(10),	
	@intYear				int,
	@intPeriod				int,
	@intCurrency			int
	)
RETURNS float

begin

/*
Debug code
declare
	@strCustomerCode		varchar(10)		= 'ABAP01',	
	@intYear				int				= 2010,
	@intPeriod				int				= 12,
	@intCurrency			int				= 0
*/

declare @fltReturnValue	as float
declare @intLastYtdYear as int
declare @binAccountCode as varbinary(20)

select @binAccountCode=CAST((rtrim(@strAccountCode) + REPLICATE(char(32),20-len(@strAccountCode))) as varbinary(20))


--Get Last YTD year
select 
	@intLastYtdYear	= max(h.hiYear) + 1900
FROM 
	[!ActiveSchema!].[HISTORY_All] h (NOEXPAND)
WHERE 
	hiCodeComputed=@binAccountCode 
	and h.hiExClass = 86
	and h.hiYear < @intYear - 1900
	and h.hiPeriod = 255			
	and h.hiCurrency = @intCurrency 

-- Get value
select
	/*	
	cast(substring(hiCode,2,6) as varchar(6)),
	cast(substring(hiCode,7,3) as varchar(3)),	
	cast(substring(hiCode,8,6) as varchar(6)),	
	cast(substring(hiCode,10,3) as varchar(3)),	
	*	
	*/	
	@fltReturnValue = SUM(hiPurchases-hiSales)	
from
	[!ActiveSchema!].HISTORY_All h (NOEXPAND)
where 
	hiExCLass =	86			-- ASCII ('V')	
	and hiCodeComputed=@binAccountCode
	and 
	(
		(h.hiYear = @intLastYTDYear - 1900 and h.hiPeriod = 255)		-- Last YTD record we had
		or
		(h.hiYear = @intYear - 1900 and h.hiPeriod <= @intPeriod)		-- All this year up to and including specified period
	)
	and h.hiCurrency = @intCurrency 
	
--select @fltReturnValue 
return @fltReturnValue

end



