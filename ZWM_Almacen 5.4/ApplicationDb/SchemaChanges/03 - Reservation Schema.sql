SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

GO
IF NOT (EXISTS(SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID(N'[dbo].[zwm_mvtran_mst]') AND [type]='U'))
CREATE TABLE [dbo].[zwm_mvtran_mst] (
		[SiteRef]            [dbo].[SiteType] NOT NULL,
		[trans_num]          [dbo].[DcTransNumType] IDENTITY(1, 1) NOT NULL,
		[whse]               [dbo].[WhseType] NOT NULL,
		[item]               [dbo].[ItemType] NOT NULL,
		[from_loc]           [dbo].[LocType] NULL,
		[from_lot]           [dbo].[LotType] NULL,
		[to_loc]             [dbo].[LocType] NULL,
		[to_lot]             [dbo].[LotType] NULL,
		[stat]               [dbo].[DcStatusType] NULL,
		[trans_type]         [dbo].[DcTransTypeType] NULL,
		[trans_date]         [dbo].[DateType] NOT NULL,
		[qty_moved]          [dbo].[QtyUnitNoNegType] NULL,
		[u_m]                [dbo].[UMType] NOT NULL,
		[document_num]       [dbo].[DocumentNumType] NULL,
		[exchange]           [dbo].[FlagNyType] NULL,
		[exchange_loc]       [dbo].[LocType] NOT NULL,
		[exchange_lot]       [dbo].[LotType] NULL,
		[CreatedBy]          [dbo].[UsernameType] NOT NULL,
		[UpdatedBy]          [dbo].[UsernameType] NOT NULL,
		[CreateDate]         [dbo].[CurrentDateType] NOT NULL,
		[RecordDate]         [dbo].[CurrentDateType] NOT NULL,
		[RowPointer]         [dbo].[RowPointerType] NOT NULL,
		[NoteExistsFlag]     [dbo].[FlagNyType] NOT NULL,
		[InWorkflow]         [dbo].[FlagNyType] NOT NULL,
		CONSTRAINT [IX_zwm_mvtran_mst_RowPointer]
		UNIQUE
		NONCLUSTERED
		([RowPointer])

)
GO
IF (EXISTS(SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID(N'[dbo].[zwm_mvtran_mst]') AND [type]='U')) AND NOT (EXISTS (SELECT * FROM sys.indexes WHERE [name]=N'PK_zwm_mvtran_mst_1' AND [object_id]=OBJECT_ID(N'[dbo].[zwm_mvtran_mst]')))
ALTER TABLE [dbo].[zwm_mvtran_mst]
	ADD
	CONSTRAINT [PK_zwm_mvtran_mst_1]
	PRIMARY KEY
	CLUSTERED
	([SiteRef], [trans_num])
GO
IF (EXISTS(SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID(N'[dbo].[zwm_mvtran_mst]') AND [type]='U')) AND NOT (EXISTS (SELECT * FROM sys.objects WHERE [object_id]=OBJECT_ID(N'[dbo].[DF_zwm_mvtran_mst_CreateDate]') AND [parent_object_id]=OBJECT_ID(N'[dbo].[zwm_mvtran_mst]')))
ALTER TABLE [dbo].[zwm_mvtran_mst]
	ADD
	CONSTRAINT [DF_zwm_mvtran_mst_CreateDate]
	DEFAULT (getdate()) FOR [CreateDate]
GO
IF (EXISTS(SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID(N'[dbo].[zwm_mvtran_mst]') AND [type]='U')) AND NOT (EXISTS (SELECT * FROM sys.objects WHERE [object_id]=OBJECT_ID(N'[dbo].[DF_zwm_mvtran_mst_CreatedBy]') AND [parent_object_id]=OBJECT_ID(N'[dbo].[zwm_mvtran_mst]')))
ALTER TABLE [dbo].[zwm_mvtran_mst]
	ADD
	CONSTRAINT [DF_zwm_mvtran_mst_CreatedBy]
	DEFAULT (suser_sname()) FOR [CreatedBy]
GO
IF (EXISTS(SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID(N'[dbo].[zwm_mvtran_mst]') AND [type]='U')) AND NOT (EXISTS (SELECT * FROM sys.objects WHERE [object_id]=OBJECT_ID(N'[dbo].[DF_zwm_mvtran_mst_exchange]') AND [parent_object_id]=OBJECT_ID(N'[dbo].[zwm_mvtran_mst]')))
ALTER TABLE [dbo].[zwm_mvtran_mst]
	ADD
	CONSTRAINT [DF_zwm_mvtran_mst_exchange]
	DEFAULT ((0)) FOR [exchange]
GO
IF (EXISTS(SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID(N'[dbo].[zwm_mvtran_mst]') AND [type]='U')) AND NOT (EXISTS (SELECT * FROM sys.objects WHERE [object_id]=OBJECT_ID(N'[dbo].[DF_zwm_mvtran_mst_InWorkflow]') AND [parent_object_id]=OBJECT_ID(N'[dbo].[zwm_mvtran_mst]')))
ALTER TABLE [dbo].[zwm_mvtran_mst]
	ADD
	CONSTRAINT [DF_zwm_mvtran_mst_InWorkflow]
	DEFAULT ((0)) FOR [InWorkflow]
GO
IF (EXISTS(SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID(N'[dbo].[zwm_mvtran_mst]') AND [type]='U')) AND NOT (EXISTS (SELECT * FROM sys.objects WHERE [object_id]=OBJECT_ID(N'[dbo].[DF_zwm_mvtran_mst_NoteExistsFlag]') AND [parent_object_id]=OBJECT_ID(N'[dbo].[zwm_mvtran_mst]')))
ALTER TABLE [dbo].[zwm_mvtran_mst]
	ADD
	CONSTRAINT [DF_zwm_mvtran_mst_NoteExistsFlag]
	DEFAULT ((0)) FOR [NoteExistsFlag]
GO
IF (EXISTS(SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID(N'[dbo].[zwm_mvtran_mst]') AND [type]='U')) AND NOT (EXISTS (SELECT * FROM sys.objects WHERE [object_id]=OBJECT_ID(N'[dbo].[DF_zwm_mvtran_mst_qty_moved]') AND [parent_object_id]=OBJECT_ID(N'[dbo].[zwm_mvtran_mst]')))
ALTER TABLE [dbo].[zwm_mvtran_mst]
	ADD
	CONSTRAINT [DF_zwm_mvtran_mst_qty_moved]
	DEFAULT ((0)) FOR [qty_moved]
GO
IF (EXISTS(SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID(N'[dbo].[zwm_mvtran_mst]') AND [type]='U')) AND NOT (EXISTS (SELECT * FROM sys.objects WHERE [object_id]=OBJECT_ID(N'[dbo].[DF_zwm_mvtran_mst_RecordDate]') AND [parent_object_id]=OBJECT_ID(N'[dbo].[zwm_mvtran_mst]')))
ALTER TABLE [dbo].[zwm_mvtran_mst]
	ADD
	CONSTRAINT [DF_zwm_mvtran_mst_RecordDate]
	DEFAULT (getdate()) FOR [RecordDate]
GO
IF (EXISTS(SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID(N'[dbo].[zwm_mvtran_mst]') AND [type]='U')) AND NOT (EXISTS (SELECT * FROM sys.objects WHERE [object_id]=OBJECT_ID(N'[dbo].[DF_zwm_mvtran_mst_RowPointer]') AND [parent_object_id]=OBJECT_ID(N'[dbo].[zwm_mvtran_mst]')))
ALTER TABLE [dbo].[zwm_mvtran_mst]
	ADD
	CONSTRAINT [DF_zwm_mvtran_mst_RowPointer]
	DEFAULT (newid()) FOR [RowPointer]
GO
IF (EXISTS(SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID(N'[dbo].[zwm_mvtran_mst]') AND [type]='U')) AND NOT (EXISTS (SELECT * FROM sys.objects WHERE [object_id]=OBJECT_ID(N'[dbo].[DF_zwm_mvtran_mst_SiteRef]') AND [parent_object_id]=OBJECT_ID(N'[dbo].[zwm_mvtran_mst]')))
ALTER TABLE [dbo].[zwm_mvtran_mst]
	ADD
	CONSTRAINT [DF_zwm_mvtran_mst_SiteRef]
	DEFAULT (rtrim(CONVERT([nvarchar](8),context_info(),(0)))) FOR [SiteRef]
GO
IF (EXISTS(SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID(N'[dbo].[zwm_mvtran_mst]') AND [type]='U')) AND NOT (EXISTS (SELECT * FROM sys.objects WHERE [object_id]=OBJECT_ID(N'[dbo].[DF_zwm_mvtran_mst_UpdatedBy]') AND [parent_object_id]=OBJECT_ID(N'[dbo].[zwm_mvtran_mst]')))
ALTER TABLE [dbo].[zwm_mvtran_mst]
	ADD
	CONSTRAINT [DF_zwm_mvtran_mst_UpdatedBy]
	DEFAULT (suser_sname()) FOR [UpdatedBy]
GO
ALTER TABLE [dbo].[zwm_mvtran_mst] SET (LOCK_ESCALATION = TABLE)
GO
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

GO
IF NOT (EXISTS(SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID(N'[dbo].[zwm_item_col_box_mst]') AND [type]='U'))
CREATE TABLE [dbo].[zwm_item_col_box_mst] (
		[SiteRef]            [dbo].[SiteType] NOT NULL,
		[item]               [dbo].[ItemType] NOT NULL,
		[whse]               [dbo].[WhseType] NOT NULL,
		[loc]                [dbo].[LocType] NOT NULL,
		[reorder_qty]        [dbo].[QtyUnitType] NULL,
		[min_qty]            [dbo].[QtyUnitType] NULL,
		[CreatedBy]          [dbo].[UsernameType] NOT NULL,
		[UpdatedBy]          [dbo].[UsernameType] NOT NULL,
		[CreateDate]         [dbo].[CurrentDateType] NOT NULL,
		[RecordDate]         [dbo].[CurrentDateType] NOT NULL,
		[RowPointer]         [dbo].[RowPointerType] NOT NULL,
		[NoteExistsFlag]     [dbo].[FlagNyType] NOT NULL,
		[InWorkflow]         [dbo].[FlagNyType] NOT NULL,
		CONSTRAINT [IX_zwm_item_col_box_mst_RowPointer]
		UNIQUE
		NONCLUSTERED
		([RowPointer])

)
GO
IF (EXISTS(SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID(N'[dbo].[zwm_item_col_box_mst]') AND [type]='U')) AND NOT (EXISTS (SELECT * FROM sys.indexes WHERE [name]=N'PK_zwm_item_col_box_mst' AND [object_id]=OBJECT_ID(N'[dbo].[zwm_item_col_box_mst]')))
ALTER TABLE [dbo].[zwm_item_col_box_mst]
	ADD
	CONSTRAINT [PK_zwm_item_col_box_mst]
	PRIMARY KEY
	CLUSTERED
	([SiteRef], [item], [whse])
GO
IF (EXISTS(SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID(N'[dbo].[zwm_item_col_box_mst]') AND [type]='U')) AND NOT (EXISTS (SELECT * FROM sys.objects WHERE [object_id]=OBJECT_ID(N'[dbo].[DF_zwm_item_col_box_mst_CreateDate]') AND [parent_object_id]=OBJECT_ID(N'[dbo].[zwm_item_col_box_mst]')))
ALTER TABLE [dbo].[zwm_item_col_box_mst]
	ADD
	CONSTRAINT [DF_zwm_item_col_box_mst_CreateDate]
	DEFAULT (getdate()) FOR [CreateDate]
GO
IF (EXISTS(SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID(N'[dbo].[zwm_item_col_box_mst]') AND [type]='U')) AND NOT (EXISTS (SELECT * FROM sys.objects WHERE [object_id]=OBJECT_ID(N'[dbo].[DF_zwm_item_col_box_mst_CreatedBy]') AND [parent_object_id]=OBJECT_ID(N'[dbo].[zwm_item_col_box_mst]')))
ALTER TABLE [dbo].[zwm_item_col_box_mst]
	ADD
	CONSTRAINT [DF_zwm_item_col_box_mst_CreatedBy]
	DEFAULT (suser_sname()) FOR [CreatedBy]
GO
IF (EXISTS(SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID(N'[dbo].[zwm_item_col_box_mst]') AND [type]='U')) AND NOT (EXISTS (SELECT * FROM sys.objects WHERE [object_id]=OBJECT_ID(N'[dbo].[DF_zwm_item_col_box_mst_InWorkflow]') AND [parent_object_id]=OBJECT_ID(N'[dbo].[zwm_item_col_box_mst]')))
ALTER TABLE [dbo].[zwm_item_col_box_mst]
	ADD
	CONSTRAINT [DF_zwm_item_col_box_mst_InWorkflow]
	DEFAULT ((0)) FOR [InWorkflow]
GO
IF (EXISTS(SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID(N'[dbo].[zwm_item_col_box_mst]') AND [type]='U')) AND NOT (EXISTS (SELECT * FROM sys.objects WHERE [object_id]=OBJECT_ID(N'[dbo].[DF_zwm_item_col_box_mst_min_qty]') AND [parent_object_id]=OBJECT_ID(N'[dbo].[zwm_item_col_box_mst]')))
ALTER TABLE [dbo].[zwm_item_col_box_mst]
	ADD
	CONSTRAINT [DF_zwm_item_col_box_mst_min_qty]
	DEFAULT ((0)) FOR [min_qty]
GO
IF (EXISTS(SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID(N'[dbo].[zwm_item_col_box_mst]') AND [type]='U')) AND NOT (EXISTS (SELECT * FROM sys.objects WHERE [object_id]=OBJECT_ID(N'[dbo].[DF_zwm_item_col_box_mst_NoteExistsFlag]') AND [parent_object_id]=OBJECT_ID(N'[dbo].[zwm_item_col_box_mst]')))
ALTER TABLE [dbo].[zwm_item_col_box_mst]
	ADD
	CONSTRAINT [DF_zwm_item_col_box_mst_NoteExistsFlag]
	DEFAULT ((0)) FOR [NoteExistsFlag]
GO
IF (EXISTS(SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID(N'[dbo].[zwm_item_col_box_mst]') AND [type]='U')) AND NOT (EXISTS (SELECT * FROM sys.objects WHERE [object_id]=OBJECT_ID(N'[dbo].[DF_zwm_item_col_box_mst_RecordDate]') AND [parent_object_id]=OBJECT_ID(N'[dbo].[zwm_item_col_box_mst]')))
ALTER TABLE [dbo].[zwm_item_col_box_mst]
	ADD
	CONSTRAINT [DF_zwm_item_col_box_mst_RecordDate]
	DEFAULT (getdate()) FOR [RecordDate]
GO
IF (EXISTS(SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID(N'[dbo].[zwm_item_col_box_mst]') AND [type]='U')) AND NOT (EXISTS (SELECT * FROM sys.objects WHERE [object_id]=OBJECT_ID(N'[dbo].[DF_zwm_item_col_box_mst_reorder_qty]') AND [parent_object_id]=OBJECT_ID(N'[dbo].[zwm_item_col_box_mst]')))
ALTER TABLE [dbo].[zwm_item_col_box_mst]
	ADD
	CONSTRAINT [DF_zwm_item_col_box_mst_reorder_qty]
	DEFAULT ((0)) FOR [reorder_qty]
GO
IF (EXISTS(SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID(N'[dbo].[zwm_item_col_box_mst]') AND [type]='U')) AND NOT (EXISTS (SELECT * FROM sys.objects WHERE [object_id]=OBJECT_ID(N'[dbo].[DF_zwm_item_col_box_mst_RowPointer]') AND [parent_object_id]=OBJECT_ID(N'[dbo].[zwm_item_col_box_mst]')))
ALTER TABLE [dbo].[zwm_item_col_box_mst]
	ADD
	CONSTRAINT [DF_zwm_item_col_box_mst_RowPointer]
	DEFAULT (newid()) FOR [RowPointer]
GO
IF (EXISTS(SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID(N'[dbo].[zwm_item_col_box_mst]') AND [type]='U')) AND NOT (EXISTS (SELECT * FROM sys.objects WHERE [object_id]=OBJECT_ID(N'[dbo].[DF_zwm_item_col_box_mst_SiteRef]') AND [parent_object_id]=OBJECT_ID(N'[dbo].[zwm_item_col_box_mst]')))
ALTER TABLE [dbo].[zwm_item_col_box_mst]
	ADD
	CONSTRAINT [DF_zwm_item_col_box_mst_SiteRef]
	DEFAULT (rtrim(CONVERT([nvarchar](8),context_info(),(0)))) FOR [SiteRef]
GO
IF (EXISTS(SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID(N'[dbo].[zwm_item_col_box_mst]') AND [type]='U')) AND NOT (EXISTS (SELECT * FROM sys.objects WHERE [object_id]=OBJECT_ID(N'[dbo].[DF_zwm_item_col_box_mst_UpdatedBy]') AND [parent_object_id]=OBJECT_ID(N'[dbo].[zwm_item_col_box_mst]')))
ALTER TABLE [dbo].[zwm_item_col_box_mst]
	ADD
	CONSTRAINT [DF_zwm_item_col_box_mst_UpdatedBy]
	DEFAULT (suser_sname()) FOR [UpdatedBy]
GO
ALTER TABLE [dbo].[zwm_item_col_box_mst] SET (LOCK_ESCALATION = TABLE)
GO
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

GO

IF EXISTS(SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID(N'[dbo].[zwm_col_box_req_mst]') AND [type]='U')
DROP TABLE zwm_col_box_req_mst
GO


IF NOT (EXISTS(SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID(N'[dbo].[zwm_col_box_req_mst]') AND [type]='U'))
CREATE TABLE [dbo].[zwm_col_box_req_mst] (
		[SiteRef]            [dbo].[SiteType] NOT NULL,
		[item]               [dbo].[ItemType] NULL,
		[whse]               [dbo].[WhseType] NULL,
		[ref_type]           [dbo].[RefTypeIJKPRTType] NULL,
		[ref_num]            [dbo].[JobPoProjReqTrnNumType]  NULL,
		[ref_line_suf]       [dbo].[SuffixPoLineProjTaskReqTrnLineType]  NULL,
		[ref_release]        [dbo].[OperNumPoReleaseType]  NULL,
		[due_date]           [dbo].[DateType]  NULL,
		[qty_req_conv]       [dbo].[QtyUnitNoNegType] NULL,
		[u_m]                [dbo].[UMType] NULL,
		[CreatedBy]          [dbo].[UsernameType] NOT NULL,
		[UpdatedBy]          [dbo].[UsernameType] NOT NULL,
		[CreateDate]         [dbo].[CurrentDateType] NOT NULL,
		[RecordDate]         [dbo].[CurrentDateType] NOT NULL,
		[RowPointer]         [dbo].[RowPointerType] NOT NULL,
		[NoteExistsFlag]     [dbo].[FlagNyType] NOT NULL,
		[InWorkflow]         [dbo].[FlagNyType] NOT NULL,
		CONSTRAINT [IX_zwm_col_box_req_mst_RowPointer]
		UNIQUE
		NONCLUSTERED
		([RowPointer])

)
GO
IF (EXISTS(SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID(N'[dbo].[zwm_col_box_req_mst]') AND [type]='U')) AND NOT (EXISTS (SELECT * FROM sys.objects WHERE [object_id]=OBJECT_ID(N'[dbo].[DF_zwm_col_box_req_mst_CreateDate]') AND [parent_object_id]=OBJECT_ID(N'[dbo].[zwm_col_box_req_mst]')))
ALTER TABLE [dbo].[zwm_col_box_req_mst]
	ADD
	CONSTRAINT [DF_zwm_col_box_req_mst_CreateDate]
	DEFAULT (getdate()) FOR [CreateDate]
GO
IF (EXISTS(SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID(N'[dbo].[zwm_col_box_req_mst]') AND [type]='U')) AND NOT (EXISTS (SELECT * FROM sys.objects WHERE [object_id]=OBJECT_ID(N'[dbo].[DF_zwm_col_box_req_mst_CreatedBy]') AND [parent_object_id]=OBJECT_ID(N'[dbo].[zwm_col_box_req_mst]')))
ALTER TABLE [dbo].[zwm_col_box_req_mst]
	ADD
	CONSTRAINT [DF_zwm_col_box_req_mst_CreatedBy]
	DEFAULT (suser_sname()) FOR [CreatedBy]
GO
IF (EXISTS(SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID(N'[dbo].[zwm_col_box_req_mst]') AND [type]='U')) AND NOT (EXISTS (SELECT * FROM sys.objects WHERE [object_id]=OBJECT_ID(N'[dbo].[DF_zwm_col_box_req_mst_InWorkflow]') AND [parent_object_id]=OBJECT_ID(N'[dbo].[zwm_col_box_req_mst]')))
ALTER TABLE [dbo].[zwm_col_box_req_mst]
	ADD
	CONSTRAINT [DF_zwm_col_box_req_mst_InWorkflow]
	DEFAULT ((0)) FOR [InWorkflow]
GO
IF (EXISTS(SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID(N'[dbo].[zwm_col_box_req_mst]') AND [type]='U')) AND NOT (EXISTS (SELECT * FROM sys.objects WHERE [object_id]=OBJECT_ID(N'[dbo].[DF_zwm_col_box_req_mst_NoteExistsFlag]') AND [parent_object_id]=OBJECT_ID(N'[dbo].[zwm_col_box_req_mst]')))
ALTER TABLE [dbo].[zwm_col_box_req_mst]
	ADD
	CONSTRAINT [DF_zwm_col_box_req_mst_NoteExistsFlag]
	DEFAULT ((0)) FOR [NoteExistsFlag]
GO
IF (EXISTS(SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID(N'[dbo].[zwm_col_box_req_mst]') AND [type]='U')) AND NOT (EXISTS (SELECT * FROM sys.objects WHERE [object_id]=OBJECT_ID(N'[dbo].[DF_zwm_col_box_req_mst_qty_req_conv]') AND [parent_object_id]=OBJECT_ID(N'[dbo].[zwm_col_box_req_mst]')))
ALTER TABLE [dbo].[zwm_col_box_req_mst]
	ADD
	CONSTRAINT [DF_zwm_col_box_req_mst_qty_req_conv]
	DEFAULT ((0)) FOR [qty_req_conv]
GO
IF (EXISTS(SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID(N'[dbo].[zwm_col_box_req_mst]') AND [type]='U')) AND NOT (EXISTS (SELECT * FROM sys.objects WHERE [object_id]=OBJECT_ID(N'[dbo].[DF_zwm_col_box_req_mst_RecordDate]') AND [parent_object_id]=OBJECT_ID(N'[dbo].[zwm_col_box_req_mst]')))
ALTER TABLE [dbo].[zwm_col_box_req_mst]
	ADD
	CONSTRAINT [DF_zwm_col_box_req_mst_RecordDate]
	DEFAULT (getdate()) FOR [RecordDate]
GO
IF (EXISTS(SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID(N'[dbo].[zwm_col_box_req_mst]') AND [type]='U')) AND NOT (EXISTS (SELECT * FROM sys.objects WHERE [object_id]=OBJECT_ID(N'[dbo].[DF_zwm_col_box_req_mst_RowPointer]') AND [parent_object_id]=OBJECT_ID(N'[dbo].[zwm_col_box_req_mst]')))
ALTER TABLE [dbo].[zwm_col_box_req_mst]
	ADD
	CONSTRAINT [DF_zwm_col_box_req_mst_RowPointer]
	DEFAULT (newid()) FOR [RowPointer]
GO
IF (EXISTS(SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID(N'[dbo].[zwm_col_box_req_mst]') AND [type]='U')) AND NOT (EXISTS (SELECT * FROM sys.objects WHERE [object_id]=OBJECT_ID(N'[dbo].[DF_zwm_col_box_req_mst_SiteRef]') AND [parent_object_id]=OBJECT_ID(N'[dbo].[zwm_col_box_req_mst]')))
ALTER TABLE [dbo].[zwm_col_box_req_mst]
	ADD
	CONSTRAINT [DF_zwm_col_box_req_mst_SiteRef]
	DEFAULT (rtrim(CONVERT([nvarchar](8),context_info(),(0)))) FOR [SiteRef]
GO
IF (EXISTS(SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID(N'[dbo].[zwm_col_box_req_mst]') AND [type]='U')) AND NOT (EXISTS (SELECT * FROM sys.objects WHERE [object_id]=OBJECT_ID(N'[dbo].[DF_zwm_col_box_req_mst_UpdatedBy]') AND [parent_object_id]=OBJECT_ID(N'[dbo].[zwm_col_box_req_mst]')))
ALTER TABLE [dbo].[zwm_col_box_req_mst]
	ADD
	CONSTRAINT [DF_zwm_col_box_req_mst_UpdatedBy]
	DEFAULT (suser_sname()) FOR [UpdatedBy]
GO
ALTER TABLE [dbo].[zwm_col_box_req_mst] SET (LOCK_ESCALATION = TABLE)
GO
