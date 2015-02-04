/****** Object:  Table [dbo].[ZWM_TMP_disploc]    Script Date: 10/30/2014 13:00:26 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
IF NOT (EXISTS(SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID(N'[dbo].[ZWM_TMP_disploc]') AND [type]='U'))
CREATE TABLE [dbo].[ZWM_TMP_disploc](
	[RFRefRowPointer] [dbo].[RowPointerType] NULL,
	[item] [dbo].[ItemType] NULL,
	[whse] [dbo].[WhseType] NULL,
	[lot] [dbo].[LotType] NULL,
	[fromloc] [dbo].[LocType] NULL,
	[qtytostore] [dbo].[QtyUnitType] NULL,
	[loc] [dbo].[LocType] NULL,
	[description] [dbo].[DescriptionType] NULL,
	[seq] [int] NULL,
	[CreatedBy] [dbo].[UsernameType] NOT NULL,
	[UpdatedBy] [dbo].[UsernameType] NOT NULL,
	[CreateDate] [dbo].[CurrentDateType] NOT NULL,
	[RecordDate] [dbo].[CurrentDateType] NOT NULL,
	[RowPointer] [dbo].[RowPointerType] NOT NULL,
	[NoteExistsFlag] [dbo].[FlagNyType] NOT NULL,
	[InWorkflow] [dbo].[FlagNyType] NOT NULL,
 CONSTRAINT [IX_ZWM_TMP_disploc_RowPointer] UNIQUE NONCLUSTERED 
(
	[RowPointer] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO

IF (EXISTS(SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID(N'[dbo].[ZWM_TMP_disploc]') AND [type]='U')) AND NOT (EXISTS (SELECT * FROM sys.objects WHERE [object_id]=OBJECT_ID(N'[dbo].[DF_ZWM_TMP_disploc_CreatedBy]') AND [parent_object_id]=OBJECT_ID(N'[dbo].[ZWM_TMP_disploc]')))
ALTER TABLE [dbo].[ZWM_TMP_disploc] ADD  CONSTRAINT [DF_ZWM_TMP_disploc_CreatedBy]  DEFAULT (suser_sname()) FOR [CreatedBy]
GO

IF (EXISTS(SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID(N'[dbo].[ZWM_TMP_disploc]') AND [type]='U')) AND NOT (EXISTS (SELECT * FROM sys.objects WHERE [object_id]=OBJECT_ID(N'[dbo].[DF_ZWM_TMP_disploc_UpdatedBy]') AND [parent_object_id]=OBJECT_ID(N'[dbo].[ZWM_TMP_disploc]')))
ALTER TABLE [dbo].[ZWM_TMP_disploc] ADD  CONSTRAINT [DF_ZWM_TMP_disploc_UpdatedBy]  DEFAULT (suser_sname()) FOR [UpdatedBy]
GO

IF (EXISTS(SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID(N'[dbo].[ZWM_TMP_disploc]') AND [type]='U')) AND NOT (EXISTS (SELECT * FROM sys.objects WHERE [object_id]=OBJECT_ID(N'[dbo].[DF_ZWM_TMP_disploc_CreateDate]') AND [parent_object_id]=OBJECT_ID(N'[dbo].[ZWM_TMP_disploc]')))
ALTER TABLE [dbo].[ZWM_TMP_disploc] ADD  CONSTRAINT [DF_ZWM_TMP_disploc_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
GO

IF (EXISTS(SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID(N'[dbo].[ZWM_TMP_disploc]') AND [type]='U')) AND NOT (EXISTS (SELECT * FROM sys.objects WHERE [object_id]=OBJECT_ID(N'[dbo].[DF_ZWM_TMP_disploc_RecordDate]') AND [parent_object_id]=OBJECT_ID(N'[dbo].[ZWM_TMP_disploc]')))
ALTER TABLE [dbo].[ZWM_TMP_disploc] ADD  CONSTRAINT [DF_ZWM_TMP_disploc_RecordDate]  DEFAULT (getdate()) FOR [RecordDate]
GO

IF (EXISTS(SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID(N'[dbo].[ZWM_TMP_disploc]') AND [type]='U')) AND NOT (EXISTS (SELECT * FROM sys.objects WHERE [object_id]=OBJECT_ID(N'[dbo].[DF_ZWM_TMP_disploc_RowPointer]') AND [parent_object_id]=OBJECT_ID(N'[dbo].[ZWM_TMP_disploc]')))
ALTER TABLE [dbo].[ZWM_TMP_disploc] ADD  CONSTRAINT [DF_ZWM_TMP_disploc_RowPointer]  DEFAULT (newid()) FOR [RowPointer]
GO

IF (EXISTS(SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID(N'[dbo].[ZWM_TMP_disploc]') AND [type]='U')) AND NOT (EXISTS (SELECT * FROM sys.objects WHERE [object_id]=OBJECT_ID(N'[dbo].[DF_ZWM_TMP_disploc_NoteExistsFlag]') AND [parent_object_id]=OBJECT_ID(N'[dbo].[ZWM_TMP_disploc]')))
ALTER TABLE [dbo].[ZWM_TMP_disploc] ADD  CONSTRAINT [DF_ZWM_TMP_disploc_NoteExistsFlag]  DEFAULT ((0)) FOR [NoteExistsFlag]
GO

IF (EXISTS(SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID(N'[dbo].[ZWM_TMP_disploc]') AND [type]='U')) AND NOT (EXISTS (SELECT * FROM sys.objects WHERE [object_id]=OBJECT_ID(N'[dbo].[DF_ZWM_TMP_disploc_InWorkflow]') AND [parent_object_id]=OBJECT_ID(N'[dbo].[ZWM_TMP_disploc]')))
ALTER TABLE [dbo].[ZWM_TMP_disploc] ADD  CONSTRAINT [DF_ZWM_TMP_disploc_InWorkflow]  DEFAULT ((0)) FOR [InWorkflow]
GO


