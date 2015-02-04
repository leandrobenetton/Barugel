/****** Object:  StoredProcedure [dbo].[ZWM_TransferOrdersReserveSp]    Script Date: 01/09/2015 15:00:13 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ZWM_TransferOrdersReserveSp]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ZWM_TransferOrdersReserveSp]
GO

/****** Object:  StoredProcedure [dbo].[ZWM_TransferOrdersReserveSp]    Script Date: 01/09/2015 15:00:13 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


/* $Header: /ApplicationDB/Stored Procedures/ReserveSp.sp 17    8/29/11 11:58a vanmmar $  */
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

/* $Archive: /ApplicationDB/Stored Procedures/ReserveSp.sp $
 *
 * SL8.03 17 141543 vanmmar Mon Aug 29 11:58:58 2011
 * 141543
 *
 * SL8.03 16 139207 Dmcwhorter Fri Jun 10 13:14:00 2011
 * Reserved Qty is always zero when running Preview
 * 139207 - During Preview, show the amount that will be reserved.
 *
 * SL8.02 15 128675 Mewing Tue Apr 27 14:54:27 2010
 * Update Copyright to 2010
 *
 * SL8.02 14 128372 pgross Thu Mar 18 13:36:41 2010
 * Order Shipping - when shipping a reservable item from a non-reserved location causing MRP to plan extra materials.
 * added explicit transaction block handling
 *
 * SL8.02 13 125228 pgross mar. mars 09 14:10:29 2010
 * .Net Framework Execution wsa aborted by escalation policy because of out of memory
 * made changes to improve performance
 *
 * SL8.02 12 rs4588 Dahn Thu Mar 04 16:22:30 2010
 * rs4588 copyright header changes
 *
 * SL8.01 11 rs3953 Vlitmano Tue Aug 26 17:13:56 2008
 * RS3953 - Changed a Copyright header?
 *
 * SL8.01 10 rs3953 Vlitmano Mon Aug 18 15:36:29 2008
 * Changed a Copyright header information(RS3959)
 *
 * SL8.01 9 108501 nmannam Tue Mar 25 04:53:35 2008
 * Error message and not able to ship Reserved item: "Procedure or Function 'UpdResvSp' expects parameter '@SessionID', which was not supplied."
 * 108501- sessionid is passed to 'UpdResvSp'.
 *
 * SL8.00 8 RS2968 nkaleel Fri Feb 23 04:38:40 2007
 * changing copyright information(RS2968)
 *
 * SL8.00 7 RS2968 prahaladarao.hs Tue Jul 11 11:15:08 2006
 * RS 2968, Name change CopyRight Update.
 *
 * SL8.00 6 93558 jabraham Fri Mar 31 01:48:32 2006
 * Order Date not populating
 * ISSUE 93558
 * Added code for getting Order date correctly
 *
 * SL7.05 5 91818 NThurn Fri Jan 06 16:47:55 2006
 * Inserted standard External Touch Point call.  (RS3177)
 *
 * SL7.04 4 91152 Hcl-guptanu Wed Dec 28 05:51:04 2005
 * Issue ## 91152
 * Added "WITH (READUNCOMMITTED)" to item selects.
 *
 * $NoKeywords: $
 */
CREATE PROCEDURE [dbo].[ZWM_TransferOrdersReserveSp] (
  @RsvdType       NCHAR
, @InFile         NCHAR
, @StartTrnNum     TrnNumType
, @EndTrnNum       TrnNumType
, @StartTrnLine    TrnLineType
, @EndTrnLine      TrnLineType
, @StartOrderDate GenericDate
, @EndOrderDate   GenericDate
, @StartDueDate   GenericDate
, @EndDueDate     GenericDate
, @StartWhse   WhseType
, @EndWhse     WhseType
, @StartItem      ItemType
, @EndItem        ItemType
, @Infobar        Infobar     OUTPUT
, @StartOrderDateOffset  DateOffsetType = NULL
, @EndOrderDateOffset  DateOffsetType = NULL
, @StartDueDateOffset  DateOffsetType = NULL
, @EndDueDateOffset  DateOffsetType = NULL
)
AS


DECLARE
 @LowString	WideTextType
,@HighString WideTextType
,@LowDate	DateType
,@HighDate	DateType


SET @LowString = dbo.LowCharacter()
SET @HighString  = dbo.HighCharacter()

SET @LowDate = dbo.LowDate()
SET @HighDate = dbo.HighDate()

SET @StartTrnNum = ISNULL(dbo.ExpandKyByType ('TrnNumType', @StartTrnNum),@LowString )
SET @EndTrnNum = ISNULL(dbo.ExpandKyByType ('TrnNumType', @EndTrnNum),@HighString )

SET @StartOrderDate = ISNULL(@StartOrderDate,@LowDate)
SET @EndOrderDate = ISNULL(@EndOrderDate,@HighDate)

SET @StartDueDate  = ISNULL(@StartDueDate,@LowDate)
SET @EndDueDate    = ISNULL(@EndDueDate,@HighDate) 

SET @StartTrnLine = ISNULL(@StartTrnLine,0)
SET @EndTrnLine = ISNULL(@EndTrnLine,999)

SET @StartWhse = ISNULL(@StartWhse,@LowString)
SET @EndWhse   = ISNULL(@EndWhse,@HighString)

SET @StartItem = ISNULL(@StartItem,@LowString)
SET @EndItem = ISNULL(@EndItem,@HighString)

   -- Check for existence of Generic External Touch Point routine (this section was generated by SpETPCodeSp and inserted by CallETPs.exe):
   IF OBJECT_ID(N'dbo.EXTGEN_ZWM_TransferOrdersReserveSp') IS NOT NULL
   BEGIN
      DECLARE @EXTGEN_SpName sysname
      SET @EXTGEN_SpName = N'dbo.EXTGEN_ZWM_TransferOrdersReserveSp'
      -- Invoke the ETP routine, passing in (and out) this routine's parameters:
      DECLARE @EXTGEN_Severity int
      EXEC @EXTGEN_Severity = @EXTGEN_SpName
         @RsvdType
         , @InFile
         , @StartTrnNum
         , @EndTrnNum
         , @StartTrnLine
         , @EndTrnLine
         , @StartOrderDate
         , @EndOrderDate
         , @StartDueDate
         , @EndDueDate
         , @StartWhse
         , @EndWhse
         , @StartItem
         , @EndItem
         , @Infobar OUTPUT
         , @StartOrderDateOffset
         , @EndOrderDateOffset
         , @StartDueDateOffset
         , @EndDueDateOffset
 
      -- ETP routine can RETURN 1 to signal that the remainder of this standard routine should now proceed:
      IF @EXTGEN_Severity <> 1
         RETURN @EXTGEN_Severity
   END
   -- End of Generic External Touch Point code.
 
EXEC dbo.ApplyDateOffsetSp @StartOrderDate OUTPUT, @StartOrderDateOffset, 0
EXEC dbo.ApplyDateOffsetSp @EndOrderDate OUTPUT, @EndOrderDateOffset, 1
EXEC dbo.ApplyDateOffsetSp @StartDueDate OUTPUT, @StartDueDateOffset, 0
EXEC dbo.ApplyDateOffsetSp @EndDueDate OUTPUT, @EndDueDateOffset, 1

DECLARE
  @Severity				INT
, @QtyReserved			QtyUnitType
, @ItmItem				ItemType
, @ItmDescription		DescriptionType
, @ItmUM					UMType
, @TotTrnNum			TrnNumType
, @TotTrnLine			TrnLineType
, @TotQtyToReserve	QtyUnitType
, @TotWhse				WhseType
, @TotUM					UMType
, @TotDueDate			GenericDate
, @FromWhse				WhseType
, @WhseName				NameType
, @RsiRowPointer		RowPointerType
, @RsiQtyRsvdConv		QtyUnitType
, @TrnOrderDate			GenericDate
, @TotQtyOrdered		QtyUnitType
, @SessionID			RowPointerType
, @UseStat				nvarchar(10)
, @ParmsSite			SiteType
, @PostCount			int

SET @Severity    = 0
SET @Infobar     = NULL
SET @QtyReserved = 0
set @UseStat = case when @RsvdType = 'R' then 'O' else 'OF' end
select @ParmsSite = site from parms with (readuncommitted)

SELECT
  @TotTrnNum       AS trn_num
, @TotTrnLine      AS trn_line
, @TotDueDate		AS due_date
, @TrnOrderDate    AS order_date
, @TotWhse     AS from_whse
, @TotQtyOrdered  AS qty_ordered
, @ItmUM          AS u_m
, @QtyReserved    AS qty_rsvd
, @ItmItem        AS item
, @ItmDescription AS description
INTO #Results
WHERE 1=2

exec dbo.ApsSyncDeferSp @Infobar output
, @Context = 'ReserveSp'

set @PostCount = 0

DECLARE
  ReserveSpCrs1 CURSOR LOCAL STATIC FOR
SELECT
  itm.item
, itm.description
, itm.u_m
, trni.trn_num
, trni.trn_line
, trn.order_date
, trni.qty_req - trni.ZWM_QtyRsvd - trni.qty_shipped
, trni.from_whse
, trni.u_m
, trni.sch_ship_date
, trni.qty_req
, trn.from_whse
, whs.name
FROM item AS itm WITH (READUNCOMMITTED)
INNER JOIN trnitem AS trni ON trni.item = itm.item
									AND CHARINDEX(trni.stat, @UseStat) > 0
INNER JOIN transfer trn with (readuncommitted) ON trn.trn_num = trni.trn_num
INNER JOIN whse AS whs with (readuncommitted) ON
  whs.whse = trn.from_whse

WHERE  
		 itm.item		BETWEEN @StartItem AND @EndItem
   AND ISNULL (itm.reservable, 0) = 1
	AND trni.from_site = @ParmsSite
	AND trni.trn_num	BETWEEN @StartTrnNum AND @EndTrnNum
	AND trni.trn_line BETWEEN @StartTrnLine AND @EndTrnLine 
   AND trn.from_whse BETWEEN @StartWhse	AND @EndWhse
   AND trn.order_date BETWEEN  @StartOrderDate AND @EndOrderDate
   AND trni.sch_ship_date BETWEEN @StartDueDate AND @EndDueDate
	
ORDER BY itm.item, trni.item, trni.sch_ship_date

OPEN ReserveSpCrs1
WHILE @Severity = 0
BEGIN
    FETCH ReserveSpCrs1 INTO
      @ItmItem
    , @ItmDescription
    , @ItmUM
    , @TotTrnNum
    , @TotTrnLine
    , @TrnOrderDate
    , @TotQtyToReserve
    , @TotWhse
    , @TotUM
    , @TotDueDate
    , @TotQtyOrdered
    , @FromWhse
    , @WhseName

    IF @@FETCH_STATUS != 0
        BREAK

   if @PostCount = 0
   begin
      set @PostCount = 1
      begin transaction
   end
   else
      set @PostCount = @PostCount + 1

   if @PostCount > 100
   begin
      commit transaction
      set @PostCount = 1
      begin transaction
   end

    IF @RsvdType = 'R'
    BEGIN
        IF @InFile = 'T' OR @InFile = 'B'
        BEGIN

            EXEC @Severity = dbo.ZWM_InvRsvSp
              @ItmItem
            , @TotTrnNum
            , @TotTrnLine
            , 0						-- ref_release = 0
            , @TotQtyToReserve
            , @TotWhse
            , @TotUM
            , @FromWhse
            , 'reserve.p'
            , @QtyReserved OUTPUT
            , @Infobar     OUTPUT
            , @ParmsSite
            , 0				-- No realizar reservar fijas (No hace reservas para item Clase C)
            , 0			-- Hrs a resevar NULL
            , 'T'				-- Identificar reservas como T=Transfer Order
            IF @Severity <> 0
                BREAK

        END -- @Infile 'T', or 'B'
        ELSE
        BEGIN
            /* Preview only */
            EXEC @Severity = dbo.ZWM_InvRsvSp
              @ItmItem
            , @TotTrnNum
            , @TotTrnLine
            , 0					-- Ref_release = 0
            , @TotQtyToReserve
            , @TotWhse
            , @TotUM
            , @FromWhse
            , 'reserve.pprev'
            , @QtyReserved OUTPUT
            , @Infobar     OUTPUT
            , @ParmsSite
            , 0				-- No realizar reservar fijas (No hace reservas para item Clase C)
            , 0			-- Hrs a resevar NULL
            , 'T'				-- Identificar reservas como T=Transfer Order
            IF @Severity <> 0
                BREAK
        END -- Preview only

      INSERT INTO #Results (
         trn_num
       , trn_line
       , order_date
       , due_date
       , from_whse
       , qty_ordered
       , u_m
       , qty_rsvd
       , item
       , description
       ) VALUES (
         @TotTrnNum
       , @TotTrnLine
       , @TrnOrderDate
       , @TotDueDate
       , @TotWhse
       , @TotQtyOrdered
       , @ItmUM
       , @QtyReserved
       , @ItmItem
       , @ItmDescription
       )
    END -- @RsvdType = 'R'
    ELSE
    BEGIN
        DECLARE
          ReserveSpCrs2 CURSOR local static FOR
        SELECT
          rsi.RowPointer
        , rsi.qty_rsvd_conv
        FROM rsvd_inv AS rsi
        WHERE rsi.ref_num = @TotTrnNum
        AND rsi.ref_line = @TotTrnLine
        AND rsi.ref_release = 0
        -- ZWM
        AND ISNULL(rsi.ZWM_RefType,'O') = 'T'

        OPEN ReserveSpCrs2
        WHILE @Severity = 0
        BEGIN
            FETCH ReserveSpCrs2 INTO
              @RsiRowPointer
            , @RsiQtyRsvdConv

            IF @@FETCH_STATUS = -1
                BREAK
            IF @@FETCH_STATUS = -2
                CONTINUE

            IF @Infile = 'T' OR @Infile = 'B'
            BEGIN
                SET @SessionID     = dbo.SessionIDSp() 
                EXEC @Severity = dbo.UpdResvSp
                  1 -- @DelRsvd true
                , @RsiRowPointer
                , @RsiQtyRsvdConv
                , 1 -- @ConvFactor
                , 'From Base' -- @FromBase
                , @Infobar OUTPUT
                , @SessionID
                IF @Severity <> 0
                    BREAK
            END
            INSERT INTO #Results (
               trn_num
             , trn_line
             , order_date
             , due_date
             , from_whse
             , qty_ordered
             , u_m
             , qty_rsvd
             , item
             , description
             ) VALUES (
               @TotTrnNum
             , @TotTrnLine
             , @TrnOrderDate
             , @TotDueDate
             , @TotWhse 
             , @TotQtyOrdered
             , @ItmUM
             , @RsiQtyRsvdConv
             , @ItmItem
             , @ItmDescription
             )
        END
        CLOSE ReserveSpCrs2
        DEALLOCATE ReserveSpCrs2

    END -- @RsvdType <> 'R'

END -- End ReserveSpCrs1
CLOSE ReserveSpCrs1
DEALLOCATE ReserveSpCrs1

if @PostCount > 0
   commit transaction

exec dbo.ApsSyncImmediateSp @Infobar output
, @Context = 'ReserveSp'

SELECT DISTINCT
  trn_num
, trn_line
, order_date
, due_date
, from_whse
, qty_ordered
, u_m
, qty_rsvd
, item
, description
FROM #Results

DROP TABLE #Results

RETURN 0

GO


