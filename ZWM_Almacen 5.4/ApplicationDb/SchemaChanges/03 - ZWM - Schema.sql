SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

GO
IF NOT (EXISTS(SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID(N'[dbo].[zwm_zip_addr_mst]') AND [type]='U'))
CREATE TABLE [dbo].[zwm_zip_addr_mst] (
		[SiteRef]            [dbo].[SiteType] NOT NULL,
		[zip]                [dbo].[PostalCodeType] NULL,
		[street]             [dbo].[AddressType] NULL,
		[ending_num]         [dbo].[GenericCodeType] NULL,
		[starting_num]       [dbo].[GenericCodeType] NULL,
		[city]               [dbo].[CityType] NULL,
		[county]             [dbo].[CountyType] NULL,
		[state]              [dbo].[StateType] NULL,
		[country]            [dbo].[CountryType] NULL,
		[CreatedBy]          [dbo].[UsernameType] NOT NULL,
		[UpdatedBy]          [dbo].[UsernameType] NOT NULL,
		[CreateDate]         [dbo].[CurrentDateType] NOT NULL,
		[RecordDate]         [dbo].[CurrentDateType] NOT NULL,
		[RowPointer]         [dbo].[RowPointerType] NOT NULL,
		[NoteExistsFlag]     [dbo].[FlagNyType] NOT NULL,
		[InWorkflow]         [dbo].[FlagNyType] NOT NULL,
		CONSTRAINT [IX_zwm_zip_addr_mst_RowPointer]
		UNIQUE
		NONCLUSTERED
		([RowPointer])

)
GO
IF (EXISTS(SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID(N'[dbo].[zwm_zip_addr_mst]') AND [type]='U')) AND NOT (EXISTS (SELECT * FROM sys.objects WHERE [object_id]=OBJECT_ID(N'[dbo].[DF_zwm_zip_addr_mst_CreateDate]') AND [parent_object_id]=OBJECT_ID(N'[dbo].[zwm_zip_addr_mst]')))
ALTER TABLE [dbo].[zwm_zip_addr_mst]
	ADD
	CONSTRAINT [DF_zwm_zip_addr_mst_CreateDate]
	DEFAULT (getdate()) FOR [CreateDate]
GO
IF (EXISTS(SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID(N'[dbo].[zwm_zip_addr_mst]') AND [type]='U')) AND NOT (EXISTS (SELECT * FROM sys.objects WHERE [object_id]=OBJECT_ID(N'[dbo].[DF_zwm_zip_addr_mst_CreatedBy]') AND [parent_object_id]=OBJECT_ID(N'[dbo].[zwm_zip_addr_mst]')))
ALTER TABLE [dbo].[zwm_zip_addr_mst]
	ADD
	CONSTRAINT [DF_zwm_zip_addr_mst_CreatedBy]
	DEFAULT (suser_sname()) FOR [CreatedBy]
GO
IF (EXISTS(SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID(N'[dbo].[zwm_zip_addr_mst]') AND [type]='U')) AND NOT (EXISTS (SELECT * FROM sys.objects WHERE [object_id]=OBJECT_ID(N'[dbo].[DF_zwm_zip_addr_mst_InWorkflow]') AND [parent_object_id]=OBJECT_ID(N'[dbo].[zwm_zip_addr_mst]')))
ALTER TABLE [dbo].[zwm_zip_addr_mst]
	ADD
	CONSTRAINT [DF_zwm_zip_addr_mst_InWorkflow]
	DEFAULT ((0)) FOR [InWorkflow]
GO
IF (EXISTS(SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID(N'[dbo].[zwm_zip_addr_mst]') AND [type]='U')) AND NOT (EXISTS (SELECT * FROM sys.objects WHERE [object_id]=OBJECT_ID(N'[dbo].[DF_zwm_zip_addr_mst_NoteExistsFlag]') AND [parent_object_id]=OBJECT_ID(N'[dbo].[zwm_zip_addr_mst]')))
ALTER TABLE [dbo].[zwm_zip_addr_mst]
	ADD
	CONSTRAINT [DF_zwm_zip_addr_mst_NoteExistsFlag]
	DEFAULT ((0)) FOR [NoteExistsFlag]
GO
IF (EXISTS(SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID(N'[dbo].[zwm_zip_addr_mst]') AND [type]='U')) AND NOT (EXISTS (SELECT * FROM sys.objects WHERE [object_id]=OBJECT_ID(N'[dbo].[DF_zwm_zip_addr_mst_RecordDate]') AND [parent_object_id]=OBJECT_ID(N'[dbo].[zwm_zip_addr_mst]')))
ALTER TABLE [dbo].[zwm_zip_addr_mst]
	ADD
	CONSTRAINT [DF_zwm_zip_addr_mst_RecordDate]
	DEFAULT (getdate()) FOR [RecordDate]
GO
IF (EXISTS(SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID(N'[dbo].[zwm_zip_addr_mst]') AND [type]='U')) AND NOT (EXISTS (SELECT * FROM sys.objects WHERE [object_id]=OBJECT_ID(N'[dbo].[DF_zwm_zip_addr_mst_RowPointer]') AND [parent_object_id]=OBJECT_ID(N'[dbo].[zwm_zip_addr_mst]')))
ALTER TABLE [dbo].[zwm_zip_addr_mst]
	ADD
	CONSTRAINT [DF_zwm_zip_addr_mst_RowPointer]
	DEFAULT (newid()) FOR [RowPointer]
GO
IF (EXISTS(SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID(N'[dbo].[zwm_zip_addr_mst]') AND [type]='U')) AND NOT (EXISTS (SELECT * FROM sys.objects WHERE [object_id]=OBJECT_ID(N'[dbo].[DF_zwm_zip_addr_mst_SiteRef]') AND [parent_object_id]=OBJECT_ID(N'[dbo].[zwm_zip_addr_mst]')))
ALTER TABLE [dbo].[zwm_zip_addr_mst]
	ADD
	CONSTRAINT [DF_zwm_zip_addr_mst_SiteRef]
	DEFAULT (rtrim(CONVERT([nvarchar](8),context_info(),(0)))) FOR [SiteRef]
GO
IF (EXISTS(SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID(N'[dbo].[zwm_zip_addr_mst]') AND [type]='U')) AND NOT (EXISTS (SELECT * FROM sys.objects WHERE [object_id]=OBJECT_ID(N'[dbo].[DF_zwm_zip_addr_mst_UpdatedBy]') AND [parent_object_id]=OBJECT_ID(N'[dbo].[zwm_zip_addr_mst]')))
ALTER TABLE [dbo].[zwm_zip_addr_mst]
	ADD
	CONSTRAINT [DF_zwm_zip_addr_mst_UpdatedBy]
	DEFAULT (suser_sname()) FOR [UpdatedBy]
GO
ALTER TABLE [dbo].[zwm_zip_addr_mst] SET (LOCK_ESCALATION = TABLE)
GO
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

GO
IF NOT (EXISTS(SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID(N'[dbo].[zwm_zip_mst]') AND [type]='U'))
CREATE TABLE [dbo].[zwm_zip_mst] (
		[SiteRef]            [dbo].[SiteType] NOT NULL,
		[zip]                [dbo].[PostalCodeType] NOT NULL,
		[route]              [dbo].[ZWM_RouteType] NOT NULL,
		[distance]           [dbo].[QtyUnitNoNegType] NOT NULL,
		[CreatedBy]          [dbo].[UsernameType] NOT NULL,
		[UpdatedBy]          [dbo].[UsernameType] NOT NULL,
		[CreateDate]         [dbo].[CurrentDateType] NOT NULL,
		[RecordDate]         [dbo].[CurrentDateType] NOT NULL,
		[RowPointer]         [dbo].[RowPointerType] NOT NULL,
		[NoteExistsFlag]     [dbo].[FlagNyType] NOT NULL,
		[InWorkflow]         [dbo].[FlagNyType] NOT NULL,
		CONSTRAINT [IX_zwm_zip_mst_RowPointer]
		UNIQUE
		NONCLUSTERED
		([RowPointer])

)
GO
IF (EXISTS(SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID(N'[dbo].[zwm_zip_mst]') AND [type]='U')) AND NOT (EXISTS (SELECT * FROM sys.indexes WHERE [name]=N'PK_zwm_zip_mst_1' AND [object_id]=OBJECT_ID(N'[dbo].[zwm_zip_mst]')))
ALTER TABLE [dbo].[zwm_zip_mst]
	ADD
	CONSTRAINT [PK_zwm_zip_mst_1]
	PRIMARY KEY
	CLUSTERED
	([SiteRef], [zip])
GO
IF (EXISTS(SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID(N'[dbo].[zwm_zip_mst]') AND [type]='U')) AND NOT (EXISTS (SELECT * FROM sys.objects WHERE [object_id]=OBJECT_ID(N'[dbo].[DF_zwm_zip_mst_CreateDate]') AND [parent_object_id]=OBJECT_ID(N'[dbo].[zwm_zip_mst]')))
ALTER TABLE [dbo].[zwm_zip_mst]
	ADD
	CONSTRAINT [DF_zwm_zip_mst_CreateDate]
	DEFAULT (getdate()) FOR [CreateDate]
GO
IF (EXISTS(SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID(N'[dbo].[zwm_zip_mst]') AND [type]='U')) AND NOT (EXISTS (SELECT * FROM sys.objects WHERE [object_id]=OBJECT_ID(N'[dbo].[DF_zwm_zip_mst_CreatedBy]') AND [parent_object_id]=OBJECT_ID(N'[dbo].[zwm_zip_mst]')))
ALTER TABLE [dbo].[zwm_zip_mst]
	ADD
	CONSTRAINT [DF_zwm_zip_mst_CreatedBy]
	DEFAULT (suser_sname()) FOR [CreatedBy]
GO
IF (EXISTS(SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID(N'[dbo].[zwm_zip_mst]') AND [type]='U')) AND NOT (EXISTS (SELECT * FROM sys.objects WHERE [object_id]=OBJECT_ID(N'[dbo].[DF_zwm_zip_mst_InWorkflow]') AND [parent_object_id]=OBJECT_ID(N'[dbo].[zwm_zip_mst]')))
ALTER TABLE [dbo].[zwm_zip_mst]
	ADD
	CONSTRAINT [DF_zwm_zip_mst_InWorkflow]
	DEFAULT ((0)) FOR [InWorkflow]
GO
IF (EXISTS(SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID(N'[dbo].[zwm_zip_mst]') AND [type]='U')) AND NOT (EXISTS (SELECT * FROM sys.objects WHERE [object_id]=OBJECT_ID(N'[dbo].[DF_zwm_zip_mst_NoteExistsFlag]') AND [parent_object_id]=OBJECT_ID(N'[dbo].[zwm_zip_mst]')))
ALTER TABLE [dbo].[zwm_zip_mst]
	ADD
	CONSTRAINT [DF_zwm_zip_mst_NoteExistsFlag]
	DEFAULT ((0)) FOR [NoteExistsFlag]
GO
IF (EXISTS(SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID(N'[dbo].[zwm_zip_mst]') AND [type]='U')) AND NOT (EXISTS (SELECT * FROM sys.objects WHERE [object_id]=OBJECT_ID(N'[dbo].[DF_zwm_zip_mst_RecordDate]') AND [parent_object_id]=OBJECT_ID(N'[dbo].[zwm_zip_mst]')))
ALTER TABLE [dbo].[zwm_zip_mst]
	ADD
	CONSTRAINT [DF_zwm_zip_mst_RecordDate]
	DEFAULT (getdate()) FOR [RecordDate]
GO
IF (EXISTS(SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID(N'[dbo].[zwm_zip_mst]') AND [type]='U')) AND NOT (EXISTS (SELECT * FROM sys.objects WHERE [object_id]=OBJECT_ID(N'[dbo].[DF_zwm_zip_mst_RowPointer]') AND [parent_object_id]=OBJECT_ID(N'[dbo].[zwm_zip_mst]')))
ALTER TABLE [dbo].[zwm_zip_mst]
	ADD
	CONSTRAINT [DF_zwm_zip_mst_RowPointer]
	DEFAULT (newid()) FOR [RowPointer]
GO
IF (EXISTS(SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID(N'[dbo].[zwm_zip_mst]') AND [type]='U')) AND NOT (EXISTS (SELECT * FROM sys.objects WHERE [object_id]=OBJECT_ID(N'[dbo].[DF_zwm_zip_mst_SiteRef]') AND [parent_object_id]=OBJECT_ID(N'[dbo].[zwm_zip_mst]')))
ALTER TABLE [dbo].[zwm_zip_mst]
	ADD
	CONSTRAINT [DF_zwm_zip_mst_SiteRef]
	DEFAULT (rtrim(CONVERT([nvarchar](8),context_info(),(0)))) FOR [SiteRef]
GO
IF (EXISTS(SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID(N'[dbo].[zwm_zip_mst]') AND [type]='U')) AND NOT (EXISTS (SELECT * FROM sys.objects WHERE [object_id]=OBJECT_ID(N'[dbo].[DF_zwm_zip_mst_UpdatedBy]') AND [parent_object_id]=OBJECT_ID(N'[dbo].[zwm_zip_mst]')))
ALTER TABLE [dbo].[zwm_zip_mst]
	ADD
	CONSTRAINT [DF_zwm_zip_mst_UpdatedBy]
	DEFAULT (suser_sname()) FOR [UpdatedBy]
GO
ALTER TABLE [dbo].[zwm_zip_mst] SET (LOCK_ESCALATION = TABLE)
GO
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

GO
IF NOT (EXISTS(SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID(N'[dbo].[zwm_freight_weight_mst]') AND [type]='U'))
CREATE TABLE [dbo].[zwm_freight_weight_mst] (
		[SiteRef]                [dbo].[SiteType] NOT NULL,
		[weight]                 [dbo].[WeightType] NOT NULL,
		[distance]               [dbo].[QtyUnitNoNegType] NOT NULL,
		[freight_min_amount]     [dbo].[AmountType] NULL,
		[freight_amount]         [dbo].[AmountType] NULL,
		[u_m]                    [dbo].[UMType] NOT NULL,
		[CreatedBy]              [dbo].[UsernameType] NOT NULL,
		[UpdatedBy]              [dbo].[UsernameType] NOT NULL,
		[CreateDate]             [dbo].[CurrentDateType] NOT NULL,
		[RecordDate]             [dbo].[CurrentDateType] NOT NULL,
		[RowPointer]             [dbo].[RowPointerType] NOT NULL,
		[NoteExistsFlag]         [dbo].[FlagNyType] NOT NULL,
		[InWorkflow]             [dbo].[FlagNyType] NOT NULL,
		[currency]				 [dbo].CurrCodeType NULL
		CONSTRAINT [IX_zwm_freight_weight_mst_RowPointer]
		UNIQUE
		NONCLUSTERED
		([RowPointer])

)
GO
IF (EXISTS(SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID(N'[dbo].[zwm_freight_weight_mst]') AND [type]='U')) AND NOT (EXISTS (SELECT * FROM sys.indexes WHERE [name]=N'PK_zwm_freight_weight_mst' AND [object_id]=OBJECT_ID(N'[dbo].[zwm_freight_weight_mst]')))
ALTER TABLE [dbo].[zwm_freight_weight_mst]
	ADD
	CONSTRAINT [PK_zwm_freight_weight_mst]
	PRIMARY KEY
	CLUSTERED
	([SiteRef], [weight], [distance])
GO
IF (EXISTS(SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID(N'[dbo].[zwm_freight_weight_mst]') AND [type]='U')) AND NOT (EXISTS (SELECT * FROM sys.objects WHERE [object_id]=OBJECT_ID(N'[dbo].[DF_zwm_freight_weight_mst_CreateDate]') AND [parent_object_id]=OBJECT_ID(N'[dbo].[zwm_freight_weight_mst]')))
ALTER TABLE [dbo].[zwm_freight_weight_mst]
	ADD
	CONSTRAINT [DF_zwm_freight_weight_mst_CreateDate]
	DEFAULT (getdate()) FOR [CreateDate]
GO
IF (EXISTS(SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID(N'[dbo].[zwm_freight_weight_mst]') AND [type]='U')) AND NOT (EXISTS (SELECT * FROM sys.objects WHERE [object_id]=OBJECT_ID(N'[dbo].[DF_zwm_freight_weight_mst_CreatedBy]') AND [parent_object_id]=OBJECT_ID(N'[dbo].[zwm_freight_weight_mst]')))
ALTER TABLE [dbo].[zwm_freight_weight_mst]
	ADD
	CONSTRAINT [DF_zwm_freight_weight_mst_CreatedBy]
	DEFAULT (suser_sname()) FOR [CreatedBy]
GO
IF (EXISTS(SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID(N'[dbo].[zwm_freight_weight_mst]') AND [type]='U')) AND NOT (EXISTS (SELECT * FROM sys.objects WHERE [object_id]=OBJECT_ID(N'[dbo].[DF_zwm_freight_weight_mst_distance]') AND [parent_object_id]=OBJECT_ID(N'[dbo].[zwm_freight_weight_mst]')))
ALTER TABLE [dbo].[zwm_freight_weight_mst]
	ADD
	CONSTRAINT [DF_zwm_freight_weight_mst_distance]
	DEFAULT ((0)) FOR [distance]
GO
IF (EXISTS(SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID(N'[dbo].[zwm_freight_weight_mst]') AND [type]='U')) AND NOT (EXISTS (SELECT * FROM sys.objects WHERE [object_id]=OBJECT_ID(N'[dbo].[DF_zwm_freight_weight_mst_freight_amount]') AND [parent_object_id]=OBJECT_ID(N'[dbo].[zwm_freight_weight_mst]')))
ALTER TABLE [dbo].[zwm_freight_weight_mst]
	ADD
	CONSTRAINT [DF_zwm_freight_weight_mst_freight_amount]
	DEFAULT ((0)) FOR [freight_amount]
GO
IF (EXISTS(SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID(N'[dbo].[zwm_freight_weight_mst]') AND [type]='U')) AND NOT (EXISTS (SELECT * FROM sys.objects WHERE [object_id]=OBJECT_ID(N'[dbo].[DF_zwm_freight_weight_mst_freight_min_amount]') AND [parent_object_id]=OBJECT_ID(N'[dbo].[zwm_freight_weight_mst]')))
ALTER TABLE [dbo].[zwm_freight_weight_mst]
	ADD
	CONSTRAINT [DF_zwm_freight_weight_mst_freight_min_amount]
	DEFAULT ((0)) FOR [freight_min_amount]
GO
IF (EXISTS(SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID(N'[dbo].[zwm_freight_weight_mst]') AND [type]='U')) AND NOT (EXISTS (SELECT * FROM sys.objects WHERE [object_id]=OBJECT_ID(N'[dbo].[DF_zwm_freight_weight_mst_InWorkflow]') AND [parent_object_id]=OBJECT_ID(N'[dbo].[zwm_freight_weight_mst]')))
ALTER TABLE [dbo].[zwm_freight_weight_mst]
	ADD
	CONSTRAINT [DF_zwm_freight_weight_mst_InWorkflow]
	DEFAULT ((0)) FOR [InWorkflow]
GO
IF (EXISTS(SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID(N'[dbo].[zwm_freight_weight_mst]') AND [type]='U')) AND NOT (EXISTS (SELECT * FROM sys.objects WHERE [object_id]=OBJECT_ID(N'[dbo].[DF_zwm_freight_weight_mst_NoteExistsFlag]') AND [parent_object_id]=OBJECT_ID(N'[dbo].[zwm_freight_weight_mst]')))
ALTER TABLE [dbo].[zwm_freight_weight_mst]
	ADD
	CONSTRAINT [DF_zwm_freight_weight_mst_NoteExistsFlag]
	DEFAULT ((0)) FOR [NoteExistsFlag]
GO
IF (EXISTS(SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID(N'[dbo].[zwm_freight_weight_mst]') AND [type]='U')) AND NOT (EXISTS (SELECT * FROM sys.objects WHERE [object_id]=OBJECT_ID(N'[dbo].[DF_zwm_freight_weight_mst_RecordDate]') AND [parent_object_id]=OBJECT_ID(N'[dbo].[zwm_freight_weight_mst]')))
ALTER TABLE [dbo].[zwm_freight_weight_mst]
	ADD
	CONSTRAINT [DF_zwm_freight_weight_mst_RecordDate]
	DEFAULT (getdate()) FOR [RecordDate]
GO
IF (EXISTS(SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID(N'[dbo].[zwm_freight_weight_mst]') AND [type]='U')) AND NOT (EXISTS (SELECT * FROM sys.objects WHERE [object_id]=OBJECT_ID(N'[dbo].[DF_zwm_freight_weight_mst_RowPointer]') AND [parent_object_id]=OBJECT_ID(N'[dbo].[zwm_freight_weight_mst]')))
ALTER TABLE [dbo].[zwm_freight_weight_mst]
	ADD
	CONSTRAINT [DF_zwm_freight_weight_mst_RowPointer]
	DEFAULT (newid()) FOR [RowPointer]
GO
IF (EXISTS(SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID(N'[dbo].[zwm_freight_weight_mst]') AND [type]='U')) AND NOT (EXISTS (SELECT * FROM sys.objects WHERE [object_id]=OBJECT_ID(N'[dbo].[DF_zwm_freight_weight_mst_SiteRef]') AND [parent_object_id]=OBJECT_ID(N'[dbo].[zwm_freight_weight_mst]')))
ALTER TABLE [dbo].[zwm_freight_weight_mst]
	ADD
	CONSTRAINT [DF_zwm_freight_weight_mst_SiteRef]
	DEFAULT (rtrim(CONVERT([nvarchar](8),context_info(),(0)))) FOR [SiteRef]
GO
IF (EXISTS(SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID(N'[dbo].[zwm_freight_weight_mst]') AND [type]='U')) AND NOT (EXISTS (SELECT * FROM sys.objects WHERE [object_id]=OBJECT_ID(N'[dbo].[DF_zwm_freight_weight_mst_UpdatedBy]') AND [parent_object_id]=OBJECT_ID(N'[dbo].[zwm_freight_weight_mst]')))
ALTER TABLE [dbo].[zwm_freight_weight_mst]
	ADD
	CONSTRAINT [DF_zwm_freight_weight_mst_UpdatedBy]
	DEFAULT (suser_sname()) FOR [UpdatedBy]
GO
IF (EXISTS(SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID(N'[dbo].[zwm_freight_weight_mst]') AND [type]='U')) AND NOT (EXISTS (SELECT * FROM sys.objects WHERE [object_id]=OBJECT_ID(N'[dbo].[DF_zwm_freight_weight_mst_weight]') AND [parent_object_id]=OBJECT_ID(N'[dbo].[zwm_freight_weight_mst]')))
ALTER TABLE [dbo].[zwm_freight_weight_mst]
	ADD
	CONSTRAINT [DF_zwm_freight_weight_mst_weight]
	DEFAULT ((0)) FOR [weight]
GO
ALTER TABLE [dbo].[zwm_freight_weight_mst] SET (LOCK_ESCALATION = TABLE)
GO
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

GO
IF NOT (EXISTS(SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID(N'[dbo].[zwm_route_mst]') AND [type]='U'))
CREATE TABLE [dbo].[zwm_route_mst] (
		[SiteRef]            [dbo].[SiteType] NOT NULL,
		[route]              [dbo].[ZWM_RouteType] NOT NULL,
		[description]        [dbo].[DescriptionType] NULL,
		[CreatedBy]          [dbo].[UsernameType] NOT NULL,
		[UpdatedBy]          [dbo].[UsernameType] NOT NULL,
		[CreateDate]         [dbo].[CurrentDateType] NOT NULL,
		[RecordDate]         [dbo].[CurrentDateType] NOT NULL,
		[RowPointer]         [dbo].[RowPointerType] NOT NULL,
		[NoteExistsFlag]     [dbo].[FlagNyType] NOT NULL,
		[InWorkflow]         [dbo].[FlagNyType] NOT NULL,
		CONSTRAINT [IX_zwm_route_mst_RowPointer]
		UNIQUE
		NONCLUSTERED
		([RowPointer])

)
GO
IF (EXISTS(SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID(N'[dbo].[zwm_route_mst]') AND [type]='U')) AND NOT (EXISTS (SELECT * FROM sys.indexes WHERE [name]=N'PK_zwm_route_mst' AND [object_id]=OBJECT_ID(N'[dbo].[zwm_route_mst]')))
ALTER TABLE [dbo].[zwm_route_mst]
	ADD
	CONSTRAINT [PK_zwm_route_mst]
	PRIMARY KEY
	CLUSTERED
	([SiteRef], [route])
GO
IF (EXISTS(SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID(N'[dbo].[zwm_route_mst]') AND [type]='U')) AND NOT (EXISTS (SELECT * FROM sys.objects WHERE [object_id]=OBJECT_ID(N'[dbo].[DF_zwm_route_mst_CreateDate]') AND [parent_object_id]=OBJECT_ID(N'[dbo].[zwm_route_mst]')))
ALTER TABLE [dbo].[zwm_route_mst]
	ADD
	CONSTRAINT [DF_zwm_route_mst_CreateDate]
	DEFAULT (getdate()) FOR [CreateDate]
GO
IF (EXISTS(SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID(N'[dbo].[zwm_route_mst]') AND [type]='U')) AND NOT (EXISTS (SELECT * FROM sys.objects WHERE [object_id]=OBJECT_ID(N'[dbo].[DF_zwm_route_mst_CreatedBy]') AND [parent_object_id]=OBJECT_ID(N'[dbo].[zwm_route_mst]')))
ALTER TABLE [dbo].[zwm_route_mst]
	ADD
	CONSTRAINT [DF_zwm_route_mst_CreatedBy]
	DEFAULT (suser_sname()) FOR [CreatedBy]
GO
IF (EXISTS(SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID(N'[dbo].[zwm_route_mst]') AND [type]='U')) AND NOT (EXISTS (SELECT * FROM sys.objects WHERE [object_id]=OBJECT_ID(N'[dbo].[DF_zwm_route_mst_InWorkflow]') AND [parent_object_id]=OBJECT_ID(N'[dbo].[zwm_route_mst]')))
ALTER TABLE [dbo].[zwm_route_mst]
	ADD
	CONSTRAINT [DF_zwm_route_mst_InWorkflow]
	DEFAULT ((0)) FOR [InWorkflow]
GO
IF (EXISTS(SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID(N'[dbo].[zwm_route_mst]') AND [type]='U')) AND NOT (EXISTS (SELECT * FROM sys.objects WHERE [object_id]=OBJECT_ID(N'[dbo].[DF_zwm_route_mst_NoteExistsFlag]') AND [parent_object_id]=OBJECT_ID(N'[dbo].[zwm_route_mst]')))
ALTER TABLE [dbo].[zwm_route_mst]
	ADD
	CONSTRAINT [DF_zwm_route_mst_NoteExistsFlag]
	DEFAULT ((0)) FOR [NoteExistsFlag]
GO
IF (EXISTS(SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID(N'[dbo].[zwm_route_mst]') AND [type]='U')) AND NOT (EXISTS (SELECT * FROM sys.objects WHERE [object_id]=OBJECT_ID(N'[dbo].[DF_zwm_route_mst_RecordDate]') AND [parent_object_id]=OBJECT_ID(N'[dbo].[zwm_route_mst]')))
ALTER TABLE [dbo].[zwm_route_mst]
	ADD
	CONSTRAINT [DF_zwm_route_mst_RecordDate]
	DEFAULT (getdate()) FOR [RecordDate]
GO
IF (EXISTS(SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID(N'[dbo].[zwm_route_mst]') AND [type]='U')) AND NOT (EXISTS (SELECT * FROM sys.objects WHERE [object_id]=OBJECT_ID(N'[dbo].[DF_zwm_route_mst_RowPointer]') AND [parent_object_id]=OBJECT_ID(N'[dbo].[zwm_route_mst]')))
ALTER TABLE [dbo].[zwm_route_mst]
	ADD
	CONSTRAINT [DF_zwm_route_mst_RowPointer]
	DEFAULT (newid()) FOR [RowPointer]
GO
IF (EXISTS(SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID(N'[dbo].[zwm_route_mst]') AND [type]='U')) AND NOT (EXISTS (SELECT * FROM sys.objects WHERE [object_id]=OBJECT_ID(N'[dbo].[DF_zwm_route_mst_SiteRef]') AND [parent_object_id]=OBJECT_ID(N'[dbo].[zwm_route_mst]')))
ALTER TABLE [dbo].[zwm_route_mst]
	ADD
	CONSTRAINT [DF_zwm_route_mst_SiteRef]
	DEFAULT (rtrim(CONVERT([nvarchar](8),context_info(),(0)))) FOR [SiteRef]
GO
IF (EXISTS(SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID(N'[dbo].[zwm_route_mst]') AND [type]='U')) AND NOT (EXISTS (SELECT * FROM sys.objects WHERE [object_id]=OBJECT_ID(N'[dbo].[DF_zwm_route_mst_UpdatedBy]') AND [parent_object_id]=OBJECT_ID(N'[dbo].[zwm_route_mst]')))
ALTER TABLE [dbo].[zwm_route_mst]
	ADD
	CONSTRAINT [DF_zwm_route_mst_UpdatedBy]
	DEFAULT (suser_sname()) FOR [UpdatedBy]
GO
ALTER TABLE [dbo].[zwm_route_mst] SET (LOCK_ESCALATION = TABLE)
GO
