/****** Object:  StoredProcedure [dbo].[ZWM_InvRsvSp]    Script Date: 01/09/2015 14:44:59 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ZWM_InvRsvSp]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ZWM_InvRsvSp]
GO

/****** Object:  StoredProcedure [dbo].[ZWM_InvRsvSp]    Script Date: 01/09/2015 14:44:59 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


--  Converted from item/inv-resv.p.  This routine creates inventory resevations.

/* $Header: /ApplicationDB/Stored Procedures/InvRsvSp.sp 20    6/10/11 1:13p Dmcwhorter $  */
/*
*****************************************	**********************
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

/* $Archive: /ApplicationDB/Stored Procedures/InvRsvSp.sp $
 *
 * SL8.03 20 139207 Dmcwhorter Fri Jun 10 13:13:13 2011
 * Reserved Qty is always zero when running Preview
 * 139207 - During Preview, show the amount that will be reserved.
 *
 * SL8.03 19 rs4892 Jpan2 Wed Jun 01 23:02:56 2011
 * rs4892 - do not include contained quantity for reservation process.
 *
 * SL8.02 18 128675 Mewing Tue Apr 27 13:53:03 2010
 * Update Copyright to 2010
 *
 * SL8.02 17 125228 pgross mar. mars 09 14:10:51 2010
 * .Net Framework Execution wsa aborted by escalation policy because of out of memory
 * made changes to improve performance
 *
 * SL8.02 16 rs4588 Dahn Thu Mar 04 14:37:22 2010
 * rs4588 copyright header changes
 *
 * SL8.02 15 125579 Clarsco Tue Feb 16 10:14:05 2010
 * When the 'Tax-Free Imported Material' and 'Reservable' fields are checked, you cannot reserve the item if the Lot Track field is not checked.
 * Enhancement 125579
 * For @TaxFreeMatl failures, added the message stating Tax Free Material: Yes exists.
 *
 * SL8.01 14 rs3953 Vlitmano Tue Aug 26 17:05:28 2008
 * RS3953 - Changed a Copyright header?
 *
 * SL8.01 13 rs3953 Vlitmano Mon Aug 18 15:27:01 2008
 * Changed a Copyright header information(RS3959)
 *
 * SL8.00 12 RS2968 nkaleel Fri Feb 23 03:11:11 2007
 * changing copyright information
 *
 * SL8.00 11 97743 Hcl-jainami Thu Feb 01 08:33:54 2007
 * Reserving from location is done in alphabetical order Location name instead of on Rank
 * Checked-in for issue 97743:
 * Added ORDER BY clause to InvResvSpCrs1 Cursor definition when '@ItemLotTracked = 0'.
 *
 * SL8.00 10 RS2968 prahaladarao.hs Tue Jul 11 09:32:35 2006
 * RS 2968, Name change CopyRight Update.
 *
 * SL8.00 9 93653 jagadisha.mk Tue Jun 13 02:57:00 2006
 * Badly formed error message
 * 93653
 * Included the @Severity when building message using MsgAppSp and include prefix dbo to Sp call.
 *
 * SL8.00 8 93653 jagadisha.mk Thu Jun 08 04:37:55 2006
 * Badly formed error message
 * Issue: #93653
 *  The Execution GetErrorMessageTextSp  has been replaced by MsgAppSp in order generate correct message.
 *
 * SL7.05 7 91818 NThurn Fri Jan 06 15:51:17 2006
 * Inserted standard External Touch Point call.  (RS3177)
 *
 * SL7.04 6 91150 hcl-singind Wed Dec 28 04:00:49 2005
 * Issue #: 91150.
 * Added "WITH (READUNCOMMITTED)" to item Select Statement.
 *
 * SL7.04 5 85238 Hcl-kavimah Tue Feb 01 00:51:52 2005
 * Reservable (lot tracked) Item with on hand stock available not reserved in CO reserve line function.
 * Issue 85238,
 *
 *
 * added the following condition to take exact locations.
 *
 *     AND   itl.loc  = llo.loc
 *
 *
 *
 *
 * $NoKeywords: $
 */
CREATE PROCEDURE [dbo].[ZWM_InvRsvSp] (
  @Item         ItemType
, @CoNum        CoNumType
, @CoLine       CoLineType
, @CoRelease    CoLineType
, @QtyToReserve QtyUnitType
, @Whse         WhseType
, @UM           UMType
, @CustNum      CustNumType
, @ProgramName  OSLocationType
, @QtyReserved  QtyUnitType     OUTPUT
, @Infobar      Infobar OUTPUT
, @ParmsSite	 SiteType = null
, @pZWMFixedRsvd FlagNyType = 0		-- Indicador si la reserva debe hacer como fija
, @pReserveTime	int		 = 0			-- Horas a reservar , NULL = permanente
, @pZWMRefType	RefTypeIJKOPRSTWType = 'O'
)
AS

   -- Check for existence of Generic External Touch Point routine (this section was generated by SpETPCodeSp and inserted by CallETPs.exe):
   IF OBJECT_ID(N'dbo.EXTGEN_ZWM_InvRsvSp') IS NOT NULL
   BEGIN
      DECLARE @EXTGEN_SpName sysname
      SET @EXTGEN_SpName = N'dbo.EXTGEN_ZWM_InvRsvSp'
      -- Invoke the ETP routine, passing in (and out) this routine's parameters:
      DECLARE @EXTGEN_Severity int
      EXEC @EXTGEN_Severity = @EXTGEN_SpName
         @Item
         , @CoNum
         , @CoLine
         , @CoRelease
         , @QtyToReserve
         , @Whse
         , @UM
         , @CustNum
         , @ProgramName
         , @QtyReserved OUTPUT
         , @Infobar OUTPUT
         , @ParmsSite
			, @pZWMFixedRsvd 
			, @pReserveTime
			, @pZWMRefType	
 
      -- ETP routine can RETURN 1 to signal that the remainder of this standard routine should now proceed:
      IF @EXTGEN_Severity <> 1
         RETURN @EXTGEN_Severity
   END
   -- End of Generic External Touch Point code.
 
DECLARE
  @Severity       INT
, @ItemLotTracked Flag
, @ItemItem       ItemType
, @ItemIssueBy    ListLocLotType
, @ItemUM         UMType
, @TRsvdLoc       LocType
, @TRsvdLot       LotType
, @TRsvdQty       QtyUnitType
, @TRsvdNum       RsvdNumType
, @InLoc          LocType
, @InLot          LotType
, @InImportDocId  ImportDocIdType
, @TRsvdImportDocId ImportDocIdType
, @TaxFreeMatl    ListYesNoType
, @UomConvFactor UMConvFactorType
, @NewRsvdQty       QtyUnitType

-- ZWM 
DECLARE
  @ResInvZWMFixedRsvd	FlagNyType
 ,@ItemZWM_ReserveType  GenericCodeType
 -- Caja Recolectora
, @ZWMItemCBoxItem			ItemType
, @ZWMItemCBoxWhse			WhseType
, @ZWMItemCBoxLoc			LocType
, @ZWMItemCBoxRowPointer	RowPointerType
, @CoItemZrtResWhse	WhseType
, @CoItemZrtLoc		LocType
, @CoItemZrtLot		LotType
, @CoItemRowPointer	RowPointerType
, @TItemCBoxLot		LotType
, @TItemIsCBox			FlagNyType
, @TItemLotSelected FlagNyType
, @ItemUmStock2		UmType
, @PalletUomConvFactor UMConvFactorType
, @TTotalItemQty			QtyUnitType
, @TReserveFromStock		FlagNyType

-- ZWM Parms
, @RowPointer	RowPointerType
, @ReservePct	MarkupType

SET @Infobar = NULL
SET @Severity = 0
SET @QtyReserved = 0

SET @TItemIsCBox = 0
SET @TItemLotSelected = 0
SET @TReserveFromStock = 0
SET @pZWMRefType = ISNULL(@pZWMRefType, 'O')


-- Verificar si existe la columna de reserva del lote del módulo ZRT
IF (EXISTS(SELECT * FROM sys.objects 
				WHERE [object_id] = OBJECT_ID(N'[dbo].[coitem_mst]') 
				AND [type]='U')) 
				AND (EXISTS(SELECT * FROM sys.columns WHERE [name]=N'zrt_lot' 
																	AND [object_id]=OBJECT_ID(N'[dbo].[coitem_mst]')))
				AND (EXISTS(SELECT * FROM sys.columns WHERE [name]=N'zrt_loc' 
																	AND [object_id]=OBJECT_ID(N'[dbo].[coitem_mst]')))

				AND (EXISTS(SELECT * FROM sys.columns WHERE [name]=N'zrt_res_whse' 
																	AND [object_id]=OBJECT_ID(N'[dbo].[coitem_mst]')))
	
-- Verificar si se ha asignado un lote específico para 
IF @pZWMRefType = 'O'
BEGIN
	
	SELECT  TOP 1
	   -- @CoItemZrtResWhse = zrt_res_whse
	  -- ,
	    @CoItemZrtLot	= zrt_lot
	    ,@CoItemRowPointer = RowPointer
	   FROM coitem WITH (READUNCOMMITTED)
	   WHERE co_num = @CoNum    
			AND co_line = @CoLine
			AND co_release = @CoRelease 
			
		IF @CoItemRowPointer IS NOT NULL
			SET @TItemLotSelected = 1
END				


SELECT
  @ItemLotTracked = it.lot_tracked
, @ItemItem       = it.item
, @ItemIssueBy    = it.issue_by
, @ItemUM         = it.u_m
, @TaxFreeMatl    = it.tax_free_matl
-- ZWM
, @ItemZWM_ReserveType = ZWM_ReservationType
, @ItemUmStock2 = ZWM_UMStock2 
FROM item AS it WITH (READUNCOMMITTED)
WHERE it.item = @Item


-- Si es un artículo con Tipo de Reserva Clase C, no reservar si la reserva debe ser fija
IF @pZWMFixedRsvd = 0 AND @ItemZWM_ReserveType  = 'C'
	RETURN @Severity
	
		
-- Verificar si es un item de Caja Recolectora
SELECT 
  @ZWMItemCBoxItem			= item
, @ZWMItemCBoxWhse			= whse
, @ZWMItemCBoxLoc			= loc
, @ZWMItemCBoxRowPointer = RowPointer
FROM zwm_Item_col_box  WITH (READUNCOMMITTED) 
WHERE  item = @Item
	AND whse = @Whse 
	
IF @ZWMItemCBoxRowPointer IS NOT NULL
	SET @TItemIsCBox = 1 
	
-- Determinar el lote de caja recolectora, ya que este debe ir al principio en reserva
IF @TItemIsCBox = 1 AND @ItemLotTracked = 1
	SELECT TOP 1 @TItemCBoxLot = lot
		FROM lot_loc 
		WHERE whse = @Whse
		AND item = @Item
		AND loc = @ZWMItemCBoxLoc 


-- Determinar si el item excede % del Pallet.
IF @TItemIsCBox = 1
BEGIN

 IF @ItemUmStock2 != @ItemUM
   BEGIN
      EXEC @Severity = dbo.GetumcfSp
        @UM
      , @ItemItem
      , @CustNum
      , 'C'
      , @PalletUomConvFactor OUTPUT
      , @Infobar OUTPUT
      IF @Severity <> 0
         Return @Severity
   END
   ELSE
      SET @PalletUomConvFactor = 1
      

END	

 IF @UM != @ItemUM
   BEGIN
      EXEC @Severity = dbo.GetumcfSp
        @UM
      , @ItemItem
      , @CustNum
      , 'C'
      , @UomConvFactor OUTPUT
      , @Infobar OUTPUT
      IF @Severity <> 0
         Return @Severity
   END
   ELSE
      SET @UomConvFactor = 1
      

SET @TTotalItemQty = dbo.UomConvQty( @QtyToReserve, @UomConvFactor ,'To Base' )

-- OBtener el porcentaje de reserva máximo, si excede a este %, reservar de stock
SELECT 
 @RowPointer = RowPointer
, @ReservePct = reserve_pct
FROM zwm_parms
WHERE parm_key = 0

-- Si la cantidad a reservar en la UM del item es mayor al 90%, reservar del Stock(Loc no CR), en lugar de CR loc  
SET  @TReserveFromStock = CASE WHEN @TTotalItemQty > (@PalletUomConvFactor * (ISNULL(@ReservePct,0))/100)
									THEN 1
									ELSE 0 
									END   
									
 
-- Item No LotTracked, No CR
IF @ItemLotTracked = 0 And @TItemIsCBox = 0
BEGIN
    DECLARE
      InvResvSpCrs1 CURSOR local static FOR
    SELECT
      itl.loc
    , itl.qty_on_hand - itl.qty_rsvd - itl.qty_contained
    , NULL
    , NULL
    FROM itemloc AS itl
   INNER JOIN location loc ON loc.loc = itl.loc
   WHERE itl.whse = @Whse
    AND   itl.item = @ItemItem
    AND   itl.qty_on_hand > itl.qty_rsvd	-- Qty Available
    AND   itl.mrb_flag = 0 -- false
    AND   itl.loc_type = 'S'
    AND   ISNULL(loc.ZWM_ColBox,0) = 0		-- Cambiar por Flag de Location.is_col_box	
    ORDER BY itl.rank


END
-- Item No Lot Tracked, CR
ELSE IF @ItemLotTracked = 0 And @TItemIsCBox = 1
BEGIN
 DECLARE
      InvResvSpCrs1 CURSOR local static FOR
    SELECT
      itl.loc
    , itl.qty_on_hand - itl.qty_rsvd - itl.qty_contained
    , NULL
    , NULL
    FROM itemloc AS itl
    INNER JOIN location loc ON loc.loc = itl.loc
   WHERE itl.whse = @Whse
    AND   itl.item = @ItemItem
    AND   itl.qty_on_hand > itl.qty_rsvd	-- Qty Available
    AND   itl.mrb_flag = 0 -- false
    AND   itl.loc_type = 'S'
    AND  ISNULL(loc.ZWM_ColBox,0)  = ( CASE WHEN @TReserveFromStock = 1 THEN 0 ELSE 1 END  )
    ORDER BY (CASE 
			WHEN @TItemLotSelected = 1 
			THEN itl.loc 
			ELSE itl.rank 
			END ) DESC, itl.rank		 
END
-- Item Lot Tracked, NO CR
ELSE IF @ItemLotTracked = 1 And @TItemIsCBox = 0
BEGIN
  DECLARE
      InvResvSpCrs1 CURSOR local static FOR
    SELECT
      llo.loc
    , ( llo.qty_on_hand - llo.qty_rsvd - llo.qty_contained)
    , llo.lot
    , NULL
    FROM lot_loc AS llo
    INNER JOIN itemloc AS itl ON
          itl.qty_on_hand > itl.qty_rsvd
    AND   itl.mrb_flag = 0 -- false
    AND   itl.loc_type = 'S'
    AND   itl.item = llo.item
    AND   itl.whse = llo.whse
    AND   itl.loc  = llo.loc
    WHERE llo.whse = ISNULL(@CoItemZrtResWhse,@Whse)
 --   AND   llo.loc  = ISNULL(@CoItemZrtLoc,llo.loc)
    AND   llo.lot  = ISNULL(@CoItemZrtLot,llo.lot)
    AND   llo.item = @ItemItem
    AND   llo.qty_on_hand > llo.qty_rsvd
    AND  (SELECT SUM(xllo.qty_on_hand - xllo.qty_rsvd) 
				FROM lot_loc xllo 
				WHERE xllo.item = llo.item 
				  AND xllo.lot  = llo.lot
				  AND xllo.whse = llo.whse
					) >= @TTotalItemQty		-- Solo reservar lotes completos    

    ORDER BY 
		(CASE 
			WHEN @TItemLotSelected = 1 
			THEN itl.loc 
			ELSE itl.rank 
			END )
		, itl.rank, ( llo.qty_on_hand - llo.qty_rsvd - llo.qty_contained) -- Ordenar por Cantidad de menor a mayor itl.rank, llo.lot
END
-- Item Lot Tracked, CR
ELSE IF @ItemLotTracked = 1 And @TItemIsCBox = 1
BEGIN

	
   DECLARE
      InvResvSpCrs1 CURSOR local static FOR
    SELECT
      llo.loc
    , ( llo.qty_on_hand - llo.qty_rsvd - llo.qty_contained)
    , llo.lot
    , NULL
    FROM lot_loc AS llo
    INNER JOIN itemloc AS itl ON
          itl.qty_on_hand > itl.qty_rsvd
    AND   itl.mrb_flag = 0 -- false
    AND   itl.loc_type = 'S'
    AND   itl.item = llo.item
    AND   itl.whse = llo.whse
    AND   itl.loc  = llo.loc
    WHERE llo.whse = ISNULL(@CoItemZrtResWhse,@Whse)
    AND   llo.lot  = ISNULL(@CoItemZrtLot,llo.lot)
    AND   llo.item = @ItemItem
    AND   llo.qty_on_hand > llo.qty_rsvd
  --  AND    ISNULL(loc.ZWM_ColBox,0) = ( CASE WHEN @TReserveFromStock = 1 THEN 0 ELSE 1 END  )	
    AND  (SELECT SUM(xllo.qty_on_hand - xllo.qty_rsvd) 
				FROM lot_loc xllo 
				WHERE xllo.item = llo.item 
				  AND xllo.lot  = llo.lot
				  AND xllo.whse = llo.whse
					) >= @TTotalItemQty		-- Solo reservar lotes completos 

    ORDER BY 
    CASE WHEN (@TTotalItemQty <= 10)  -- Si aplica cola de lote, poner lote y ubicacion al principio para consumir esa cola de lote
			And (llo.qty_on_hand - llo.qty_rsvd - llo.qty_contained) > @TTotalItemQty 
		THEN  0
		ELSE  1 
		END ASC 
    , 
    CASE 
		WHEN ( llo.lot = @TItemCBoxLot)	-- Si Item = CR, colocar loc de CR al principio
		THEN 0
		ELSE 1 
	END 
    ,
    (CASE 
			WHEN @TItemLotSelected = 1		-- Colocar Lote seleccionado al principio
			THEN itl.loc 
			ELSE itl.rank 
			END )
    , itl.rank
    , ( llo.qty_on_hand - llo.qty_rsvd - llo.qty_contained) DESC -- Ordenar por Cantidad de mayor a menor  
END

OPEN InvResvSpCrs1
WHILE @Severity = 0
BEGIN
    FETCH InvResvSpCrs1 INTO
      @InLoc
    , @NewRsvdQty
    , @InLot
    , @InImportDocId
    IF @@FETCH_STATUS != 0
        BREAK

   SET @NewRsvdQty = dbo.MinQtySp(@NewRsvdQty, @QtyToReserve - @QtyReserved)

   SET @TRsvdImportDocId = @InImportDocId

   IF @UM != @ItemUM
   BEGIN
      EXEC @Severity = dbo.GetumcfSp
        @UM
      , @ItemItem
      , @CustNum
      , 'C'
      , @UomConvFactor OUTPUT
      , @Infobar OUTPUT
      IF @Severity <> 0
         break
   END
   ELSE
      SET @UomConvFactor = 1

  IF @ProgramName <> 'reserve.pprev'
   EXEC @Severity = dbo.ZWM_AddResvSp
     @ItemItem
   , @Whse
   , @CoNum
   , @CoLine
   , @CoRelease
   , @InLoc
   , @InLot
   , @NewRsvdQty
   , @UomConvFactor
   , @UM
   , 1 -- @AutoRsvd True
   , 'inv-resv.p' -- @ProgramName
   , @TRsvdNum OUTPUT
   , @Infobar  OUTPUT
   , Null
   , @TRsvdImportDocId
   , @ParmsSite = @ParmsSite
   , @pZWMRefType = @pZWMRefType

   IF @Severity <> 0
       break
       
    IF ISNULL(@pReserveTime,0) > 0
    BEGIN
		UPDATE rsvd_inv SET ZWM_ExpDate = DATEADD(HOUR,@pReserveTime,GetDate())
		WHERE rsvd_num = @TRsvdNum
    END
       
   -- Actualizar el flag de reserva fija
   IF @pZWMFixedRsvd = 1
   BEGIN
		UPDATE rsvd_inv SET zwm_fixed  = 1
			WHERE rsvd_num = @TRsvdNum
   END

   SET @QtyReserved = @QtyReserved + @NewRsvdQty

   IF @QtyReserved >= @QtyToReserve
      BREAK
END
CLOSE InvResvSpCrs1
DEALLOCATE InvResvSpCrs1

IF @Severity = 0 AND
   @QtyReserved = 0 AND
   @ProgramName NOT LIKE '%reserve.p%'
BEGIN

	IF @pZWMRefType = 'O'
	BEGIN
		EXEC @Severity = dbo.MsgAppSp @Infobar OUTPUT
                        , 'E=NoExistForIs4'
                        , '@itemloc'
                        , '@itemloc.qty_on_hand'
                        , '> 0'
                        , '@item.item'
                        , '@coitem.co_num' ,@CoNum
                        , '@coitem.co_line' ,@CoLine
                        , '@whse.whse' ,@Whse
                        , '@item.item' ,@ItemItem
	END
	ELSE
	BEGIN
	EXEC @Severity = dbo.MsgAppSp @Infobar OUTPUT
                        , 'E=NoExistForIs4'
                        , '@itemloc'
                        , '@itemloc.qty_on_hand'
                        , '> 0'
                        , '@item.item'
                        , '@trnitem.trn_num' ,@CoNum
                        , '@trnitem.trn_line' ,@CoLine
                        , '@whse.whse' ,@Whse
                        , '@item.item' ,@ItemItem
	END       

   IF @TaxFreeMatl = 1
   BEGIN
      -- Item that has [Tax Free Material: Yes] exists.
      EXEC @Severity = dbo.MsgAppSp @Infobar OUTPUT, 'E=Exist1'
         , '@Item', '@Item.tax_free_matl', '@:ListYesNo:1'
   END

    IF @Severity <> 0
        RETURN @Severity
END

RETURN 0

GO


