/****** Object:  StoredProcedure [dbo].[ZWM_RF_Picking2Sp]    Script Date: 01/20/2015 15:11:37 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ZWM_RF_Picking2Sp]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ZWM_RF_Picking2Sp]
GO

/****** Object:  StoredProcedure [dbo].[ZWM_RF_Picking2Sp]    Script Date: 01/20/2015 15:11:37 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Confirma el Pickeo
CREATE PROCEDURE [dbo].[ZWM_RF_Picking2Sp] (
     @Site				SiteType
	,@UserName			UserNameType			= NULL
	,@PPickListID		PickListIDType			= NULL
	,@Seq				PickListSequenceType	= NULL
	,@RefNum			CoNumType				= NULL
	,@RefLine			CoLineType				= NULL
	,@RefRelease		CoReleaseType			= NULL
	,@QtyUMStk1			QtyUnitType
	,@QtyUMStk2			QtyUnitType
	,@QtyUMStd			QtyUnitType
	,@Loc				LocType
	,@Lot				LotType
	,@Origin			TransferStatusType -- 'T' = Transferencia, 'O' = Orden de venta
	,@Infobar			InfobarType				= NULL OUTPUT
)
AS

 -- Check for existence of Generic External Touch Point routine (this section was generated by SpETPCodeSp and inserted by CallETPs.exe):
   IF OBJECT_ID(N'dbo.EXTGEN_ZWM_RF_Picking2Sp') IS NOT NULL
   BEGIN
      DECLARE @EXTGEN_SpName sysname
      SET @EXTGEN_SpName = N'dbo.EXTGEN_ZWM_RF_Picking2Sp'
      -- Invoke the ETP routine, passing in (and out) this routine's parameters:
      DECLARE @EXTGEN_Severity int
      EXEC @EXTGEN_Severity = @EXTGEN_SpName
		 @Site				
		,@UserName			
		,@PPickListID		
		,@Seq				
		,@RefNum			
		,@RefLine			
		,@RefRelease		
		,@QtyUMStk1			
		,@QtyUMStk2			
		,@QtyUMStd			
		,@Loc				
		,@Lot				
		,@Origin			
		,@Infobar	OUTPUT	
 
      -- ETP routine can RETURN 1 to signal that the remainder of this standard routine should now proceed:
      IF @EXTGEN_Severity <> 1
         RETURN @EXTGEN_Severity
   END
   -- End of Generic External Touch Point code.

DECLARE	@Severity int,
		@sessionId            RowPointerType

SET @UserName = isnull(@UserName,'sa')

EXEC	@Severity = [dbo].[InitSessionContextWithUserSp]
		@ContextName = 'ZWM',
		@UserName = @UserName,
		@SessionID = @SessionID OUTPUT,
		@Site = @Site
		
DECLARE
@QtyPicked		QtyUnitNoNegType
,@UMStk1		UMType
,@UMStk2		UMType
,@Item			ItemType
,@QtyStk1Conv	QtyUnitType
,@QtyStk2Conv	QtyUnitType
,@ProcessId		RowPointerType
,@QtyToPick		QtyUnitType
,@QtyToPickedYet QtyUnitType
,@LotTracked	FlagNyTYpe

SET @ProcessId = newid()
SET @QtyStk1Conv = 0
SET @QtyStk2Conv = 0

DECLARE @Pick TABLE (
	PickListID PickListIDtype,
	PickListSeq PickListSequenceType,
	PickCo conumtype,
	PickCoLine colinetype,
	PickCoRelease coreleasetype,
	PickItem itemtype,
	PickItemDesc descriptiontype,
	PickItemUm umtype,
	PickQtyToPick qtyunittype,
	PickQtyPicked qtyunittype,
	PickLoc loctype,
	PickLot lottype,
	PickSerial sernumtype,
	PickSerialized SMALLINT,
	PickLotTracked SMALLINT
	)

SET @RefNum = dbo.ExpandKyByType('CoNumType',@RefNum)

------------------------------ SET NULLs
IF LEN(LTRIM(@PPickListID)) = 0
	SET @PPickListID = NULL

IF LEN(LTRIM(@Seq)) = 0
	SET @Seq = NULL

IF LEN(LTRIM(@RefNum)) = 0
	SET @RefNum = NULL

IF LEN(LTRIM(@RefLine)) = 0
	SET @RefLine = NULL

IF LEN(LTRIM(@RefRelease)) = 0
	SET @RefRelease = NULL
------------------------------ SET NULLs

-------------------------------------------------------------- Validaciones
IF @Lot IS NOT NULL
	SET @Lot = dbo.ExpandKyByType('LotType',@Lot)
	
	
IF	(@Origin = 'O' and @PPickListID IS NULL AND @Seq IS NULL AND @RefNum IS NULL AND @RefLine IS NULL AND @RefRelease IS NULL) OR (@Origin = 'T' and @PPickListID IS NULL AND @Seq IS NULL AND @RefNum IS NULL AND @RefLine IS NULL )
BEGIN
	SET @Infobar = 'Debe ingresar Pick List ID o Numero de Pedido'
	SET @Severity = 16
	RETURN @Severity
END

IF (@PPickListID IS NULL or @Seq IS NULL)
BEGIN
	SELECT @PPickListID = plr.pick_list_id, @Seq = plr.sequence
	FROM pick_list_ref plr JOIN pick_list pl on plr.pick_list_id = pl.pick_list_id
	WHERE 
	(@Origin = 'O' and plr.ref_num = @RefNum AND plr.ref_line_suf = @RefLine AND plr.ref_release = @RefRelease AND pl.status = 'O')
	OR
	(@Origin = 'T' and plr.ref_num = @RefNum AND plr.ref_line_suf = @RefLine and pl.status = 'O')
END

IF (select count(pick_list_id)FROM pick_list_ref where pick_list_id = @PPickListID and sequence = @Seq) = 0
BEGIN
	SET @Infobar = 'No Existen los datos de referencia'
	SET @Severity = 16
	RETURN @Severity
END

IF (select status FROM pick_list_ref plr join pick_list pl on pl.pick_list_id = plr.pick_list_id 
WHERE plr.pick_list_id = @PPickListID and plr.sequence = @Seq) != 'O'
BEGIN
	SET @Infobar = 'El Pickeo esta cerrado'
	SET @Severity = 16
	RETURN @Severity
END


-- Clear all entries for this session        
DELETE tmp_pick_list_loc
WHERE process_id = @ProcessId


IF @Origin = 'O'
	SELECT @Item = item FROM coitem WHERE co_num = @RefNum and co_line = @RefLine and co_release = @RefRelease

IF @Origin = 'T'
	SELECT @Item = item FROM trnitem WHERE trn_num = @RefNum and trn_line = @RefLine

SELECT @LotTracked = lot_tracked from item where item.item = @Item

IF @QtyUMStk1 IS NOT NULL
BEGIN
	SET @UMStk1 = ( SELECT ZWM_UMStock1 FROM item WHERE item = @Item )
	EXEC @Severity = dbo.UMConvQtySp
		@UM               = @UMStk1
	  , @Item             = @Item
	  , @VendNum          = NULL
	  , @Area             = NULL
	  , @ConvertToBase    = 1
	  , @QtyToBeConverted = @QtyUMStk1 
	  , @OutQty           = @QtyStk1Conv OUTPUT --devuelve la cantidad convertida
	  , @Infobar          = @Infobar       OUTPUT
END

IF @QtyUMStk2 IS NOT NULL
BEGIN
	SET @UMStk2 = ( SELECT ZWM_UMStock2 FROM item WHERE item = @Item )
	EXEC @Severity = dbo.UMConvQtySp
		@UM               = @UMStk2
	  , @Item             = @Item
	  , @VendNum          = NULL
	  , @Area             = NULL
	  , @ConvertToBase    = 1
	  , @QtyToBeConverted = @QtyUMStk2
	  , @OutQty           = @QtyStk2Conv OUTPUT --devuelve la cantidad convertida
	  , @Infobar          = @Infobar       OUTPUT
END

SET @QtyPicked = @QtyStk1Conv + @QtyStk2Conv + @QtyUMStd
------------------------------------------------------------------------------------------
-- valida que la cantidad pickeada sea <= a la cantidad a pickear - cantidad pickeada previamente

SELECT @QtyToPick = qty_to_pick, @QtyToPickedYet = qty_picked 
FROM pick_list_ref
WHERE pick_list_id = @PPickListID and sequence = @Seq

IF (@QtyPicked + @QtyToPickedYet) > @QtyToPick 
BEGIN
	SET @Infobar = 'Se intenta pickear una cantidad mayor a la requerida'
	SET @Severity = 16
	RETURN @Severity
END


EXEC	@Severity = [dbo].[PickConfirmationSp]
		@ProcessId = @ProcessId,
		@PPickListID = @PPickListID,
		@RecordDiff = 1,
		@Infobar = @Infobar OUTPUT

IF @Severity <> 0
BEGIN
	DELETE tmp_pick_list_loc WHERE process_id = @ProcessId
	RETURN @Severity
END

IF (SELECT count(*) FROM tmp_pick_list_loc WHERE process_id = @ProcessId and pick_list_id = @PPickListID and pick_group = @Seq and loc is not null and ((lot is not null and @LotTracked = 1) Or @LotTracked = 0)) > 0
BEGIN
	IF (SELECT count(*) FROM tmp_pick_list_loc WHERE process_id = @ProcessId and pick_list_id = @PPickListID and pick_group =	@Seq and loc = @Loc and ((lot = @Lot and @LotTracked = 1) Or @LotTracked = 0)) > 0
	BEGIN
		
		UPDATE tmp_pick_list_loc SET qty_pick = @QtyPicked WHERE process_id = @ProcessId and pick_list_id = @PPickListID and		pick_group = @Seq and loc = @loc and lot = @lot
	END
	ELSE
		SELECT TOP 1 process_id,selected,pick_list_id,pick_group,ref_num,ref_line_suf,ref_release,item,description,@Loc,rank,		qty_on_hand,qty_reserved,@QtyPicked,qty_to_pick,@Lot,exp_date,reserved,ser_num,u_m,lot_tracked,ser_tracked,orig_loc			FROM tmp_pick_list_loc where process_id = @ProcessId and pick_list_id = @PPickListID and		pick_group = @Seq
END

ELSE IF (Select count(*) from tmp_pick_list_loc where process_id = @ProcessId and pick_list_id = @PPickListID and pick_group = @Seq AND loc IS NULL AND ((lot is null and @LotTracked = 1) OR @LotTracked = 0)) > 0
BEGIN
	UPDATE tmp_pick_list_loc SET qty_pick = @QtyPicked, loc = @Loc, lot = @Lot where process_id = @ProcessId and pick_list_id	 = @PPickListID AND pick_group = @Seq
END

EXEC	@Severity = [dbo].[PickConfirmationCompleteSp]
		@ProcessId = @ProcessId,
		@PPickListID = @PPickListID,
		@RecordDiff = 1,
		@Infobar = @Infobar OUTPUT

IF @Severity <> 0
BEGIN
	DELETE tmp_pick_list_loc WHERE process_id = @ProcessId
	Return @Severity
END

-- Clear all entries for this session        
DELETE tmp_pick_list_loc
WHERE process_id = @ProcessId

EXEC dbo.CloseSessionContextSp @SessionID = @SessionID
GO

