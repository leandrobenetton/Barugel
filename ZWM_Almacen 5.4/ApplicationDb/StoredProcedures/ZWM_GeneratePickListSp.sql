/****** Object:  StoredProcedure [dbo].[ZWM_GeneratePickListSp]    Script Date: 01/09/2015 14:41:24 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ZWM_GeneratePickListSp]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ZWM_GeneratePickListSp]
GO

/****** Object:  StoredProcedure [dbo].[ZWM_GeneratePickListSp]    Script Date: 01/09/2015 14:41:24 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[ZWM_GeneratePickListSp] (
 @ProcessId                 RowPointerType
,@PPicker                   UserNameType
,@PPackLoc                  LocType
,@RouteId					ZwmIdRouteMapType
,@BGTaskProcessId1          RowPointerType  OUTPUT
,@BGTaskProcessId2          RowPointerType  OUTPUT
,@InfoBar                   InfoBarType     OUTPUT
)
as

   -- Check for existence of Generic External Touch Point routine (this section was generated by SpETPCodeSp and inserted by CallETPs.exe):
   IF OBJECT_ID(N'dbo.EXTGEN_ZWM_GeneratePickListSp') IS NOT NULL
   BEGIN
      DECLARE @EXTGEN_SpName sysname
      SET @EXTGEN_SpName = N'dbo.EXTGEN_ZWM_GeneratePickListSp'
      -- Invoke the ETP routine, passing in (and out) this routine's parameters:
      DECLARE @EXTGEN_Severity int
      EXEC @EXTGEN_Severity = @EXTGEN_SpName
			 @ProcessId
			,@PPicker
			,@PPackLoc
			,@RouteId
			,@BGTaskProcessId1          OUTPUT
			,@BGTaskProcessId2          OUTPUT
			,@InfoBar                   OUTPUT
 
      -- ETP routine can RETURN 1 to signal that the remainder of this standard routine should now proceed:
      IF @EXTGEN_Severity <> 1
         RETURN @EXTGEN_Severity
   END
   -- End of Generic External Touch Point code.
 
DECLARE
 @Severity      INT
,@PickListId    PickListIdType
,@group         smallint
,@CustNum       CustNumType
,@CustSeq       CustSeqType
,@Whse          WhseType
,@Picker        UserNameType
,@PackLoc       LocType
,@Reftype       RefTypeIJOPRSTType
,@Conum         CoNumType
,@Coline        CoLineType
,@corelease     CoReleaseType
,@item          ItemType
,@qtytopick     QtyUnitType
,@qtypicked     QtyUnitType
,@PickId        PickListIdType
,@Seq           smallint
,@lot           lottype
,@loc           loctype
,@sernum        sernumtype
,@picked        listyesnotype
,@Reserved      ListYesNoType
,@ItemWhseCntInProc      ListYesNoType
,@RsvdNum       RsvdNumType   

DECLARE @LocalSite SiteType
SELECT @LocalSite = parms.site
FROM parms

SET @Severity = 0
SET @BGTaskProcessId1 = NEWID()
SET @BGTaskProcessId2 = NEWID()


DECLARE @picks table(
 Grp        smallint
,PickListId PickListIdType
)

DECLARE pick_curs CURSOR LOCAL STATIC FOR
select distinct pick_group, whse, cust_num, cust_seq, pack_loc, picker
FROM tmp_pick_list
WHERE process_id = @ProcessId

OPEN pick_curs
WHILE 1 = 1
BEGIN
    FETCH pick_curs INTO @group, @Whse, @CustNum, @CustSeq, @PackLoc, @Picker
    IF @@FETCH_STATUS <> 0 BREAK

    IF @Picker is null SET @Picker = @PPicker
    IF @PPackLoc <> @PackLoc SET @PackLoc = @PPackLoc

    INSERT INTO pick_list (whse, cust_num, cust_seq, picker, pack_loc, pick_date, ZWM_IdRouteMap, ZWM_RefType)
                   VALUES (@Whse, @CustNum, @CustSeq, @Picker, @PackLoc, dbo.GetSiteDate(getdate()), @RouteId, 'O')
    SET @PickListId = @@IDENTITY

    INSERT INTO @picks (grp, PickListId) VALUES (@group, @PickListId)

    -- insert record for running reports
    INSERT INTO tmp_pick_list (process_id, pick_list_id, selected, RowPointer)
                       VALUES (@BGTaskProcessId1, @PickListId, 1, NEWID())

    INSERT INTO tmp_pick_list (process_id, pick_list_id, selected, RowPointer)
                       VALUES (@BGTaskProcessId2, @PickListId, 1, NEWID())
END
CLOSE pick_curs
DEALLOCATE pick_curs

IF (EXISTS (SELECT 1 FROM tmp_pick_list 
                     INNER JOIN co ON tmp_pick_list.ref_num = co.co_num
                         WHERE process_id = @ProcessId AND co.payment_method = 'A')
    AND EXISTS (SELECT 1 FROM tmp_pick_list 
                         INNER JOIN co ON tmp_pick_list.ref_num = co.co_num
                         WHERE process_id = @ProcessId AND co.payment_method = 'C'))
   OR (NOT EXISTS (SELECT 1 FROM tmp_pick_list 
                            INNER JOIN co ON tmp_pick_list.ref_num = co.co_num 
                            WHERE process_id = @ProcessId AND co.payment_method <> 'C')
       AND (SELECT COUNT(cust_num) FROM (SELECT DISTINCT cust_num FROM tmp_pick_list WHERE process_id = @ProcessId) AS tmp_pick_list) > 1
       AND (SELECT COUNT(cust_seq) FROM (SELECT DISTINCT cust_seq FROM tmp_pick_list WHERE process_id = @ProcessId) AS tmp_pick_list) > 1)
BEGIN
   EXEC @Severity = dbo.MsgAppSp @Infobar OUTPUT
                                 ,'E=GroupedTogetherWith'  
                                 ,'@CreditCardOrders'
                                 ,'@CreditCardOrders'
   RETURN @Severity
END

DECLARE ref_curs CURSOR LOCAL STATIC FOR
SELECT grp, PickListId, ref_num, ref_line_suf, ref_release, qty_to_pick, whse, item
FROM tmp_pick_list
JOIN @picks ON grp = pick_group
WHERE process_id = @processid
ORDER BY grp

OPEN ref_curs
WHILE 1 = 1
BEGIN
    FETCH ref_curs INTO @group, @PickId, @conum, @coline, @corelease, @qtytopick, @whse, @item
    IF @@FETCH_STATUS <> 0 BREAK

    SELECT @Seq = null,@Reserved = 0

    SELECT @seq = isnull(MAX(sequence), 0) + 1
    FROM pick_list_ref
    WHERE pick_list_id = @PickId

    INSERT INTO pick_list_ref (pick_list_id, sequence, ref_type, ref_num, ref_line_suf, ref_release, qty_to_pick, qty_picked)
                   VALUES (@PickId, @seq, 'O', @conum, @coline, @corelease, isnull(@qtytopick,0), 0)

    DECLARE loc_curs CURSOR LOCAL STATIC FOR
    SELECT loc, lot, qty_to_pick, qty_pick, reserved
    FROM tmp_pick_list_loc
    WHERE process_id = @processid
      and pick_group = @group
      and loc is not null
      and ref_num = @conum
      and ref_line_suf = @coline
      and ref_release = @corelease
      and qty_to_pick <> 0
    ORDER BY pick_group
    
    OPEN loc_curs
    WHILE 1 = 1
    BEGIN
        FETCH loc_curs INTO @loc, @lot, @qtytopick, @qtypicked, @reserved
        IF @@FETCH_STATUS <> 0 BREAK

        SET @RsvdNum = null
        IF @Reserved = 1
          SELECT TOP 1 @RsvdNum    = rsvd_inv.rsvd_num
          FROM rsvd_inv_mst rsvd_inv WITH (INDEX (IX_rsvd_inv_mst_ref_rsvd))
          WHERE rsvd_inv.site_ref = @LocalSite AND
	        rsvd_inv.ref_num     = @CoNum AND
                rsvd_inv.ref_line    = @CoLine AND
                rsvd_inv.ref_release = @CoRelease AND
                rsvd_inv.qty_rsvd    > 0.0

        if not exists (SELECT 1 FROM pick_list_loc
                       WHERE pick_list_id = @PickId                         
                         and sequence = @Seq
                         and loc = @loc
                         and isnull(lot,'') = isnull(@lot,'')) 
        INSERT INTO pick_list_loc (pick_list_id, sequence, loc, lot, qty_to_pick, qty_picked)
                           VALUES (@PickId, @seq, @loc, @lot, 0, 0)
   
        UPDATE pick_list_loc
        SET qty_to_pick = qty_to_pick + @qtytopick
        WHERE pick_list_id = @PickId
                         and sequence = @Seq
                         and loc = @loc
                         and isnull(lot,'') = isnull(@lot,'')

        IF @Reserved = 0        
        BEGIN
            UPDATE itemloc
            SET assigned_to_be_picked_qty = assigned_to_be_picked_qty + @qtytopick
            WHERE item = @item
              AND whse = @Whse
              AND loc = @loc
                  
            IF @lot is not null
                UPDATE lot_loc
                SET assigned_to_be_picked_qty = assigned_to_be_picked_qty + @qtytopick
                WHERE whse = @Whse
                  AND item = @item                 
                  AND loc = @loc
                  AND lot = @lot
        END

        DECLARE ser_curs CURSOR LOCAL STATIC FOR
        SELECT ser_num
        FROM tmp_pick_list_serial
        WHERE process_id = @processid
          AND pick_group = @group
          AND ref_num = @conum
          AND ref_line_suf = @coline
          AND ref_release = @corelease
          AND loc = @loc
          AND isnull(lot, '') = isnull(@lot, '')
          AND picked = 1
          AND reserved = @reserved
        ORDER BY pick_group
        
        OPEN ser_curs
        WHILE 1 = 1
        BEGIN
            FETCH ser_curs INTO @sernum
            IF @@FETCH_STATUS <> 0 BREAK

            INSERT INTO pick_list_serial (pick_list_id, sequence, loc, lot, ser_num, picked)
                           VALUES (@PickId, @seq, @loc, @lot, @sernum, 0)

            IF @Reserved = 0
               UPDATE serial
               SET assigned_to_be_picked = 1
               WHERE item = @item
                 AND ser_num = @sernum

        END
        CLOSE ser_curs
        DEALLOCATE ser_curs
    END
    CLOSE loc_curs
    DEALLOCATE loc_curs

END
CLOSE ref_curs
DEALLOCATE ref_curs


SET @Severity = @@error

IF @severity = 0
BEGIN
   SET @infobar = null   
	EXEC @Severity = MsgAppSp @Infobar OUTPUT, 'I=CmdSucceeded', '@%generate'
END
GO


