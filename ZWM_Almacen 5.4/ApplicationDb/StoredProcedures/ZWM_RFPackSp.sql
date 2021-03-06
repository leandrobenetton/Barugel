/****** Object:  StoredProcedure [dbo].[ZWM_RFPackSp]    Script Date: 01/20/2015 15:13:47 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ZWM_RFPackSp]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ZWM_RFPackSp]
GO

/****** Object:  StoredProcedure [dbo].[ZWM_RFPackSp]    Script Date: 01/20/2015 15:13:47 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[ZWM_RFPackSp] (
    @Site			SiteType
    ,@UserName		UsernameType		= NULL
    ,@IDPickList	PickListIDType		= NULL
    ,@RouteID		ZwmIdRouteMapType	= NULL 
    ,@RefNum		CoNumType			= NULL
    ,@Confirmation	FlagNyType			= 0
	,@ShipLoc		LocType				= NULL
	,@QtyPack		PackagesType		= NULL
	,@Weight		TotalWeightType		= NULL
	,@WeightUM		UMType				= NULL
	,@ReadyToShip	char(1)				= NULL
	,@Origin		TransferStatusType -- 'T' = Transferencia, 'O' = Orden de venta
    ,@Infobar		InfobarType OUTPUT
)
AS

 -- Check for existence of Generic External Touch Point routine (this section was generated by SpETPCodeSp and inserted by CallETPs.exe):
   IF OBJECT_ID(N'dbo.EXTGEN_ZWM_RFPackSp') IS NOT NULL
   BEGIN
      DECLARE @EXTGEN_SpName sysname
      SET @EXTGEN_SpName = N'dbo.EXTGEN_ZWM_RFPackSp'
      -- Invoke the ETP routine, passing in (and out) this routine's parameters:
      DECLARE @EXTGEN_Severity int
      EXEC @EXTGEN_Severity = @EXTGEN_SpName
			@Site
			,@UserName
			,@IDPickList	
			,@RouteID
			,@RefNum
			,@Confirmation	
			,@ShipLoc
			,@QtyPack
			,@Weight
			,@WeightUM
			,@ReadyToShip
			,@Infobar		OUTPUT
 
      -- ETP routine can RETURN 1 to signal that the remainder of this standard routine should now proceed:
      IF @EXTGEN_Severity <> 1
         RETURN @EXTGEN_Severity
   END
   -- End of Generic External Touch Point code.

DECLARE	@return_value			int,
		@sessionId				RowPointerType,
		@Severity				int,
		@ProcessId				RowPointerType,
		@PackLocCursor			LocType,
		@CustNum				CustNumType,
		@CustSeq				CustSeqType,
		@Whse					WhseType,
		@ErrFlag				FlagNyType

Set @Severity = 0

SET @UserName = isnull(@UserName,'sa')

EXEC	@return_value = [dbo].[InitSessionContextWithUserSp]
		@ContextName = 'ZWM',
		@UserName = @UserName,
		@SessionID = @SessionID OUTPUT,
		@Site = @Site
		
		
SET @RefNum = dbo.ExpandKyByType('CoNumType',@RefNum)

SET @ProcessId = NEWID()
SET @Confirmation = ISNULL(@Confirmation,0)
SET @ErrFlag = 0

IF @ShipLoc IS NULL
	SELECT @ShipLoc = ship_loc from invparms
ELSE IF(SELECT loc FROM location WHERE loc = @ShipLoc) IS NULL
	BEGIN
		SET @Infobar = 'La ubicación de despacho no existe'
		SET @Severity = 16
		RETURN @severity
	END


------------------------------ SET NULLs
IF LEN(LTRIM(@RefNum)) = 0
	SET @RefNum = NULL
	
IF LEN(LTRIM(@IDPickList)) = 0
	SET @IDPickList = NULL

IF LEN(LTRIM(@RouteID)) = 0
	SET @RouteID = NULL

IF LEN(LTRIM(@ShipLoc)) = 0
	SET @ShipLoc = NULL

IF LEN(LTRIM(@QtyPack)) = 0
	SET @QtyPack = NULL

IF LEN(LTRIM(@Weight)) = 0
	SET @Weight = NULL

IF LEN(LTRIM(@WeightUM)) = 0
	SET @WeightUM = NULL

IF LEN(LTRIM(@ReadyToShip)) = 0
	SET @ReadyToShip = NULL
------------------------------ SET NULLs

------------------------------------------------------------------------------------- Validaciones

IF @IDPickList IS NULL AND @RouteID IS NULL AND @RefNum IS NULL
	BEGIN
		SET @Infobar = 'Debe ingresar hoja de ruta, Pick List ID u Orden'
		SET @Severity = 16
		RETURN @Severity
	END

IF NOT EXISTS(SELECT pl.pick_list_id
FROM pick_list pl 
JOIN pick_list_ref plr 
on plr.pick_list_id = pl.pick_list_id 
WHERE (pl.ZWM_IdRouteMap = @RouteID OR @RouteID IS NULL) 
AND (pl.pick_list_id = @IDPickList OR @IDPickList IS NULL) 
AND (plr.ref_num = @RefNum OR @RefNum IS NULL)
) 
BEGIN
	SET @Infobar = 'No existen Pick Lists con los datos ingresados'
	SET @Severity = 16
	RETURN @Severity
END	
--------------------------------------------------------------------------------------


IF EXISTS(SELECT pl.pick_list_id FROM pick_list pl JOIN pick_list_ref plr on plr.pick_list_id = pl.pick_list_id WHERE pl.status = 'O' AND (pl.ZWM_IdRouteMap = @RouteID OR @RouteID IS NULL) AND (pl.pick_list_id = @IDPickList OR @IDPickList IS NULL) AND (plr.ref_num = @RefNum OR @RefNum IS NULL)) AND @Confirmation  = 0
BEGIN
	SET @Infobar = 'Hay Pick List en estado "Abierto"'
	SET @Severity = 16
	RETURN @Severity
END
ELSE IF EXISTS(SELECT pl.pick_list_id FROM pick_list pl JOIN pick_list_ref plr on plr.pick_list_id = pl.pick_list_id WHERE pl.status = 'O' AND (pl.ZWM_IdRouteMap = @RouteID OR @RouteID IS NULL) AND (pl.pick_list_id = @IDPickList OR @IDPickList IS NULL) AND (plr.ref_num = @RefNum OR @RefNum IS NULL)) AND @Confirmation  = 1
-- Si el pick_list esta abierto y @Confirmation = 1, lo marca como piqueado
BEGIN
	UPDATE pick_list SET status = 'P' WHERE status = 'O' AND pick_list_id in (SELECT count(pl.pick_list_id) FROM pick_list pl JOIN pick_list_ref plr on plr.pick_list_id = pl.pick_list_id WHERE pl.status = 'O' AND (pl.ZWM_IdRouteMap = @RouteID OR @RouteID IS NULL) AND (pl.pick_list_id = @IDPickList OR @IDPickList IS NULL) AND (plr.ref_num = @RefNum OR @RefNum IS NULL))
END

IF EXISTS(SELECT pl.pick_list_id FROM pick_list pl JOIN pick_list_ref plr on plr.pick_list_id = pl.pick_list_id WHERE pl.status = 'P' AND (pl.ZWM_IdRouteMap = @RouteID OR @RouteID IS NULL) AND (pl.pick_list_id = @IDPickList OR @IDPickList IS NULL) AND (plr.ref_num = @RefNum OR @RefNum IS NULL))
BEGIN
	SET @Infobar = 'No hay registros para procesar'
	SET @Severity = 16
	RETURN @Severity
END
		
IF @Weight IS NOT NULL AND @WeightUM IS NULL
	Select @WeightUM = um_weight from zwm_parms

IF @Weight IS NOT NULL AND @RouteId IS NOT NULL AND @IDPickList IS NULL And @RefNum IS NULL
	SET @Weight = @Weight / isnull((select count(*) from pick_list where ZWM_IdRouteMap = @RouteID),0)

IF @QtyPack IS NOT NULL AND @RouteId IS NOT NULL AND @IDPickList IS NULL And @RefNum IS NULL
	SET @QtyPack = @QtyPack / isnull((select count(*) from pick_list where ZWM_IdRouteMap = @RouteID),0)


DECLARE pickCursor CURSOR LOCAL STATIC FOR
SELECT distinct pl.pick_list_id 
FROM pick_list pl 
JOIN pick_list_ref plr on plr.pick_list_id = pl.pick_list_id
WHERE pl.status = 'P' 
AND (pl.ZWM_IdRouteMap = @RouteID OR @RouteID IS NULL)
AND (pl.pick_list_id = @IDPickList OR @IDPickList IS NULL)
AND (plr.ref_num = @RefNum OR @RefNum IS NULL)
			
	OPEN pickCursor
	WHILE 1=1
	BEGIN
		FETCH pickCursor INTO @IDPickList
				
		IF @@FETCH_STATUS <> 0
			BREAK
				
		IF(@Origin = 'O')
			SELECT @CustNum = cust_num, @CustSeq = cust_seq, @Whse = whse
			FROM pick_list WHERE pick_list_id = @IDPickList
		ELSE IF (@Origin = 'T')
			SELECT @Whse = whse
			FROM pick_list WHERE pick_list_id = @IDPickList

		EXEC	@Severity = [dbo].[GeneratePickListTmpSp]
				@ProcessId = @ProcessId,
				@Select = 1,
				@PickListId = @IDPickList,
				@CustNum = @CustNum,
				@CustSeq = @CustSeq,
				@Whse = @Whse,
				@Group = NULL,
				@Packer = @UserName,
				@InfoBar = @InfoBar OUTPUT
				
		EXEC	@Severity = [dbo].[GenerateShipmentSp]
				@ProcessId = @ProcessId,
				@ShipLoc = @ShipLoc,
				@Packages = @QtyPack,
				@Weight = @Weight,
				@WeightUm = @WeightUM,
				@InfoBar = @InfoBar OUTPUT,
				@ShipmentStatus = @ReadyToShip
	
		IF @Severity <> 0
			set @ErrFlag = 1
					
	end --end cursor
			
CLOSE pickCursor
DEALLOCATE pickCursor

IF @ErrFlag = 1
BEGIN
	SET @Severity = 16
	SET @Infobar = 'Existen registros procesados con error'
END

EXEC dbo.CloseSessionContextSp @SessionID = @SessionID
	
RETURN @Severity
GO


