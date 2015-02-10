/****** Object:  UserDefinedFunction [dbo].[ZWM_GetGlobalUmCfSp]    Script Date: 01/09/2015 15:12:09 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ZWM_GetGlobalUmCfSp]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[ZWM_GetGlobalUmCfSp]
GO

/****** Object:  UserDefinedFunction [dbo].[ZWM_GetGlobalUmCfSp]    Script Date: 01/09/2015 15:12:10 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE FUNCTION [dbo].[ZWM_GetGlobalUmCfSp]
 ( @pBaseUM    UMType
 , @pToUM       ItemType
) 
RETURNS UMConvFactorType
AS 
BEGIN

DECLARE
   @ConvFactor       UMConvFactorType
 , @Severity         INT
 , @UmConvRowPointer RowPointerType
 , @InverseFlag      FlagNyType
 
 	
         SELECT
            @UMConvRowPointer = u_m_conv.RowPointer
          , @ConvFactor = u_m_conv.conv_factor
          , @InverseFlag = 0
         FROM u_m_conv with (readuncommitted)
         WHERE u_m_conv.from_u_m = @pBaseUM
           AND u_m_conv.to_u_m = @pToUM
           AND u_m_conv.item IS NULL
           AND u_m_conv.type = 'G'
           AND u_m_conv.vend_num IS NULL

         -- Check for Inverse
         IF @UMConvRowPointer IS NULL
         BEGIN
            SELECT
               @UMConvRowPointer = u_m_conv.RowPointer
             , @ConvFactor       = u_m_conv.conv_factor
             , @InverseFlag      = 1
            FROM u_m_conv with (readuncommitted)
            WHERE u_m_conv.from_u_m = @pToUM
              AND u_m_conv.to_u_m = @pBaseUM
              AND u_m_conv.item IS NULL
              AND u_m_conv.type = 'G'
              AND u_m_conv.vend_num IS NULL
         END
   
   IF @ConvFactor IS NULL
		SET @ConvFactor = 1  
      
   IF @InverseFlag = 1
      SET @ConvFactor = 1.0 / @ConvFactor

   RETURN @ConvFactor

              
 END


GO


