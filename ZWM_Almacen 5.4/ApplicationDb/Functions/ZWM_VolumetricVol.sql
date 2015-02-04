/****** Object:  UserDefinedFunction [dbo].[ZWM_VolumetricVol]    Script Date: 01/09/2015 15:09:44 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ZWM_VolumetricVol]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[ZWM_VolumetricVol]
GO

/****** Object:  UserDefinedFunction [dbo].[ZWM_VolumetricVol]    Script Date: 01/09/2015 15:09:44 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Calcula el Volumen Aforado de un articulo

CREATE FUNCTION [dbo].[ZWM_VolumetricVol] (
	@Item ItemType
) RETURNS ZwmStockMeasuresType
AS
BEGIN

DECLARE 
@VolumetricVol ZwmStockMeasuresType
,@Severity int
,@Infobar InfobarType

SELECT @VolumetricVol= ZWM_VolVol FROM item where item = @Item

RETURN isnull(@VolumetricVol,0)

END

GO


