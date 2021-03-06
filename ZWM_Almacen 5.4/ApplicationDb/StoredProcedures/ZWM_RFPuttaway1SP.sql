/****** Object:  StoredProcedure [dbo].[ZWM_RFPuttaway1SP]    Script Date: 01/20/2015 15:14:00 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ZWM_RFPuttaway1SP]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ZWM_RFPuttaway1SP]
GO

/****** Object:  StoredProcedure [dbo].[ZWM_RFPuttaway1SP]    Script Date: 01/20/2015 15:14:00 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[ZWM_RFPuttaway1SP](
	 @Site		     SiteType	
	,@UserName		 UserNameType = NULL
	,@Item			 ItemType
	,@QtyUMStd       QtyUnitType
	,@QtyUMStk1      QtyUnitType
	,@QtyUMStk2      QtyUnitType
	,@Whse			 WhseType = NULL
	,@FromLoc		 LocType = NULL --ubicacion de origen. Si es null, tomar la ubicaci�n indicada como de recepcion para el dep�sito1
	,@Lot			 LotType  --agrego el LOTE que no estaba en las especificaciones del SP
	,@Max			 Int = NULL
	,@RFRefRowPointer	 RowPointerType = NULL OUTPUT
	,@Post			 FlagNyType = 0 --indica si se carga en una tabla o no
	,@Infobar		 InfobarType = NULL OUTPUT
)
AS

 -- Check for existence of Generic External Touch Point routine (this section was generated by SpETPCodeSp and inserted by CallETPs.exe):
   IF OBJECT_ID(N'dbo.EXTGEN_ZWM_RFPuttaway1SP') IS NOT NULL
   BEGIN
      DECLARE @EXTGEN_SpName sysname
      SET @EXTGEN_SpName = N'dbo.EXTGEN_ZWM_RFPuttaway1SP'
      -- Invoke the ETP routine, passing in (and out) this routine's parameters:
      DECLARE @EXTGEN_Severity int
      EXEC @EXTGEN_Severity = @EXTGEN_SpName
		@Site
		,@UserName
		,@Item
		,@QtyUMStd
		,@QtyUMStk1
		,@QtyUMStk2
		,@Whse
		,@FromLoc
		,@Lot
		,@Max
		,@RFRefRowPointer
		,@Post
		,@Infobar
		
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

SET @Lot = dbo.ExpandKyByType('LotType',@Lot)

------------------------------ SET NULLs
If (len(ltrim(@Lot)) = 0) SET @Lot = null
If (len(ltrim(@Whse)) = 0) SET @Whse = null
If (len(ltrim(@FromLoc)) = 0) SET @FromLoc = null
If (len(ltrim(@Max)) = 0) SET @Max = null
------------------------------ SET NULLs

----------------------------------------------------------------------- VARIABLES
DECLARE 
@Severity int
,@QtyToStore QtyUnitType			    -- cantidad a almacenar. 
,@LotTracked ListYesNoType				-- controla lote

-- variables para la conversi�n de unidades
,@UMItem               UMType
,@QtyStk1Converted     QtyUnitType
,@QtyStk2Converted     QtyUnitType
,@OutQty               int
,@UMStk1			   UMType
,@UMStk2			   UMType

SET @QtyStk1Converted = 0
SET @QtyStk2Converted = 0
SET @Severity = 0
set @QtyUMStd = ISNULL(@QtyUMStd,0)
set @QtyUMStk1 = ISNULL(@QtyUMStk1,0)
set @QtyUMStk2 = ISNULL(@QtyUMStk2,0)
SET @Lot = dbo.ExpandKyByType('LotType',@Lot)

------------------------------------------------------------------------ SPs
--convierte las cantidades de Stk1 a UM estandar
IF @QtyUMStk1 > 0
BEGIN
	SET @UMStk1 = ( SELECT ZWM_UMStock1 FROM item WHERE item = @Item )
	EXEC @Severity = dbo.UMConvQtySp
		@UM               = @UMStk1
	  , @Item             = @Item
	  , @VendNum          = NULL
	  , @Area             = NULL
	  , @ConvertToBase    = 1
	  , @QtyToBeConverted = @QtyUMStk1
	  , @OutQty           = @QtyStk1Converted OUTPUT --devuelve la cantidad convertida
	  , @Infobar          = @Infobar       OUTPUT
END

--convierte las cantidades de Stk2 a UM estandar
IF @QtyUMStk2 > 0
BEGIN 
	SET @UMStk2 = ( SELECT ZWM_UMStock2 FROM item WHERE item = @Item )
	EXEC @Severity = dbo.UMConvQtySp
		@UM               = @UMStk2
	  , @Item             = @Item
	  , @VendNum          = NULL
	  , @Area             = NULL
	  , @ConvertToBase    = 1
	  , @QtyToBeConverted = @QtyUMStk2
	  , @OutQty           = @QtyStk2Converted OUTPUT --devuelve la cantidad convertida
	  , @Infobar          = @Infobar       OUTPUT
END

------------------------------------------------------------------------ Seteo de variables
--cantidad a almacenar.
SET @QtyToStore = @QtyUMStd + @QtyStk1Converted + @QtyStk2Converted 

-- Si el par�metro de dep�sito es NULL, tomar el dep�sito principal, sino verifica que exista
IF @Whse IS NULL
		SELECT @Whse = def_whse FROM invparms
ELSE IF(SELECT Whse FROM Whse WHERE whse = @Whse) IS NULL
BEGIN
	SET @Infobar = 'El almac�n no existe'
	SET @Severity = 16
	RETURN @severity
END

-- Si el par�metro de ubicaci�n es NULL, tomar la ubicaci�n de recepcion; caso contrario verificar que la ubicaci�n exista
IF @FromLoc IS NULL
	SELECT @FromLoc = loc FROM zwm_parms
ELSE IF(SELECT loc FROM location WHERE loc = @FromLoc) IS NULL
	BEGIN
		SET @Infobar = 'La ubicaci�n no existe'
		SET @Severity = 16
		RETURN @severity
	END
	
--Verifica el art�culo
IF (select count(item) from item where item = @Item) = 0
BEGIN
	SET @Infobar = 'No existe el art�culo'
	SET @Severity = 16
	RETURN @severity
END

-- El articulo controla lote
SELECT @LotTracked = lot_tracked FROM item WHERE item = @Item

--Verifica el lote
IF @LotTracked = 1 And (select count(*) from lot where lot = @lot) = 0 And @Lot is not null
BEGIN
	SET @Infobar = 'No existe el lote'
	SET @Severity = 16
	RETURN @severity
END

------------------------------------------------------------------------ Tabla Temporal
--tabla intermedia
declare @dispLoc table 
--declare @dispLoc Table
(litem nvarchar(30),lwhse nvarchar(4), llot nvarchar(15), lloc nvarchar(15), ldescription nvarchar(40), lranking tinyint
, MultProd tinyint, MismoProd tinyint, MultLot tinyint, MismoLot tinyint, VolDisp decimal (11,3), VolFlag tinyint)
------------------------------------------------------------------------ /Tabla Temporal

IF @LotTracked = 0
BEGIN
	INSERT INTO @dispLoc
	select
	@item,@whse,lot = NULL,loc.loc,loc.description,iw.ranking,
	MultProd = 0,
	MismoProd = 0,
	MultLot = 0,
	MismoLot = 0,
	VolDisp = 0,
	VolFlag = 0
	from location loc
	join zwm_itm_whse iw
	on ((iw.zone = loc.ZWM_Zone and iw.zone is not null) or (iw.zone is null and iw.location = loc.loc))
	join item 
	on ((iw.family_code = item.family_code and iw.family_code is not null) or (iw.family_code is null and iw.item = item.item))
	left join itemloc il
	on il.loc = loc.loc and il.item = iw.item and il.whse = iw.whse
	----------------------------------------------
	where item.item = @Item and iw.whse = @Whse
	and loc.mrb_flag = 0 
	AND (il.mrb_flag = 0 or il.mrb_flag is null)
	AND loc.loc_type != 'T'
	--en caso que se requiera mostrar solo ubicaciones vacias
	and (iw.empty_loc = 0 
	or (iw.empty_loc = 1 
	and (select sum(ilx.qty_on_hand) from itemloc ilx where ilx.whse = iw.whse and ilx.loc = loc.loc) <= 0)) 
	--permitir multiples productos
	and (loc.ZWM_MultProd = 1 
	or (loc.ZWM_MultProd = 0 
	and (select top 1 item from itemloc ilx where ilx.whse = iw.whse and ilx.loc = loc.loc and ilx.item !=	iw.item and ilx.qty_on_hand > 0) is null))
	--peso maximo de la ubicacion debe ser > peso existente + peso a almacenar
	--Si el peso no esta seteado en el sistema, se asumir� que la ubicaci�n permite peso infinito
	and 
	(dbo.ZWM_LocMaxWeight(loc.loc) is null or dbo.ZWM_LocMaxWeight(loc.loc) = 0 or
	(dbo.ZWM_LocMaxWeight(loc.loc) > 
	isnull(@QtyUMStd * dbo.ZWM_UnitWeight(@Item),0) +
	isnull(@QtyUMStk1 * item.ZWM_Stk1Weight,0) +
	isnull(@QtyUMStk2 * item.ZWM_Stk2Weight,0) +
	(SELECT isnull(sum(qty_on_hand * dbo.ZWM_UnitWeight(ilx.item)),0) FROM itemloc ilx 
	WHERE ilx.whse = iw.whse and ilx.loc = loc.loc and ilx.qty_on_hand > 0)
	))
	--volumen maximo de la ubicacion debe ser > volumen existente + volumen a almacenar
	--Si el volumen no esta seteado en el sistema, se asumir� que la ubicaci�n permite volumen infinito
	and 
	(loc.ZWM_Vol is null or loc.ZWM_Vol = 0 or
	(loc.ZWM_Vol > 
	isnull(@QtyUMStd * dbo.ZWM_VolumetricVol(@Item),0) +
	isnull(@QtyUMStk1 * item.ZWM_Stk1Vol,0) +
	isnull(@QtyUMStk2 * item.ZWM_Stk2Vol,0) +
	(SELECT isnull(sum(qty_on_hand * dbo.ZWM_VolumetricVol(ilx.item)),0) FROM itemloc ilx 
	WHERE ilx.whse = iw.whse and ilx.loc = loc.loc and ilx.qty_on_hand > 0)
	))
	--An�lisis por dimensiones ancho stk1
	and (loc.ZWM_Width is null or loc.ZWM_Width = 0 or @QtyUMStk1 = 0 or (loc.ZWM_Width > isnull(item.ZWM_Stk1Width,0)))
	--An�lisis por dimensiones alto stk1
	and (loc.ZWM_Height is null or loc.ZWM_Height = 0 or @QtyUMStk1 = 0 or (loc.ZWM_Height > isnull(item.ZWM_Stk1Height,0)))
	--An�lisis por dimensiones prof stk1
	and (loc.ZWM_Depth is null or loc.ZWM_Depth = 0 or @QtyUMStk1 = 0 or (loc.ZWM_Depth > isnull(item.ZWM_Stk1Depth,0)))
	--An�lisis por dimensiones ancho stk2
	and (loc.ZWM_Width is null or loc.ZWM_Width = 0 or @QtyUMStk2 = 0 or (loc.ZWM_Width > isnull(item.ZWM_Stk2Width,0)))
	--An�lisis por dimensiones alto stk2
	and (loc.ZWM_Height is null or loc.ZWM_Height = 0 or @QtyUMStk2 = 0 or (loc.ZWM_Height > isnull(item.ZWM_Stk2Height,0)))
	--An�lisis por dimensiones prof stk2
	and (loc.ZWM_Depth is null or loc.ZWM_Depth = 0 or @QtyUMStk2 = 0 or (loc.ZWM_Depth > isnull(item.ZWM_Stk2Depth,0)))	
END
ELSE IF @LotTracked = 1
BEGIN
	INSERT INTO @dispLoc
	SELECT
	@item,@whse,@lot,loc.loc,loc.description,iw.ranking,
	MultProd = 0,
	MismoProd = 0,
	MultLot = 0,
	MismoLot = 0,
	VolDisp = 0,
	VolFlag = 0
	from location loc
	join zwm_itm_whse iw
	on ((iw.zone = loc.ZWM_Zone and iw.zone is not null) or (iw.zone is null and iw.location = loc.loc))
	join item 
	on ((iw.family_code = item.family_code and iw.family_code is not null) or (iw.family_code is null and iw.item = item.item))
	left join itemloc il
	on il.loc = loc.loc and il.item = iw.item and il.whse = iw.whse
	------------------------------------------
	where item.item = @Item and iw.whse = @Whse
	and loc.mrb_flag = 0 
	AND (il.mrb_flag = 0 or il.mrb_flag is null)
	AND loc.loc_type != 'T'
	--en caso que se requiera mostrar solo ubicaciones vacias
	and (iw.empty_loc = 0 
	or (iw.empty_loc = 1 
	and (select sum(ilx.qty_on_hand) from itemloc ilx where ilx.whse = iw.whse and ilx.loc = loc.loc) <= 0)) 
	--permitir multiples productos
	and (loc.ZWM_MultProd = 1 
	or (loc.ZWM_MultProd = 0 
	and (select top 1 item from itemloc ilx where ilx.whse = iw.whse and ilx.loc = loc.loc and ilx.item !=	iw.item and ilx.			qty_on_hand > 0) is null))
		--permitir multiples lotes
	and (loc.ZWM_MultLot = 1 
	or (loc.ZWM_MultLot = 0 
	and (select top 1 item from lot_loc llx where llx.whse = iw.whse and llx.loc = loc.loc and llx.item = @item and llx.lot != @lot		and	llx.qty_on_hand > 0) is null))
	--peso maximo de la ubicacion debe ser > peso existente + peso a almacenar
	--Si el peso no esta seteado en el sistema, se asumir� que la ubicaci�n permite peso infinito
	and 
	(dbo.ZWM_LocMaxWeight(loc.loc) is null or dbo.ZWM_LocMaxWeight(loc.loc) = 0 or
	(dbo.ZWM_LocMaxWeight(loc.loc) > 
	isnull(@QtyUMStd * dbo.ZWM_UnitWeight(@Item),0) +
	isnull(@QtyUMStk1 * item.ZWM_Stk1Weight,0) +
	isnull(@QtyUMStk2 * item.ZWM_Stk2Weight,0) +
	(SELECT isnull(sum(qty_on_hand * dbo.ZWM_UnitWeight(ilx.item)),0) FROM itemloc ilx 
	WHERE ilx.whse = iw.whse and ilx.loc = loc.loc and ilx.qty_on_hand > 0)
	))
	--volumen maximo de la ubicacion debe ser > volumen existente + volumen a almacenar
	--Si el volumen no esta seteado en el sistema, se asumir� que la ubicaci�n permite volumen infinito
	and 
	(loc.ZWM_Vol is null or loc.ZWM_Vol = 0 or
	(loc.ZWM_Vol > 
	isnull(@QtyUMStd * dbo.ZWM_VolumetricVol(@Item),0) +
	isnull(@QtyUMStk1 * item.ZWM_Stk1Vol,0) +
	isnull(@QtyUMStk2 * item.ZWM_Stk2Vol,0) +
	(SELECT isnull(sum(qty_on_hand * dbo.ZWM_VolumetricVol(ilx.item)),0) FROM itemloc ilx 
	WHERE ilx.whse = iw.whse and ilx.loc = loc.loc and ilx.qty_on_hand > 0)
	))
	--An�lisis por dimensiones ancho stk1
	and (loc.ZWM_Width is null or loc.ZWM_Width = 0 or @QtyUMStk1 = 0 or (loc.ZWM_Width > isnull(item.ZWM_Stk1Width,0)))
	--An�lisis por dimensiones alto stk1
	and (loc.ZWM_Height is null or loc.ZWM_Height = 0 or @QtyUMStk1 = 0 or (loc.ZWM_Height > isnull(item.ZWM_Stk1Height,0)))
	--An�lisis por dimensiones prof stk1
	and (loc.ZWM_Depth is null or loc.ZWM_Depth = 0 or @QtyUMStk1 = 0 or (loc.ZWM_Depth > isnull(item.ZWM_Stk1Depth,0)))
	--An�lisis por dimensiones ancho stk2
	and (loc.ZWM_Width is null or loc.ZWM_Width = 0 or @QtyUMStk2 = 0 or (loc.ZWM_Width > isnull(item.ZWM_Stk2Width,0)))
	--An�lisis por dimensiones alto stk2
	and (loc.ZWM_Height is null or loc.ZWM_Height = 0 or @QtyUMStk2 = 0 or (loc.ZWM_Height > isnull(item.ZWM_Stk2Height,0)))
	--An�lisis por dimensiones prof stk2
	and (loc.ZWM_Depth is null or loc.ZWM_Depth = 0 or @QtyUMStk2 = 0 or (loc.ZWM_Depth > isnull(item.ZWM_Stk2Depth,0)))	
END

UPDATE @dispLoc SET MismoLot = 1
FROM lot_loc
where 
lot_loc.whse = lwhse
and lot_loc.loc =lloc
and lot_loc.item = litem
and lot_loc.lot = llot
and lot_loc.qty_on_hand > 0

UPDATE @dispLoc SET MultLot = 1
from lot_loc
where lot_loc.whse = lwhse
and lot_loc.loc = lloc
and lot_loc.item = litem
and lot_loc.lot != llot
and lot_loc.qty_on_hand > 0

UPDATE @dispLoc SET MismoProd = 1
FROM itemloc
where 
itemloc.whse = lwhse
and itemloc.loc = lloc
and itemloc.item = litem
and itemloc.qty_on_hand > 0

UPDATE @dispLoc SET MultProd = 1
FROM itemloc
where 
itemloc.whse = lwhse
and itemloc.loc = lloc
and itemloc.item != litem
and itemloc.qty_on_hand > 0

UPDATE @dispLoc SET VolDisp = l.ZWM_Vol - x.vol
FROM location l,
(SELECT ilx.whse, ilx.loc, vol = isnull(sum(ilx.qty_on_hand * dbo.ZWM_VolumetricVol(ilx.item)),0) 
FROM itemloc ilx
WHERE ilx.qty_on_hand > 0
GROUP BY ilx.whse, ilx.loc)x
WHERE l.loc = lloc
and x.whse = lwhse 
and x.loc = lloc

UPDATE @dispLoc SET VolFlag = 1
where VolDisp = 0 or VolDisp is null


--Borra lo creado para con anterioridad
delete from ZWM_TMP_disploc
where RFRefRowPointer = @RFRefRowPointer

--Inserta los datos
Set @RFRefRowPointer = (newid())

insert into ZWM_TMP_disploc
select
@RFRefRowPointer
,@Item, @Whse, @Lot, @FromLoc,@QtyToStore
,lloc,ldescription
,Row_Number() OVER(ORDER BY lRanking asc, MismoLot desc, VolFlag asc, VolDisp asc, lLoc)
,@UserName,@UserName,getdate(),getdate(),newid(),0,0
from @dispLoc
ORDER BY lRanking asc, MismoLot desc, VolFlag asc, VolDisp asc, lLoc

IF @BAR = 1 and @Max is null
	Set @Max = 99

IF @Max is not null
	Delete from ZWM_TMP_disploc where seq > @Max

IF @BAR = 1
BEGIN
	--devuelve lo obtenido para el usuario
	select loc + REPLICATE(' ',16-LEN(ltrim(loc)))
	from ZWM_TMP_disploc
	where RfRefRowPointer = @RFRefRowPointer
	order by seq asc	
END
ELSE
BEGIN
	--devuelve lo obtenido para el usuario
	select 
	seq,loc,description
	from ZWM_TMP_disploc
	where RfRefRowPointer = @RFRefRowPointer
	order by seq asc	
END

IF @Post = 0
	delete from ZWM_TMP_disploc where RFRefRowPointer = @RFRefRowPointer

EXEC dbo.CloseSessionContextSp @SessionID = @SessionID

RETURN @Severity
GO


