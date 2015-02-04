/****** Object:  UserDefinedFunction [dbo].[ZWM_VolumetricWeight]    Script Date: 01/09/2015 15:11:44 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ZWM_VolumetricWeight]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[ZWM_VolumetricWeight]
GO

/****** Object:  UserDefinedFunction [dbo].[ZWM_VolumetricWeight]    Script Date: 01/09/2015 15:11:44 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



-- Calcula el Peso Aforado de un articulo

CREATE FUNCTION [dbo].[ZWM_VolumetricWeight] (
	@Item ItemType
) RETURNS ZwmStockMeasuresType
AS
BEGIN

DECLARE 
@VolWeight ZwmStockMeasuresType
,@VolVol ZwmStockMeasuresType
,@VolFactor  ItemWeightType
,@Coefficient  ZwmCoefVolWeightType
,@Infobar InfobarType

--Peso aforado = (Volumen / Factor Volumétrico) * coeficiente

Select @VolVol= ZWM_VolVol from item where item = @Item

select @VolFactor = volumetric_factor from zwm_parms

select @Coefficient = isnull(item.ZWM_VolCoefficient,famcode.ZWM_VolCoefficient)
from item left join famcode on famcode.family_code = item.family_code
where item = @Item

SET @Coefficient = ISNULL(@Coefficient,1)
	
SET @VolWeight = isnull((@VolVol * @VolFactor) * @Coefficient,0)


RETURN @VolWeight

END

GO


