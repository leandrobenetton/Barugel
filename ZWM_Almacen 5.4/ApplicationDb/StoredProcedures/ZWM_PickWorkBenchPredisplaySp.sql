/****** Object:  StoredProcedure [dbo].[ZWM_PickWorkBenchPredisplaySp]    Script Date: 01/09/2015 14:47:14 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ZWM_PickWorkBenchPredisplaySp]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ZWM_PickWorkBenchPredisplaySp]
GO

/****** Object:  StoredProcedure [dbo].[ZWM_PickWorkBenchPredisplaySp]    Script Date: 01/09/2015 14:47:14 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



create PROCEDURE [dbo].[ZWM_PickWorkBenchPredisplaySp] (
    @ShipCode	ShipCodeType = NULL OUTPUT
)
AS

Declare @Severity int
Set @Severity = 0

--Inicio de Sesion
DECLARE	@return_value int,
		@sessionId            RowPointerType,
		@UserName UsernameType,
		@SIte SiteType

SET @UserName = isnull(@UserName,'sa')

EXEC	@return_value = [dbo].[InitSessionContextWithUserSp]
		@ContextName = 'ZWM',
		@UserName = @UserName,
		@SessionID = @SessionID OUTPUT,
		@Site = @Site
		
--Solo para implementacion Barugel Azulay
DECLARE @BAR FlagNyTYpe
IF (Select count(*) from zwm_parms where customer = 'BAR') > 0
	Set @BAR = 1 


IF @BAR = 1
BEGIN
	select @ShipCode = ship_via_picklist from zwm_parms
END

RETURN @Severity

EXEC dbo.CloseSessionContextSp @SessionID = @SessionID
GO


