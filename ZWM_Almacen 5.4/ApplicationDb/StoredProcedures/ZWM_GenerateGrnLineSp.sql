/****** Object:  StoredProcedure [dbo].[ZWM_GenerateGrnLineSp]    Script Date: 01/09/2015 14:40:34 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ZWM_GenerateGrnLineSp]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ZWM_GenerateGrnLineSp]
GO

/****** Object:  StoredProcedure [dbo].[ZWM_GenerateGrnLineSp]    Script Date: 01/09/2015 14:40:34 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[ZWM_GenerateGrnLineSp] (
     @VendNum      VendNumType
   , @GrnNum       GrnNumType
   , @PoNum        PoNumType
   , @PoLine       PoLineType
   , @PoRelease    PoReleaseType
   , @QtyShipped   QtyUnitNoNegType
   , @Selected     FlagNyType
   , @FromPo       FlagNyType
   , @Infobar      InfobarType OUTPUT
   ) 
AS

-- Check for existence of Generic External Touch Point routine (this section was generated by SpETPCodeSp and inserted by CallETPs.exe):
   IF OBJECT_ID(N'dbo.EXTGEN_ZWM_GenerateGrnLineSp') IS NOT NULL
   BEGIN
      DECLARE @EXTGEN_SpName sysname
      SET @EXTGEN_SpName = N'dbo.EXTGEN_ZWM_GenerateGrnLineSp'
      -- Invoke the ETP routine, passing in (and out) this routine's parameters:
      DECLARE @EXTGEN_Severity int
      EXEC @EXTGEN_Severity = @EXTGEN_SpName
		@VendNum      
	   , @GrnNum       
	   , @PoNum        
	   , @PoLine       
	   , @PoRelease    
	   , @QtyShipped   
	   , @Selected     
	   , @FromPo       
	   , @Infobar       OUTPUT	
 
      -- ETP routine can RETURN 1 to signal that the remainder of this standard routine should now proceed:
      IF @EXTGEN_Severity <> 1
         RETURN @EXTGEN_Severity
   END
   -- End of Generic External Touch Point code.

DECLARE
     @Severity                INT
   , @LastGrnLine             GrnLineType
   , @TItemUM                 UMType
   , @UomConvFactor           UMConvFactorType

SET @Infobar = NULL
SET @Severity    = 0
SET @LastGrnLine = 0

DECLARE
     @PoitemRowPointer        RowPointerType
   , @PoitemUM                UMType
   , @PoitemItem              ItemType
   , @PoitemQtyOrdered        QtyUnitNoNegType
   , @PoitemQtyReceived       QtyUnitNoNegType
   , @ItemRowPointer          RowPointerType
   , @ItemUM                  UMType
   , @GrnLineRowPointer       RowPointerType
   , @GrnLineVendNum          VendNumType
   , @GrnLineGrnNum           GrnNumType
   , @GrnLineGrnLine          GrnLineType
   , @GrnLineQtyRec           QtyUnitType
   , @GrnLineQtyShippedConv   QtyUnitType
   , @PoRcptRowPointer        RowPointerType
   , @PoRcptQtyReceived       QtyUnitType

DECLARE
@RcvdUnderTol		   TolerancePercentType
,@RcvdOverTol		   TolerancePercentType
,@RcvdUnderTolGen	   TolerancePercentType
,@RcvdOverTolGen	   TolerancePercentType


IF EXISTS (SELECT TOP 1 * FROM grn_hdr 
           WHERE grn_hdr.grn_num = @GrnNum AND
                 grn_hdr.vend_num = @VendNum AND
                 grn_hdr.stat <> 'I')
BEGIN
   EXEC @Severity = dbo.MsgAppSp @Infobar OUTPUT
      , 'E=MustCompare1'
      , '@grn_hdr.stat'
      , '@:GrnStatus:I'
      , '@grn_hdr'
      , '@grn_hdr.grn_num'
      ,  @GrnNum

   RETURN @Severity
END

IF (@QtyShipped <= 0 OR @Selected = 0 OR @Selected IS NULL)
BEGIN
	SET @Severity = 16
	SET @Infobar = 'No se ha seleccionado ningun registro'
    RETURN @Severity
END

WHILE @Severity = 0
BEGIN
   DECLARE GenerateGrnLineSpCrs CURSOR LOCAL STATIC FOR
   SELECT
        grn_line.RowPointer
      , grn_line.vend_num
      , grn_line.grn_num
      , grn_line.grn_line
   FROM grn_line
   WHERE grn_line.grn_num = @GrnNum AND
         grn_line.vend_num = @VendNum
   OPEN GenerateGrnLineSpCrs
   WHILE @Severity = 0
   BEGIN /* DEPTH:1 */
      FETCH GenerateGrnLineSpCrs INTO
        @GrnLineRowPointer
      , @GrnLineVendNum
      , @GrnLineGrnNum
      , @GrnLineGrnLine
      IF @@FETCH_STATUS = -1
          BREAK

      SET @LastGrnLine = @GrnLineGrnLIne
   END
   CLOSE      GenerateGrnLineSpCrs
   DEALLOCATE GenerateGrnLineSpCrs

   SET @GrnLineGrnLine = @LastGrnLine + 1

   IF @GrnLineGrnLine = 10000
   BEGIN
      EXEC @Severity = MsgAppSp @Infobar OUTPUT
         , 'E=CmdFailed3'
         , '@%generate'
         , '@grn_line'
         , '@grn_line.vend_num'
         , @GrnLineVendNum
         , '@grn_line.grn_num'
         , @GrnLineGrnNum
         , '@grn_line.grn_line'
         , @GrnLineGrnLine
      BREAK
   END

   SET @PoitemRowPointer  = NULL
   SET @PoitemUM          = NULL
   SET @TItemUM           = NULL
   SET @PoitemItem        = NULL
   SET @PoitemQtyOrdered  = 0
   SET @PoitemQtyReceived = 0
   SET @GrnLineQtyRec     = 0
   SET @GrnLineQtyShippedConv = 0

   SELECT
        @PoitemRowPointer  = poitem.RowPointer
      , @PoitemUM          = poitem.u_m
      , @PoitemItem        = poitem.item
      , @PoitemQtyOrdered  = poitem.qty_ordered
      , @PoitemQtyReceived = poitem.qty_received
   FROM poitem
   WHERE poitem.po_num = @PoNum
     AND poitem.po_line = @PoLine
     AND poitem.po_release = @PoRelease

   IF @PoitemRowPointer IS NULL
   BEGIN
      SET @Severity = 16
      BREAK
   END

	Select @RcvdOverTol = rcvd_over_po_qty_tolerance, @RcvdUnderTol = rcvd_under_po_qty_tolerance from item where item.item = @PoitemItem
	Select @RcvdOverTolGen = rcvd_over_po_qty_tolerance,@RcvdUnderTolGen = rcvd_under_po_qty_tolerance from poparms
	SET @RcvdOverTol = ISNULL(@RcvdOverTol,@RcvdOverTolGen)
	SET @RcvdUnderTol = ISNULL(@RcvdUnderTol,@RcvdUnderTolGen)

	IF (@RcvdOverTol IS NOT NULL) AND (@QtyShipped > (@PoitemQtyOrdered + (@PoitemQtyOrdered*@RcvdOverTol/100) - @PoitemQtyReceived))
	BEGIN
	  SET @Infobar = 'Existen Cantidades mayores a las solicitadas por compras'
      SET @Severity = 16
      BREAK
	END

   INSERT INTO grn_line (
      vend_num,
      grn_num,
      grn_line,
      po_num,
      po_line,
      po_release,
      u_m,
      qty_shipped_conv)
   VALUES (
      @VendNum,
      @GrnNum,
      @GrnLineGrnLine,
      @PoNum,
      @PoLine,
      @PoRelease,
      @PoitemUM,
	  @QtyShipped)

   UPDATE poitem
   SET ZWM_QtyShipped = 0
   FROM grn_line
   WHERE grn_line.vend_num = @VendNum AND
         grn_line.grn_num = @GrnNum AND
         grn_line.grn_line = @GrnLineGrnLine
         AND grn_line.po_num = poitem.po_num
         AND grn_line.po_line = poitem.po_line
         AND grn_line.po_release = poitem.po_release
   
   BREAK
END

RETURN @Severity

GO

