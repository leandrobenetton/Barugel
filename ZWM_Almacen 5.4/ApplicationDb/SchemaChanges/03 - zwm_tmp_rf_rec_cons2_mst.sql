/****** Object:  Table [dbo].[zwm_rf_rec_cons2_mst]    Script Date: 10/06/2014 16:13:51 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-----------------------------------------------------------------------------------------------------------------
--Este bloque va porque la tabla zwm_rf_rec_cons2_mst se renombrará a zwm_tmp_rf_rec_cons2_mst
IF (EXISTS(SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID(N'[dbo].[zwm_rf_rec_cons2_mst]') AND [type]='U'))
EXEC sp_rename 'zwm_rf_rec_cons2_mst', 'zwm_tmp_rf_rec_cons2_mst';
-----------------------------------------------------------------------------------------------------------------


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[zwm_tmp_rf_rec_cons2_mst]') AND type in (N'U'))

CREATE TABLE [dbo].[zwm_tmp_rf_rec_cons2_mst](
	[id] [dbo].[ZwmIdRFConsType] NOT NULL,
	[item] [dbo].[ItemType] NOT NULL,
	[qty_um_std] [dbo].[QtyUnitType] NULL,
	[qty_um_stk1] [dbo].[QtyUnitType] NULL,
	[qty_um_stk1_conv] [dbo].[QtyUnitType] NULL,
	[qty_um_stk2] [dbo].[QtyUnitType] NULL,
	[qty_um_stk2_conv] [dbo].[QtyUnitType] NULL,
	[whse] [dbo].[WhseType] NOT NULL,
	[loc] [dbo].[LocType] NULL,
	[lot] [dbo].[LotType] NULL,
	[cont_number] [dbo].[ZwmContNumberType] NOT NULL,
	[user_trans] [dbo].[ZwmUser] NULL,
	[RowPointer] [dbo].[RowPointer] NOT NULL,
	[co_num] [dbo].[CoNumType] NULL,
	[co_line] [smallint] NULL,
	[co_release] [smallint] NULL,
	[deci_attribute1] [decimal](10, 2) NULL,
	[deci_attribute2] [decimal](10, 2) NULL,
	[deci_attribute3] [decimal](10, 2) NULL,
	[deci_attribute4] [decimal](10, 2) NULL,
	[deci_attribute5] [decimal](10, 2) NULL,
	[deci_attribute6] [decimal](10, 2) NULL,
	[deci_attribute7] [decimal](10, 2) NULL,
	[deci_attribute8] [decimal](10, 2) NULL,
	[deci_attribute9] [decimal](10, 2) NULL,
	[deci_attribute10] [decimal](10, 2) NULL,
	[char_attribute1] [nvarchar](20) NULL,
	[char_attribute2] [nvarchar](20) NULL,
	[char_attribute3] [nvarchar](20) NULL,
	[char_attribute4] [nvarchar](20) NULL,
	[char_attribute5] [nvarchar](20) NULL,
	[char_attribute6] [nvarchar](20) NULL,
	[char_attribute7] [nvarchar](20) NULL,
	[char_attribute8] [nvarchar](20) NULL,
	[char_attribute9] [nvarchar](20) NULL,
	[char_attribute10] [nvarchar](20) NULL,
	[employee] [dbo].[EmpNumType] NULL,
	[status] [nvarchar](1) NULL,
 CONSTRAINT [PK_zwm_rf_rec_cons2_mst] PRIMARY KEY CLUSTERED 
(
	[RowPointer] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


