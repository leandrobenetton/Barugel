/****** Object:  StoredProcedure [dbo].[ZWM_Rpt_VendorASNReconciliationSp]    Script Date: 01/09/2015 14:58:55 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ZWM_Rpt_VendorASNReconciliationSp]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ZWM_Rpt_VendorASNReconciliationSp]
GO

/****** Object:  StoredProcedure [dbo].[ZWM_Rpt_VendorASNReconciliationSp]    Script Date: 01/09/2015 14:58:55 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


/* $Header: /ApplicationDB/Stored Procedures/Rpt_VendorASNReconciliationSp.sp 16    12/27/12 3:17a Lqian2 $ */

CREATE PROCEDURE [dbo].[ZWM_Rpt_VendorASNReconciliationSp] (
   @StartingGrn                GrnNumType      = NULL,
   @EndingGrn                  GrnNumType      = NULL,
   @StartingVendor             VendNumType     = NULL,
   @EndingVendor               VendNumType     = NULL,
   @StartingHdrDate            DateType        = NULL,
   @EndingHdrDate              DateType        = NULL,
   @ExceptionsOnly             LISTYesNoType   = 0,
   @PrintGrnHdrNotes           LISTYesNoType   = 0,
   @PrintGrnLineNotes          LISTYesNoType   = 0,
   @ShowInternalNotes          LISTYesNoType   = 0,
   @ShowExternalNotes          LISTYesNoType   = 0,
   @StartingHdrDateOffset      DateOffsetType  = NULL,
   @EndingHdrDateOffset        DateOffsetType  = NULL,
   @DisplayHeader              ListYesNoType   = 1,
   @TaskId                     TaskNumType     = NULL,
   @pSite                      SiteType        = NULL
)
AS
--  Crystal reports has the habit of setting the isolation level to dirty
-- read, so we'll correct that for this routine now.  Transaction management
-- is also not being provided by Crystal, so a transaction is started here.
BEGIN TRANSACTION
SET XACT_ABORT ON

IF dbo.GetIsolationLevel(N'VendorASNReconciliationReport') = N'COMMITTED'
   SET TRANSACTION ISOLATION LEVEL READ COMMITTED
ELSE
   SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

-- A session context is created so session variables can be used.
DECLARE
  @RptSessionID           RowPointerType
 ,@GrnHdrVendNum          VendNumType
 ,@GrnHdrGrnNum           GrnNumType
 ,@GrnHdrGrnHdrDate       DateType
 ,@GrnHdrShipCode         ShipCodeType
 ,@GrnHdrShippedDate      DateType
 ,@GrnHdrRowpointer       RowPointerType
 ,@GrnHdrNoteEXISTSFlag   FlagNyType
 ,@GrnHdrNoteExist        FlagNyType
 ,@GrnHdrTable            sysname
 ,@RecEmployeeName        EmpNameType
 ,@RecEmployeeRowpointer  RowPointerType
 ,@PoitemUM               UMType
 ,@PoitemItem             ItemType
 ,@PoitemRowpointer       RowPointerType
 ,@GrnLineQtyShippedConv  QtyUnitType
 ,@GrnLineQtyRec          QtyUnitType
 ,@GrnLineQtyRej          QtyUnitType
 ,@GrnLineGrnNum          GrnNumType
 ,@GrnLineVendNum         VendNumType
 ,@GrnLineGrnLine         GrnLineType
 ,@GrnLinePoNum           PoNumType
 ,@GrnLinePoLine          PoLineType
 ,@GrnLinePoRelease       PoReleaseType
 ,@GrnLineUM              UMType
 ,@GrnLineRowpointer      RowPointerType
 ,@GrnLineNoteEXISTSFlag  FlagNyType
 ,@GrnLineNoteExist       FlagNyType
 ,@GrnLineTable           sysname
 ,@ShipcodeDescription    DescriptionType
 ,@ShipcodeRowpointer     RowPointerType
 ,@VendorRowpointer       RowPointerType
 ,@InsEmployeeName        EmpNameType
 ,@InsEmployeeRowpointer  RowPointerType
 ,@ItemRowpointer         RowPointerType
 ,@VendaddrName           NameType
 ,@VendaddrRowpointer     RowPointerType
 ,@Severity               INT
 ,@t_qtu_shipped          QtyUnitType
 ,@P_at_least_one         ListYesNoType
 ,@Infobar                InfoBarType
 ,@t_qtu_discrepancy      QtyUnitType
 ,@P_discrepancy          ListYesNoType
 ,@t_found_one            ListYesNoType
 ,@convfactor             UMConvFactorType
 ,@LowCharacter           HighLowCharType
 ,@HighCharacter          HighLowCharType

EXEC dbo.InitSessionContextSp
   @ContextName = 'ZWM_Rpt_VendorASNReconciliationSp'
 , @SessionID   = @RptSessionID OUTPUT
 , @Site        = @pSite

SET @LowCharacter  = dbo.LowCharacter()
SET @HighCharacter = dbo.HighCharacter()

DECLARE @headerset TABLE
 (
  vend_num             NVARCHAR(7),
  vname                NVARCHAR(60),
  rec_employee_name    NVARCHAR(35),
  ins_employee_name    NVARCHAR(35),
  grn_hdr_date         DATETIME,
  grn_num              NVARCHAR(30),
  ship_code            NVARCHAR(4),
  shipcode_description NVARCHAR(40),
  shipped_date         DATETIME,
  grn_hdr_table        SYSNAME           NULL,
  grn_hdr_note_exist   TINYINT           NULL,
  grn_hdr_row_pointer  UNIQUEIDENTIFIER  NULL
 )

DECLARE @detailset TABLE
 (
  l_grn_num             NVARCHAR(30),
  l_vend_num            NVARCHAR(7),
  grn_line              SMALLINT,
  po_num                NVARCHAR(10),
  po_line               SMALLINT,
  po_release            SMALLINT,
  item                  NVARCHAR(30),
  qty_shipped           DECIMAL(19, 8),
  grn_line_u_m          NVARCHAR(3),
  qty_received          DECIMAL(19, 8),
  poitem_u_m            NVARCHAR(3),
  qty_rejected          DECIMAL(19, 8),
  qty_discrepancy       DECIMAL(19, 8),
  poline_u_m            NVARCHAR(3),
  grn_line_table        SYSNAME          NULL,
  grn_line_note_exist   TINYINT          NULL,
  grn_line_row_pointer  UNIQUEIDENTIFIER NULL
 )

SET @GrnHdrTable     = 'grn_hdr'
SET @GrnLineTable    = 'grn_line'
SET @Severity        = 0
SET @StartingGrn     = ISNULL(@StartingGRN, @LowCharacter)
SET @EndingGrn       = ISNULL(@EndingGRN, @HighCharacter)
SET @StartingVendor  = ISNULL(dbo.ExpandKyByType('VendNumType', @StartingVendor), @LowCharacter)
SET @EndingVendor    = ISNULL(dbo.ExpandKyByType('VendNumType', @EndingVendor), @HighCharacter)



/*
   -- Check for existence of Generic External Touch Point routine (this section was generated by SpETPCodeSp and inserted by CallETPs.exe):
   IF OBJECT_ID(N'dbo.EXTGEN_Rpt_VendorASNReconciliationSp') IS NOT NULL
   BEGIN
      DECLARE @EXTGEN_SpName sysname
      SET @EXTGEN_SpName = N'dbo.EXTGEN_Rpt_VendorASNReconciliationSp'
      -- Invoke the ETP routine, passing in (and out) this routine's parameters:
      EXEC @EXTGEN_SpName
         @StartingGrn
         , @EndingGrn
         , @StartingVendor
         , @EndingVendor
         , @StartingHdrDate
         , @EndingHdrDate
         , @ExceptionsOnly
         , @PrintGrnHdrNotes
         , @PrintGrnLineNotes
         , @ShowInternalNotes
         , @ShowExternalNotes
         , @StartingHdrDateOffset
         , @EndingHdrDateOffset
         , @DisplayHeader
         , @TaskId
         , @pSite
         

      IF @@TRANCOUNT > 0
         COMMIT TRANSACTION
      EXEC dbo.CloseSessionContextSp @SessionID = @RptSessionID
      -- ETP routine must take over all desired functionality of this standard routine:
      RETURN
   END
   -- End of Generic External Touch Point code.
*/

EXEC dbo.ApplyDateOffsetSP
         @Date = @StartingHdrDate OUT,
         @Offset = @StartingHdrDateOffset,
         @IsEndDate = 0

EXEC dbo.ApplyDateOffsetSP
         @Date = @EndingHdrDate OUT,
         @Offset = @EndingHdrDateOffset,
         @IsEndDate = 1




-------------------------------------------------------------------------------------------------------------------
declare @ReportTable table 
(
fecha		datetime,
grn			nvarchar(30),
vend_num    nvarchar(7),
vend_name   nvarchar(60),
po_num		nvarchar(10),
item		nvarchar(30),
item_desc	nvarchar(40),
qty_rec		decimal(19,8)
) 
 

declare
@DateTime	DateType,
@GRN		GrnNumType,
@VendCod	VendNumType,
@VendName	NameType,
@PONum		PoNumType,
@ItemCode	ItemType,
@ItemDesc	DescriptionType,
@QtyRfRec	QtyUnitType

DECLARE grn_cur CURSOR LOCAL STATIC FOR	
	SELECT	grn.grn_num
	FROM grn_hdr grn
	JOIN zwm_tmp_rf_cons1_mst rf
	ON grn.grn_num = rf.grn_num
	WHERE rf.grn_num BETWEEN @StartingGRN AND @EndingGRN
	AND (grn.grn_hdr_date BETWEEN @StartingHdrDate AND @EndingHdrDate)
	AND (grn.vend_num BETWEEN @StartingVendor AND @EndingVendor)
	ORDER BY grn.grn_num


	OPEN grn_cur
	WHILE 1=1
	BEGIN
		FETCH grn_cur INTO @GRN
				
		IF @@FETCH_STATUS <> 0
			BREAK
			
			DECLARE rec_line CURSOR LOCAL STATIC FOR
			
			SELECT sum(qty_um_std+qty_um_stk1+qty_um_stk2) AS qty, item,@GRN AS grn
			FROM zwm_tmp_rf_rec_cons2_mst rec
			JOIN zwm_tmp_rf_cons1_mst rf
			ON rec.id = rf.id_rec_cons
			WHERE rf.grn_num = @GRN
			GROUP BY rec.item
			
			OPEN rec_line
			WHILE 1=1
			BEGIN
				FETCH rec_line INTO
				@QtyRfRec,@ItemCode,@GRN
				
				IF @@FETCH_STATUS <> 0
					BREAK
					
				SELECT @DateTime = grn_hdr_date, @VendCod = vend_num FROM grn_hdr WHERE grn_hdr.grn_num = @GRN
				SELECT @PONum = po_num FROM grn_line WHERE grn_num = @GRN and vend_num = @VendCod
				
				INSERT INTO @ReportTable(
				fecha,
				grn,
				vend_num,
				vend_name,
				po_num,
				item,
				item_desc,
				qty_rec	
				)VALUES(
				@DateTime,
				@GRN,
				@VendCod,
				(SELECT name FROM vendaddr WHERE vend_num = @VendCod), 
				@PONum,
				@ItemCode, 
				(SELECT description FROM item WHERE item = @ItemCode), 
				@QtyRfRec 
			)
			
			END
				
		CLOSE rec_line
		DEALLOCATE rec_line
   
	END
	
	CLOSE grn_cur
	DEALLOCATE grn_cur
	
	
	
SELECT * FROM @ReportTable
-------------------------------------------------------------------------------------------------------------------


/*

-- For each grn-hdr
DECLARE grn_hdr_vendor_employee_crs CURSOR LOCAL STATIC FOR
SELECT
   grn_hdr.vend_num,
   grn_hdr.grn_num,
   grn_hdr.grn_hdr_date,
   grn_hdr.ship_code,
   grn_hdr.shipped_date,
   grn_hdr.rowpointer,
   vendor.rowpointer,
   vendaddr.name,
   vendaddr.rowpointer,
   shipcode.description,
   shipcode.rowpointer,
   rec_employee.name,
   rec_employee.rowpointer,
   ins_employee.name,
   ins_employee.rowpointer,
   grn_hdr.NoteEXISTSFlag
FROM grn_hdr
JOIN vendor  ON vendor.vend_num = grn_hdr.vend_num
JOIN vendaddr ON vendaddr.vend_num = grn_hdr.vend_num
JOIN shipcode ON shipcode.ship_code = grn_hdr.ship_code
LEFT OUTER JOIN employee as rec_employee
ON rec_employee.emp_num = grn_hdr.rec_emp_num
LEFT OUTER JOIN employee as ins_employee
ON ins_employee.emp_num = grn_hdr.ins_emp_num
WHERE (grn_hdr.grn_num BETWEEN @StartingGRN AND @EndingGRN)
AND (grn_hdr.grn_hdr_date BETWEEN @StartingHdrDate AND @EndingHdrDate)
AND (grn_hdr.vend_num BETWEEN @StartingVendor AND @EndingVendor)

OPEN grn_hdr_vendor_employee_crs
WHILE 1 = 1
BEGIN
   FETCH grn_hdr_vendor_employee_crs INTO
     @GrnHdrVendNum,
     @GrnHdrGrnNum,
     @GrnHdrGrnHdrDate,
     @GrnHdrShipCode,
     @GrnHdrShippedDate,
     @GrnHdrRowpointer,
     @VendorRowpointer,
     @VendaddrName,
     @VendaddrRowpointer,
     @ShipcodeDescription,
     @ShipcodeRowpointer,
     @RecEmployeeName,
     @RecEmployeeRowpointer,
     @InsEmployeeName,
     @InsEmployeeRowpointer,
     @GrnHdrNoteEXISTSFlag

   IF @@FETCH_STATUS <> 0
      BREAK
   --get note from grn_hdr
   SET @GrnHdrNoteExist = 0
   If @PrintGrnHdrNotes <> 0
      SET @GrnHdrNoteExist = dbo.ReportNotesExist ( @GrnHdrTable,
                                                 @GrnHdrRowPointer,
                                                 @ShowInternalNotes,
                                                 @ShowExternalNotes,
                                                 @GrnHdrNoteEXISTSFlag )

   DECLARE grn_line_poitem_crs CURSOR local static FOR
   SELECT
      grn_line.qty_shipped_conv,
      grn_line.qty_rec,
      grn_line.qty_rej,
      grn_line.grn_num,
      grn_line.vend_num,
      grn_line.grn_line,
      grn_line.po_num,
      grn_line.po_line,
      grn_line.po_release,
      grn_line.u_m,
      grn_line.rowpointer,poitem.
      u_m,
      poitem.item,
      poitem.rowpointer
   FROM grn_line
   JOIN poitem ON poitem.po_num     = grn_line.po_num AND
                  poitem.po_line    = grn_line.po_line AND
                  poitem.po_release = grn_line.po_release
   WHERE grn_line.vend_num = @GrnHdrVendNum
     AND grn_line.grn_num = @GrnHdrGrnNum

   OPEN grn_line_poitem_crs
   WHILE 1 = 1
   BEGIN
      FETCH grn_line_poitem_crs INTO
            @GrnLineQtyShippedConv,
            @GrnLineQtyRec,
            @GrnLineQtyRej,
            @GrnLineGrnNum,
            @GrnLineVendNum,
            @GrnLineGrnLine,
            @GrnLinePoNum,
            @GrnLinePoLine,
            @GrnLinePoRelease,
            @GrnLineUM,
            @GrnLineRowpointer,
            @PoitemUM,
            @PoitemItem,
            @PoitemRowpointer

      IF @@FETCH_STATUS <> 0
         BREAK
      SET @t_qtu_shipped = 0
      SET @p_at_least_one = 1

      EXEC @convfactor = dbo.getumcf
                         @PoitemUM,
                         @PoitemItem,
                         @GrnHdrVendNum,
                         @Area = 'P'

      EXEC @Severity = dbo.UomConvQtySp
                       @GrnLineQtyShippedConv,
                       @ConvFactor,
                       'To Base',
                       @t_qtu_shipped OUTPUT,
                       @Infobar OUTPUT

      IF @Severity <> 0
         GOTO END_OF_PROG

      SET @t_qtu_discrepancy = @t_qtu_shipped - (@GrnLineQtyRec + @GrnLineQtyRej)

      IF @t_qtu_discrepancy <> 0
      BEGIN
         SET @p_discrepancy = 1
         BREAK
      END
   END
   CLOSE grn_line_poitem_crs
   DEALLOCATE grn_line_poitem_crs

   IF (@ExceptionsOnly = 1) AND (NOT @P_discrepancy = 1) OR
      ((NOT  @ExceptionsOnly = 1) AND (NOT @p_at_least_one = 1))
      CONTINUE

   INSERT INTO @HeaderSet (
      vend_num,
      vname,
      rec_employee_name,
      ins_employee_name,
      grn_hdr_date,
      grn_num,
      ship_code,
      shipcode_description,
      shipped_date,
      grn_hdr_table,
      grn_hdr_note_exist,
      grn_hdr_row_pointer
      )
   VALUES (
      @GrnHdrVendNum,
      @VendaddrName,
      @RecEmployeeName,
      @InsEmployeeName,
      @GrnHdrGrnHdrDate,
      @GrnHdrGrnNum,
      @GrnHdrShipCode,
      @ShipcodeDescription,
      @GrnHdrShippedDate,
      @GrnHdrTable,
      @GrnHdrNoteExist,
      @GrnHdrRowPointer
      )

   SET @t_found_one = 0
   --For each grn-line
   DECLARE grn_line_poitem_crs CURSOR local static FOR
   SELECT
      grn_line.qty_shipped_conv,
      grn_line.qty_rec,
      grn_line.qty_rej,
      grn_line.grn_num,
      grn_line.vend_num,
      grn_line.grn_line,
      grn_line.po_num,
      grn_line.po_line,
      grn_line.po_release,
      grn_line.u_m,
      grn_line.rowpointer,
      poitem.u_m,
      poitem.item,
      poitem.rowpointer,
      grn_line.NoteEXISTSFlag
   FROM grn_line
     JOIN poitem ON (poitem.po_num  = grn_line.po_num)
     AND (poitem.po_line      = grn_line.po_line)
     AND (poitem.po_release   = grn_line.po_release)
   WHERE (grn_line.grn_num    = @GrnHdrGrnNum)
     AND (grn_line.vend_num   = @GrnHdrVendNum)
   ORDER BY grn_line.grn_num

   OPEN grn_line_poitem_crs
   WHILE 1 = 1
   BEGIN
      FETCH grn_line_poitem_crs INTO
            @GrnLineQtyShippedConv,
            @GrnLineQtyRec,
            @GrnLineQtyRej,
            @GrnLineGrnNum,
            @GrnLineVendNum,
            @GrnLineGrnLine,
            @GrnLinePoNum,
            @GrnLinePoLine,
            @GrnLinePoRelease,
            @GrnLineUM,
            @GrnLineRowpointer,
            @PoitemUM,
            @PoitemItem,
            @PoitemRowpointer,
            @GrnLineNoteEXISTSFlag
      IF @@FETCH_STATUS <> 0
         BREAK
      -- get note from grn_line table
      SET @GrnLineNoteExist = 0
      If @PrintGrnLineNotes <> 0
         SET @GrnLineNoteExist = dbo.ReportNotesExist(@GrnLineTable
                                                 , @GrnLineRowPointer
                                                 , @ShowInternalNotes
                                                 , @ShowExternalNotes
                                                 , @GrnLineNoteEXISTSFlag)

      SELECT @ItemRowpointer = item.rowpointer
      FROM item
      WHERE item.item = @PoitemItem

      IF @@ROWCOUNT <> 1
         SET @ItemRowpointer = NULL

      SET @t_found_one        = 1
      SET @t_qtu_shipped      = 0
      SET @t_qtu_discrepancy  = 0

      EXEC @convfactor = dbo.getumcf
                         @PoitemUM,
                         @PoitemItem,
                         @GrnHdrVendNum,
                         @Area = 'P'

      EXEC @Severity = dbo.UomConvQtySp
                       @GrnLineQtyShippedConv,
                       @ConvFactor,
                       'To Base',
                       @t_qtu_shipped OUTPUT,
                       @Infobar OUTPUT

      IF @Severity <> 0
         GOTO END_OF_PROG

      SET @t_qtu_discrepancy = @t_qtu_shipped - (@GrnLineQtyRec + @GrnLineQtyRej)

      IF (@ExceptionsOnly = 1) AND (@t_qtu_discrepancy <> 0) OR (NOT @ExceptionsOnly = 1)
      BEGIN
         INSERT INTO @DetailSet (
            l_grn_num,
            l_vend_num,
            grn_line,
            po_num,
            po_line,
            po_release,
            item,
            qty_shipped,
            grn_line_u_m,
            qty_received,
            Poitem_u_m,
            qty_rejected,
            qty_discrepancy,
            PoLine_u_m,
            grn_line_table,
            grn_line_note_exist,
            grn_line_row_pointer
            )
         VALUES (
            @GrnLineGrnNum,
            @GrnLineVendNum,
            @GrnLineGrnLine,
            @GrnLinePoNum,
            @GrnLinePoLine,
            @GrnLinePoRelease,
            @PoitemItem,
            @GrnLineQtyShippedConv,
            @GrnLineUM,
            @GrnLineQtyRec,
            @PoitemUM,
            @GrnLineQtyRej,
            @t_qtu_discrepancy,
            @PoitemUM,
            @GrnLineTable,
            @GrnLineNoteExist,
            @GrnLineRowPointer
         )
      END --IF (@ExceptionsOnly = 1) AND (@t_qtu_discrepancy <> 0) OR (NOT @ExceptionsOnly = 1)
   END
   CLOSE grn_line_poitem_crs
   DEALLOCATE grn_line_poitem_crs

END
CLOSE grn_hdr_vendor_employee_crs
DEALLOCATE grn_hdr_vendor_employee_crs

END_OF_PROG:
IF @Severity <> 0
BEGIN
   IF @TaskId IS NOT NULL
      EXEC dbo.AddProcessErrorLogSp @ProcessId = @TaskId, @InfobarText = @Infobar, @MessageSeverity = @Severity
END*/

/*SELECT * FROM @HeaderSet
LEFT OUTER JOIN @DetailSet ON (l_grn_num = grn_num) AND (l_vend_num = vend_num)
WHERE @Severity = 0*/

COMMIT TRANSACTION
EXEC dbo.CloseSessionContextSp @SessionID = @RptSessionID
RETURN @Severity

GO


