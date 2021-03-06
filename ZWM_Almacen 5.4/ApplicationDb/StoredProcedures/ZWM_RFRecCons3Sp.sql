/****** Object:  StoredProcedure [dbo].[ZWM_RFRecCons3Sp]    Script Date: 01/20/2015 15:14:58 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ZWM_RFRecCons3Sp]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ZWM_RFRecCons3Sp]
GO

/****** Object:  StoredProcedure [dbo].[ZWM_RFRecCons3Sp]    Script Date: 01/20/2015 15:14:58 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


/*
Ejecuta el proceso de confirmacion y genera las transacciiones de recepcion

Si Confirmation  = 0, Procesa y borra los registros de la tabla temporal
Si Confirmation  = 1, Procesa y no borra los registros de la tabla temporal
*/

CREATE PROCEDURE [dbo].[ZWM_RFRecCons3Sp] (
     @Site				SiteType
	,@UserName			UserNameType	= NULL
  	,@Id				ZwmIdRFConsType = NULL
	,@Whse				WhSEType		= NULL
	,@Confirmation		FlagNyType
	,@Infobar			InfobarType OUTPUT
)
AS


   -- Check for existence of Generic External Touch Point routine (this section was generated by SpETPCodeSp AND inserted by CallETPs.exe):
   IF OBJECT_ID(N'dbo.EXTGEN_ZWM_RFRecCons3Sp') IS NOT NULL
   BEGIN
      DECLARE @EXTGEN_SpName sysname
      SET @EXTGEN_SpName = N'dbo.EXTGEN_ZWM_RFRecCons3Sp'
      -- Invoke the ETP routine, passing in (AND out) this routine's parameters:
      DECLARE @EXTGEN_Severity int
      EXEC @EXTGEN_Severity = @EXTGEN_SpName
		@Site
		,@UserName
  		,@Id
  		,@Whse
		,@Confirmation 
		,@Infobar	OUTPUT
 
      -- ETP routine can RETURN 1 to signal that the remainder of this stANDard routine should now proceed:
      IF @EXTGEN_Severity <> 1
         RETURN @EXTGEN_Severity
   END
   -- End of Generic External Touch Point code.

--Inicio de Sesion
DECLARE	@return_value int,
		@sessionId            RowPointerType

SET @UserName = isnull(@UserName,'sa')

EXEC	@return_value = [dbo].[InitSessionContextWithUserSp]
		@ContextName = 'ZWM',
		@UserName = @UserName,
		@SessionID = @SessionID OUTPUT,
		@Site = @Site

--Solo para implementacion Barugel Azulay
DECLARE @BAR FlagNyTYpe
IF (SELECT count(*) FROM zwm_parms WHERE customer = 'BAR') > 0
	SET @BAR = 1 

DECLARE @Severity int
SET @Severity = 0

------------------------------ SET NULLs
IF LEN(LTRIM(@Id)) = 0 SET @Id = NULL
IF LEN(LTRIM(@Whse)) = 0 SET @Whse = NULL
------------------------------ SET NULLs

-- Si el par�metro de dep�sito es NULL, tomar el dep�sito principal, sino verifica que exista
IF @Whse IS NULL
		SELECT @Whse = def_whse FROM invparms
ELSE IF(SELECT Whse FROM Whse WHERE whse = @Whse) IS NULL
BEGIN
	SET @Infobar = 'El almac�n no existe'
	SET @Severity = 16
	RETURN @severity
END

-- tabla con los parametros del SP
DECLARE @RECRF TABLE
(
  TransDate			  DateType
, Whse				  WhSEType
, PoNum				  PoNumType
, PoLine			  PoLineType
, PoRelease			  PoReleaSEType
, QtyToReceive		  QtyUnitType
, QtyToReject		  QtyUnitType
, Tran1UM			  UMType
, ReturnX			  ListYesNoType
, HaveItem			  ListYesNoType
, Itemx				  ItemType
, Loc                 LocType
, Lot				  LotType
, ReasonCode		  ReasonCodeType
, Cost				  CostPrcType
, Material			  CostPrcType
, Duty				  CostPrcType
, Freight		      CostPrcType
, Brokerage			  CostPrcType
, Insurance			  CostPrcType
, LocFrt			  CostPrcType
, Consign			  ListYesNoType
, PackNum			  GrnPackNumType
, WorkKey			  RefStrType
, GRNExists			  ListYesNoType
, GrnNum			  GrnNumType
, GrnLine			  GrnLineType
, Infobar			  InfobarType
, ImportDocId		  ImportDocIdType
, EmpNum			  EmpNumType
, ZlaForCost          CostPrcType
, ZlaForMaterial      CostPrcType
, ZlaForDuty          CostPrcType
, ZlaForFreight       CostPrcType
, ZlaForBrokerage     CostPrcType
, ZlaForInsurance     CostPrcType
, ZlaForLocFrt        CostPrcType
, ZlaPackNum		  VendInvoiceType
)

---------------------------------------------------------------------- tabla temporal que carga las lecturas RF
DECLARE @LecturasRF TABLE(
id nvarchar(15),item nvarchar(30),qty decimal(19,8),whse nvarchar(4),loc nvarchar(15),lot nvarchar(15),qty_proc decimal(19,9),emp nvarchar(7),co_num nvarchar(10), co_line smallint ,co_release smallint
)

INSERT INTO @LecturasRF(id,item,qty,whse,loc,lot,qty_proc,emp,co_num,co_line,co_release)
	SELECT id,item,SUM(qty_um_std+qty_um_stk1+qty_um_stk2),whse,loc,lot,0,employee, co_num, co_line, co_release
	FROM zwm_tmp_rf_rec_cons2_mst
	WHERE id = @Id AND whse = @whse AND (status IS NULL or (status != 'P' AND status != 'E'))
	GROUP BY id,item,lot,whse,loc,employee, co_num, co_line, co_release
---------------------------------------------------------------------- /tabla temporal que carga las lecturas RF

DECLARE
@itemLineGrn	ItemType
,@qtyLineGrn	QtyUnitType
,@Grn			GrnNumTYpe
,@GrnLine		GrnLineType
,@Po			PoNumType
,@Poitem		PoLineType
,@PoRelease		PoReleaSEType
,@RefNum		CoNumType
,@RefLine		CoLineType
,@RefRelease	CoReleaSEType

,@qtyRec		QtyUnitType
,@Loc			LocType
,@Lot			LotType
,@qtyProc		QtyUnitType
,@Emp			EmpNumType

,@qtyGrnLineRcvd QtyUnitType
,@qtyRestante QtyUnitType

,@ZlaForCost CostPrcType
,@ZlaForMaterial CostPrcType
,@ZlaForDuty CostPrcType
,@ZlaForFreight CostPrcType
,@ZlaForBrokerage CostPrcType
,@ZlaForInsurance CostPrcType
,@ZlaForLocFrt CostPrcType
,@PackNum nvarchar(22)

---variables de conversion de unidades
,@UMItem               UMType
,@QtyConverted         QtyUnitType
,@OutQty               int


declare 
@Tran1UM UMType,
@GrnUM UMType,
@ReasonCode ReasonCodeType,
@Cost CostPrcType,
@Duty CostPrcType,
@Freight CostPrcType,
@Brokerage CostPrcType,
@Insurance CostPrcType,
@LocFrt CostPrcType,
@Material CostPrcType

------------------------------------------------------------------ cursor que recorre las lineas de grn
DECLARE CursorGRN CURSOR LOCAL STATIC FOR

	SELECT poi.item,grn.qty_shipped_conv,grn.qty_rec,grn.u_m,grn.grn_num,grn.grn_line,poi.po_num,poi.po_line,poi.po_release
	,poi.ref_num, poi.ref_line_suf, poi.ref_release
	--campos para la tabla @RECRF

	,item_cost, unit_mat_cost, unit_duty_cost, unit_loc_frt_cost, unit_insurance_cost, unit_freight_cost, unit_brokerage_cost
	,poi.zla_for_item_cost,poi.zla_for_unit_mat_cost,poi.zla_for_unit_duty_cost,poi.zla_for_unit_freight_cost,poi.zla_for_unit_brokerage_cost,poi.zla_for_unit_insurance_cost,poi.zla_for_unit_loc_frt_cost	

	FROM grn_line grn
	INNER JOIN zwm_tmp_rf_cons1_mst rf
	on grn.grn_num = rf.grn_num AND grn.vend_num = rf.vend_num
	INNER JOIN poitem poi
	ON grn.po_line =  poi.po_line
	WHERE rf.id_rec_cons = @Id
	AND grn.po_num = poi.po_num
	ORDER BY poi.item

OPEN CursorGRN
WHILE 1=1
BEGIN
	FETCH CursorGRN INTO
		@itemLineGrn,@qtyLineGrn,@qtyGrnLineRcvd,@GrnUM,@Grn,@GrnLine,@Po,@Poitem,@PoRelease,@RefNum,@RefLine,@RefRelease,

		@Cost,@Material,@Duty,@LocFrt,@Insurance,@Freight,@Brokerage,
		@ZlaForCost,@ZlaForMaterial,@ZlaForDuty,@ZlaForFreight,@ZlaForBrokerage,@ZlaForInsurance,@ZlaForLocFrt
		
		IF @@FETCH_STATUS <> 0
			BREAK

	--convierte a UM estANDar
	SET @UMItem = ( SELECT u_m FROM item WHERE item = @itemLineGrn )
	EXEC @Severity = dbo.UMConvQtySp
		@UM               = @GrnUM
	  , @Item             = @itemLineGrn
	  , @VendNum          = NULL
	  , @Area             = NULL
	  , @ConvertToBase    = 1
	  , @QtyToBeConverted = @qtyLineGrn
	  , @OutQty           = @QtyConverted OUTPUT --devuelve la cantidad convertida
	  , @Infobar          = @Infobar      OUTPUT

	SET @qtyLineGrn = @QtyConverted

	--SET @qtyGrnLineRcvd = 0
	SET @qtyRestante = @qtyLineGrn - @qtyGrnLineRcvd

	---------------------------------------------------------------------------------------- Cargo variables
	SELECT @Tran1UM = u_m FROM item WHERE item = @itemLineGrn
	SELECT @PackNum = ZWM_packNumber FROM grn_hdr WHERE grn_num = @Grn
	---------------------------------------------------------------------------------------- /Cargo variables	
					
			DECLARE CurRF CURSOR LOCAL STATIC FOR
				SELECT qty,whse,loc,lot,qty_proc,emp
					FROM @LecturasRF
					WHERE item = @itemLineGrn 
					AND ((co_num IS NULL AND @RefNum IS NULL) or co_num = @RefNum)
					AND ((co_line IS NULL AND @RefLine = 0) or co_line = @RefLine)
					AND ((co_release IS NULL AND @RefRelease = 0) or co_release = @RefRelease)

			OPEN curRF
			WHILE 1=1
			BEGIN
				FETCH CurRF INTO @qtyRec,@whse,@Loc,@Lot,@qtyProc,@Emp
				IF @@FETCH_STATUS <> 0
					BREAK
						
					IF (@qtyRestante > @qtyRec - @qtyProc) AND (@qtyRec - @qtyProc > 0)
					
					BEGIN
						INSERT INTO @RECRF (
						TransDate,Whse, PoNum, PoLine, PoRelease, QtyToReceive,QtyToReject,Tran1UM,ReturnX,HaveItem,Itemx,
						Loc,Lot,ReasonCode,Cost,Material,Duty,Freight,Brokerage,insurance,LocFrt,Consign,PackNum,WorkKey,
						GRNExists,GrnNum,GrnLine,Infobar,ImportDocId,EmpNum,ZlaForCost,ZlaForMaterial,ZlaForDuty,
						ZlaForFreight,ZlaForBrokerage,ZlaForInsurance,ZlaForLocFrt,ZlaPackNum
						)VALUES(
						GETDATE(),@whse,@Po,@Poitem,@PoRelease,@qtyRec - @qtyProc,0,@Tran1UM,0,1,@itemLineGrn,
						@Loc,@Lot,NULL,@Cost,@Material,@Duty,@Freight,@Brokerage,@Insurance,@LocFrt,null,@PackNum,						null,
						1,@Grn,@GrnLine,null,null,@Emp,@ZlaForCost,@ZlaForMaterial,@ZlaForDuty,
						@ZlaForFreight,@ZlaForBrokerage,@ZlaForInsurance,@ZlaForLocFrt,null
						)

						SET @qtyGrnLineRcvd = @qtyGrnLineRcvd + (@qtyRec - @qtyProc)
						SET @qtyRestante = @qtyLineGrn - @qtyGrnLineRcvd

						UPDATE @LecturasRF SET @qtyProc = @qtyRec
						WHERE item = @itemLineGrn AND whse = @whse AND loc = @Loc AND lot = @Lot
					END
					ELSE IF @qtyRestante > 0 AND (@qtyRec - @qtyProc > 0)
					BEGIN
						INSERT INTO @RECRF (
						TransDate,Whse, PoNum, PoLine, PoRelease, QtyToReceive,QtyToReject,Tran1UM,ReturnX,HaveItem,Itemx,
						Loc,Lot,ReasonCode,Cost,Material,Duty,Freight,Brokerage,insurance,LocFrt,Consign,PackNum,WorkKey,
						GRNExists,GrnNum,GrnLine,Infobar,ImportDocId,EmpNum,ZlaForCost,ZlaForMaterial,ZlaForDuty,
						ZlaForFreight,ZlaForBrokerage,ZlaForInsurance,ZlaForLocFrt,ZlaPackNum
						)VALUES(
						GETDATE(),@whse,@Po,@Poitem,@PoRelease,@qtyRestante,0,@Tran1UM,0,1,@itemLineGrn,
						@Loc,@Lot,@ReasonCode,@Cost,@Material,@Duty,@Freight,@Brokerage,@Insurance,@LocFrt,null,@PackNum,null,
						0,@Grn,@GrnLine,null,null,null,@ZlaForCost,@ZlaForMaterial,@ZlaForDuty,
						@ZlaForFreight,@ZlaForBrokerage,@ZlaForInsurance,@ZlaForLocFrt,null
						)

						UPDATE @LecturasRF SET @qtyProc = @qtyRestante + @qtyProc
						WHERE item = @itemLineGrn AND whse = @whse AND loc = @Loc AND lot = @Lot

						SET @qtyGrnLineRcvd = @qtyGrnLineRcvd + @qtyRestante
						SET @qtyRestante = @qtyLineGrn - @qtyGrnLineRcvd
					END
					
			END
			CLOSE CurRF
			DEALLOCATE CurRF
END

CLOSE CursorGRN
DEALLOCATE CursorGRN

---------------------------------------------------------------------------------------------- confirma la recepci�n
DECLARE
@TransDate				DateType,
@PoNum					PoNumType,
@PoLine					PoLineType,
@QtyToReceive			QtyUnitType,
@QtyToReject			QtyUnitType,
@HaveItem				ListYesNoType,
@Return					ListYesNoType,
@Item					ItemType,
@Consign				ListYesNoType,
@WorkKey				RefStrType,
@GRNExists				ListYesNoType,
@GrnNum					GrnNumType,
@ImportDocId			ImportDocIdType,
@EmpNum					EmpNumType,
@ZlaPackNum				VendInvoiceType
,@cantLecturas			int
,@counter				int
,@RecordProcessed		int

SET @cantLecturas = (SELECT count(TransDate) FROM @RECRF) --cantidad de registros
SET @counter = 0 

DECLARE ExecRecCons CURSOR LOCAL STATIC FOR
SELECT * FROM @RECRF

BEGIN TRANSACTION

OPEN ExecRecCons
WHILE 1=1
BEGIN

	FETCH ExecRecCons INTO
	@TransDate,@Whse,@PoNum,@PoLine,@PoRelease,@QtyToReceive,@QtyToReject,@Tran1UM,@Return,@HaveItem,@Item,@Loc,@Lot,@ReasonCode,@Cost,@Material,@Duty,@Freight,@Brokerage,@Insurance,@LocFrt,@Consign,@PackNum,@WorkKey,@GRNExists,@GrnNum,@GrnLine,@Infobar,@ImportDocId,@EmpNum,@ZlaForCost,@ZlaForMaterial,@ZlaForDuty,@ZlaForFreight,@ZlaForBrokerage,@ZlaForInsurance,@ZlaForLocFrt,@ZlaPackNum

	IF @@FETCH_STATUS <> 0
		BREAK
		
		--Creo si no existe la relacion del item con ubicacion y deposito
		IF (SELECT TOP 1 Loc FROM ItemLoc WHERE ItemLoc.item = @Item AND ItemLoc.whse = @whse AND ItemLoc.loc = @Loc ) IS NULL
			BEGIN
			EXEC	@Severity = [dbo].[ItemWhstkSp]
					@PBegItem = @Item,
					@PEndItem = @Item,
					@PWhse = @whse,
					@PLoc = @Loc,
					@PMrbFlag = 0,
					@PPermFlag = 0,
					@RecordProcessed = @RecordProcessed OUTPUT,
					@Infobar = @Infobar OUTPUT
			END

			IF @Severity <> 0
			BEGIN
				ROLLBACK TRANSACTION
				SET @Infobar = 'Error: ' + @Infobar
				SET @Severity = 16
				RETURN @Severity
			END 

		--Creo el lote si no existe aun		
		IF (SELECT TOP 1 lot FROM Lot WHERE Lot.item = @Item AND Lot.lot = @Lot) IS NULL
			BEGIN
			EXEC	@Severity = [dbo].[LotAddSp]
					@Item = @Item,
					@Lot = @Lot,
					@RcvdQty = @QtyToReceive,
					@FROMPO = 1,
					@VendLot = NULL,
					@CreateNonUnique = NULL,
					@Infobar = @Infobar OUTPUT,
					@Site = @Site
			END

			IF @Severity <> 0
			BEGIN
				ROLLBACK TRANSACTION
				SET @Infobar = 'Error: ' + @Infobar
				SET @Severity = 16
				RETURN @Severity
			END 
		
		--Realizo la recepcion
		EXEC @Severity = dbo.[ZLA_PoReceivingTrxPostSp]
		@TransDate			   = @TransDate
		, @Whse				   = @Whse
		, @PoNum			   = @PoNum
		, @PoLine			   = @PoLine
		, @PoRelease		   = @PoRelease
		, @QtyToReceive		   = @QtyToReceive
		, @QtyToReject		   = @QtyToReject
		, @Tran1UM			   = @Tran1UM
		, @Return			   = @Return
		, @HaveItem			   = @HaveItem
		, @Item				   = @Item
		, @Loc				   = @Loc
		, @Lot				   = @Lot
		, @ReasonCode		   = @ReasonCode
		, @Cost				   = @Cost
		, @Material			   = @Material
		, @Duty				   = @Duty
		, @Freight			   = @Freight
		, @Brokerage		   = @Brokerage
		, @Insurance		   = @Insurance
		, @LocFrt			   = @LocFrt
		, @Consign			   = @Consign
		, @PackNum			   = @PackNum
		, @WorkKey			   = @WorkKey
		, @GRNExists		   = @GRNExists
		, @GrnNum			   = @GrnNum
		, @GrnLine			   = @GrnLine
		, @Infobar			   = @Infobar
		, @ImportDocId		   = @ImportDocId
		, @EmpNum			   = @EmpNum
		, @ZlaForCost          = @ZlaForCost
		, @ZlaForMaterial      = @ZlaForMaterial
		, @ZlaForDuty          = @ZlaForDuty
		, @ZlaForFreight       = @ZlaForFreight
		, @ZlaForBrokerage     = @ZlaForBrokerage
		, @ZlaForInsurance     = @ZlaForInsurance
		, @ZlaForLocFrt        = @ZlaForLocFrt
		, @ZlaPackNum		   = @ZlaPackNum

			IF @Severity <> 0
			BEGIN
				ROLLBACK TRANSACTION
				SET @Infobar = 'Error: ' + @Infobar
				SET @Severity = 16
				RETURN @Severity
			END 

		-- luego de hacer la recepcion, si el articulo tiene atributos de lote se deben insertar en la tabla attribute_value
		INSERT INTO attribute_value(
	   [RefRowPointer]
		,[deci_attribute1],[deci_attribute2],[deci_attribute3],[deci_attribute4],[deci_attribute5]
		,[deci_attribute6],[deci_attribute7],[deci_attribute8],[deci_attribute9],[deci_attribute10]
		,[char_attribute1],[char_attribute2],[char_attribute3],[char_attribute4],[char_attribute5]
	   ,[char_attribute6],[char_attribute7],[char_attribute8],[char_attribute9],[char_attribute10]
	   ,[logi_attribute]
	   )
	   SELECT DISTINCT l.RowPointer 
	   ,rf.deci_attribute1,rf.deci_attribute2,rf.deci_attribute3,rf.deci_attribute4,rf.deci_attribute5,rf.deci_attribute6,rf.deci_attribute7,rf.deci_attribute8,rf.deci_attribute9,rf.deci_attribute10
	   ,rf.char_attribute1,rf.char_attribute2,rf.char_attribute3,rf.char_attribute4,rf.char_attribute5,rf.char_attribute6,rf.char_attribute7,rf.char_attribute8,rf.char_attribute9,rf.char_attribute10
	   ,0
	   FROM lot l
	   JOIN zwm_tmp_rf_rec_cons2_mst rf
	   ON l.lot = rf.lot
	   WHERE 
	   (rf.deci_attribute1 IS NOT NULL or rf.deci_attribute2 IS NOT NULL or rf.deci_attribute3 IS NOT NULL or rf.deci_attribute4 is		not null or rf.deci_attribute5 IS NOT NULL or rf.deci_attribute6 IS NOT NULL or rf.deci_attribute7 IS NOT NULL or rf.			deci_attribute8 IS NOT NULL or rf.deci_attribute9 IS NOT NULL or rf.deci_attribute10 IS NOT NULL or 
	   rf.char_attribute1 IS NOT NULL or rf.char_attribute2 IS NOT NULL or rf.char_attribute3 IS NOT NULL or rf.char_attribute4 is		not null or rf.char_attribute5 IS NOT NULL or rf.char_attribute6 IS NOT NULL or rf.char_attribute7 IS NOT NULL or rf.			char_attribute8 IS NOT NULL or rf.char_attribute9 IS NOT NULL or rf.char_attribute10 IS NOT NULL)
	   AND l.RowPointer not in (SELECT RefRowPointer FROM attribute_value)
	   AND @Id = rf.id AND l.lot = @Lot AND l.item = @item

		IF @Severity <> 0
		BEGIN
			ROLLBACK TRANSACTION
			SET @Infobar = 'Error: ' + @Infobar
			SET @Severity = 16
			RETURN @Severity
			
		END 
		ELSE 
		BEGIN 
			SET @counter = @counter + 1	

			UPDATE zwm_tmp_rf_rec_cons2_mst SET status = 'P' 
			WHERE id = @Id
			AND item = @item
			AND whse = @whse
			AND lot = @Lot
			AND loc = @Loc
			AND status IS NULL
		END
END

IF (@cantLecturas = @counter) AND (@cantLecturas <> 0) AND (@Confirmation = 1)
BEGIN
	COMMIT TRANSACTION
	UPDATE grn_hdr SET stat = 'A' FROM zwm_tmp_rf_cons1_mst rf WHERE grn_hdr.grn_num = rf.grn_num AND rf.id_rec_cons = @Id AND rf.Whse = @Whse--Pone el GRN como aprobado para habilitar su facturacion
	SET @Infobar = 'Recepci�n consolidada terminada'
END
ELSE IF (@cantLecturas = @counter) AND (@cantLecturas <> 0) AND (@Confirmation = 0)
BEGIN
	COMMIT TRANSACTION
	UPDATE grn_hdr SET stat = 'A' FROM zwm_tmp_rf_cons1_mst rf WHERE grn_hdr.grn_num = rf.grn_num AND rf.id_rec_cons = @Id AND rf.Whse = @Whse--Pone el GRN como aprobado para habilitar su facturacion
	DELETE FROM zwm_tmp_rf_rec_cons2_mst WHERE id = @Id AND Whse = @Whse   --borra las lecturas
	DELETE FROM zwm_tmp_rf_cons1_mst WHERE id_rec_cons = @Id AND Whse = @Whse --borra el ID de recepcion
	SET @Infobar = 'Recepci�n consolidada terminada'
END
ELSE IF (@cantLecturas = 0)
BEGIN
	ROLLBACK TRANSACTION
	SET @Infobar = 'No existe recepci�n consolidada con el ID ingresado'
	SET @Severity = 16
END
ELSE
BEGIN
	ROLLBACK TRANSACTION
	SET @Infobar = 'Se encontro un error en el proceso, verifique los datos ingresados no procesados'
	SET @Severity = 16
END

CLOSE ExecRecCons
DEALLOCATE ExecRecCons

EXEC dbo.CloseSessionContextSp @SessionID = @SessionID

RETURN @Severity
GO


