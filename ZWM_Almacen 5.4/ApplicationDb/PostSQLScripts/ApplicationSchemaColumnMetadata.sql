--Este script permite generar números de GRN, con prefijo definido en el campo zwm_parms.grn_prefix , autoincremental, en caso de que no se ingrese un número de GRN al momento de crear uno.
--Estos registros se definen en el formulario "AppicationSchemaColumnMetadata"

SET NOCOUNT ON
SET ANSI_PADDING ON
GO


--declaro el RowPointer
DECLARE @N1 UNIQUEIDENTIFIER
SELECT @N1 = NEWID()

IF NOT EXISTS(SELECT * FROM [dbo].[AppColumn] WHERE [TableName]=N'grn_hdr_mst' AND [ColumnName]=N'grn_num') 

INSERT INTO [dbo].[AppColumn]
           (TableName,ColumnName,NextkeyPrefix,NextkeyGenerator,NextkeyLength,NextkeyPreGenerate,NextkeyPostGenerate,RegisterNewKeyAddlParms,NextkeyAddlKeys,NextkeyPartitionCondition,NoteExistsFlag,CreatedBy,UpdatedBy,CreateDate,RecordDate,RowPointer,InWorkflow,KeySequence)
     VALUES
           ('grn_hdr_mst','grn_num','','NextGrnSp',null,null,null,null,null,null,0,'','',GETDATE(),GETDATE(),@N1,0,null
           )
           
go


if exists (select * from AppColumn where TableName = 'grn_hdr_mst' and ColumnName = 'grn_num' and NextkeyPrefix = 'zwm_parms.grn_prefix')
	update AppColumn set NextkeyPrefix = '' where TableName = 'grn_hdr_mst' and ColumnName = 'grn_num' and NextkeyPrefix = 'zwm_parms.grn_prefix'