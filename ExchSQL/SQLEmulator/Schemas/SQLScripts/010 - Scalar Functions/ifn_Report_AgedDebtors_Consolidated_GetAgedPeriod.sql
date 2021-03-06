--/////////////////////////////////////////////////////////////////////////////
--// Filename		: ifn_Report_AgedDebtors_Consolidated_GetAgedPeriod.sql
--// Author		: 
--// Date		: 
--// Copyright Notice	: (c) 2015 Advanced Business Software & Solutions Ltd. All rights reserved.
--// Description	: SQL Script to add ifn_Report_AgedDebtors_Consolidated_GetAgedPeriod function
--//
--/////////////////////////////////////////////////////////////////////////////
--// Version History:
--//	1	: File Creation
--//
--/////////////////////////////////////////////////////////////////////////////

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[common].[ifn_Report_AgedDebtors_Consolidated_GetAgedPeriod]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
	drop function [common].[ifn_Report_AgedDebtors_Consolidated_GetAgedPeriod]
go

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create function [common].[ifn_Report_AgedDebtors_Consolidated_GetAgedPeriod]
	(	
	@datAsAtDate			datetime,
	@datDueDate				datetime,
	@intAgeBy				tinyint,		-- 1 = Days, 2 = Weeks, 3 = Months
	@decAgeingInterval		decimal			-- Decimal type so division below doesn't treat as integer
	)
RETURNS int

begin

declare @intElapsed	integer
--if @datDueDate > @datAsAtDate 
--	set @intElapsed = 0
--else
begin
	set @intElapsed = 1 +
		(case @intAgeBy
			when 1 then floor(datediff(d, @datDueDate, @datAsAtDate)/@decAgeingInterval)
			when 2 then floor(datediff(wk, @datDueDate, @datAsAtDate)/@decAgeingInterval)
			when 3 then floor(datediff(m, @datDueDate, @datAsAtDate)/@decAgeingInterval)
		end)
		
	-- Returned value must be within the range 0 - 5 which maps to a column in the report
	-- which for, e.g., a monthly report with a 1 month interval will be
	-- Not Due, Current, 1 Month, 2 Months, 3 Months, 4 Months, 4 Months +

	if @intElapsed < 1 
		set @intElapsed = 0			-- Set as column 0, i.e. Not Due
		
	if @intElapsed > 5 
		set @intElapsed = 5			-- Set as column 5, i.e. + column

end

-- Return the value
RETURN @intElapsed

end



