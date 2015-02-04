/****** Object:  StoredProcedure [dbo].[ZWM_GetRouteSheetSp]    Script Date: 01/09/2015 14:44:15 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ZWM_GetRouteSheetSp]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ZWM_GetRouteSheetSp]
GO

/****** Object:  StoredProcedure [dbo].[ZWM_GetRouteSheetSp]    Script Date: 01/09/2015 14:44:15 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



-- Retorna las hojas de ruta
CREATE PROCEDURE [dbo].[ZWM_GetRouteSheetSp] (
	@RouteId	ZwmIdRouteMapType OUTPUT
	,@RefType	RefTypeIJKOPRSTWType OUTPUT
	,@Infobar	InfobarType OUTPUT
)as

select @RouteId = ZWM_IdRouteMap, @RefType = ISNULL(ZWM_RefType,'O') FROM pick_list_mst

GO


