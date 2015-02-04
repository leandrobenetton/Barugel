/****** Object:  StoredProcedure [dbo].[ZWM_RFRecConsDelSp]    Script Date: 01/20/2015 15:15:36 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ZWM_RFRecConsDelSp]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ZWM_RFRecConsDelSp]
GO

/****** Object:  StoredProcedure [dbo].[ZWM_RFRecConsDelSp]    Script Date: 01/20/2015 15:15:36 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[ZWM_RFRecConsDelSp] (
   @Site			SiteType
  ,@UserName		UserNameType		= NULL
  ,@Id	            ZwmIdRFCONsType		= NULL
  ,@Whse			WhseType			= NULL
  ,@Item            ItemType			= NULL
  ,@Lot             LotType				= NULL
  ,@CONtNumber      ZwmCONtNumberType	= NULL
  ,@Infobar		    InfobarType			= NULL OUTPUT
)
AS

   -- Check for existence of Generic External Touch Point routine (this sectiON was generated by SpETPCodeSp AND inserted by CallETPs.exe):
   IF OBJECT_ID(N'dbo.EXTGEN_ZWM_RFRecCONsDelSp') IS NOT NULL
   BEGIN
      DECLARE @EXTGEN_SpName sysname
      SET @EXTGEN_SpName = N'dbo.EXTGEN_ZWM_RFRecCONsDelSp'
      -- Invoke the ETP routine, passing in (AND out) this routine's parameters:
      DECLARE @EXTGEN_Severity int
      EXEC @EXTGEN_Severity = @EXTGEN_SpName
		   @Site				
		  ,@UserName			
		  ,@Id	            
		  ,@Whse			
		  ,@Item            
		  ,@Lot            
		  ,@CONtNumber      
		  ,@Infobar		    OUTPUT
 
   -- ETP routine can RETURN 1 to signal that the remainder of this stANDard routine should now proceed:
      IF @EXTGEN_Severity <> 1
         RETURN @EXTGEN_Severity
   END
   -- End of Generic External Touch Point code.

--Inicio de SesiON
DECLARE	@return_value int,
		@sessiONId            RowPointerType

SET @UserName = isnull(@UserName,'sa')

EXEC	@return_value = [dbo].[InitSessiONCONtextWithUserSp]
		@CONtextName = 'ZWM',
		@UserName = @UserName,
		@SessiONID = @SessiONID OUTPUT,
		@Site = @Site

--Solo para implementaciON Barugel Azulay
DECLARE @BAR FlagNyTYpe
IF (SELECT count(*) FROM zwm_parms WHERE customer = 'BAR') > 0
	Set @BAR = 1 

DECLARE @Severity int
,@MsgFlag int
SET @Severity = 0
SET @MsgFlag = 0

------------------------------ SET NULLs
IF (len(ltrim(@Id)) = 0) SET @Id = NULL
IF (len(ltrim(@Item)) = 0) SET @Item = null
IF (len(ltrim(@Lot)) = 0) SET @Lot = null
IF (len(ltrim(@CONtNumber)) = 0) SET @CONtNumber = null
------------------------------ SET NULLs

SET @Lot = dbo.ExpANDKyByType('LotType',@Lot)

--El articulo debe existir
IF (SELECT count(item) FROM item WHERE item = @Item) = 0 AND @item IS NOT NULL
BEGIN
	SET @Infobar = 'No existe el art�culo'
	SET @Severity = 16
	RETURN @severity
END

-- Si el par�metro de dep�sito es NULL, tomar el dep�sito principal, sino verIFica que exista
IF @Whse IS NULL
		SELECT @Whse = def_whse FROM invparms
ELSE IF(SELECT Whse FROM Whse WHERE whse = @Whse) IS NULL
BEGIN
	SET @Infobar = 'El almac�n no existe'
	SET @Severity = 16
	RETURN @severity
END

--Borra RecepciON CONsolidada Entera
IF @Id IS NOT NULL AND @Whse IS NOT NULL AND @item IS NULL AND @Lot IS NULL AND @CONtNumber IS NULL
BEGIN
	DELETE FROM zwm_tmp_rf_rec_cONs2_mst WHERE id = @Id AND Whse = @Whse
	DELETE FROM zwm_tmp_rf_cONs1_mst WHERE id_rec_cONs = @Id AND Whse = @Whse
	SET @MsgFlag = 1
END

--Borra RecepciON CONsolidada x item
IF @Id IS NOT NULL AND @Whse IS NOT NULL AND @item IS NOT NULL AND @Lot IS NULL AND @CONtNumber IS NULL
BEGIN
	DELETE FROM zwm_tmp_rf_rec_cONs2_mst WHERE id = @Id AND Whse = @Whse AND item = @item AND Whse = @Whse
	SET @MsgFlag = 2
END

--Borra RecepciON CONsolidada x Lote
IF @Id IS NOT NULL AND @Whse IS NOT NULL AND @item IS NOT NULL AND @Lot IS NOT NULL AND @CONtNumber IS NULL
BEGIN
	DELETE FROM zwm_tmp_rf_rec_cONs2_mst WHERE id = @Id AND Whse = @Whse AND item = @item AND lot = @Lot
	SET @MsgFlag = 2
END

--Borra RecepciON CONsolidada x CONtenedor
IF @Id IS NOT NULL AND @Whse IS NOT NULL AND @item IS NULL AND @Lot IS NULL AND @CONtNumber IS NOT NULL
BEGIN
	DELETE FROM zwm_tmp_rf_rec_cONs2_mst WHERE id = @Id AND Whse =@Whse AND cONt_number = @CONtNumber
	SET @MsgFlag = 2
END
IF @Id IS NOT NULL AND @Whse IS NOT NULL AND @item IS NOT NULL AND @Lot IS NULL AND @CONtNumber IS NOT NULL
BEGIN
	DELETE FROM zwm_tmp_rf_rec_cONs2_mst WHERE id = @Id AND Whse = @Whse AND item = @item AND cONt_number = @CONtNumber
	SET @MsgFlag = 2
END
IF @Id IS NOT NULL AND @Whse IS NOT NULL AND @item IS NOT NULL AND @Lot IS NOT NULL AND @CONtNumber IS NOT NULL
BEGIN
	DELETE FROM zwm_tmp_rf_rec_cONs2_mst WHERE id = @Id AND Whse = @Whse AND item = @item AND lot = @Lot AND cONt_number = @CONtNumber
	SET @MsgFlag = 2
END

IF @MsgFlag = 0
BEGIN
	SET @Severity = 16
	SET @Infobar = 'No se elimino ning�n registro'
END
ELSE IF @MsgFlag = 1
BEGIN
	SET @Severity = 0
	SET @Infobar = 'Recepci�n CONsolidada Eliminada'
END
ELSE IF @MsgFlag = 2
BEGIN
	SET @Severity = 0
	SET @Infobar = 'Lineas de Recepci�n CONsolidada Eliminadas'
END

EXEC dbo.CloseSessiONCONtextSp @SessiONID = @SessiONID
	
RETURN @Severity
GO


