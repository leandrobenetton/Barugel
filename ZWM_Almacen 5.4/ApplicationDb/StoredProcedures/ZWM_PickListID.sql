/****** Object:  StoredProcedure [dbo].[ZWM_PickListID]    Script Date: 01/09/2015 14:46:17 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ZWM_PickListID]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ZWM_PickListID]
GO

/****** Object:  StoredProcedure [dbo].[ZWM_PickListID]    Script Date: 01/09/2015 14:46:17 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[ZWM_PickListID] (
    @IDPickList		ZWM_RouteType = NULL OUTPUT
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

-- Genera el ID de PickList
DECLARE 
@Today date
,@NextDay date
,@NextDayDay nvarchar(10)
,@PickListID ZWM_RouteType
,@NumberId tinyint
,@ENDDATE date 
,@LastID ZWM_RouteType
,@LastIDPL ZWM_RouteType
,@LastIDTrn ZWM_RouteType

SET @Today = CONVERT (date, GETDATE())
SET @NextDay = DATEADD(day, 1, CONVERT (date, GETDATE()))
SET @NextDayDay = datename(dw,@NextDay)

-- Si @NextDayDay es viernes, salto al lunes
IF @NextDayDay = 'Saturday'
	SET @NextDay = DATEADD(day, 3, CONVERT (date, GETDATE()))
	
-- si @NextDay es feriado, @NextDay es el dia siguiente al feriado.
IF (select count(RowPointer) FROM CAL000_mst WHERE @NextDay between STARTDATE and ENDDATE) > 0
BEGIN
	
	SELECT @NextDay = ENDDATE FROM CAL000_mst WHERE @NextDay between STARTDATE and ENDDATE
	SET @NextDayDay = datename(dw,@NextDay)

	IF @NextDayDay = 'Saturday'
		SET @NextDay = DATEADD(day, 2, CONVERT (date, @NextDay))
	ELSE IF @NextDayDay = 'Sunday'
		SET @NextDay = DATEADD(day, 1, CONVERT (date, @NextDay))
		
	IF (SELECT count(RowPointer) FROM CAL000_mst WHERE @NextDay between STARTDATE and ENDDATE) > 0
		SELECT @NextDay = ENDDATE FROM CAL000_mst WHERE @NextDay between STARTDATE and ENDDATE	
END


DECLARE 
@datePick nvarchar(7)
, @next nvarchar(10)
, @PICKLISTFINAL nvarchar(10)

SET @next = @NextDay
SET @datePick = SUBSTRING(@next,9,2) + SUBSTRING(@next,6,2) + SUBSTRING(@next,3,2) + '%'

-- El ID de Hoja de Ruta será autoincremental correlativo tanto para PickList como para las Ordenes de transferencia, y se calcula a pertir del ultimo ID generado tanto para PickList como para las Ordenes de transferencia

--traigo los ultimos RouteID
SELECT top 1 @LastIDPL = ZWM_IdRouteMap FROM pick_list_mst WHERE ZWM_IdRouteMap like @datePick ORDER BY ZWM_IdRouteMap DESC
--SELECT top 1 @LastIDTrn = route_map_id FROM zwm_transfer_pick_list_mst WHERE route_map_id like @datePick ORDER BY route_map_id DESC

IF @LastIDPL is null
	SET @IDPickList = SUBSTRING(CONVERT(char(10), @NextDay),9,2) + SUBSTRING(CONVERT(char(10), @NextDay),6,2) + SUBSTRING(CONVERT(char(10), @NextDay),3,2)+'-001'	
else
BEGIN
	SET @LastIDPL = SUBSTRING(@LastIDPL,8,3)+1

	IF LEN(@LastIDPL)=1
		SET @LastIDPL = '00'+@LastIDPL
	IF LEN(@LastIDPL)=2
		SET @LastIDPL = '0'+@LastIDPL
		
	SET @IDPickList = SUBSTRING(@next,9,2) + SUBSTRING(@next,6,2) + SUBSTRING(@next,3,2)+'-'+@LastIDPL
	END

/*
	-- Ambos RouteID son NULL
	IF @LastIDPL is null and @LastIDTrn is null
		BEGIN
		SET @IDPickList = SUBSTRING(CONVERT(char(10), @NextDay),9,2) + SUBSTRING(CONVERT(char(10), @NextDay),6,2) + SUBSTRING(CONVERT(char(10), @NextDay),3,2)+'-001'	
		END
		
	-- El ultimo RouteID fue generado en PickList
	ELSE IF @LastIDPL is not null and @LastIDTrn is null
		BEGIN
		SET @LastIDPL = SUBSTRING(@LastIDPL,8,3)+1

		IF LEN(@LastIDPL)=1
			SET @LastIDPL = '00'+@LastIDPL
		IF LEN(@LastIDPL)=2
			SET @LastIDPL = '0'+@LastIDPL
			
		SET @IDPickList = SUBSTRING(@next,9,2) + SUBSTRING(@next,6,2) + SUBSTRING(@next,3,2)+'-'+@LastIDPL
		END
		
	-- El ultimo RouteID fue generado en Transferencia
	ELSE IF @LastIDPL is null and @LastIDTrn is not null
		BEGIN
		SET @LastIDTrn = SUBSTRING(@LastIDTrn,8,3)+1

		IF LEN(@LastIDTrn)=1
			SET @LastIDTrn = '00'+@LastIDTrn
		IF LEN(@LastIDTrn)=2
			SET @LastIDTrn = '0'+@LastIDTrn
			
		SET @IDPickList = SUBSTRING(@next,9,2) + SUBSTRING(@next,6,2) + SUBSTRING(@next,3,2)+'-'+@LastIDTrn
		END
		
	-- Cuando PickList y Transferencia tienen RouteID, toma el mayor
	ELSE IF @LastIDPL is not null and @LastIDTrn is not null
		BEGIN
		
		IF @LastIDPL > @LastIDTrn
			SET @LastID = @LastIDPL
		ELSE IF @LastIDPL < @LastIDTrn
			SET @LastID = @LastIDTrn
		ELSE IF @LastIDPL = @LastIDTrn
			SET @LastID = @LastIDTrn
		
		SET @LastID = SUBSTRING(@LastID,8,3)+1

		IF LEN(@LastID)=1
			SET @LastID = '00'+@LastID
		IF LEN(@LastID)=2
			SET @LastID = '0'+@LastID
			
		SET @IDPickList = SUBSTRING(@next,9,2) + SUBSTRING(@next,6,2) + SUBSTRING(@next,3,2)+'-'+@LastID
		END*/

END

RETURN @Severity

EXEC dbo.CloseSessionContextSp @SessionID = @SessionID
GO


