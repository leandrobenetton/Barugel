/****** Object:  StoredProcedure [dbo].[ZWM_RFNNStockSp]    Script Date: 01/20/2015 15:13:34 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ZWM_RFNNStockSp]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ZWM_RFNNStockSp]
GO

/****** Object:  StoredProcedure [dbo].[ZWM_RFNNStockSp]    Script Date: 01/20/2015 15:13:34 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[ZWM_RFNNStockSp](
     @Site			 SiteType
	,@UserName		 UserNameType	= NULL
	,@Item			 ItemType		= NULL
	,@Loc			 LocType		= NULL
	,@Whse			 WhseType		= NULL
	,@Mrb_flag		 ListYesNoType  = 0
	,@Infobar		 InfobarType	= NULL OUTPUT
)
AS

   -- Check for existence of Generic External Touch Point routine (this section was generated by SpETPCodeSp and inserted by CallETPs.exe):
   IF OBJECT_ID(N'dbo.EXTGEN_ZWM_RFNNStockSp') IS NOT NULL
   BEGIN
      DECLARE @EXTGEN_SpName sysname
      SET @EXTGEN_SpName = N'dbo.EXTGEN_ZWM_RFNNStockSp'
      -- Invoke the ETP routine, passing in (and out) this routine's parameters:
      DECLARE @EXTGEN_Severity int
      EXEC @EXTGEN_Severity = @EXTGEN_SpName
	     @Site
		,@UserName
		,@Item
		,@Loc
		,@Whse
		,@Mrb_flag
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


----------------------------------------------------------------------- VARIABLES
DECLARE @Severity int
,@MsgFlag int
SET @Severity = 0
SET @MsgFlag = 0

------------------------------ SET NULLs
IF LEN(LTRIM(@Whse)) = 0
	SET @Whse = NULL
	
IF LEN(LTRIM(@Loc)) = 0
	SET @Loc = NULL
	
IF LEN(LTRIM(@Item)) = 0
	SET @Item = NULL
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

-- Validaciones
IF(SELECT loc FROM location WHERE loc = @Loc) IS NULL
BEGIN
	SET @Infobar = 'Ubicaci�n incorrecta'
	SET @Severity = 16
	RETURN @severity
END
ELSE IF(SELECT whse FROM whse WHERE whse = @whse) IS NULL
BEGIN
	SET @Infobar = 'Almac�n incorrecto'
	SET @Severity = 16
	RETURN @severity
END
ELSE IF(SELECT item FROM item WHERE item = @Item) IS NULL
BEGIN
	SET @Infobar = 'Art�culo incorrecto'
	SET @Severity = 16
	RETURN @severity
END

IF @Loc IS NOT NULL AND @Item IS NULL
BEGIN
	UPDATE location SET mrb_flag = @Mrb_flag WHERE loc = @loc
	SET @MsgFlag = 1
END
ELSE IF @Loc IS NOT NULL AND @Item IS NOT NULL AND @whse IS NOT NULL
BEGIN
	UPDATE itemloc SET mrb_flag = @Mrb_flag WHERE whse = @whse AND loc = @loc AND item = @item
	SET @MsgFlag = 1
END

IF @MsgFlag = 0
BEGIN
	SET @Severity = 16
	SET @Infobar = 'No se actualiz� ning�n registro'
END
ELSE IF @MsgFlag = 1
BEGIN
	SET @Severity = 0
	SET @Infobar = 'Ubicaci�n actualizada'
END
ELSE IF @MsgFlag = 2
BEGIN
	SET @Severity = 0
	SET @Infobar = 'Ubicaci�n-Art�culo actualizada'
END

EXEC dbo.CloseSessionContextSp @SessionID = @SessionID

RETURN @Severity
GO


