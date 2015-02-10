----------------------------------------------------------------------------------------------------
IF  EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[dbo].[CK_co_zwm_co_num]') AND parent_object_id = OBJECT_ID(N'[dbo].[co_mst]'))
ALTER TABLE [dbo].[co_mst] DROP CONSTRAINT [CK_co_zwm_co_num]
GO

ALTER TABLE [dbo].[co_mst]  WITH NOCHECK ADD  CONSTRAINT [CK_co_zwm_co_num] CHECK  (([dbo].[ZWM_RestrictedRefNum]([co_num],'O')=(0)))
GO

ALTER TABLE [dbo].[co_mst] CHECK CONSTRAINT [CK_co_zwm_co_num]
GO
----------------------------------------------------------------------------------------------------

IF  EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[dbo].[CK_transfer_zwm_trn_num]') AND parent_object_id = OBJECT_ID(N'[dbo].[transfer_mst]'))
ALTER TABLE [dbo].[transfer_mst] DROP CONSTRAINT [CK_transfer_zwm_trn_num]
GO

ALTER TABLE [dbo].[transfer_mst]  WITH NOCHECK ADD  CONSTRAINT [CK_transfer_zwm_trn_num] CHECK  (([dbo].[ZWM_RestrictedRefNum]([trn_num],'T')=(0)))
GO

ALTER TABLE [dbo].[transfer_mst] CHECK CONSTRAINT [CK_transfer_zwm_trn_num]
GO

----------------------------------------------------------------------------------------------------
IF  EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[dbo].[CK_zwm_item_col_box_itemwhseloc]') AND parent_object_id = OBJECT_ID(N'[dbo].[zwm_item_col_box_mst]'))
ALTER TABLE [dbo].[zwm_item_col_box_mst] DROP CONSTRAINT [CK_zwm_item_col_box_itemwhseloc]
GO

ALTER TABLE [dbo].[zwm_item_col_box_mst]  WITH NOCHECK ADD  CONSTRAINT [CK_zwm_item_col_box_itemwhseloc] CHECK  (([dbo].[ZWM_ValidateItemColBox]([item],[whse],[loc])=(0)))
GO

ALTER TABLE [dbo].[zwm_item_col_box_mst] CHECK CONSTRAINT [CK_zwm_item_col_box_itemwhseloc]
GO

