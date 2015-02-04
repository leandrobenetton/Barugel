IF NOT EXISTS(SELECT * FROM [dbo].[BGTaskDefinitions] WHERE [TaskName]=N'ZWM_BarcodedItemLabelsReport')
	INSERT INTO [dbo].[BGTaskDefinitions] ([TaskName], [TaskTypeCode], [TaskExecutable], [ExclusiveFlag], [TaskDescription], [MaxConcurrent], [IsolationLevel], [ReportType]) VALUES (N'ZWM_BarcodedItemLabelsReport', N'RPT', N'ZWM_Rpt_BarcodedItemLabels', 0, NULL, 20, NULL, NULL)
ELSE
	UPDATE [dbo].[BGTaskDefinitions] SET [TaskName]=N'ZWM_BarcodedItemLabelsReport', [TaskTypeCode]=N'RPT', [TaskExecutable]=N'ZWM_Rpt_BarcodedItemLabels', [ExclusiveFlag]=0, [TaskDescription]=NULL, [MaxConcurrent]=20, [IsolationLevel]=NULL, [ReportType]=NULL WHERE [TaskName]=N'ZWM_BarcodedItemLabelsReport'
	
------------------------------------------------------------------------------------------------------------------------

IF NOT EXISTS(SELECT * FROM [dbo].[BGTaskDefinitions] WHERE [TaskName]=N'ZWM_GoodsReceivingNoteReport')
	INSERT INTO [dbo].[BGTaskDefinitions] ([TaskName], [TaskTypeCode], [TaskExecutable], [ExclusiveFlag], [TaskDescription], [MaxConcurrent], [IsolationLevel], [ReportType]) VALUES (N'ZWM_GoodsReceivingNoteReport', N'RPT', N'ZWM_GoodsReceivingNote', 0, NULL, 20, NULL, NULL)
ELSE
	UPDATE [dbo].[BGTaskDefinitions] SET [TaskName]=N'ZWM_GoodsReceivingNoteReport', [TaskTypeCode]=N'RPT', [TaskExecutable]=N'ZWM_GoodsReceivingNote', [ExclusiveFlag]=0, [TaskDescription]=NULL, [MaxConcurrent]=20, [IsolationLevel]=NULL, [ReportType]=NULL WHERE [TaskName]=N'ZWM_GoodsReceivingNoteReport'

------------------------------------------------------------------------------------------------------------------------

IF NOT EXISTS(SELECT * FROM [dbo].[BGTaskDefinitions] WHERE [TaskName]=N'GoodsReceivingNoteReport')
	INSERT INTO [dbo].[BGTaskDefinitions] ([TaskName], [TaskTypeCode], [TaskExecutable], [ExclusiveFlag], [TaskDescription], [MaxConcurrent], [IsolationLevel], [ReportType]) VALUES (N'GoodsReceivingNoteReport', N'RPT', N'ZWM_GoodsReceivingNote', 0, NULL, 20, NULL, NULL)
ELSE
	UPDATE [dbo].[BGTaskDefinitions] SET [TaskName]=N'GoodsReceivingNoteReport', [TaskTypeCode]=N'RPT', [TaskExecutable]=N'ZWM_GoodsReceivingNote', [ExclusiveFlag]=0, [TaskDescription]=NULL, [MaxConcurrent]=20, [IsolationLevel]=NULL, [ReportType]=NULL WHERE [TaskName]=N'GoodsReceivingNoteReport'
	
------------------------------------------------------------------------------------------------------------------------

IF NOT EXISTS(SELECT * FROM [dbo].[BGTaskDefinitions] WHERE [TaskName]=N'ZWM_ItemStorageReport')
	INSERT INTO [dbo].[BGTaskDefinitions] ([TaskName], [TaskTypeCode], [TaskExecutable], [ExclusiveFlag], [TaskDescription], [MaxConcurrent], [IsolationLevel], [ReportType]) VALUES (N'ZWM_ItemStorageReport', N'RPT', N'ZWM_ItemStorageReport', 0, NULL, 20, NULL, NULL)
ELSE
	UPDATE [dbo].[BGTaskDefinitions] SET [TaskName]=N'ZWM_ItemStorageReport', [TaskTypeCode]=N'RPT', [TaskExecutable]=N'ZWM_ItemStorageReport', [ExclusiveFlag]=0, [TaskDescription]=NULL, [MaxConcurrent]=20, [IsolationLevel]=NULL, [ReportType]=NULL WHERE [TaskName]=N'ZWM_ItemStorageReport'

------------------------------------------------------------------------------------------------------------------------

IF NOT EXISTS(SELECT * FROM [dbo].[BGTaskDefinitions] WHERE [TaskName]=N'ZWM_RFRecConsReport')
	INSERT INTO [dbo].[BGTaskDefinitions] ([TaskName], [TaskTypeCode], [TaskExecutable], [ExclusiveFlag], [TaskDescription], [MaxConcurrent], [IsolationLevel], [ReportType]) VALUES (N'ZWM_RFRecConsReport', N'RPT', N'ZWM_RFRecConsReport', 0, NULL, 20, NULL, NULL)
ELSE
	UPDATE [dbo].[BGTaskDefinitions] SET [TaskName]=N'ZWM_RFRecConsReport', [TaskTypeCode]=N'RPT', [TaskExecutable]=N'ZWM_RFRecConsReport', [ExclusiveFlag]=0, [TaskDescription]=NULL, [MaxConcurrent]=20, [IsolationLevel]=NULL, [ReportType]=NULL WHERE [TaskName]=N'ZWM_RFRecConsReport'

------------------------------------------------------------------------------------------------------------------------

IF NOT EXISTS(SELECT * FROM [dbo].[BGTaskDefinitions] WHERE [TaskName]=N'VendorASNReconciliationReport')
	INSERT INTO [dbo].[BGTaskDefinitions] ([TaskName], [TaskTypeCode], [TaskExecutable], [ExclusiveFlag], [TaskDescription], [MaxConcurrent], [IsolationLevel], [ReportType]) VALUES (N'VendorASNReconciliationReport', N'RPT', N'ZWM_VendorASNReconciliationReport', 0, NULL, 20, NULL, NULL)
ELSE
	UPDATE [dbo].[BGTaskDefinitions] SET [TaskName]=N'VendorASNReconciliationReport', [TaskTypeCode]=N'RPT', [TaskExecutable]=N'ZWM_VendorASNReconciliationReport', [ExclusiveFlag]=0, [TaskDescription]=NULL, [MaxConcurrent]=20, [IsolationLevel]=NULL, [ReportType]=NULL WHERE [TaskName]=N'VendorASNReconciliationReport'	

------------------------------------------------------------------------------------------------------------------------

IF NOT EXISTS(SELECT * FROM [dbo].[BGTaskDefinitions] WHERE [TaskName]=N'ZWM_LocationLabelReport')
	INSERT INTO [dbo].[BGTaskDefinitions] ([TaskName], [TaskTypeCode], [TaskExecutable], [ExclusiveFlag], [TaskDescription], [MaxConcurrent], [IsolationLevel], [ReportType]) VALUES (N'ZWM_LocationLabelReport', N'RPT', N'ZWM_LocationLabel', 0, NULL, 20, NULL, NULL)
ELSE
	UPDATE [dbo].[BGTaskDefinitions] SET [TaskName]=N'ZWM_LocationLabelReport', [TaskTypeCode]=N'RPT', [TaskExecutable]=N'ZWM_LocationLabel', [ExclusiveFlag]=0, [TaskDescription]=NULL, [MaxConcurrent]=20, [IsolationLevel]=NULL, [ReportType]=NULL WHERE [TaskName]=N'ZWM_LocationLabelReport'		

------------------------------------------------------------------------------------------------------------------------

IF NOT EXISTS(SELECT * FROM [dbo].[BGTaskDefinitions] WHERE [TaskName]=N'ZWM_Stk1BarCodeItemLabelsReport')
	INSERT INTO [dbo].[BGTaskDefinitions] ([TaskName], [TaskTypeCode], [TaskExecutable], [ExclusiveFlag], [TaskDescription], [MaxConcurrent], [IsolationLevel], [ReportType]) VALUES (N'ZWM_Stk1BarCodeItemLabelsReport', N'RPT', N'ZWM_Stk1BarCodeItemLabels', 0, NULL, 20, NULL, NULL)
ELSE
	UPDATE [dbo].[BGTaskDefinitions] SET [TaskName]=N'ZWM_Stk1BarCodeItemLabelsReport', [TaskTypeCode]=N'RPT', [TaskExecutable]=N'ZWM_Stk1BarCodeItemLabels', [ExclusiveFlag]=0, [TaskDescription]=NULL, [MaxConcurrent]=20, [IsolationLevel]=NULL, [ReportType]=NULL WHERE [TaskName]=N'ZWM_Stk1BarCodeItemLabelsReport'		

------------------------------------------------------------------------------------------------------------------------

IF NOT EXISTS(SELECT * FROM [dbo].[BGTaskDefinitions] WHERE [TaskName]=N'ZWM_Stk2BarCodeItemLabelsReport')
	INSERT INTO [dbo].[BGTaskDefinitions] ([TaskName], [TaskTypeCode], [TaskExecutable], [ExclusiveFlag], [TaskDescription], [MaxConcurrent], [IsolationLevel], [ReportType]) VALUES (N'ZWM_Stk2BarCodeItemLabelsReport', N'RPT', N'ZWM_Stk2BarCodeItemLabels', 0, NULL, 20, NULL, NULL)
ELSE
	UPDATE [dbo].[BGTaskDefinitions] SET [TaskName]=N'ZWM_Stk2BarCodeItemLabelsReport', [TaskTypeCode]=N'RPT', [TaskExecutable]=N'ZWM_Stk2BarCodeItemLabels', [ExclusiveFlag]=0, [TaskDescription]=NULL, [MaxConcurrent]=20, [IsolationLevel]=NULL, [ReportType]=NULL WHERE [TaskName]=N'ZWM_Stk2BarCodeItemLabelsReport'		

------------------------------------------------------------------------------------------------------------------------

IF NOT EXISTS(SELECT * FROM [dbo].[BGTaskDefinitions] WHERE [TaskName]=N'ZWM_PickListRouteReport')
	INSERT INTO [dbo].[BGTaskDefinitions] ([TaskName], [TaskTypeCode], [TaskExecutable], [ExclusiveFlag], [TaskDescription], [MaxConcurrent], [IsolationLevel], [ReportType]) VALUES (N'ZWM_PickListRouteReport', N'RPT', N'ZWM_PickListRouteReport', 0, NULL, 20, NULL, NULL)
ELSE
	UPDATE [dbo].[BGTaskDefinitions] SET [TaskName]=N'ZWM_PickListRouteReport', [TaskTypeCode]=N'RPT', [TaskExecutable]=N'ZWM_PickListRouteReport', [ExclusiveFlag]=0, [TaskDescription]=NULL, [MaxConcurrent]=20, [IsolationLevel]=NULL, [ReportType]=NULL WHERE [TaskName]=N'ZWM_PickListRouteReport'		

------------------------------------------------------------------------------------------------------------------------

IF NOT EXISTS(SELECT * FROM [dbo].[BGTaskDefinitions] WHERE [TaskName]=N'ZWM_RouteMapLabels')
	INSERT INTO [dbo].[BGTaskDefinitions] ([TaskName], [TaskTypeCode], [TaskExecutable], [ExclusiveFlag], [TaskDescription], [MaxConcurrent], [IsolationLevel], [ReportType]) VALUES (N'ZWM_RouteMapLabels', N'RPT', N'ZWM_RouteMapLabels', 0, NULL, 20, NULL, NULL)
ELSE
	UPDATE [dbo].[BGTaskDefinitions] SET [TaskName]=N'ZWM_RouteMapLabels', [TaskTypeCode]=N'RPT', [TaskExecutable]=N'ZWM_Rpt_RouteMapLabelsSp', [ExclusiveFlag]=0, [TaskDescription]=NULL, [MaxConcurrent]=20, [IsolationLevel]=NULL, [ReportType]=NULL WHERE [TaskName]=N'ZWM_RouteMapLabels'		

------------------------------------------------------------------------------------------------------------------------

IF NOT EXISTS(SELECT * FROM [dbo].[BGTaskDefinitions] WHERE [TaskName]=N'BAR_ShipmentPackingSlipReport')
	INSERT INTO [dbo].[BGTaskDefinitions] ([TaskName], [TaskTypeCode], [TaskExecutable], [ExclusiveFlag], [TaskDescription], [MaxConcurrent], [IsolationLevel], [ReportType]) VALUES (N'BAR_ShipmentPackingSlipReport', N'RPT', N'BAR_ShipmentPackingSlip', 0, NULL, 20, NULL, NULL)
ELSE
	UPDATE [dbo].[BGTaskDefinitions] SET [TaskName]=N'BAR_ShipmentPackingSlipReport', [TaskTypeCode]=N'RPT', [TaskExecutable]=N'BAR_ShipmentPackingSlip', [ExclusiveFlag]=0, [TaskDescription]=NULL, [MaxConcurrent]=20, [IsolationLevel]=NULL, [ReportType]=NULL WHERE [TaskName]=N'BAR_ShipmentPackingSlipReport'		

------------------------------------------------------------------------------------------------------------------------