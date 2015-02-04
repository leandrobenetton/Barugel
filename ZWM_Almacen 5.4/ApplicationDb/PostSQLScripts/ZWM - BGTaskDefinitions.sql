IF NOT EXISTS(SELECT * FROM [dbo].[BGTaskDefinitions] WHERE [TaskName]=N'ZWM_CollectBoxSupplyReport')
	INSERT INTO [dbo].[BGTaskDefinitions] ([TaskName], [TaskTypeCode], [TaskExecutable], [ExclusiveFlag], [TaskDescription], [MaxConcurrent], [IsolationLevel], [ReportType]) VALUES (N'ZWM_CollectBoxSupplyReport', N'RPT', N'ZWM_CollectBoxSupply', 0, NULL, 20, N'UNCOMMITTED', NULL)
IF NOT EXISTS(SELECT * FROM [dbo].[BGTaskDefinitions] WHERE [TaskName]=N'ZWM_DeleteTempReservation')
	INSERT INTO [dbo].[BGTaskDefinitions] ([TaskName], [TaskTypeCode], [TaskExecutable], [ExclusiveFlag], [TaskDescription], [MaxConcurrent], [IsolationLevel], [ReportType]) VALUES (N'ZWM_DeleteTempReservation', N'SP', N'ZWM_DeleteTempReservationSp', 0, NULL, 20, N'COMMITTED', NULL)



