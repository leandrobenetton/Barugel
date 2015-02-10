IF  EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[dbo].[CK_zwm_item_col_box_itemwhseloc]') AND parent_object_id = OBJECT_ID(N'[dbo].[zwm_item_col_box_mst]'))
ALTER TABLE [dbo].[zwm_item_col_box_mst] DROP CONSTRAINT [CK_zwm_item_col_box_itemwhseloc]
GO

/****** Object:  UserDefinedFunction [dbo].[ZWM_ValidateItemColBox]    Script Date: 02/03/2015 18:26:44 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ZWM_ValidateItemColBox]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[ZWM_ValidateItemColBox]
GO

/****** Object:  UserDefinedFunction [dbo].[ZWM_ValidateItemColBox]    Script Date: 02/03/2015 18:26:44 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[ZWM_ValidateItemColBox](
  @Item		ItemType = NULL
, @Whse		WhseType = NULL
, @Loc		LocType = NULL
)    
RETURNS BIT

AS

BEGIN
	DECLARE @ResultBit BIT = 0

	IF (select count(*) from zwm_item_col_box icbx where icbx.item = @Item and icbx.whse = @Whse) > 1
		SELECT @ResultBit = 1

	IF (select count(*) from zwm_item_col_box icbx where icbx.loc = @loc and icbx.whse = @Whse) > 1
		SELECT @ResultBit = 1

	RETURN @ResultBit

 END
GO


