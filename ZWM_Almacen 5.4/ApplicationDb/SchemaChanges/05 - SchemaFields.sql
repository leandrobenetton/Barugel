IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'coitem_mst' AND COLUMN_NAME = 'zwm_ship_code')
ALTER TABLE [dbo].[coitem_mst] ADD zwm_ship_code [dbo].ShipCodeType NULL --122
---------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'coitem_mst' AND COLUMN_NAME = 'zrt_obs')
ALTER TABLE [dbo].[coitem_mst] ADD zrt_obs varchar(500) NULL --123
---------------------------------------------------------------------------------------------------------------
-- custaddr_mst
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'custaddr_mst' AND COLUMN_NAME = 'zwm_route')
ALTER TABLE [dbo].custaddr_mst ADD zwm_route [varchar](15) NULL
---------------------------------------------------------------------------------------------------------------
-- zwm_parms_mst
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'zwm_parms_mst' AND COLUMN_NAME = 'reserve_pct')
ALTER TABLE [dbo].zwm_parms_mst ADD reserve_pct [dbo].MarkupType NULL

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'zwm_parms_mst' AND COLUMN_NAME = 'customer')
ALTER TABLE [dbo].zwm_parms_mst ADD customer nvarchar(3) NULL
---------------------------------------------------------------------------------------------------------------
-- zwm_tmp_rf_cons1_mst
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'zwm_tmp_rf_cons1_mst' AND COLUMN_NAME = 'whse')
ALTER TABLE [dbo].zwm_tmp_rf_cons1_mst ADD whse [dbo].WhseType NULL

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'zwm_tmp_rf_cons1_mst' AND COLUMN_NAME = 'vend_num')
ALTER TABLE [dbo].zwm_tmp_rf_cons1_mst ADD vend_num [dbo].VendNumType NULL

---------------------------------------------------------------------------------------------------------------
-- zwm_freight_weight_mst
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'zwm_freight_weight_mst' AND COLUMN_NAME = 'currency')
ALTER TABLE [dbo].zwm_freight_weight_mst ADD currency [dbo].CurrCodeType NULL

--------------------------------------------------------------------------------------------------------------------------
-- zwm_itm_whse_mst
IF (EXISTS(SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID(N'[dbo].[zwm_itm_whse_mst]') AND [type]='U')) AND NOT (EXISTS(SELECT * FROM sys.columns WHERE [name]=N'family_code' AND [object_id]=OBJECT_ID(N'[dbo].[zwm_itm_whse_mst]')))

ALTER TABLE [dbo].[zwm_itm_whse_mst]
      ADD [family_code] [dbo].[FamilyCodeType]  NULL
GO
--------------------------------------------------------------------------------------------------------------------------

-- coitem_mst --
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'coitem_mst' AND COLUMN_NAME = 'zrt_ship_whse')
ALTER TABLE [dbo].[coitem_mst] ADD [zrt_ship_whse] [dbo].[WhseType] NULL --120

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'coitem_mst' AND COLUMN_NAME = 'zrt_lot')
ALTER TABLE [dbo].[coitem_mst] ADD [zrt_lot] [dbo].[LotType] NULL --121

IF (EXISTS(SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID(N'[dbo].[coitem_mst]') AND [type]='U')) AND NOT (EXISTS(SELECT * FROM sys.columns WHERE [name]=N'zwm_ship_code' AND [object_id]=OBJECT_ID(N'[dbo].[coitem_mst]')))

ALTER TABLE [dbo].[coitem_mst]
      ADD [zwm_ship_code] [dbo].[ShipCodeType]  NULL
GO

IF (EXISTS(SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID(N'[dbo].[coitem_mst]') AND [type]='U')) AND NOT (EXISTS(SELECT * FROM sys.columns WHERE [name]=N'zrt_obs' AND [object_id]=OBJECT_ID(N'[dbo].[coitem_mst]')))

ALTER TABLE [dbo].[coitem_mst]
      ADD [zrt_obs] [varchar](500) NULL
GO
---------------------------------------------------------------------------------------------------------------------------

-- shipment_mst --
IF (EXISTS(SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID(N'[dbo].[shipment_mst]') AND [type]='U')) AND NOT (EXISTS(SELECT * FROM sys.columns WHERE [name]=N'zla_do_num' AND [object_id]=OBJECT_ID(N'[dbo].[shipment_mst]')))
ALTER TABLE [dbo].[shipment_mst]
      ADD [zla_do_num] [dbo].[DoNumType] NULL
GO

IF (EXISTS(SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID(N'[dbo].[shipment_mst]') AND [type]='U')) AND NOT (EXISTS(SELECT * FROM sys.columns WHERE [name]=N'zla_ship_num' AND [object_id]=OBJECT_ID(N'[dbo].[shipment_mst]')))
ALTER TABLE [dbo].[shipment_mst]
      ADD [zla_ship_num] [dbo].[DoNumType] NULL
GO

IF (EXISTS(SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID(N'[dbo].[shipment_mst]') AND [type]='U')) AND NOT (EXISTS(SELECT * FROM sys.columns WHERE [name]=N'zla_shipper_point' AND [object_id]=OBJECT_ID(N'[dbo].[shipment_mst]')))
ALTER TABLE [dbo].[shipment_mst]
      ADD [zla_shipper_point] [dbo].[ZlaLastTranIdType] NULL
GO

---------------------------------------------------------------------------------------------------------------------------
-- zwm_parms_mst

IF (EXISTS(SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID(N'[dbo].[zwm_parms_mst]') AND [type]='U')) AND NOT (EXISTS(SELECT * FROM sys.columns WHERE [name]=N'zla_shipper_point' AND [object_id]=OBJECT_ID(N'[dbo].[zwm_parms_mst]')))
ALTER TABLE [dbo].[zwm_parms_mst]
      ADD [zla_shipper_point] [dbo].[ZlaLastTranIdType] NULL
GO

IF (EXISTS(SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID(N'[dbo].[zwm_parms_mst]') AND [type]='U')) AND NOT (EXISTS(SELECT * FROM sys.columns WHERE [name]=N'ship_via_picklist' AND [object_id]=OBJECT_ID(N'[dbo].[zwm_parms_mst]')))
ALTER TABLE [dbo].[zwm_parms_mst]
      ADD [ship_via_picklist] [dbo].[ShipCodeType] NULL
GO

IF (EXISTS(SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID(N'[dbo].[zwm_parms_mst]') AND [type]='U')) AND NOT (EXISTS(SELECT * FROM sys.columns WHERE [name]=N'ship_via_transfer_picklist' AND [object_id]=OBJECT_ID(N'[dbo].[zwm_parms_mst]')))
ALTER TABLE [dbo].[zwm_parms_mst]
      ADD [ship_via_transfer_picklist] [dbo].[ShipCodeType] NULL
GO

IF (EXISTS(SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID(N'[dbo].[zwm_parms_mst]') AND [type]='U')) AND NOT (EXISTS(SELECT * FROM sys.columns WHERE [name]=N'prefix_transfer_picklist' AND [object_id]=OBJECT_ID(N'[dbo].[zwm_parms_mst]')))
ALTER TABLE [dbo].[zwm_parms_mst]
      ADD [prefix_transfer_picklist] [dbo].[AlphaPrefixType] NULL
GO

IF (EXISTS(SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID(N'[dbo].[zwm_parms_mst]') AND [type]='U')) AND NOT (EXISTS(SELECT * FROM sys.columns WHERE [name]=N'transfer_loc' AND [object_id]=OBJECT_ID(N'[dbo].[zwm_parms_mst]')))
ALTER TABLE [dbo].[zwm_parms_mst]
      ADD [transfer_loc] [dbo].[LocType] NULL
GO
---------------------------------------------------------------------------------------------------------------------------

--- pick_list_mst, permite nulos en los campos cust_num y cust_seq
ALTER TABLE [dbo].[pick_list_mst]
	ALTER COLUMN [cust_num] [dbo].[CustNumType]  NULL
	
ALTER TABLE [dbo].[pick_list_mst]
	ALTER COLUMN [cust_seq] [dbo].[CustSeqType]  NULL

---------------------------------------------------------------------------------------------------------------------------

--- shipment_mst, permite nulos en los campos cust_num y cust_seq
ALTER TABLE [dbo].[shipment_mst]
	ALTER COLUMN [cust_num] [dbo].[CustNumType]  NULL
	
ALTER TABLE [dbo].[shipment_mst]
	ALTER COLUMN [cust_seq] [dbo].[CustSeqType]  NULL

---------------------------------------------------------------------------------------------------------------------
-- el campo loc admite nulos
IF (EXISTS(SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID(N'[dbo].[zwm_item_col_box_mst]') AND [type]='U')) 
	ALTER TABLE zwm_item_col_box_mst ALTER COLUMN loc [dbo].[LocType]  NULL

---------------------------------------------------------------------------------------------------------------------
--- tmp_pick_list
-- agrego el campo ZWM_ToWhse para ZWM_GenerateTransferPickListSp
IF (EXISTS(SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID(N'[dbo].[tmp_pick_list]') AND [type]='U')) AND NOT (EXISTS(SELECT * FROM sys.columns WHERE [name]=N'ZWM_ToWhse' AND [object_id]=OBJECT_ID(N'[dbo].[tmp_pick_list]')))
ALTER TABLE [dbo].[tmp_pick_list]
      ADD [ZWM_ToWhse] [dbo].[WhseType] NULL
GO

---------------------------------------------------------------------------------------------------------------------------
