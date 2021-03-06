/****** Object:  StoredProcedure [dbo].[ZWM_DeleteGrnLineSp]    Script Date: 01/09/2015 14:37:36 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ZWM_DeleteGrnLineSp]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ZWM_DeleteGrnLineSp]
GO

/****** Object:  StoredProcedure [dbo].[ZWM_DeleteGrnLineSp]    Script Date: 01/09/2015 14:37:36 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[ZWM_DeleteGrnLineSp] (
     @VendNum      VendNumType
   , @GrnNum       GrnNumType
   , @Infobar      InfobarType OUTPUT
   ) 
AS

-- Check for existence of Generic External Touch Point routine (this section was generated by SpETPCodeSp and inserted by CallETPs.exe):
   IF OBJECT_ID(N'dbo.EXTGEN_ZWM_DeleteGrnLineSp') IS NOT NULL
   BEGIN
      DECLARE @EXTGEN_SpName sysname
      SET @EXTGEN_SpName = N'dbo.EXTGEN_ZWM_DeleteGrnLineSpt'
      -- Invoke the ETP routine, passing in (and out) this routine's parameters:
      DECLARE @EXTGEN_Severity int
      EXEC @EXTGEN_Severity = @EXTGEN_SpName
		@VendNum      
	   , @GrnNum       
	   , @Infobar	OUTPUT

      -- ETP routine can RETURN 1 to signal that the remainder of this standard routine should now proceed:
      IF @EXTGEN_Severity <> 1
         RETURN @EXTGEN_Severity
   END
   -- End of Generic External Touch Point code.
   

DECLARE		@Severity	INT
SET @Severity = 0
    
IF EXISTS (SELECT TOP 1 * FROM grn_line 
		   inner join grn_hdr on grn_hdr.grn_num = grn_line.grn_num
           WHERE grn_hdr.grn_num = @GrnNum
                 AND grn_hdr.vend_num = @VendNum
                 AND qty_rec <> 0)
BEGIN
	SET @Severity = 16
	SET @Infobar = 'El NRM ya tiene recepciones asociadas, no se puede continuar con el proceso'
	RETURN @Severity
END 

IF @Severity = 0
BEGIN
   DELETE FROM grn_line 
   WHERE vend_num = @VendNum 
   AND grn_num = @GrnNum
   
   SET @Infobar = 'Las lineas del NRM fueron borradas'
END
GO


