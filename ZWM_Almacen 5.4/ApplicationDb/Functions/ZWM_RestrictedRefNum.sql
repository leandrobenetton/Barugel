IF  EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[dbo].[CK_co_zwm_co_num]') AND parent_object_id = OBJECT_ID(N'[dbo].[co_mst]'))
ALTER TABLE [dbo].[co_mst] DROP CONSTRAINT [CK_co_zwm_co_num]
GO

IF  EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[dbo].[CK_transfer_zwm_trn_num]') AND parent_object_id = OBJECT_ID(N'[dbo].[transfer_mst]'))
ALTER TABLE [dbo].[transfer_mst] DROP CONSTRAINT [CK_transfer_zwm_trn_num]
GO


/****** Object:  UserDefinedFunction [dbo].[ZWM_RestrictedRefNum]    Script Date: 01/26/2015 12:58:10 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ZWM_RestrictedRefNum]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[ZWM_RestrictedRefNum]
GO

/****** Object:  UserDefinedFunction [dbo].[ZWM_RestrictedRefNum]    Script Date: 01/26/2015 12:58:10 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[ZWM_RestrictedRefNum](
      @RefNum	CoJobProjTrnNumType
      ,@RefType	RefTYpeIJKOTType
)    
RETURNS BIT

AS

BEGIN
	DECLARE @ResultBit BIT = 0

	IF @RefType != 'O' AND EXISTS (SELECT co_num from co where co_num = @RefNum)
		SELECT @ResultBit = 1

	IF @RefType != 'T' AND EXISTS (SELECT trn_num from transfer where trn_num = @RefNum)
		SELECT @ResultBit = 1

	RETURN @ResultBit

 END
GO


