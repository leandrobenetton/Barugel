
/* 
Elimina la restriccion del campo ref_type de la tabla pick_list_ref, para poder cargarle el valor 'T' para pick list de ordenes de transferencias 
*/
IF  EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[dbo].[CK_pick_list_ref_mst_ref_type]') AND parent_object_id = OBJECT_ID(N'[dbo].[pick_list_ref_mst]'))
ALTER TABLE [dbo].[pick_list_ref_mst] DROP CONSTRAINT [CK_pick_list_ref_mst_ref_type]
GO



--Estos constraint se agregan en la carpeta de funciones para que se instalen correctamente
----------------------------------------------------------------------------------------------------
/*
Evita que una CO y TRN tengan el mismo número (no puede existir un co_num = trn_num y viceversa)

IF NOT EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[dbo].[CK_co_zwm_co_num]') AND parent_object_id = OBJECT_ID(N'[dbo].[co_mst]'))
ALTER TABLE [dbo].[co_mst]
WITH NOCHECK ADD CONSTRAINT [CK_co_zwm_co_num] CHECK  (([dbo].[ZWM_RestrictedRefNum]([co_num])=(1)))
GO
*/
----------------------------------------------------------------------------------------------------
/*
Evita que una CO y TRN tengan el mismo número (no puede existir un co_num = trn_num y viceversa)

IF NOT EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[dbo].[CK_transfer_zwm_trn_num]') AND parent_object_id = OBJECT_ID(N'[dbo].[transfer_mst]'))
ALTER TABLE [dbo].[transfer_mst]
WITH NOCHECK ADD CONSTRAINT [CK_transfer_zwm_trn_num] CHECK  (([dbo].[ZWM_RestrictedRefNum]([trn_num])=(1)))
GO
*/
