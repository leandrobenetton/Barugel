IF (EXISTS(SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID(N'[dbo].[ZWM_ExistsGrnLineSp]') AND [type]='P'))
DROP PROCEDURE [dbo].[ZWM_ExistsGrnLineSp]
GO
/****** Object:  StoredProcedure [dbo].[ZWM_ExistsGrnLineSp]    Script Date: 10/01/2014 17:30:50 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[ZWM_ExistsGrnLineSp] (
     @VendNum      VendNumType
   , @GrnNum       GrnNumType
   , @Infobar      InfobarType OUTPUT
   ) AS

DECLARE @Severity                INT
SET @Infobar = NULL
SET @Severity    = 0



IF EXISTS (SELECT TOP 1 * FROM grn_line
		   inner join grn_hdr on grn_hdr.grn_num = grn_line.grn_num
          WHERE grn_hdr.grn_num = @GrnNum
          AND grn_hdr.vend_num = @VendNum)
BEGIN
	SET @Severity = 16
	SET @Infobar = 'El GRN ya tiene lìneas asociadas, no se puede continuar con el proceso'
   RETURN @Severity
END 


GO


