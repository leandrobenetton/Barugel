/****** Object:  StoredProcedure [dbo].[ZWM_Execute_RFRecConsReport]    Script Date: 10/30/2014 16:15:00 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ZWM_Execute_RFRecConsReport]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ZWM_Execute_RFRecConsReport]
GO

/****** Object:  StoredProcedure [dbo].[ZWM_Execute_RFRecConsReport]    Script Date: 10/30/2014 16:15:00 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ZWM_Execute_RFRecConsReport] (
    @Site		 SiteType	
  , @IdRecCons	 ZwmIdRFConsType  = NULL
  , @UserName	 UserNameType	  = NULL
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
		
SET @taskParms1 = '~LIT~(' + cast (@Site as nvarchar) + '), ~LIT~('+ cast(@IdRecCons as nvarchar) +')'

EXEC	@severity = [dbo].[BGTaskSubmitSp]
		@TaskName = 'ZWM_RFRecConsReport',
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

/*
SELECT	@Infobar as N'@Infobar',
		@TaskID as N'@TaskID',
		@TaskHistoryRowPointer as N'@TaskHistoryRowPointer',
		@PreviewInterval as N'@PreviewInterval'
*/

If @severity = 0
	Set @Infobar = 'Informe procesado'

Return @severity

GO


