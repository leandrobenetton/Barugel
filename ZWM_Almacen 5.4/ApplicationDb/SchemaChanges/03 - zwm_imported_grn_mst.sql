/****** Object:  Table [dbo].[zwm_imported_grn_mst]    Script Date: 10/02/2014 08:56:32 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[zwm_imported_grn_mst]') AND type in (N'U'))

CREATE TABLE [dbo].[zwm_imported_grn_mst](
	[po_num] [dbo].[PoNumType] NULL,
	[pack_number] [dbo].[VendInvoiceType] NULL,
	[item] [dbo].[ItemType] NULL,
	[bar_code] [dbo].[ZwmBarCodeType] NULL,
	[qty_shipped] [dbo].[QtyUnitNoNegType] NULL,
	[shipped_date] [dbo].[DateType] NULL,
	[processed] [dbo].[FlagNyType] NULL,
	[CreatedBy] [dbo].[UsernameType] NULL,
	[UpdatedBy] [dbo].[UsernameType] NULL,
	[CreateDate] [dbo].[CurrentDateType] NULL,
	[RecordDate] [dbo].[CurrentDateType] NULL,
	[RowPointer] [dbo].[RowPointerType] NULL,
	[NoteExistsFlag] [dbo].[FlagNyType] NULL,
	[InWorkflow] [dbo].[FlagNyType] NULL,
	[site_ref] [dbo].[SiteType] NULL,
 CONSTRAINT [IX_zwm_imported_grn_mst_RowPointer] UNIQUE NONCLUSTERED 
(
	[RowPointer] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING ON
GO

IF (EXISTS(SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID(N'[dbo].[zwm_imported_grn_mst]') AND [type]='U')) AND NOT (EXISTS (SELECT * FROM sys.objects WHERE [object_id]=OBJECT_ID(N'[dbo].[DF_zwm_imported_grn_mst_CreatedBy]') AND [parent_object_id]=OBJECT_ID(N'[dbo].[zwm_imported_grn_mst]')))
ALTER TABLE [dbo].[zwm_imported_grn_mst] ADD  CONSTRAINT [DF_zwm_imported_grn_mst_CreatedBy]  DEFAULT (suser_sname()) FOR [CreatedBy]
GO

IF (EXISTS(SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID(N'[dbo].[zwm_imported_grn_mst]') AND [type]='U')) AND NOT (EXISTS (SELECT * FROM sys.objects WHERE [object_id]=OBJECT_ID(N'[dbo].[DF_zwm_imported_grn_mst_UpdatedBy]') AND [parent_object_id]=OBJECT_ID(N'[dbo].[zwm_imported_grn_mst]')))
ALTER TABLE [dbo].[zwm_imported_grn_mst] ADD  CONSTRAINT [DF_zwm_imported_grn_mst_UpdatedBy]  DEFAULT (suser_sname()) FOR [UpdatedBy]
GO

IF (EXISTS(SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID(N'[dbo].[zwm_imported_grn_mst]') AND [type]='U')) AND NOT (EXISTS (SELECT * FROM sys.objects WHERE [object_id]=OBJECT_ID(N'[dbo].[DF_zwm_imported_grn_mst_CreateDate]') AND [parent_object_id]=OBJECT_ID(N'[dbo].[zwm_imported_grn_mst]')))
ALTER TABLE [dbo].[zwm_imported_grn_mst] ADD  CONSTRAINT [DF_zwm_imported_grn_mst_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
GO

IF (EXISTS(SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID(N'[dbo].[zwm_imported_grn_mst]') AND [type]='U')) AND NOT (EXISTS (SELECT * FROM sys.objects WHERE [object_id]=OBJECT_ID(N'[dbo].[DF_zwm_imported_grn_mst_RecordDate]') AND [parent_object_id]=OBJECT_ID(N'[dbo].[zwm_imported_grn_mst]')))
ALTER TABLE [dbo].[zwm_imported_grn_mst] ADD  CONSTRAINT [DF_zwm_imported_grn_mst_RecordDate]  DEFAULT (getdate()) FOR [RecordDate]
GO

IF (EXISTS(SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID(N'[dbo].[zwm_imported_grn_mst]') AND [type]='U')) AND NOT (EXISTS (SELECT * FROM sys.objects WHERE [object_id]=OBJECT_ID(N'[dbo].[DF_zwm_imported_grn_mst_RowPointer]') AND [parent_object_id]=OBJECT_ID(N'[dbo].[zwm_imported_grn_mst]')))
ALTER TABLE [dbo].[zwm_imported_grn_mst] ADD  CONSTRAINT [DF_zwm_imported_grn_mst_RowPointer]  DEFAULT (newid()) FOR [RowPointer]
GO

IF (EXISTS(SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID(N'[dbo].[zwm_imported_grn_mst]') AND [type]='U')) AND NOT (EXISTS (SELECT * FROM sys.objects WHERE [object_id]=OBJECT_ID(N'[dbo].[DF_zwm_imported_grn_mst_NoteExistsFlag]') AND [parent_object_id]=OBJECT_ID(N'[dbo].[zwm_imported_grn_mst]')))
ALTER TABLE [dbo].[zwm_imported_grn_mst] ADD  CONSTRAINT [DF_zwm_imported_grn_mst_NoteExistsFlag]  DEFAULT ((0)) FOR [NoteExistsFlag]
GO

IF (EXISTS(SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID(N'[dbo].[zwm_imported_grn_mst]') AND [type]='U')) AND NOT (EXISTS (SELECT * FROM sys.objects WHERE [object_id]=OBJECT_ID(N'[dbo].[DF_zwm_imported_grn_mst_InWorkflow]') AND [parent_object_id]=OBJECT_ID(N'[dbo].[zwm_imported_grn_mst]')))
ALTER TABLE [dbo].[zwm_imported_grn_mst] ADD  CONSTRAINT [DF_zwm_imported_grn_mst_InWorkflow]  DEFAULT ((0)) FOR [InWorkflow]
GO


