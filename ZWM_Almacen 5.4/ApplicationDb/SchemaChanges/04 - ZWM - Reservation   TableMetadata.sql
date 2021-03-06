SET NOCOUNT ON
SET ANSI_PADDING ON
GO


IF NOT EXISTS(SELECT * FROM [dbo].[AppTable] WHERE [TableName]=N'zwm_mvtran_mst')
	INSERT INTO [dbo].[AppTable] ([TableName], [Update_AllWhen], [UpdateRecordDateWhen], [IgnoreInsert], [IgnoreUpdate], [DisallowUpdate], [KeepClusteringKeys], [UseRPOnInsert], [UseRPOnUpdate], [IupTriggerModifiesNewRows], [RememberIdentity], [RegisterNewKey], [TestOutsideLockForNewKey], [NextKeyReverseKeyOrder], [InheritorTableList], [ModuleName], [Update_AllRegardlessOfBaseTableChanges], [AppViewName], [SiteColumnName]) VALUES (N'zwm_mvtran_mst', NULL, NULL, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, NULL, N'Custom', 0, N'zwm_mvtran', N'SiteRef')
ELSE
	UPDATE [dbo].[AppTable] SET [TableName]=N'zwm_mvtran_mst', [Update_AllWhen]=NULL, [UpdateRecordDateWhen]=NULL, [IgnoreInsert]=0, [IgnoreUpdate]=0, [DisallowUpdate]=0, [KeepClusteringKeys]=0, [UseRPOnInsert]=0, [UseRPOnUpdate]=0, [IupTriggerModifiesNewRows]=1, [RememberIdentity]=0, [RegisterNewKey]=0, [TestOutsideLockForNewKey]=0, [NextKeyReverseKeyOrder]=0, [InheritorTableList]=NULL, [ModuleName]=N'Custom', [Update_AllRegardlessOfBaseTableChanges]=0, [AppViewName]=N'zwm_mvtran', [SiteColumnName]=N'SiteRef' WHERE [TableName]=N'zwm_mvtran_mst'

IF NOT EXISTS(SELECT * FROM [dbo].[AppTable] WHERE [TableName]=N'zwm_item_col_box_mst')
	INSERT INTO [dbo].[AppTable] ([TableName], [Update_AllWhen], [UpdateRecordDateWhen], [IgnoreInsert], [IgnoreUpdate], [DisallowUpdate], [KeepClusteringKeys], [UseRPOnInsert], [UseRPOnUpdate], [IupTriggerModifiesNewRows], [RememberIdentity], [RegisterNewKey], [TestOutsideLockForNewKey], [NextKeyReverseKeyOrder], [InheritorTableList], [ModuleName], [Update_AllRegardlessOfBaseTableChanges], [AppViewName], [SiteColumnName]) VALUES (N'zwm_item_col_box_mst', NULL, NULL, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, NULL, N'Custom', 0, N'zwm_item_col_box', N'SiteRef')
ELSE
	UPDATE [dbo].[AppTable] SET [TableName]=N'zwm_item_col_box_mst', [Update_AllWhen]=NULL, [UpdateRecordDateWhen]=NULL, [IgnoreInsert]=0, [IgnoreUpdate]=0, [DisallowUpdate]=0, [KeepClusteringKeys]=0, [UseRPOnInsert]=0, [UseRPOnUpdate]=0, [IupTriggerModifiesNewRows]=1, [RememberIdentity]=0, [RegisterNewKey]=0, [TestOutsideLockForNewKey]=0, [NextKeyReverseKeyOrder]=0, [InheritorTableList]=NULL, [ModuleName]=N'Custom', [Update_AllRegardlessOfBaseTableChanges]=0, [AppViewName]=N'zwm_item_col_box', [SiteColumnName]=N'SiteRef' WHERE [TableName]=N'zwm_item_col_box_mst'

IF NOT EXISTS(SELECT * FROM [dbo].[AppTable] WHERE [TableName]=N'zwm_col_box_req_mst')
	INSERT INTO [dbo].[AppTable] ([TableName], [Update_AllWhen], [UpdateRecordDateWhen], [IgnoreInsert], [IgnoreUpdate], [DisallowUpdate], [KeepClusteringKeys], [UseRPOnInsert], [UseRPOnUpdate], [IupTriggerModifiesNewRows], [RememberIdentity], [RegisterNewKey], [TestOutsideLockForNewKey], [NextKeyReverseKeyOrder], [InheritorTableList], [ModuleName], [Update_AllRegardlessOfBaseTableChanges], [AppViewName], [SiteColumnName]) VALUES (N'zwm_col_box_req_mst', NULL, NULL, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, NULL, N'Custom', 0, N'zwm_col_box_req', N'SiteRef')
ELSE
	UPDATE [dbo].[AppTable] SET [TableName]=N'zwm_col_box_req_mst', [Update_AllWhen]=NULL, [UpdateRecordDateWhen]=NULL, [IgnoreInsert]=0, [IgnoreUpdate]=0, [DisallowUpdate]=0, [KeepClusteringKeys]=0, [UseRPOnInsert]=0, [UseRPOnUpdate]=0, [IupTriggerModifiesNewRows]=1, [RememberIdentity]=0, [RegisterNewKey]=0, [TestOutsideLockForNewKey]=0, [NextKeyReverseKeyOrder]=0, [InheritorTableList]=NULL, [ModuleName]=N'Custom', [Update_AllRegardlessOfBaseTableChanges]=0, [AppViewName]=N'zwm_col_box_req', [SiteColumnName]=N'SiteRef' WHERE [TableName]=N'zwm_col_box_req_mst'
