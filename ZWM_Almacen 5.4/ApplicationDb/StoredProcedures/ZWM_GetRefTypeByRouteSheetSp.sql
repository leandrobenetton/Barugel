/****** Object:  StoredProcedure [dbo].[ZWM_GetRefTypeByRouteSheetSp]    Script Date: 01/09/2015 14:43:42 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ZWM_GetRefTypeByRouteSheetSp]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ZWM_GetRefTypeByRouteSheetSp]
GO

/****** Object:  StoredProcedure [dbo].[ZWM_GetRefTypeByRouteSheetSp]    Script Date: 01/09/2015 14:43:42 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



-- Retorna el tipo de referencia de los pick list de una hoja de ruta
CREATE PROCEDURE [dbo].[ZWM_GetRefTypeByRouteSheetSp] (
	@RouteId	ZwmIdRouteMapType
	,@RefType	RefTypeIJKOPRSTWType OUTPUT
	,@Infobar	InfobarType OUTPUT
)as

select top 1 @RefType = ISNULL(ZWM_RefType,'O') FROM pick_list where ZWM_IdRouteMap = @RouteId
GO


