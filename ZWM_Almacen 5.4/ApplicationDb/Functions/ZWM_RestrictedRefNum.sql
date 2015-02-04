IF  EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[dbo].[CK_co_zwm_co_num]') AND parent_object_id = OBJECT_ID(N'[dbo].[co_mst]'))
ALTER TABLE [dbo].[co_mst] DROP CONSTRAINT [CK_co_zwm_co_num]
GO

IF  EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[dbo].[CK_transfer_zwm_trn_num]') AND parent_object_id = OBJECT_ID(N'[dbo].[transfer_mst]'))
ALTER TABLE [dbo].[transfer_mst] DROP CONSTRAINT [CK_transfer_zwm_trn_num]
GO

-----------------------------------------------------------------------------------------------------------

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ZWM_RestrictedRefNum]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[ZWM_RestrictedRefNum]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[ZWM_RestrictedRefNum](
      @RefNum	CoNumType
)    
RETURNS BIT

AS

BEGIN
	DECLARE @ResultBit BIT = 1

	IF EXISTS(SELECT co_num from co_mst where co_num = (SELECT trn_num FROM transfer_mst where trn_num = @RefNum))
		SELECT @ResultBit = 0
		
	IF EXISTS(SELECT trn_num from transfer_mst where trn_num = (Select co_num FROM co_mst where co_num = @RefNum) )
		SELECT @ResultBit = 0

	RETURN @ResultBit

 END
GO