IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ZWM_UnitWeight]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[ZWM_UnitWeight]
GO
/****** Object:  UserDefinedFunction [dbo].[ZWM_UnitWeight]    Script Date: 10/02/2014 09:10:00 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Calcula el peso unitario de un articulo

CREATE FUNCTION [dbo].[ZWM_UnitWeight] (
	@Item ItemType
) RETURNS ZwmStockMeasuresType
AS
BEGIN

DECLARE 
@UM		UMType
,@UMw	UMType
,@UW	UnitWeightType
,@UWw	UnitWeightTYpe

,@UMConvRowPointer RowPointerType
,@ConvFactor UMConvFactorType

,@Severity int
,@Infobar InfobarType


SELECT 
@UW = unit_weight
,@UM = weight_units
FROM item
WHERE item = @Item

SELECT 
top 1 @UMw = um_weight
FROM zwm_parms

if (@UM <> @UMw AND @UM is not null AND @UMw is not null)
BEGIN

	SELECT
	@UMConvRowPointer = u_m_conv.RowPointer
	, @ConvFactor = u_m_conv.conv_factor
    FROM u_m_conv with (readuncommitted)
    WHERE u_m_conv.from_u_m = @UM
    AND u_m_conv.to_u_m = @UMw
    AND u_m_conv.item IS NULL
    AND u_m_conv.type = 'G'
    AND u_m_conv.vend_num IS NULL
    
   IF @UMConvRowPointer IS NOT NULL
		SET @UWw = ROUND(@UW * @ConvFactor, 10)

	-- Check for Inverse
	IF @UMConvRowPointer IS NULL
		BEGIN
		SELECT
		@UMConvRowPointer = u_m_conv.RowPointer
		, @ConvFactor       = u_m_conv.conv_factor
		FROM u_m_conv with (readuncommitted)
		WHERE u_m_conv.from_u_m = @UMw
		AND u_m_conv.to_u_m = @UM
		AND u_m_conv.item IS NULL
		AND u_m_conv.type = 'G'
		AND u_m_conv.vend_num IS NULL
		
		SET @UWw = ROUND(@UW / @ConvFactor, 10)
		
		END
		
END
Else SET @UWw = @UW

RETURN isnull(@UWw,0)

END


GO


