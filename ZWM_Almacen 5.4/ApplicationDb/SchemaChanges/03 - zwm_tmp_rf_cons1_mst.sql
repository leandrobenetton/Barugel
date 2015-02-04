/****** Object:  Table [dbo].[zwm_tmp_rf_cons1_mst]    Script Date: 10/31/2014 10:46:20 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-----------------------------------------------------------------------------------------------------------------
--Este bloque va porque la tabla zwm_rf_cons1_mst se renombrará a zwm_tmp_rf_cons1_mst
IF (EXISTS(SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID(N'[dbo].[zwm_rf_cons1_mst]') AND [type]='U'))
EXEC sp_rename 'zwm_rf_cons1_mst', 'zwm_tmp_rf_cons1_mst';
-----------------------------------------------------------------------------------------------------------------

IF NOT (EXISTS(SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID(N'[dbo].[zwm_tmp_rf_cons1_mst]') AND [type]='U'))
CREATE TABLE [dbo].[zwm_tmp_rf_cons1_mst](
	[id_rec_cons] [dbo].[ZwmIdRFConsType] NOT NULL,
	[grn_num] [dbo].[GrnNumType] NOT NULL,
	[vend_num] [dbo].[VendNumType] NOT NULL,
	[whse] [dbo].[WhseType] NOT NULL,
	[state] [nvarchar](50) NULL,
 CONSTRAINT [PK__zwm_rf_c__F455F50A3DC13BB2] PRIMARY KEY CLUSTERED 
(
	[id_rec_cons] ASC,
	[grn_num] ASC,
	[vend_num] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO