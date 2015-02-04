/****** Object:  StoredProcedure [dbo].[ZWM_Execute_VendorASNReconciliationReport]    Script Date: 01/09/2015 14:40:14 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ZWM_Execute_VendorASNReconciliationReport]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ZWM_Execute_VendorASNReconciliationReport]
GO

/****** Object:  StoredProcedure [dbo].[ZWM_Execute_VendorASNReconciliationReport]    Script Date: 01/09/2015 14:40:14 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[ZWM_Execute_VendorASNReconciliationReport] (
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
		@taskParms2           BGTaskParmsType

SET @UserName = isnull(@UserName,'sa')
SET @severity = 0

EXEC	@return_value = [dbo].[InitSessionContextWithUserSp]
		@ContextName = 'RunReport',
		@UserName = @UserName,
		@SessionID = @SessionID OUTPUT,
		@Site = @Site

DECLARE @GrnNum GrnNumType
, @Vendum VendNumType
DECLARE ReportSet CURSOR LOCAL STATIC FOR
SELECT grn_num, vend_num FROM zwm_tmp_rf_cons1_mst where id_rec_cons = @IdRecCons
--SELECT grn_num, vend_num FROM grn_hdr
OPEN ReportSet
WHILE 1=1
BEGIN
	FETCH ReportSet INTO
	@GrnNum, @Vendum

	IF @@FETCH_STATUS <> 0
		BREAK

--	SET @taskParms1 = '~LIT~(' + ltrim(cast (@GrnNum as nvarchar)) + '), ~LIT~('+ ltrim(cast(@GrnNum as nvarchar))+ '), ~LIT~('+ cast(@Vendum as nvarchar)+ '), ~LIT~('+ cast(@Vendum as nvarchar) +'),,,0,1,1,1,0,,,0,BG~TASKID~'
	SET @taskParms1 = ltrim(cast (@GrnNum as nvarchar))+','+ltrim(cast(@GrnNum as nvarchar))+','+cast(@Vendum as nvarchar)+','+cast(@Vendum as nvarchar)+',,,0,1,1,1,0,,, 0,BG~TASKID~'

	EXEC	@Severity = [dbo].[BGTaskSubmitSp]
		@TaskName = 'VendorASNReconciliationReport',
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


