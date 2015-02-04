/****** Object:  StoredProcedure [dbo].[ZWM_RFRecTransfer2Sp]    Script Date: 01/20/2015 15:16:22 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ZWM_RFRecTransfer2Sp]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ZWM_RFRecTransfer2Sp]
GO

/****** Object:  StoredProcedure [dbo].[ZWM_RFRecTransfer2Sp]    Script Date: 01/20/2015 15:16:22 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[ZWM_RFRecTransfer2Sp] (
  @Site				SiteType
  ,@UserName		UserNameType		= NULL
  ,@Id	            ZwmIdRFConsType		= NULL
  ,@Whse            WhseType			= NULL
  ,@Item            ItemType			= NULL
  ,@QtyUMStd        QtyUnitType			= NULL
  ,@QtyUMStock1     QtyUnitType			= NULL
  ,@QtyUMStock2     QtyUnitType			= NULL
  ,@Loc             LocType				= NULL
  ,@Lot             LotType				= NULL
  ,@ContNumber      ZwmContNumberType	= NULL
  ,@Emp				EmpNumType			= NULL
  ,@Infobar		    InfobarType			= NULL OUTPUT
)
AS

   -- Check for existence of Generic External Touch Point routine (this section was generated by SpETPCodeSp and inserted by CallETPs.exe):
   IF OBJECT_ID(N'dbo.EXTGEN_ZWM_RFRecCons2Sp') IS NOT NULL
   BEGIN
      DECLARE @EXTGEN_SpName sysname
      SET @EXTGEN_SpName = N'dbo.EXTGEN_ZWM_RFRecCons2Sp'
      -- Invoke the ETP routine, passing in (and out) this routine's parameters:
      DECLARE @EXTGEN_Severity int
      EXEC @EXTGEN_Severity = @EXTGEN_SpName
		   @Site
		  ,@UserName
		  ,@Id
		  ,@Whse
		  ,@Item
		  ,@QtyUMStd
		  ,@QtyUMStock1
		  ,@QtyUMStock2
		  ,@Loc
		  ,@Lot
		  ,@ContNumber
		  ,@Emp
		  ,@Infobar	OUTPUT
 
   -- ETP routine can RETURN 1 to signal that the remainder of this standard routine should now proceed:
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
IF (Select count(*) from zwm_parms where customer = 'BAR') > 0
	Set @BAR = 1

DECLARE @Severity int
,@tracked ListYesNoType

SET @Severity = 0
SET @Lot = dbo.ExpandKyByType('LotType',@Lot)
SET @Emp = dbo.ExpandKyByType('EmpNumType',@Emp)

------------------------------ SET NULLs
If (len(ltrim(@Id)) = 0) SET @Id = NULL
IF LEN(LTRIM(@Whse)) = 0 SET @Whse = NULL
If (len(ltrim(@Item )) = 0) SET @Item  = NULL
IF LEN(LTRIM(@QtyUMStd)) = 0 SET @QtyUMStd = NULL
If (len(ltrim(@QtyUMStock1)) = 0) SET @QtyUMStock1 = NULL
IF LEN(LTRIM(@QtyUMStock2)) = 0 SET @QtyUMStock2 = NULL
If (len(ltrim(@Loc )) = 0) SET @Loc  = NULL
IF LEN(LTRIM(@Lot )) = 0 SET @Lot  = NULL
If (len(ltrim(@ContNumber)) = 0) SET @ContNumber = NULL
IF LEN(LTRIM(@Emp	)) = 0 SET @Emp	 = NULL
------------------------------ SET NULLs

IF NOT EXISTS(SELECT item FROM item WHERE item = @Item)
BEGIN
	SET @Infobar = 'El art�culo no existe'
	SET @Severity = 16
	RETURN @severity
END
	
	SELECT @tracked = lot_tracked FROM item WHERE item = @Item 

	IF (@tracked = 1 AND @Lot IS NULL)
	BEGIN
		SET @Infobar = 'Se debe ingresar un lote'
		SET @Severity = 16
		RETURN @severity
	END


-- Si el par�metro de dep�sito es NULL, tomar el dep�sito principal; sino verificar que exista
IF @Whse IS NULL
	SELECT @Whse = def_whse FROM invparms
ELSE IF(SELECT Whse FROM Whse WHERE whse = @Whse) IS NULL
BEGIN
	SET @Infobar = 'El almac�n no existe'
	SET @Severity = 16
	RETURN @severity
END

--El whse debe estar asociado al Id
	IF(SELECT whse FROM zwm_tmp_rf_rec_transfer1_mst WHERE whse = @Whse and id_rec = @Id)IS NULL
	BEGIN
		SET @Infobar = 'El almacen no corresponde con la recepcion consolidada'
		SET @Severity = 16
		RETURN @severity
	END

-- Si el par�metro de ubicaci�n es NULL, tomar la ubicaci�n de recepcion; caso contrario verificar que la ubicaci�n exista
	IF @Loc IS NULL
		SELECT @Loc = transfer_loc FROM zwm_parms
	ELSE IF(SELECT loc FROM location WHERE loc = @Loc) IS NULL
		BEGIN
			SET @Infobar = 'La ubicaci�n no existe'
			SET @Severity = 16
			RETURN @severity
		END
		
/* 16.2 */		
-- Si al recibir el art�culo asociado a un ID o GRN, el art�culo tuviera asociaci�n (pedido de ventas) debe verificar que el dato del pedido sea v�lido y que la cantidad no supere la asociada para cada pedido o a stock.
/*
DECLARE 
@RefUnica FlagNyTYpe
,@ExisteRef FlagNyTYpe
,@RefNum	CoJobProjTrnNumType
,@RefLine	CoLineSuffixProjTaskTrnLineType
,@RefRel	CoReleaseOperNumType

Set @ExisteRef = 0
Set @RefUnica = 0

select @RefUnica = Count(*)
from poitem poi
join grn_line grn
on poi.po_num = grn.po_num and poi.po_line = grn.po_line and poi.po_release = grn.po_release
join zwm_rf_cons1_mst rf
on grn.grn_num = rf.grn_num and grn.vend_num = rf.vend_num
where rf.id_rec_cons = @Id
and poi.item = @Item

If @RefUnica = 1 and @CoNum is null and @CoLine is null and @CoRelease is null
BEGIN
	select @CoNum = poi.ref_num, @CoLine = poi.ref_line_suf, @CoRelease = poi.ref_release, @ExisteRef = 1
	from poitem poi
	join grn_line grn
	on poi.po_num = grn.po_num and poi.po_line = grn.po_line and poi.po_release = grn.po_release
	join zwm_rf_cons1_mst rf
	on grn.grn_num = rf.grn_num and grn.vend_num = rf.vend_num
	where rf.id_rec_cons = @Id
	and poi.ref_num is not null and poi.ref_line_suf is not null and poi.ref_release is not null
END
ELSE
BEGIN
	select @ExisteRef = 1
	from poitem poi
	join grn_line grn
	on poi.po_num = grn.po_num and poi.po_line = grn.po_line and poi.po_release = grn.po_release
	join zwm_rf_cons1_mst rf
	on grn.grn_num = rf.grn_num and grn.vend_num = rf.vend_num
	where rf.id_rec_cons = @Id
	and 
	(@CoNum + cast(@CoLine as nvarchar(10)) + cast(@CoRelease as nvarchar(10)) 
	= poi.ref_num + cast(poi.ref_line_suf as nvarchar(10)) + cast(poi.ref_release as nvarchar(10)))
END

IF (@ExisteRef = 0 and (@CoNum is not null or @CoLine is not null or @CoRelease is not null))
	BEGIN 
		SET @Severity = 16
		SET @Infobar = 'Referencia a pedido incorrecta'
		RETURN @severity
	END
*/


-- Verifica si el articulo esta asociado al GRN.
/*
DECLARE @ExisteItem FlagNyTYpe

Set @ExisteItem = 0

select top 1 @ExisteItem = 1
from poitem poi
join grn_line grn
on poi.po_num = grn.po_num and poi.po_line = grn.po_line and poi.po_release = grn.po_release
join zwm_rf_cons1_mst rf
on grn.grn_num = rf.grn_num and grn.vend_num = rf.vend_num
where rf.id_rec_cons = @Id
and @Item = poi.item

IF (@ExisteItem = 0)
	BEGIN 
		SET @Severity = 16
		SET @Infobar = 'El item no existe en el NRM'
		RETURN @severity
	END
*/

/*

/* la suma de las cantidades correspondientes al mismo art�culo y mismo ID superan la cantidad indicada como despachada en las Transferencias asociadas al mismo ID y mismo item */
DECLARE 
 @cantidad             decimal(19,8)
,@cantidad_grn         decimal(19,8)
,@cantidad_grn_conv    decimal(19,8)
,@cantidad_grn_tol	   decimal(19,8)
,@cantidadrec_grn	   decimal(19,8)
,@UM_grn			   UMType
,@UMItem               UMType
,@QtyBoxConverted      QtyUnitType
,@QtyPalletConverted   QtyUnitType
,@OutQty               int
,@UMStk1			   UMType
,@UMStk2			   UMType
,@RcvdUnderTol		   TolerancePercentType
,@RcvdOverTol		   TolerancePercentType
,@RcvdUnderTolGen	   TolerancePercentType
,@RcvdOverTolGen	   TolerancePercentType

Select @RcvdOverTol = rcvd_over_po_qty_tolerance, @RcvdUnderTol = rcvd_under_po_qty_tolerance from item where item.item = @Item
select @RcvdOverTolGen = rcvd_over_po_qty_tolerance,@RcvdUnderTolGen = rcvd_under_po_qty_tolerance from poparms
SET @RcvdOverTol = ISNULL(ISNULL(@RcvdOverTol,@RcvdOverTolGen),0)
SET @RcvdUnderTol = ISNULL(ISNULL(@RcvdUnderTol,@RcvdUnderTolGen),0)

SET @QtyBoxConverted = 0
SET @QtyPalletConverted = 0

set @QtyUMStd = isnull(@QtyUMStd,0)
set @QtyUMStock1 = isnull(@QtyUMStock1,0) 
set @QtyUMStock2 = isnull(@QtyUMStock2,0) 

IF @QtyUMStock1 > 0
BEGIN
	--convierte las cantidades de cajas a UM estandar
	set @UMStk1 = ( SELECT ZWM_UMStock1 FROM item WHERE item = @Item )
	EXEC @Severity = dbo.UMConvQtySp
		@UM               = @UMStk1
	  , @Item             = @Item
	  , @VendNum          = NULL
	  , @Area             = NULL
	  , @ConvertToBase    = 1
	  , @QtyToBeConverted = @QtyUMStock1 
	  , @OutQty           = @QtyBoxConverted OUTPUT --devuelve la cantidad convertida
	  , @Infobar          = @Infobar       OUTPUT
END

IF @QtyUMStock2 > 0
BEGIN
	--convierte las cantidades de pallets a UM estandar
	set @UMStk2 = ( SELECT ZWM_UMStock2 FROM item WHERE item = @Item )
	EXEC @Severity = dbo.UMConvQtySp
		@UM               = @UMStk2
	  , @Item             = @Item
	  , @VendNum          = NULL
	  , @Area             = NULL
	  , @ConvertToBase    = 1
	  , @QtyToBeConverted = @QtyUMStock2 
	  , @OutQty           = @QtyPalletConverted OUTPUT --devuelve la cantidad convertida
	  , @Infobar          = @Infobar       OUTPUT
END


/*
--cantidad rf 
SET @cantidad = (SELECT SUM(ISNULL(rf.qty_um_std,0)+ISNULL(rf.qty_um_stk1,0)+ISNULL(rf.qty_um_stk2,0))
FROM zwm_rf_rec_cons2_mst rf 
WHERE rf.item = @Item AND rf.id = @Id
AND ((@CoNum is null and rf.co_num is null) or @CoNum = rf.co_num)
AND ((@CoLine is null and rf.co_line is null) or @CoLine = rf.co_line)
AND ((@CoRelease is null and rf.co_release is null) or @CoRelease = rf.co_release)
)

SET @cantidad = ISNULL(@Cantidad, 0)


--ESTO TIENE UN ERROR, UNA OC PUEDE TENER VARIAS LINEAS PARA EL MISMO ITEM CON UM DIFERENTES, CALCULA INCORRECTAMENTE EN ESE CASO
--cantidad del grn
SET @cantidad_grn = (SELECT SUM(grn.qty_shipped_conv)
FROM grn_line grn
INNER JOIN zwm_rf_cons1_mst rf
on grn.grn_num = rf.grn_num and grn.vend_num = rf.vend_num
INNER JOIN poitem poi
ON grn.po_num = poi.po_num AND grn.po_line = poi.po_line AND grn.po_release = poi.po_release
WHERE rf.id_rec_cons = @Id AND poi.item = @Item
AND ((@CoNum is null and poi.ref_num is null)or @CoNum = poi.ref_num)
AND ((@CoLine is null and poi.ref_line_suf = 0)or @CoLine = poi.ref_line_suf)
AND ((@CoRelease is null and poi.ref_release = 0)or @CoRelease = poi.ref_release)
)

SET @cantidad_grn = ISNULL(@Cantidad_grn, 0)

--cantidad recibida del grn
SET @cantidadrec_grn = (SELECT SUM(grn.qty_rec)
FROM grn_line grn
INNER JOIN zwm_rf_cons1_mst rf
on grn.grn_num = rf.grn_num and grn.vend_num = rf.vend_num
INNER JOIN poitem poi
ON grn.po_num = poi.po_num AND grn.po_line = poi.po_line AND grn.po_release = poi.po_release
WHERE rf.id_rec_cons = @Id AND poi.item = @Item
AND ((@CoNum is null and poi.ref_num is null)or @CoNum = poi.ref_num)
AND ((@CoLine is null and poi.ref_line_suf = 0)or @CoLine = poi.ref_line_suf)
AND ((@CoRelease is null and poi.ref_release = 0)or @CoRelease = poi.ref_release)
)

SET @cantidadrec_grn = ISNULL(@cantidadrec_grn,0)

--UM del grn
SET @um_grn = (SELECT TOP 1 grn.u_m
FROM grn_line grn
INNER JOIN zwm_rf_cons1_mst rf
on grn.grn_num = rf.grn_num and grn.vend_num = rf.vend_num
INNER JOIN poitem poi
ON grn.po_num = poi.po_num AND grn.po_line = poi.po_line AND grn.po_release = poi.po_release
WHERE rf.id_rec_cons = @Id AND poi.item = @Item
AND ((@CoNum is null and poi.ref_num is null)or @CoNum = poi.ref_num)
AND ((@CoLine is null and poi.ref_line_suf = 0)or @CoLine = poi.ref_line_suf)
AND ((@CoRelease is null and poi.ref_release = 0)or @CoRelease = poi.ref_release)
)

IF @cantidad_grn > 0
BEGIN
	--convierte las cantidades de grn a UM estandar
	EXEC @Severity = dbo.UMConvQtySp
		@UM               = @UM_grn
	  , @Item             = @Item
	  , @VendNum          = NULL
	  , @Area             = NULL
	  , @ConvertToBase    = 1
	  , @QtyToBeConverted = @cantidad_grn 
	  , @OutQty           = @cantidad_grn_conv OUTPUT --devuelve la cantidad convertida
	  , @Infobar          = @Infobar       OUTPUT
END

SET @cantidad = @cantidad + @QtyUMStd + @QtyBoxConverted + @QtyPalletConverted

DECLARE @RowPointer RowPointerType
SET @RowPointer = newid()
IF @cantidad > (@cantidad_grn_conv - @cantidadrec_grn)
	BEGIN 
		SET @Severity = 16
		SET @Infobar = 'Cantidad mayor a la indicada en grn'
		RETURN @severity
	END
ELSE
	BEGIN
		INSERT INTO zwm_rf_rec_cons2_mst
		([id],[item],[qty_um_std],[qty_um_stk1],[qty_um_stk1_conv],[qty_um_stk2],[qty_um_stk2_conv],[whse],[loc],[lot],[cont_number],[user_trans],[employee],[RowPointer],[co_num],[co_line],[co_release],[deci_attribute1],[deci_attribute2],[deci_attribute3],[deci_attribute4],[deci_attribute5],[deci_attribute6],[deci_attribute7],[deci_attribute8],[deci_attribute9],[deci_attribute10],[char_attribute1],[char_attribute2],[char_attribute3],[char_attribute4],[char_attribute5],[char_attribute6],[char_attribute7],[char_attribute8],[char_attribute9],[char_attribute10])
		VALUES
		-- las cantidades [qty_um_stk1_conv] y [qty_um_stk2_conv] no son las cantidades convertidas, siguiendo la logica de SL
		(@Id,@Item,@QtyUMStd,@QtyBoxConverted,@QtyUMStock1,@QtyPalletConverted,@QtyUMStock2,@Whse,@Loc,@Lot,@ContNumber,@UserName,@Emp,@RowPointer,@CoNum,@CoLine,@CoRelease,@DA1,@DA2,@DA3,@DA4,@DA5,@DA6,@DA7,@DA8,@DA9,@DA10,@CA1,@CA2,@CA3,@CA4,@CA5,@CA6,@CA7,@CA8,@CA9,@CA10)
	END
*/
*/
EXEC dbo.CloseSessionContextSp @SessionID = @SessionID
	
RETURN @Severity
GO

