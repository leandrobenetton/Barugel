/****** Object:  UserDefinedFunction [dbo].[Zwm_UmToStk012ConvQty]    Script Date: 01/09/2015 15:10:39 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Zwm_UmToStk012ConvQty]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[Zwm_UmToStk012ConvQty]
GO

/****** Object:  UserDefinedFunction [dbo].[Zwm_UmToStk012ConvQty]    Script Date: 01/09/2015 15:10:39 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




-- Calcula el Volumen Aforado de un articulo

CREATE FUNCTION [dbo].[Zwm_UmToStk012ConvQty] (
@Item ItemType
, @QtyToBeConverted QtyUnitType
, @Type				smallint		= 0     --0: Cantidad en UMStkStd; 1: cant en UmStk1, 2: cant en UmStk2
) RETURNS QtyUnitType
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
, @QtyReturn		QtyUnitType
, @Severity			int
, @Infobar			InfobarType

SET @QtyToBeConverted = ISNULL(@QtyToBeConverted,0)
IF @QtyToBeConverted < 0 SET @QtyToBeConverted = 0
SET @QtyStk2 = 0 
SET @QtyStk1 = 0
SET @QtyStkStd = 0 
SET @QtyReturn = 0

SELECT @UMStk2 = ZWM_UMStock2 FROM item_mst where item_mst.item = @Item
SELECT @UMStk1 = ZWM_UMStock1 FROM item_mst where item_mst.item = @Item
SELECT @UMStd = u_m FROM item_mst where item_mst.item = @Item


IF @QtyToBeConverted > 0 and @UMStk2 is not null and @Type = 2
BEGIN
	SET @Conv = dbo.Getumcf(@UMStk2, @Item,NULL,NULL)
	SET @QtyReturn = dbo.UomConvQty(@QtyToBeConverted, @Conv, 'From Base')
END

IF @QtyToBeConverted > 0 and @UMStk1 is not null and @Type = 1
BEGIN
	SET @Conv = dbo.Getumcf(@UMStk1, @Item,NULL,NULL)
	SET @QtyReturn = dbo.UomConvQty(@QtyToBeConverted, @Conv, 'From Base')
END

IF @QtyToBeConverted > 0 and @Type = 0
BEGIN
	SET @QtyReturn = @QtyToBeConverted
END

RETURN @QtyReturn

END



GO


