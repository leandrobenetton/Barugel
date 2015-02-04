/****** Object:  Table [dbo].[zwm_itm_whse_mst]    Script Date: 10/02/2014 09:01:02 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[zwm_itm_whse_mst]') AND type in (N'U'))

CREATE TABLE [dbo].[zwm_itm_whse_mst](
	[site_ref] [dbo].[SiteType] NOT NULL,
	[item] [dbo].[ItemType] NULL,
	[family_code] [dbo].[FamilyCodeType] NULL,
	[whse] [dbo].[WhseType] NOT NULL,
	[zone] [dbo].[DescriptionType] NULL,
	[location] [dbo].[DescriptionType] NULL,
	[ranking] [tinyint] NOT NULL,
	[empty_loc] [dbo].[ListYesNoType] NULL,
	[CreatedBy] [dbo].[UsernameType] NOT NULL,
	[UpdatedBy] [dbo].[UsernameType] NOT NULL,
	[CreateDate] [dbo].[CurrentDateType] NOT NULL,
	[RecordDate] [dbo].[CurrentDateType] NOT NULL,
	[RowPointer] [dbo].[RowPointerType] NOT NULL,
	[NoteExistsFlag] [dbo].[FlagNyType] NOT NULL,
	[InWorkflow] [dbo].[FlagNyType] NOT NULL,
 CONSTRAINT [PK_zwm_itm_whse_mst] PRIMARY KEY CLUSTERED 
(
	[RowPointer] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [IX_zwm_itm_whse_mst_RowPointer] UNIQUE NONCLUSTERED 
(
	[RowPointer] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO

IF (EXISTS(SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID(N'[dbo].[zwm_itm_whse_mst]') AND [type]='U')) AND NOT (EXISTS (SELECT * FROM sys.objects WHERE [object_id]=OBJECT_ID(N'[dbo].[DF_zwm_itm_whse_mst_site_ref]') AND [parent_object_id]=OBJECT_ID(N'[dbo].[zwm_itm_whse_mst]')))
ALTER TABLE [dbo].[zwm_itm_whse_mst] ADD  CONSTRAINT [DF_zwm_itm_whse_mst_site_ref]  DEFAULT (rtrim(CONVERT([nvarchar](8),context_info(),(0)))) FOR [site_ref]
GO

IF (EXISTS(SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID(N'[dbo].[zwm_itm_whse_mst]') AND [type]='U')) AND NOT (EXISTS (SELECT * FROM sys.objects WHERE [object_id]=OBJECT_ID(N'[dbo].[DF_zwm_itm_whse_mst_CreatedBy]') AND [parent_object_id]=OBJECT_ID(N'[dbo].[zwm_itm_whse_mst]')))
ALTER TABLE [dbo].[zwm_itm_whse_mst] ADD  CONSTRAINT [DF_zwm_itm_whse_mst_CreatedBy]  DEFAULT (suser_sname()) FOR [CreatedBy]
GO

IF (EXISTS(SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID(N'[dbo].[zwm_itm_whse_mst]') AND [type]='U')) AND NOT (EXISTS (SELECT * FROM sys.objects WHERE [object_id]=OBJECT_ID(N'[dbo].[DF_zwm_itm_whse_mst_UpdatedBy]') AND [parent_object_id]=OBJECT_ID(N'[dbo].[zwm_itm_whse_mst]')))
ALTER TABLE [dbo].[zwm_itm_whse_mst] ADD  CONSTRAINT [DF_zwm_itm_whse_mst_UpdatedBy]  DEFAULT (suser_sname()) FOR [UpdatedBy]
GO

IF (EXISTS(SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID(N'[dbo].[zwm_itm_whse_mst]') AND [type]='U')) AND NOT (EXISTS (SELECT * FROM sys.objects WHERE [object_id]=OBJECT_ID(N'[dbo].[DF_zwm_itm_whse_mst_CreateDate]') AND [parent_object_id]=OBJECT_ID(N'[dbo].[zwm_itm_whse_mst]')))
ALTER TABLE [dbo].[zwm_itm_whse_mst] ADD  CONSTRAINT [DF_zwm_itm_whse_mst_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
GO

IF (EXISTS(SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID(N'[dbo].[zwm_itm_whse_mst]') AND [type]='U')) AND NOT (EXISTS (SELECT * FROM sys.objects WHERE [object_id]=OBJECT_ID(N'[dbo].[DF_zwm_itm_whse_mst_RecordDate]') AND [parent_object_id]=OBJECT_ID(N'[dbo].[zwm_itm_whse_mst]')))
ALTER TABLE [dbo].[zwm_itm_whse_mst] ADD  CONSTRAINT [DF_zwm_itm_whse_mst_RecordDate]  DEFAULT (getdate()) FOR [RecordDate]
GO

IF (EXISTS(SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID(N'[dbo].[zwm_itm_whse_mst]') AND [type]='U')) AND NOT (EXISTS (SELECT * FROM sys.objects WHERE [object_id]=OBJECT_ID(N'[dbo].[DF_zwm_itm_whse_mst_RowPointer]') AND [parent_object_id]=OBJECT_ID(N'[dbo].[zwm_itm_whse_mst]')))
ALTER TABLE [dbo].[zwm_itm_whse_mst] ADD  CONSTRAINT [DF_zwm_itm_whse_mst_RowPointer]  DEFAULT (newid()) FOR [RowPointer]
GO

IF (EXISTS(SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID(N'[dbo].[zwm_itm_whse_mst]') AND [type]='U')) AND NOT (EXISTS (SELECT * FROM sys.objects WHERE [object_id]=OBJECT_ID(N'[dbo].[DF_zwm_itm_whse_mst_NoteExistsFlag]') AND [parent_object_id]=OBJECT_ID(N'[dbo].[zwm_itm_whse_mst]')))
ALTER TABLE [dbo].[zwm_itm_whse_mst] ADD  CONSTRAINT [DF_zwm_itm_whse_mst_NoteExistsFlag]  DEFAULT ((0)) FOR [NoteExistsFlag]
GO

IF (EXISTS(SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID(N'[dbo].[zwm_itm_whse_mst]') AND [type]='U')) AND NOT (EXISTS (SELECT * FROM sys.objects WHERE [object_id]=OBJECT_ID(N'[dbo].[DF_zwm_itm_whse_mst_InWorkflow]') AND [parent_object_id]=OBJECT_ID(N'[dbo].[zwm_itm_whse_mst]')))
ALTER TABLE [dbo].[zwm_itm_whse_mst] ADD  CONSTRAINT [DF_zwm_itm_whse_mst_InWorkflow]  DEFAULT ((0)) FOR [InWorkflow]
GO


