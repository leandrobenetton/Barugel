/****** Object:  StoredProcedure [dbo].[ZWM_RF_ColBox1Sp]    Script Date: 01/29/2015 14:57:54 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ZWM_RF_ColBox1Sp]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ZWM_RF_ColBox1Sp]
GO

/****** Object:  StoredProcedure [dbo].[ZWM_RF_ColBox1Sp]    Script Date: 01/29/2015 14:57:54 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ZWM_RF_ColBox1Sp] (
     @Site				SiteType
	,@UserName			UserNameType			= NULL
	,@whse				WhseType				= NULL
	,@Loc				LocType					= NULL		
    ,@Locout			LocType					= NULL OUTPUT
    ,@Locin				LocType					= NULL OUTPUT
    ,@Lotout			LotType					= NULL OUTPUT
    ,@Lotin				LotType					= NULL OUTPUT
    ,@Item				ItemType				= NULL OUTPUT
    ,@Qty				QtyUnitType				= NULL OUTPUT
    ,@um				UMType					= NULL OUTPUT
	,@FindLoc			FlagNyType				= NULL
    ,@Infobar			InfobarType				= NULL OUTPUT
)
AS

 -- Check for existence of Generic External Touch Point routine (this section was generated by SpETPCodeSp and inserted by CallETPs.exe):
   IF OBJECT_ID(N'dbo.EXTGEN_ZWM_RF_ColBox1Sp') IS NOT NULL
   BEGIN
      DECLARE @EXTGEN_SpName sysname
      SET @EXTGEN_SpName = N'dbo.EXTGEN_ZWM_RF_ColBox1Sp'
      -- Invoke the ETP routine, passing in (and out) this routine's parameters:
      DECLARE @EXTGEN_Severity int
      EXEC @EXTGEN_Severity = @EXTGEN_SpName
		 @Site				
		,@UserName			
		,@whse
		,@Loc
		,@Locout			OUTPUT
		,@Locin				OUTPUT
		,@Lotout			OUTPUT
		,@Lotin				OUTPUT
		,@Item				OUTPUT
		,@Qty				OUTPUT
		,@um				OUTPUT
		,@FindLoc
		,@Infobar			OUTPUT	
 
      -- ETP routine can RETURN 1 to signal that the remainder of this standard routine should now proceed:
      IF @EXTGEN_Severity <> 1
         RETURN @EXTGEN_Severity
   END
   -- End of Generic External Touch Point code.

--Setea Null en par�metros de Entrada
IF LEN(LTRIM(RTRIM(@UserName))) = 0
	SET @UserName = NULL
IF LEN(LTRIM(RTRIM(@Whse))) = 0
	SET @Whse = NULL
IF LEN(LTRIM(RTRIM(@Loc))) = 0
	SET @Loc = NULL
IF LEN(LTRIM(RTRIM(@FindLoc))) = 0
	SET @Loc = NULL

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
SET @Severity = 0

DECLARE
@LotTracked	FlagNyType
,@ZWM_MultProd	FlagNyType
,@ZWM_MultLot	FlagNyType

SET @FindLoc = ISNULL(@FindLoc,1)

-- Si el par�metro de dep�sito es NULL, tomar el dep�sito principal, sino verifica que exista
IF @Whse IS NULL
		SELECT @Whse = def_whse FROM invparms
ELSE IF(SELECT Whse FROM Whse WHERE whse = @Whse) IS NULL
BEGIN
	SET @Infobar = 'El almac�n no existe'
	SET @Severity = 16
	RETURN @severity
END

-- Verificar que la ubicaci�n exista
IF(SELECT loc FROM location WHERE loc = @Loc) IS NULL AND @Loc is not null
	BEGIN
		SET @Infobar = 'La ubicaci�n no existe'
		SET @Severity = 16
		RETURN @severity
	END

BEGIN
	SELECT TOP 1
	@Locout = mv.from_loc
	,@Locin = mv.to_loc
	,@Lotout = mv.from_lot
	,@Lotin = mv.to_lot
	,@item = mv.item
	,@qty = mv.qty_moved
	,@um = mv.u_m
	,@LotTracked = i.lot_tracked
	,@ZWM_MultLot = l.ZWM_MultLot
	,@ZWM_MultProd = l.ZWM_MultProd
	FROM 
	zwm_mv_trans mv
	LEFT JOIN item i on i.item = mv.item
	LEFT JOIN location l on l.loc = mv.to_loc
	WHERE 
	mv.whse = @Whse
	AND ((@FindLoc = 0 and @Loc = mv.to_loc) OR (@FindLoc = 1 and @Loc <= mv.to_loc) OR (@FindLoc = 1 and @Loc is null))
	ORDER BY mv.to_loc asc

	IF @LotTracked = 1
	BEGIN
		IF @ZWM_MultProd = 0 AND Exists (select ilx.item from itemloc ilx where ilx.whse = @whse and ilx.loc = @Locin and ilx.item != @Item and ilx.qty_on_hand > 0)
		BEGIN
			SET @Infobar = 'Mueva las existencias de la ubicacion '+@Locin+' y coloque el producto '+@Item+'de la ubicacion '+@Locout+' y lote '+@Lotout
		END
		ELSE IF @ZWM_MultLot = 0 AND @Lotout != @Lotin AND @Lotin is not null
		BEGIN
			SET @Infobar = 'Mueva el lote existente en la ubicacion '+@Locin+' y coloque el producto '+@Item+'de la ubicacion '+@Locout+' y lote '+@Lotout
		END
		ELSE IF @ZWM_MultLot = 1 OR @Lotout = @Lotin OR @Lotin is null
		BEGIN
			SET @Infobar = 'Coloque en la ubicacion '+@Locin+' el producto '+@Item+'de la ubicacion '+@Locout+' y lote '+@Lotout
		END
	END--Lot Tracked = 1
	ELSE IF @LotTracked = 0
	BEGIN
		IF @ZWM_MultProd = 0 AND Exists (select ilx.item from itemloc ilx where ilx.whse = @whse and ilx.loc = @Locin and ilx.item != @Item and ilx.qty_on_hand > 0)
		BEGIN
			SET @Infobar = 'Mueva las existencias de la ubicacion '+@Locin+' y coloque el producto '+@Item+'de la ubicacion '+@Locout
		END
		ELSE
		BEGIN
			SET @Infobar = 'Coloque en la ubicacion '+@Locin+' el producto '+@Item+'de la ubicacion '+@Locout
		END
	END--Lot Tracked = 0
	
END

EXEC dbo.CloseSessionContextSp @SessionID = @SessionID
GO


