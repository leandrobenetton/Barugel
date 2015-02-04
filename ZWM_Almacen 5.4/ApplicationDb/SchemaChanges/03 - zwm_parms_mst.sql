/****** Object:  Table [dbo].[zwm_parms_mst]    Script Date: 10/28/2014 11:42:04 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO
IF NOT (EXISTS(SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID(N'[dbo].[zwm_parms_mst]') AND [type]='U'))
CREATE TABLE [dbo].[zwm_parms_mst](
	[site_ref] [dbo].[SiteType] NOT NULL,
	[parm_key] [dbo].[ParmKeyType] NOT NULL,
	[grn_prefix] [dbo].[GrnPrefixType] NULL,
	[loc] [dbo].[LocType] NOT NULL,
	[um_dimension_stock1] [dbo].[UMType] NULL,
	[um_weight] [dbo].[UMType] NULL,
	[um_vol] [dbo].[UMType] NULL,
	[volumetric_factor] [dbo].[ItemWeightType] NULL,
	[CreatedBy] [dbo].[UsernameType] NULL,
	[UpdatedBy] [dbo].[UsernameType] NULL,
	[CreateDate] [dbo].[CurrentDateType] NULL,
	[RecordDate] [dbo].[CurrentDateType] NULL,
	[RowPointer] [dbo].[RowPointerType] NULL,
	[NoteExistsFlag] [dbo].[FlagNyType] NULL,
	[InWorkflow] [dbo].[FlagNyType] NULL,
	[customer] [nvarchar](3) NULL,
	[reserve_pct] [dbo].[MarkupType] NULL,
 CONSTRAINT [PK_zwm_parms_mst] PRIMARY KEY CLUSTERED 
(
	[site_ref] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [IX_zwm_parms_mst_RowPointer] UNIQUE NONCLUSTERED 
(
	[RowPointer] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING ON
GO

IF (EXISTS(SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID(N'[dbo].[zwm_parms_mst]') AND [type]='U')) AND NOT (EXISTS (SELECT * FROM sys.objects WHERE [object_id]=OBJECT_ID(N'[dbo].[DF_zwm_parms_mst_site_ref]') AND [parent_object_id]=OBJECT_ID(N'[dbo].[zwm_parms_mst]')))
ALTER TABLE [dbo].[zwm_parms_mst] 
ADD  
CONSTRAINT [DF_zwm_parms_mst_site_ref]  
DEFAULT (rtrim(CONVERT([nvarchar](8),context_info(),(0)))) FOR [site_ref]
GO

------
IF (EXISTS(SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID(N'[dbo].[zwm_parms_mst]') AND [type]='U')) AND NOT (EXISTS (SELECT * FROM sys.objects WHERE [object_id]=OBJECT_ID(N'[dbo].[DF_zwm_parms_mst_CreatedBy]') AND [parent_object_id]=OBJECT_ID(N'[dbo].[zwm_parms_mst]')))
ALTER TABLE [dbo].[zwm_parms_mst] ADD  CONSTRAINT [DF_zwm_parms_mst_CreatedBy]  DEFAULT (suser_sname()) FOR [CreatedBy]
GO

IF (EXISTS(SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID(N'[dbo].[zwm_parms_mst]') AND [type]='U')) AND NOT (EXISTS (SELECT * FROM sys.objects WHERE [object_id]=OBJECT_ID(N'[dbo].[DF_zwm_parms_mst_UpdatedBy]') AND [parent_object_id]=OBJECT_ID(N'[dbo].[zwm_parms_mst]')))
ALTER TABLE [dbo].[zwm_parms_mst] ADD  CONSTRAINT [DF_zwm_parms_mst_UpdatedBy]  DEFAULT (suser_sname()) FOR [UpdatedBy]
GO

IF (EXISTS(SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID(N'[dbo].[zwm_parms_mst]') AND [type]='U')) AND NOT (EXISTS (SELECT * FROM sys.objects WHERE [object_id]=OBJECT_ID(N'[dbo].[DF_zwm_parms_mst_CreateDate]') AND [parent_object_id]=OBJECT_ID(N'[dbo].[zwm_parms_mst]')))
ALTER TABLE [dbo].[zwm_parms_mst] ADD  CONSTRAINT [DF_zwm_parms_mst_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
GO

IF (EXISTS(SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID(N'[dbo].[zwm_parms_mst]') AND [type]='U')) AND NOT (EXISTS (SELECT * FROM sys.objects WHERE [object_id]=OBJECT_ID(N'[dbo].[DF_zwm_parms_mst_RecordDate]') AND [parent_object_id]=OBJECT_ID(N'[dbo].[zwm_parms_mst]')))
ALTER TABLE [dbo].[zwm_parms_mst] ADD  CONSTRAINT [DF_zwm_parms_mst_RecordDate]  DEFAULT (getdate()) FOR [RecordDate]
GO

IF (EXISTS(SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID(N'[dbo].[zwm_parms_mst]') AND [type]='U')) AND NOT (EXISTS (SELECT * FROM sys.objects WHERE [object_id]=OBJECT_ID(N'[dbo].[DF_zwm_parms_mst_RowPointer]') AND [parent_object_id]=OBJECT_ID(N'[dbo].[zwm_parms_mst]')))
ALTER TABLE [dbo].[zwm_parms_mst] ADD  CONSTRAINT [DF_zwm_parms_mst_RowPointer]  DEFAULT (newid()) FOR [RowPointer]
GO

IF (EXISTS(SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID(N'[dbo].[zwm_parms_mst]') AND [type]='U')) AND NOT (EXISTS (SELECT * FROM sys.objects WHERE [object_id]=OBJECT_ID(N'[dbo].[DF_zwm_parms_mst_NoteExistsFlag]') AND [parent_object_id]=OBJECT_ID(N'[dbo].[zwm_parms_mst]')))
ALTER TABLE [dbo].[zwm_parms_mst] ADD  CONSTRAINT [DF_zwm_parms_mst_NoteExistsFlag]  DEFAULT ((0)) FOR [NoteExistsFlag]
GO

IF (EXISTS(SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID(N'[dbo].[zwm_parms_mst]') AND [type]='U')) AND NOT (EXISTS (SELECT * FROM sys.objects WHERE [object_id]=OBJECT_ID(N'[dbo].[DF_zwm_parms_mst_InWorkflow]') AND [parent_object_id]=OBJECT_ID(N'[dbo].[zwm_parms_mst]')))
ALTER TABLE [dbo].[zwm_parms_mst] ADD  CONSTRAINT [DF_zwm_parms_mst_InWorkflow]  DEFAULT ((0)) FOR [InWorkflow]
GO


