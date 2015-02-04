SET NOCOUNT ON
SET ANSI_PADDING ON
GO


--zwm_imported_grn_mst

IF NOT EXISTS(SELECT * FROM [dbo].[AppTable] WHERE [TableName]=N'zwm_imported_grn_mst')
	INSERT INTO [dbo].[AppTable] ([TableName], [Update_AllWhen], [UpdateRecordDateWhen], [IgnoreInsert], [IgnoreUpdate], [DisallowUpdate], [KeepClusteringKeys], [UseRPOnInsert], [UseRPOnUpdate], [IupTriggerModifiesNewRows], [RememberIdentity], [RegisterNewKey], [TestOutsideLockForNewKey], [NextKeyReverseKeyOrder], [InheritorTableList], [ModuleName], [Update_AllRegardlessOfBaseTableChanges], [AppViewName], [SiteColumnName]) VALUES (N'zwm_imported_grn_mst', NULL, NULL, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, NULL, N'Latin America Localization', 0, N'zwm_imported_grn', N'site_ref')
ELSE
	UPDATE [dbo].[AppTable] SET [TableName]=N'zwm_imported_grn_mst', [Update_AllWhen]=NULL, [UpdateRecordDateWhen]=NULL, [IgnoreInsert]=0, [IgnoreUpdate]=0, [DisallowUpdate]=0, [KeepClusteringKeys]=0, [UseRPOnInsert]=0, [UseRPOnUpdate]=0, [IupTriggerModifiesNewRows]=1, [RememberIdentity]=0, [RegisterNewKey]=0, [TestOutsideLockForNewKey]=0, [NextKeyReverseKeyOrder]=0, [InheritorTableList]=NULL, [ModuleName]=N'Latin America Localization', [Update_AllRegardlessOfBaseTableChanges]=0, [AppViewName]=N'zwm_imported_grn', [SiteColumnName]=N'site_ref' WHERE [TableName]=N'zwm_imported_grn_mst'


------------------------------------------------------------------------------------------------------------
--zwm_parms_mst	

IF NOT EXISTS(SELECT * FROM [dbo].[AppTable] WHERE [TableName]=N'zwm_parms_mst')
	INSERT INTO [dbo].[AppTable] ([TableName], [Update_AllWhen], [UpdateRecordDateWhen], [IgnoreInsert], [IgnoreUpdate], [DisallowUpdate], [KeepClusteringKeys], [UseRPOnInsert], [UseRPOnUpdate], [IupTriggerModifiesNewRows], [RememberIdentity], [RegisterNewKey], [TestOutsideLockForNewKey], [NextKeyReverseKeyOrder], [InheritorTableList], [ModuleName], [Update_AllRegardlessOfBaseTableChanges], [AppViewName], [SiteColumnName]) VALUES (N'zwm_parms_mst', NULL, NULL, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, NULL, N'Latin America Localization', 0, N'zwm_parms', N'site_ref')
ELSE
	UPDATE [dbo].[AppTable] SET [TableName]=N'zwm_parms_mst', [Update_AllWhen]=NULL, [UpdateRecordDateWhen]=NULL, [IgnoreInsert]=0, [IgnoreUpdate]=0, [DisallowUpdate]=0, [KeepClusteringKeys]=0, [UseRPOnInsert]=0, [UseRPOnUpdate]=0, [IupTriggerModifiesNewRows]=1, [RememberIdentity]=0, [RegisterNewKey]=0, [TestOutsideLockForNewKey]=0, [NextKeyReverseKeyOrder]=0, [InheritorTableList]=NULL, [ModuleName]=N'Latin America Localization', [Update_AllRegardlessOfBaseTableChanges]=0, [AppViewName]=N'zwm_parms', [SiteColumnName]=N'site_ref' WHERE [TableName]=N'zwm_parms_mst'


------------------------------------------------------------------------------------------------------------
--zwm_itm_whse_mst	

IF NOT EXISTS(SELECT * FROM [dbo].[AppTable] WHERE [TableName]=N'zwm_itm_whse_mst')
	INSERT INTO [dbo].[AppTable] ([TableName], [Update_AllWhen], [UpdateRecordDateWhen], [IgnoreInsert], [IgnoreUpdate], [DisallowUpdate], [KeepClusteringKeys], [UseRPOnInsert], [UseRPOnUpdate], [IupTriggerModifiesNewRows], [RememberIdentity], [RegisterNewKey], [TestOutsideLockForNewKey], [NextKeyReverseKeyOrder], [InheritorTableList], [ModuleName], [Update_AllRegardlessOfBaseTableChanges], [AppViewName], [SiteColumnName]) VALUES (N'zwm_itm_whse_mst', NULL, NULL, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, NULL, N'Latin America Localization', 0, N'zwm_itm_whse', N'site_ref')
ELSE
	UPDATE [dbo].[AppTable] SET [TableName]=N'zwm_itm_whse_mst', [Update_AllWhen]=NULL, [UpdateRecordDateWhen]=NULL, [IgnoreInsert]=0, [IgnoreUpdate]=0, [DisallowUpdate]=0, [KeepClusteringKeys]=0, [UseRPOnInsert]=0, [UseRPOnUpdate]=0, [IupTriggerModifiesNewRows]=1, [RememberIdentity]=0, [RegisterNewKey]=0, [TestOutsideLockForNewKey]=0, [NextKeyReverseKeyOrder]=0, [InheritorTableList]=NULL, [ModuleName]=N'Latin America Localization', [Update_AllRegardlessOfBaseTableChanges]=0, [AppViewName]=N'zwm_itm_whse', [SiteColumnName]=N'site_ref' WHERE [TableName]=N'zwm_itm_whse_mst'

------------------------------------------------------------------------------------------------------------
--zwm_whse_zone_mst	

IF NOT EXISTS(SELECT * FROM [dbo].[AppTable] WHERE [TableName]=N'zwm_whse_zone_mst')
	INSERT INTO [dbo].[AppTable] ([TableName], [Update_AllWhen], [UpdateRecordDateWhen], [IgnoreInsert], [IgnoreUpdate], [DisallowUpdate], [KeepClusteringKeys], [UseRPOnInsert], [UseRPOnUpdate], [IupTriggerModifiesNewRows], [RememberIdentity], [RegisterNewKey], [TestOutsideLockForNewKey], [NextKeyReverseKeyOrder], [InheritorTableList], [ModuleName], [Update_AllRegardlessOfBaseTableChanges], [AppViewName], [SiteColumnName]) VALUES (N'zwm_whse_zone_mst', NULL, NULL, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, NULL, N'Latin America Localization', 0, N'zwm_whse_zone', N'site_ref')
ELSE
	UPDATE [dbo].[AppTable] SET [TableName]=N'zwm_whse_zone_mst', [Update_AllWhen]=NULL, [UpdateRecordDateWhen]=NULL, [IgnoreInsert]=0, [IgnoreUpdate]=0, [DisallowUpdate]=0, [KeepClusteringKeys]=0, [UseRPOnInsert]=0, [UseRPOnUpdate]=0, [IupTriggerModifiesNewRows]=1, [RememberIdentity]=0, [RegisterNewKey]=0, [TestOutsideLockForNewKey]=0, [NextKeyReverseKeyOrder]=0, [InheritorTableList]=NULL, [ModuleName]=N'Latin America Localization', [Update_AllRegardlessOfBaseTableChanges]=0, [AppViewName]=N'zwm_whse_zone', [SiteColumnName]=N'site_ref' WHERE [TableName]=N'zwm_whse_zone_mst'
	
	








IF NOT EXISTS(SELECT * FROM [dbo].[AppTable] WHERE [TableName]=N'zwm_zip_mst')
	INSERT INTO [dbo].[AppTable] ([TableName], [Update_AllWhen], [UpdateRecordDateWhen], [IgnoreInsert], [IgnoreUpdate], [DisallowUpdate], [KeepClusteringKeys], [UseRPOnInsert], [UseRPOnUpdate], [IupTriggerModifiesNewRows], [RememberIdentity], [RegisterNewKey], [TestOutsideLockForNewKey], [NextKeyReverseKeyOrder], [InheritorTableList], [ModuleName], [Update_AllRegardlessOfBaseTableChanges], [AppViewName], [SiteColumnName]) VALUES (N'zwm_zip_mst', NULL, NULL, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, NULL, N'Argentina Warehouse Mgmt', 0, N'zwm_zip', N'SiteRef')
ELSE
	UPDATE [dbo].[AppTable] SET [TableName]=N'zwm_zip_mst', [Update_AllWhen]=NULL, [UpdateRecordDateWhen]=NULL, [IgnoreInsert]=0, [IgnoreUpdate]=0, [DisallowUpdate]=0, [KeepClusteringKeys]=0, [UseRPOnInsert]=0, [UseRPOnUpdate]=0, [IupTriggerModifiesNewRows]=1, [RememberIdentity]=0, [RegisterNewKey]=0, [TestOutsideLockForNewKey]=0, [NextKeyReverseKeyOrder]=0, [InheritorTableList]=NULL, [ModuleName]=N'Argentina Warehouse Mgmt', [Update_AllRegardlessOfBaseTableChanges]=0, [AppViewName]=N'zwm_zip', [SiteColumnName]=N'SiteRef' WHERE [TableName]=N'zwm_zip_mst'

IF NOT EXISTS(SELECT * FROM [dbo].[AppTable] WHERE [TableName]=N'zwm_zip_addr_mst')
	INSERT INTO [dbo].[AppTable] ([TableName], [Update_AllWhen], [UpdateRecordDateWhen], [IgnoreInsert], [IgnoreUpdate], [DisallowUpdate], [KeepClusteringKeys], [UseRPOnInsert], [UseRPOnUpdate], [IupTriggerModifiesNewRows], [RememberIdentity], [RegisterNewKey], [TestOutsideLockForNewKey], [NextKeyReverseKeyOrder], [InheritorTableList], [ModuleName], [Update_AllRegardlessOfBaseTableChanges], [AppViewName], [SiteColumnName]) VALUES (N'zwm_zip_addr_mst', NULL, NULL, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, NULL, N'Argentina Warehouse Mgmt', 0, N'zwm_zip_addr', N'SiteRef')
ELSE
	UPDATE [dbo].[AppTable] SET [TableName]=N'zwm_zip_addr_mst', [Update_AllWhen]=NULL, [UpdateRecordDateWhen]=NULL, [IgnoreInsert]=0, [IgnoreUpdate]=0, [DisallowUpdate]=0, [KeepClusteringKeys]=0, [UseRPOnInsert]=0, [UseRPOnUpdate]=0, [IupTriggerModifiesNewRows]=1, [RememberIdentity]=0, [RegisterNewKey]=0, [TestOutsideLockForNewKey]=0, [NextKeyReverseKeyOrder]=0, [InheritorTableList]=NULL, [ModuleName]=N'Argentina Warehouse Mgmt', [Update_AllRegardlessOfBaseTableChanges]=0, [AppViewName]=N'zwm_zip_addr', [SiteColumnName]=N'SiteRef' WHERE [TableName]=N'zwm_zip_addr_mst'
	
IF NOT EXISTS(SELECT * FROM [dbo].[AppTable] WHERE [TableName]=N'zwm_route_mst')
	INSERT INTO [dbo].[AppTable] ([TableName], [Update_AllWhen], [UpdateRecordDateWhen], [IgnoreInsert], [IgnoreUpdate], [DisallowUpdate], [KeepClusteringKeys], [UseRPOnInsert], [UseRPOnUpdate], [IupTriggerModifiesNewRows], [RememberIdentity], [RegisterNewKey], [TestOutsideLockForNewKey], [NextKeyReverseKeyOrder], [InheritorTableList], [ModuleName], [Update_AllRegardlessOfBaseTableChanges], [AppViewName], [SiteColumnName]) VALUES (N'zwm_route_mst', NULL, NULL, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, NULL, N'Argentina Warehouse Mgmt', 0, N'zwm_route', N'SiteRef')
ELSE
	UPDATE [dbo].[AppTable] SET [TableName]=N'zwm_route_mst', [Update_AllWhen]=NULL, [UpdateRecordDateWhen]=NULL, [IgnoreInsert]=0, [IgnoreUpdate]=0, [DisallowUpdate]=0, [KeepClusteringKeys]=0, [UseRPOnInsert]=0, [UseRPOnUpdate]=0, [IupTriggerModifiesNewRows]=1, [RememberIdentity]=0, [RegisterNewKey]=0, [TestOutsideLockForNewKey]=0, [NextKeyReverseKeyOrder]=0, [InheritorTableList]=NULL, [ModuleName]=N'Argentina Warehouse Mgmt', [Update_AllRegardlessOfBaseTableChanges]=0, [AppViewName]=N'zwm_route', [SiteColumnName]=N'SiteRef' WHERE [TableName]=N'zwm_route_mst'

IF NOT EXISTS(SELECT * FROM [dbo].[AppTable] WHERE [TableName]=N'zwm_freight_weight_mst')
	INSERT INTO [dbo].[AppTable] ([TableName], [Update_AllWhen], [UpdateRecordDateWhen], [IgnoreInsert], [IgnoreUpdate], [DisallowUpdate], [KeepClusteringKeys], [UseRPOnInsert], [UseRPOnUpdate], [IupTriggerModifiesNewRows], [RememberIdentity], [RegisterNewKey], [TestOutsideLockForNewKey], [NextKeyReverseKeyOrder], [InheritorTableList], [ModuleName], [Update_AllRegardlessOfBaseTableChanges], [AppViewName], [SiteColumnName]) VALUES (N'zwm_freight_weight_mst', NULL, NULL, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, NULL, N'Argentina Warehouse Mgmt', 0, N'zwm_freight_weight', N'SiteRef')
ELSE
	UPDATE [dbo].[AppTable] SET [TableName]=N'zwm_freight_weight_mst', [Update_AllWhen]=NULL, [UpdateRecordDateWhen]=NULL, [IgnoreInsert]=0, [IgnoreUpdate]=0, [DisallowUpdate]=0, [KeepClusteringKeys]=0, [UseRPOnInsert]=0, [UseRPOnUpdate]=0, [IupTriggerModifiesNewRows]=1, [RememberIdentity]=0, [RegisterNewKey]=0, [TestOutsideLockForNewKey]=0, [NextKeyReverseKeyOrder]=0, [InheritorTableList]=NULL, [ModuleName]=N'Argentina Warehouse Mgmt', [Update_AllRegardlessOfBaseTableChanges]=0, [AppViewName]=N'zwm_freight_weight', [SiteColumnName]=N'SiteRef' WHERE [TableName]=N'zwm_freight_weight_mst'
