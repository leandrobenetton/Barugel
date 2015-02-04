/****** Object:  StoredProcedure [dbo].[ZWM_AddResvSp]    Script Date: 01/09/2015 13:04:42 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ZWM_AddResvSp]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ZWM_AddResvSp]
GO

/****** Object:  StoredProcedure [dbo].[ZWM_AddResvSp]    Script Date: 01/09/2015 13:04:42 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


--   INTERFACE:
--
--     NAME           DESCRIPTION                               TYPE    I/O/C/T
--     -------------- ---------------------------------------   -----   -------
--     p-          Item to be Reserved                       parm    input
--     p-whse         Warehouse for Reservation                 parm    input
--     p-ref-num      Order/Transfer/Work Order Number          parm    input
--     p-ref-line     Line Number / Suffix                      parm    input
--     p-ref-release  Release / Operation Number                parm    input
--     p-loc          Location from which Reservation is made   parm    input
--     p-lot          Lot from which Reservation is made        parm    input
--     p-qty          Qty to Reserve                            parm    input
--     p-conv-factor  Conversions Factor                        parm    input
--     p-u-m          Unit of Measure                           parm    input
--     p-auto-rsvd    Specifies if called from an Auto Utility  parm    input
--     p-rsvd-num     New Reservation Number                    parm    output
--     p-err-msg      Error Message                             parm    output
--

/* $Header: /ApplicationDB/Stored Procedures/AddResvSp.sp 31    12/14/12 1:36a Jmtao $  */
/*
***************************************************************
*                                                             *
*                           NOTICE                            *
*                                                             *
*   THIS SOFTWARE IS THE PROPERTY OF AND CONTAINS             *
*   CONFIDENTIAL INFORMATION OF INFOR AND/OR ITS AFFILIATES   *
*   OR SUBSIDIARIES AND SHALL NOT BE DISCLOSED WITHOUT PRIOR  *
*   WRITTEN PERMISSION. LICENSED CUSTOMERS MAY COPY AND       *
*   ADAPT THIS SOFTWARE FOR THEIR OWN USE IN ACCORDANCE WITH  *
*   THE TERMS OF THEIR SOFTWARE LICENSE AGREEMENT.            *
*   ALL OTHER RIGHTS RESERVED.                                *
*                                                             *
*   (c) COPYRIGHT 2010 INFOR.  ALL RIGHTS RESERVED.           *
*   THE WORD AND DESIGN MARKS SET FORTH HEREIN ARE            *
*   TRADEMARKS AND/OR REGISTERED TRADEMARKS OF INFOR          *
*   AND/OR ITS AFFILIATES AND SUBSIDIARIES. ALL RIGHTS        *
*   RESERVED.  ALL OTHER TRADEMARKS LISTED HEREIN ARE         *
*   THE PROPERTY OF THEIR RESPECTIVE OWNERS.                  *
*                                                             *
***************************************************************
*/

/* $Archive: /ApplicationDB/Stored Procedures/AddResvSp.sp $
 *
 * SL8.04 31 RS4615 Jmtao Fri Dec 14 01:36:41 2012
 * RS4615(Multi - Add Site within a Site Functionality).
 *
 * SL8.04 30 92739 Dhuang Fri Sep 14 01:30:49 2012
 * Usage of GetErrorMessageSp should be removed
 * 92739
 * GetErrorMessageSp is replaced with MsgAppSp
 *
 * SL8.03 29 136300 Xliang Tue May 24 05:26:52 2011
 * Code review notes
 * 136300: change error message for consignment order validation.
 *
 * SL8.03 28 rs4854 Kbotley Fri Feb 04 16:27:42 2011
 * RS4854 - Addition of Item to the select on the serial table
 *
 * SL8.03 27 RS4771 Xliang Fri Jan 21 06:13:12 2011
 * RS4771: check co consignment.if a Customer Order is flagged as a Consignment Order, then the warehouse value on the lines is required to be the Ship-To’s Consignment Warehouse.
 *
 * SL8.02 26 128675 Mewing Tue Apr 27 13:31:04 2010
 * Update Copyright to 2010
 *
 * SL8.02 25 125228 pgross mar. mars 09 14:11:06 2010
 * .Net Framework Execution wsa aborted by escalation policy because of out of memory
 * made changes to improve performance
 *
 * SL8.02 24 rs4588 Dahn Thu Mar 04 10:09:53 2010
 * RS4588 Copyright header changes
 *
 * SL8.02 23 rs4588 Dahn Wed Mar 03 17:12:59 2010
 * RS4588 Copyright header changes
 *
 * SL8.01 22 rs3953 Vlitmano Tue Aug 26 16:37:34 2008
 * RS3953 - Changed a Copyright header?
 *
 * SL8.01 21 rs3953 Vlitmano Mon Aug 18 15:02:48 2008
 * Changed a Copyright header information(RS3959)
 *
 * SL8.00 20 rs2968 nkaleel Fri Feb 23 00:05:05 2007
 * Changing copyright information
 *
 * SL8.00 19 95295 magler Wed Sep 20 14:58:17 2006
 * data not saved
 * 95295 fixed placement of @@Rowcount check.
 * Fixed bad use of GetErrorMessageTextSp
 *
 * SL8.00 18 96106 DPalmer Wed Aug 30 11:23:08 2006
 * Reservation created for non-reservable item
 * Exit program if the item is not reservable.
 *
 * SL8.00 17 RS2968 prahaladarao.hs Thu Jul 13 02:29:29 2006
 * RS 2968, Name change CopyRight Update.
 *
 * SL8.00 16 RS2968 prahaladarao.hs Tue Jul 11 03:19:59 2006
 * RS 2968
 * Name change CopyRight Update.
 *
 * SL8.00 15 90206 NThurn Mon Jan 30 06:15:43 2006
 * Do not use SCOPE_IDENTITY() with INSTEAD OF INSERT triggers.  (RS3158)
 *
 * SL7.05 14 91818 NThurn Fri Jan 06 13:47:54 2006
 * Inserted standard External Touch Point call.  (RS3177)
 *
 * SL7.04 13 91140 hcl-ajain Thu Dec 29 05:59:15 2005
 * Issue # 91140
 * Added WITH (READUNCOMMITTED) to item select statements.
 *
 * $NoKeywords: $
 */
CREATE PROCEDURE [dbo].[ZWM_AddResvSp] (
  @Item        ItemType
, @Whse        WhseType
, @RefNum      CoNumType
, @RefLine     CoLineType
, @RefRelease  CoLineType
, @Loc         LocType
, @Lot         LotType
, @Qty         QtyUnitType
, @ConvFactor  UMConvFactorType
, @UM          UMType
, @AutoRsvd    Flag
, @ProgramName OSLocationType
, @RsvdNum     RsvdNumType    OUTPUT
, @Infobar     Infobar    OUTPUT
, @SessionID   RowPointerType = NULL
, @ImportDocId ImportDocIdType
, @ParmsSite SiteType = null
, @pZWMRefType	RefTypeIJKOPRSTWType = 'O'
)
AS

   -- Check for existence of Generic External Touch Point routine (this section was generated by SpETPCodeSp and inserted by CallETPs.exe):
   IF OBJECT_ID(N'dbo.EXTGEN_ZWM_AddResvSp') IS NOT NULL
   BEGIN
      DECLARE @EXTGEN_SpName sysname
      SET @EXTGEN_SpName = N'dbo.EXTGEN_ZWM_AddResvSp'
      -- Invoke the ETP routine, passing in (and out) this routine's parameters:
      DECLARE @EXTGEN_Severity int
      EXEC @EXTGEN_Severity = @EXTGEN_SpName
         @Item
         , @Whse
         , @RefNum
         , @RefLine
         , @RefRelease
         , @Loc
         , @Lot
         , @Qty
         , @ConvFactor
         , @UM
         , @AutoRsvd
         , @ProgramName
         , @RsvdNum OUTPUT
         , @Infobar OUTPUT
         , @SessionID
         , @ImportDocId
         , @ParmsSite
 
      -- ETP routine can RETURN 1 to signal that the remainder of this standard routine should now proceed:
      IF @EXTGEN_Severity <> 1
         RETURN @EXTGEN_Severity
   END
   -- End of Generic External Touch Point code.
 
DECLARE
  @Severity       INT
, @NonSeverity       INT
, @MrbFlag        Flag
, @LotTracked     Flag
, @RsvdRowPointer RowPointerType
, @IsNewRsvd ListYesNoType
, @ItwRowPointer  RowPointerType
, @ItlRowPointer  RowPointerType
, @LlcRowPointer  RowPointerType
, @CotRowPointer  RowPointerType
, @ItwQtyOnHand   QtyUnitType
, @ItwQtyRsvdCo   QtyUnitType
, @SerialTracked  Flag
, @Cnt            QtyUnitType
, @LocalQty       QtyUnitType
, @All 	          TINYINT
, @TaxFreeMatl    ListYesNoType
, @Reservable     Flag
, @CoWhse         WhseType
, @CoConsignment  ListYesNoType

SET @Severity = 0
SET @Infobar = NULL
SET @All = CASE WHEN @Lot IS NULL THEN 1 ELSE 0 END

if @ParmsSite is null
   SELECT
     @ParmsSite = site
   FROM parms with (readuncommitted)

SELECT
  @LotTracked    = it.lot_tracked
, @SerialTracked = it.serial_tracked
, @TaxFreeMatl   = it.tax_free_matl
, @Reservable    = it.reservable
FROM item AS it  WITH (READUNCOMMITTED)
WHERE it.item = @Item

IF @@ROWCOUNT <> 1
BEGIN
    EXEC @Severity = dbo.MsgAppSp @Infobar OUTPUT
   , 'E=NoExist1'
   , '@item'
   , '@item.item'
   , @Item

    RETURN @Severity
END

-- Leave now if the item is not reservable
IF @Reservable <> 1
   RETURN @Severity

IF @pZWMRefType = 'O'
BEGIN
	-- if a Customer Order is flagged as a Consignment Order, then the warehouse value on the lines is required to be the Ship-To’s Consignment Warehouse
	SELECT 
	@CoWhse = co.whse, 
	@CoConsignment = co.consignment 
	FROM co WITH (READUNCOMMITTED)
	where co.co_num = @RefNum

	IF @@ROWCOUNT > 0
	BEGIN
		IF @CoConsignment = 1 AND @CoWhse <> @Whse
		BEGIN
			EXEC @Severity = dbo.MsgAppSp @Infobar OUTPUT
			, 'I=IsCompare=1'
			, '@co.consignment'
			, '@:ListYesNo:1'
			, '@co.co_num'
			, '@co.co_num'
			, @RefNum
			EXEC @Severity = dbo.MsgAppSp @Infobar OUTPUT
			, 'E=MustCompare'
			, '@whse.whse'
			, @CoWhse

			RETURN @Severity
		END
	END

END

SELECT @ItwRowPointer = itw.RowPointer
, @ItwQtyOnHand = itw.qty_on_hand
, @ItwQtyRsvdCo = itw.qty_rsvd_co
FROM itemwhse AS itw WITH (UPDLOCK)
WHERE itw.item = @Item
AND   itw.whse = @Whse
--AND   itw.site = @CurrentSite
IF @@ROWCOUNT <> 1
BEGIN
    EXEC @Severity = dbo.MsgAppSp @Infobar OUTPUT
   , 'E=NoExist2'
   , '@itemwhse'
   , '@itemwhse.item'
   , @Item
   , '@itemwhse.whse'
   , @Whse


    RETURN @Severity
END

SELECT
  @MrbFlag = itl.mrb_flag
, @ItlRowPointer = itl.RowPointer
FROM itemloc AS itl WITH (UPDLOCK)
WHERE itl.item = @Item
AND itl.whse = @Whse
AND itl.loc = @Loc
IF @@ROWCOUNT <> 1
BEGIN
    EXEC @Severity = dbo.MsgAppSp
      @Infobar OUTPUT
    , 'E=NoExist3'
    , '@itemloc'
	, '@itemloc.item'
    ,  @Item
	, '@itemloc.whse'
	,  @Whse
	, '@itemloc.loc'
	,  @Loc

    RETURN @Severity
END

IF @MrbFlag = 1
BEGIN
    SET @Infobar = @Item + '^' + @Whse + '^' + @Loc
    EXEC @Severity = dbo.MsgAppSp
      @Infobar OUTPUT
    , 'E=IsCompare3'
    , '@itemloc'
	, '@itemloc.mrb_flag'
    , '@itemloc'
	, '@itemloc.item'
	,  @Item
	, '@itemloc.loc'
	,  @Loc
	, '@itemloc.whse'
	,  @Whse
	

    RETURN @Severity

END

IF @LotTracked = 1
BEGIN
    SELECT @LlcRowPointer = llc.RowPointer
    FROM lot_loc AS llc WITH (UPDLOCK)
    WHERE llc.item = @Item
    AND   llc.whse = @Whse
    AND   llc.loc  = @Loc
    AND   llc.lot  = @Lot
    IF @@ROWCOUNT <> 1
    BEGIN
        SET @Infobar = @Item + '^' + @Whse + '^' + @Loc+ '^' + @Lot
        EXEC @Severity = dbo.MsgAppSp
          @Infobar OUTPUT
        , 'E=NoExist0'		
        , '@lot_loc.loc'

        RETURN @Severity

    END

END

IF @pZWMRefType = 'O'
BEGIN
	SELECT @CotRowPointer = cot.RowPointer
	FROM coitem AS cot WITH (UPDLOCK)
	WHERE cot.co_num = @RefNum
	AND cot.co_line = @RefLine
	AND cot.co_release = @RefRelease
	AND cot.ship_site = @ParmsSite
	IF @@ROWCOUNT <> 1
	BEGIN
		 SET @Infobar = @RefNum + '^' + CAST (@RefLine AS NVARCHAR) +
			 '^' + CAST (@RefRelease AS NVARCHAR)
		 EXEC @Severity = dbo.MsgAppSp
			@Infobar OUTPUT
		 , 'E=NoExist0'
		 , '@coitem.item'

		 RETURN @Severity
	END
END


IF @pZWMRefType = 'T'
BEGIN
	SELECT @CotRowPointer = cot.RowPointer
	FROM trnitem AS cot WITH (UPDLOCK)
	WHERE cot.trn_num = @RefNum
	AND cot.trn_line = @RefLine
	
	IF @@ROWCOUNT <> 1
	BEGIN
		 SET @Infobar = @RefNum + '^' + CAST (@RefLine AS NVARCHAR) +
			 '^' + CAST (@RefRelease AS NVARCHAR)
		 EXEC @Severity = dbo.MsgAppSp
			@Infobar OUTPUT
		 , 'E=NoExist0'
		 , '@trnitem.item'

		 RETURN @Severity
	END
END

IF @LotTracked = 1
BEGIN
   SELECT
     @RsvdRowPointer = rsi.RowPointer
   , @RsvdNum  = rsi.rsvd_num
   FROM rsvd_inv AS rsi WITH (UPDLOCK)
   WHERE rsi.ref_num = @RefNum
   AND rsi.ref_line = @RefLine
   AND rsi.ref_release = @RefRelease
   AND rsi.item = @Item
   AND rsi.whse = @Whse
   AND rsi.loc = @Loc
   AND rsi.lot = @Lot
   AND ISNULL(rsi.import_doc_id, '') = ISNULL(@ImportDocId, '')
END
ELSE BEGIN
   SELECT
     @RsvdRowPointer = rsi.RowPointer
   , @RsvdNum  = rsi.rsvd_num
   FROM rsvd_inv AS rsi WITH (UPDLOCK)
   WHERE rsi.ref_num = @RefNum
   AND rsi.ref_line = @RefLine
   AND rsi.ref_release = @RefRelease
   AND rsi.item = @Item
   AND rsi.whse = @Whse
   AND rsi.loc = @Loc
   AND ISNULL(rsi.import_doc_id, '') = ISNULL(@ImportDocId, '')
END

IF @RsvdRowPointer IS NOT NULL AND @Qty <= 0
    RETURN 0

set @IsNewRsvd = case when @RsvdRowPointer is null then 1 else 0 end

IF @RsvdRowPointer IS NULL
BEGIN
   set @RsvdRowPointer = newid()
   -- Signal rsvd_invInsert to store the generated Identity value in a Process Variable:
   EXEC dbo.AnticipateSessionIdentitySp N'rsvd_inv_mst'

    INSERT INTO rsvd_inv (
      item
    , whse
    , loc
    , lot
    , ref_num
    , ref_line
    , ref_release
    , import_doc_id
    , u_m
    , qty_rsvd
    , RowPointer
    , ZWM_RefType
    ) VALUES (
      @Item
    , @Whse
    , @Loc
    , @Lot
    , @RefNum
    , @RefLine
    , @RefRelease
    , @ImportDocId
    , @UM
    , @Qty
    , @RsvdRowPointer
    , @pZWMRefType
    )

   EXEC dbo.RetrieveSessionIdentitySp N'rsvd_inv_mst', @RsvdNum OUTPUT
END
ELSE IF @ProgramName <> 'job/job-pf.p'
BEGIN
    SET @Infobar = @RefNum + '^' + CAST (@RefLine AS NVARCHAR) +
       '^' + CAST (@RefRelease AS NVARCHAR)
    EXEC @NonSeverity = dbo.MsgAppSp
      @Infobar OUTPUT
    , 'E=Exist2'
    , '@rsvd_inv'
    , '@rsvd_inv.ref_num'
	,  @RefNum
	, '@rsvd_inv.ref_line'
	,  @RefLine
END

if @IsNewRsvd = 0
   UPDATE rsvd_inv
   SET u_m = @UM
   WHERE RowPointer = @RsvdRowPointer
   and isnull(u_m, '') != @UM

IF @Qty <= 0
    RETURN 0

IF @AutoRsvd = 1 AND @SerialTracked = 1
BEGIN
    SET @Cnt = @Qty


    DECLARE
      @SrlRowPointer RowPointer

     DECLARE
      AddRsvSpCrs1 CURSOR local static FOR
    SELECT
      srl.RowPointer
    FROM serial AS srl
    WHERE srl.whse = @Whse
    AND srl.item = @Item
    AND srl.loc = @Loc
    AND (srl.lot = @Lot OR @All = 1)
    AND srl.stat = 'I'
    AND ISNULL(srl.import_doc_id, '') = ISNULL(@ImportDocId, '')

    OPEN AddRsvSpCrs1
    WHILE @Severity = 0 AND @Cnt > 0
    BEGIN
        FETCH AddRsvSpCrs1 INTO
        @SrlRowPointer

        IF @@FETCH_STATUS != 0
            BREAK

        UPDATE serial
        SET stat = 'R'
        , rsvd_num = @RsvdNum
        WHERE RowPointer = @SrlRowPointer

        SET @Cnt = @Cnt - 1
    END -- cursor loop
    CLOSE AddRsvSpCrs1
    DEALLOCATE AddRsvSpCrs1

    -- Qty-on-hand is not
    -- synchronized with the number of serial numbers - basically
    -- system is screwed up.  Instead of screwing it further let us
    -- make it saner(?)
    IF @Cnt > 0
    begin
        SET @Qty = @Qty - @Cnt
        set @IsNewRsvd = 0
    end
END -- IF @AutoRsvd = 1 AND @SerialTracked = 1

SET @LocalQty = @Qty
if @IsNewRsvd = 0
   UPDATE rsvd_inv
   SET qty_rsvd = dbo.MaxQtySp(0, qty_rsvd + @Qty)
   --, qty_rsvd_conv -- handled in the trigger
   WHERE RowPointer = @RsvdRowPointer

UPDATE itemwhse
SET qty_rsvd_co = dbo.MaxQtySp(0, qty_rsvd_co + @LocalQty)
, @ItwQtyRsvdCo = qty_rsvd_co
WHERE RowPointer = @ItwRowPointer

UPDATE itemloc
SET qty_rsvd = dbo.MaxQtySp(0, qty_rsvd + @LocalQty)
WHERE RowPointer = @ItlRowPointer

IF @LotTracked = 1
BEGIN
    UPDATE lot_loc
    SET qty_rsvd = dbo.MaxQtySp(0, qty_rsvd + @LocalQty)
    WHERE RowPointer = @LlcRowPointer
END

IF @SerialTracked = 1 AND @AutoRsvd <> 1
BEGIN
    EXEC @Severity = dbo.SerResvSp
      @RsvdNum
    , @Qty
    , 1
    , @Infobar OUTPUT
    , @SessionID
    , @Item
    DELETE FROM tmp_ser WHERE tmp_ser.SessionID = @SessionID
    IF @Severity <> 0
        RETURN @Severity
END

IF @TaxFreeMatl = 1
BEGIN
    UPDATE tax_free_import_qty
    SET qty_rsvd = dbo.MaxQtySp(0, qty_rsvd + @LocalQty)
    WHERE item   = @Item AND
          whse   = @Whse AND
          loc    = @Loc  AND
          ISNULL(lot, '')  = CASE WHEN @LotTracked = 1 THEN @Lot ELSE '' END AND
          import_doc_id    = @ImportDocId
END
-- Update CO Line/Release.

IF @pZWMRefType = 'O'
BEGIN
	UPDATE coitem
	SET qty_rsvd = dbo.MaxQtySp(0, qty_rsvd + @LocalQty)
	, qty_ready = (CASE ref_type
	  WHEN 'I' THEN
		  dbo.MaxQtySp(0, dbo.MinQtySp(qty_ordered - qty_shipped + qty_returned,
			@ItwQtyOnHand - @ItwQtyRsvdCo + qty_rsvd))
	  ELSE qty_ready
	END)
	WHERE @CotRowPointer = RowPointer
END

IF @pZWMRefType = 'T'
BEGIN
	UPDATE trnitem
	SET ZWM_QtyRsvd = dbo.MaxQtySp(0, ZWM_QtyRsvd + @LocalQty)
	WHERE @CotRowPointer = RowPointer
END

IF @Severity <> 0
    RETURN @Severity

RETURN 0

GO


