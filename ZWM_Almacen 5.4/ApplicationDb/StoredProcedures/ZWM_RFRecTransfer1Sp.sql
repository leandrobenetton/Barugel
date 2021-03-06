/****** Object:  StoredProcedure [dbo].[ZWM_RFRecTransfer1Sp]    Script Date: 01/20/2015 15:16:09 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ZWM_RFRecTransfer1Sp]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ZWM_RFRecTransfer1Sp]
GO

/****** Object:  StoredProcedure [dbo].[ZWM_RFRecTransfer1Sp]    Script Date: 01/20/2015 15:16:09 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[ZWM_RFRecTransfer1Sp] (
    @Site				SiteType
  , @UserName			UserNameType	 = NULL
  , @IdRecTransfer		ZwmIdRFConsType  = NULL
  , @TrnNum				TrnNumType       = NULL
  , @Whse				WhseType		 = NULL
  , @Infobar			InfobarType      = NULL OUTPUT
)
AS

   -- Check for existence of Generic External Touch Point routine (this section was generated by SpETPCodeSp and inserted by CallETPs.exe):
   IF OBJECT_ID(N'dbo.EXTGEN_ZWM_RFRecCons1Sp') IS NOT NULL
   BEGIN
      DECLARE @EXTGEN_SpName sysname
      SET @EXTGEN_SpName = N'dbo.EXTGEN_ZWM_RFRecTransfer1Sp'
      -- Invoke the ETP routine, passing in (and out) this routine's parameters:
      DECLARE @EXTGEN_Severity int
      EXEC @EXTGEN_Severity = @EXTGEN_SpName
			@Site				
		  , @UserName			
		  , @IdRecTransfer		
		  , @TrnNum				
		  , @Whse				
		  , @Infobar	OUTPUT
 
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

------------------------------ SET NULLs
IF LEN(LTRIM(@IdRecTransfer)) = 0 SET @IdRecTransfer = NULL
IF LEN(LTRIM(@TrnNum)) = 0 SET @TrnNum = NULL
IF LEN(LTRIM(@Whse)) = 0 SET @Whse = NULL
------------------------------ SET NULLs

DECLARE @Severity int
,@ExisteReg int
  
SET @Severity = 0

-- Si el par�metro de dep�sito es NULL, tomar el dep�sito principal, sino verifica que exista
IF @Whse IS NULL
		SELECT @Whse = def_whse FROM invparms
ELSE IF(SELECT Whse FROM Whse WHERE whse = @Whse) IS NULL
BEGIN
	SET @Infobar = 'El almac�n no existe'
	SET @Severity = 16
	RETURN @severity
END

-----------------------------------------?????????????????????????????????????????????
IF EXISTS(SELECT trn_num FROM zwm_tmp_rf_rec_transfer1_mst WHERE trn_num = @TrnNum)
BEGIN
	SET @Infobar = 'La transferencia ya existe'
	SET @Severity = 16
	RETURN @severity
END
-----------------------------------------?????????????????????????????????????????????
	
IF @Severity = 0
BEGIN
	INSERT INTO zwm_tmp_rf_rec_transfer1_mst(id_rec,trn_num,whse)
	VALUES (@IdRecTransfer,@TrnNum,@Whse)
END 

EXEC dbo.CloseSessionContextSp @SessionID = @SessionID

RETURN @Severity
GO


