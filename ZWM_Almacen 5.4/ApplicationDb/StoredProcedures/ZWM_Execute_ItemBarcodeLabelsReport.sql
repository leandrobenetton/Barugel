/****** Object:  StoredProcedure [dbo].[ZWM_Execute_ItemBarcodeLabelsReport]    Script Date: 01/09/2015 14:39:55 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ZWM_Execute_ItemBarcodeLabelsReport]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ZWM_Execute_ItemBarcodeLabelsReport]
GO

/****** Object:  StoredProcedure [dbo].[ZWM_Execute_ItemBarcodeLabelsReport]    Script Date: 01/09/2015 14:39:55 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[ZWM_Execute_ItemBarcodeLabelsReport] (
    @Site		 SiteType
  , @UserName	 UserNameType	  = NULL
  , @IdRecCons	 ZwmIdRFConsType  = NULL
  , @Infobar     InfobarType      = NULL OUTPUT
  )
AS

DECLARE	@return_value int,
		@sessionId            RowPointerType,
		@severity             int,
		@TaskID TokenType,
		@TaskHistoryRowPointer RowPointerType,
		@PreviewInterval GenericIntType,
		@taskParms1           BGTaskParmsType,
		@taskParms2           BGTaskParmsType,
		@flag				  smallint

SET @UserName = isnull(@UserName,'sa')
SET @severity = 0
SET @flag = 1

EXEC	@return_value = [dbo].[InitSessionContextWithUserSp]
		@ContextName = 'RunReport',
		@UserName = @UserName,
		@SessionID = @SessionID OUTPUT,
		@Site = @Site

--Solo para implementacion Barugel Azulay
DECLARE @BAR FlagNyTYpe
IF (Select count(*) from zwm_parms where customer = 'BAR') > 0
	Set @BAR = 1 



DECLARE @GrnNum GrnNumType
, @VendNum VendNumType
DECLARE ReportSet CURSOR LOCAL STATIC FOR
SELECT grn_num, vend_num FROM zwm_tmp_rf_cons1_mst where id_rec_cons = @IdRecCons
--SELECT grn_num, vend_num FROM grn_hdr
OPEN ReportSet
WHILE 1=1
BEGIN
	FETCH ReportSet INTO
	@GrnNum, @VendNum

	IF @@FETCH_STATUS <> 0
		BREAK

	IF @BAR = 1 and Exists (Select * from vendor where vend_num = @VendNum and logifld = 0)
		Set @Flag = 0

	IF @Flag = 1
	BEGIN
		SET @taskParms1 = '1,1,,,,,,,'+ltrim(cast (@GrnNum as nvarchar))+','+ltrim(cast(@GrnNum as nvarchar))+','+',,G,1,,'
	
		EXEC	@Severity = [dbo].[BGTaskSubmitSp]
		@TaskName = 'ZWM_BarcodedItemLabelsReport',
		@TaskParms1 = @taskParms1,
		@TaskParms2 = NULL,
		@Infobar = @Infobar OUTPUT,
		@TaskID = @TaskID OUTPUT,
		@TaskStatusCode = NULL,
		@StringTable = NULL,
		@RequestingUser = NULL,
		@PrintPreview = 0,
		@TaskHistoryRowPointer = @TaskHistoryRowPointer OUTPUT,
		@PreviewInterval = @PreviewInterval OUTPUT
	END

	If @severity <> 0
	BEGIN
		Return @Severity
	END

END
CLOSE ReportSet
DEALLOCATE ReportSet

EXEC dbo.CloseSessionContextSp @SessionID = @SessionID

If @severity = 0
	Set @Infobar = 'Informe procesado'

Return @Severity

GO


