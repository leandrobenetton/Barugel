/****** Object:  StoredProcedure [dbo].[ZWM_RFPackTransferSp]    Script Date: 12/10/2014 09:42:14 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ZWM_RFPackTransferSp]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ZWM_RFPackTransferSp]
GO

/****** Object:  StoredProcedure [dbo].[ZWM_RFPackTransferSp]    Script Date: 12/10/2014 09:42:14 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[ZWM_RFPackTransferSp] (
    @Site			SiteType
    ,@UserName		UsernameType = NULL
    ,@IDPickList	PickListIDType = NULL
    ,@RouteID		ZwmIdRouteMapType = NULL 
    ,@TrnNum		TrnNumType = NULL
    ,@Confirmation	FlagNyType = 0
	,@ShipLoc		LocType = NULL
	,@QtyPack		PackagesType = NULL
	,@Weight		TotalWeightType = NULL
	,@WeightUM		UMType = NULL
    ,@Infobar		InfobarType OUTPUT
)
AS


DECLARE	@return_value int,
		@sessionId            RowPointerType,
		@Severity int,
		@ProcessId RowPointerType,
		@PackLocCursor LocType,
		@CustNum	CustNumType,
		@CustSeq	CustSeqType,
		@Whse		WhseType,
		@ErrFlag	FlagNyType

Set @Severity = 0

SET @UserName = isnull(@UserName,'sa')

EXEC	@return_value = [dbo].[InitSessionContextWithUserSp]
		@ContextName = 'ZWM',
		@UserName = @UserName,
		@SessionID = @SessionID OUTPUT,
		@Site = @Site
		
SET @TrnNum = dbo.ExpandKyByType('TrnNumType',@TrnNum)	

SET @ProcessId = NEWID()
SET @Confirmation = ISNULL(@Confirmation,0)
SET @ErrFlag = 0

IF @ShipLoc is NULL
	select @ShipLoc = ship_loc from invparms
ELSE IF(SELECT loc FROM location WHERE loc = @ShipLoc) IS NULL
	BEGIN
		SET @Infobar = 'La ubicación de despacho no existe'
		SET @Severity = 16
		RETURN @severity
	END

------------------------------------------------------------------------------------- Validaciones

IF @IDPickList is null and @RouteID is null and @TrnNum is null
	BEGIN
		SET @Infobar = 'Debe ingresar hoja de ruta, Pick List ID u Orden de Venta'
		SET @Severity = 16
		RETURN @Severity
	END


IF (SELECT count(pl.pick_list_id) FROM zwm_transfer_pick_list_mst pl 
JOIN zwm_transfer_pick_list_ref_mst plr 
on plr.pick_list_id = pl.pick_list_id 
WHERE (pl.route_map_id = @RouteID OR @RouteID is null) AND (pl.pick_list_id = @IDPickList OR @IDPickList is null) AND (plr.ref_num = @TrnNum OR @TrnNum is null)) = 0
BEGIN
	SET @Infobar = 'No existen Pick Lists con los datos ingresados'
	SET @Severity = 16
	RETURN @Severity
END	
-------------------------------------------------------------------------------------------


IF (SELECT count(pl.pick_list_id) FROM zwm_transfer_pick_list_mst pl JOIN zwm_transfer_pick_list_ref_mst plr on plr.pick_list_id = pl.pick_list_id WHERE pl.status = 'O' AND (pl.route_map_id = @RouteID OR @RouteID is null) AND (pl.pick_list_id = @IDPickList OR @IDPickList is null) AND (plr.ref_num = @TrnNum OR @TrnNum is null)) > 0 AND @Confirmation  = 0
BEGIN
	SET @Infobar = 'Hay Pick List en estado "Abierto"'
	SET @Severity = 16
	RETURN @Severity
END
ELSE IF (SELECT count(pl.pick_list_id) FROM zwm_transfer_pick_list_mst pl JOIN zwm_transfer_pick_list_ref_mst plr on plr.pick_list_id = pl.pick_list_id WHERE pl.status = 'O' AND (pl.route_map_id = @RouteID OR @RouteID is null) AND (pl.pick_list_id = @IDPickList OR @IDPickList is null) AND (plr.ref_num = @TrnNum OR @TrnNum is null)) > 0 AND @Confirmation  = 1
BEGIN
	UPDATE zwm_transfer_pick_list_mst SET status = 'P' WHERE status = 'O' AND pick_list_id in (SELECT count(pl.pick_list_id) FROM zwm_transfer_pick_list_mst pl JOIN zwm_transfer_pick_list_ref_mst plr on plr.pick_list_id = pl.pick_list_id WHERE pl.status = 'O' AND (pl.route_map_id = @RouteID OR @RouteID is null) AND (pl.pick_list_id = @IDPickList OR @IDPickList is null) AND (plr.ref_num = @TrnNum OR @TrnNum is null))
END

IF (SELECT count(pl.pick_list_id) FROM zwm_transfer_pick_list_mst pl JOIN zwm_transfer_pick_list_ref_mst plr on plr.pick_list_id = pl.pick_list_id WHERE pl.status = 'P' AND (pl.route_map_id = @RouteID OR @RouteID is null) AND (pl.pick_list_id = @IDPickList OR @IDPickList is null) AND (plr.ref_num = @TrnNum OR @TrnNum is null)) = 0
BEGIN
	SET @Infobar = 'No hay registros para procesar'
	SET @Severity = 16
	RETURN @Severity
END
		
IF @Weight is not null and @WeightUM is null
	Select @WeightUM = um_weight from zwm_parms

IF @Weight is not null and @RouteId is not null and @IDPickList is null And @TrnNum is null
	SET @Weight = @Weight / isnull((select count(*) from zwm_transfer_pick_list_mst where route_map_id = @RouteID),0)

IF @QtyPack is not null and @RouteId is not null and @IDPickList is null And @TrnNum is null
	SET @QtyPack = @QtyPack / isnull((select count(*) from zwm_transfer_pick_list_mst where route_map_id = @RouteID),0)

declare pickCursor cursor local static for 
select distinct pl.pick_list_id 
from zwm_transfer_pick_list_mst pl 
JOIN zwm_transfer_pick_list_ref_mst plr on plr.pick_list_id = pl.pick_list_id
WHERE pl.status = 'P' 
AND (pl.route_map_id = @RouteID OR @RouteID is null)
AND (pl.pick_list_id = @IDPickList OR @IDPickList is null)
AND (plr.ref_num = @TrnNum OR @TrnNum is null)
			
	open pickCursor
	while 1=1
	begin
		FETCH pickCursor into @IDPickList
				
		IF @@FETCH_STATUS <> 0
			BREAK

	SELECT /*@CustNum = cust_num, @CustSeq = cust_seq, */@Whse = whse
	FROM zwm_transfer_pick_list_mst WHERE pick_list_id = @IDPickList

			
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
			@ShipmentStatus = NULL
	
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


