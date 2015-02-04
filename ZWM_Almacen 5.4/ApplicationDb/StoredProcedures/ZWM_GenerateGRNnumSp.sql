/****** Object:  StoredProcedure [dbo].[ZWM_GenerateGRNnumSp]    Script Date: 01/09/2015 14:40:52 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ZWM_GenerateGRNnumSp]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ZWM_GenerateGRNnumSp]
GO

/****** Object:  StoredProcedure [dbo].[ZWM_GenerateGRNnumSp]    Script Date: 01/09/2015 14:40:52 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[ZWM_GenerateGRNnumSp] (
	@GRNnum			GrnNumType Output
) as

--Inicio de Sesion
DECLARE	@return_value int,
		@sessionId      RowPointerType
		,@UserName		UserNameType
		,@Site			SiteType
		,@LastGrn		GrnNumType

SET @UserName = isnull(@UserName,'sa')

EXEC	@return_value = [dbo].[InitSessionContextWithUserSp]
		@ContextName = 'ZWM',
		@UserName = @UserName,
		@SessionID = @SessionID OUTPUT,
		@Site = @Site


SELECT TOP 1 @LastGrn = grn_num FROM grn_hdr WHERE ISNUMERIC(grn_num) = 1 ORDER BY CreateDate DESC, grn_num DESC

SET @LastGrn = @LastGrn + 1

SET @GRNnum = @LastGrn
SET @GRNnum = dbo.ExpandKyByType('GrnNumType',@GRNnum)

GO


