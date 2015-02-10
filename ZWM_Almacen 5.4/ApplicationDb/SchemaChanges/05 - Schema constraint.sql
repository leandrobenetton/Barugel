
/* 
Elimina la restriccion del campo ref_type de la tabla pick_list_ref, para poder cargarle el valor 'T' para pick list de ordenes de transferencias 
*/
IF  EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[dbo].[CK_pick_list_ref_mst_ref_type]') AND parent_object_id = OBJECT_ID(N'[dbo].[pick_list_ref_mst]'))
ALTER TABLE [dbo].[pick_list_ref_mst] DROP CONSTRAINT [CK_pick_list_ref_mst_ref_type]
GO

