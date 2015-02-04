/****** Object:  UserDefinedFunction [dbo].[Zwm_UmToStk1Stk2ConvQty]    Script Date: 01/09/2015 15:11:09 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Zwm_UmToStk1Stk2ConvQty]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[Zwm_UmToStk1Stk2ConvQty]
GO

/****** Object:  UserDefinedFunction [dbo].[Zwm_UmToStk1Stk2ConvQty]    Script Date: 01/09/2015 15:11:09 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



-- Calcula el Volumen Aforado de un articulo

CREATE FUNCTION [dbo].[Zwm_UmToStk1Stk2ConvQty] (
@Item ItemType
, @QtyToBeConverted QtyUnitType
) RETURNS nvarchar(500)
AS
BEGIN

DECLARE
 @QtyStk2			QtyUnitType
, @UMStk2			UMType
, @QtyStk1			QtyUnitType
, @UMStk1			UMType
, @QtyStkStd		QtyUnitType
, @UMStd			UMType
, @QtyStkRest	    QtyUnitType
, @Conv				UMConvFactorType
, @QtyReturn		nvarchar(500)
, @Severity			int
, @Infobar			InfobarType

SET @QtyToBeConverted = ISNULL(@QtyToBeConverted,0)
IF @QtyToBeConverted < 0 SET @QtyToBeConverted = 0
SET @QtyStk2 = 0 
SET @QtyStk1 = 0
SET @QtyStkStd = 0 
SET @QtyReturn = null

SELECT @UMStk2 = ZWM_UMStock2 FROM item where item.item = @Item
SELECT @UMStk1 = ZWM_UMStock1 FROM item where item.item = @Item
SELECT @UMStd = u_m FROM item where item.item = @Item


IF @QtyToBeConverted > 0 and @UMStk2 is not null
BEGIN
	SET @Conv = dbo.Getumcf(@UMStk2, @Item,NULL,NULL)

	SET @QtyStk2 = dbo.UomConvQty(@QtyToBeConverted, @Conv, 'From Base')

	SET @QtyStkRest = @QtyStk2 - FLOOR(@QtyStk2)
	SET @QtyStk2 = FLOOR(@QtyStk2)

	SET @QtyToBeConverted = dbo.UomConvQty(@QtyStkRest, @Conv, 'To Base')
END

IF @QtyToBeConverted > 0 and @UMStk1 is not null
BEGIN
	SET @Conv = dbo.Getumcf(@UMStk1, @Item,NULL,NULL)

	SET @QtyStk1 = dbo.UomConvQty(@QtyToBeConverted, @Conv, 'From Base')

	SET @QtyStkRest = @QtyStk1 - FLOOR(@QtyStk1)
	SET @QtyStk1 = FLOOR(@QtyStk1)

	SET @QtyToBeConverted = dbo.UomConvQty(@QtyStkRest, @Conv, 'To Base')
END

SET @QtyStkStd = @QtyToBeConverted

IF @QtyStk2 > 0 
	SET @QtyReturn = cast(cast(@QtyStk2 as decimal(18,0)) as nvarchar)+' '+cast(@UMStk2 as nvarchar)

IF @QtyStk1 > 0 and @QtyReturn is not null
	SET @QtyReturn = @QtyReturn+', '+ cast(cast(@QtyStk1 as decimal(18,0)) as nvarchar)+' '+cast(@UMStk1 as nvarchar)
ELSE IF @QtyStk1 > 0 and @QtyReturn is null
	SET @QtyReturn = cast(cast(@QtyStk1 as decimal(18,0)) as nvarchar)+' '+cast(@UMStk1 as nvarchar)

IF @QtyStkStd > 0 and @QtyReturn is not null
	SET @QtyReturn = @QtyReturn+', '+ cast(cast(@QtyStkStd as decimal(18,0)) as nvarchar)+' '+cast(@UMStd as nvarchar)
ELSE IF @QtyReturn is null
	SET @QtyReturn = cast(cast(@QtyStkStd as decimal(18,0)) as nvarchar)+' '+cast(@UMStd as nvarchar)

RETURN @QtyReturn

END


GO


