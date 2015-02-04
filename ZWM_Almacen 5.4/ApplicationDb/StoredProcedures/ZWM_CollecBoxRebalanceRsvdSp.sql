/****** Object:  StoredProcedure [dbo].[ZWM_CollecBoxRebalanceRsvdSp]    Script Date: 01/02/2015 00:20:02 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ZWM_CollecBoxRebalanceRsvdSp]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ZWM_CollecBoxRebalanceRsvdSp]
GO

/****** Object:  StoredProcedure [dbo].[ZWM_CollecBoxRebalanceRsvdSp]    Script Date: 01/02/2015 00:20:02 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ZWM_CollecBoxRebalanceRsvdSp]
(
  @Item		ItemType = NULL
, @Whse	WhseType = NULL
, @Infobar	InfobarType OUTPUT
)
AS


DECLARE
  @CBReqItem			ItemType
, @CBReqWhse			WhseType
, @CBReqRefType		RefTypeIJKPRTType
, @CBReqRefNum			JobPoProjReqTrnNumType
, @CBReqRefLineSuf	SuffixPoLineProjTaskReqTrnLineType
, @CBReqRefRelease	OperNumPoReleaseType
, @CBReqDueDate		DateType
, @CBReqQtyReqConv	QtyUnitNoNegType
, @CBReqUM				UMType
, @CBReqRowPointer	RowPointerType


DECLARE
  @TLocWhse			WhseType
, @TLocItem			ItemType
, @TLocLoc			LocType
, @TLocLot			LotType
, @TLocQtyOnHand	QtyUnitType
, @TLocQtyRsvd		QtyUnitType
, @TLocRowPointer	RowPointerType
-- Item
, @ItemUM	UMType
, @ItemLotTracked	ListYesNoType
, @ItemRowPointer	RowPointerType
-- item caja recolectora
, @ItemCBItem	ItemType
, @ItemCBWhse	WhseType
, @ItemCBLoc	LocType
, @ItemCBRowPointer	RowPointer

DECLARE
  @Severity int
, @TLocQtyAvailable			QtyUnitType
, @TCBReqQtyReq				QtyUnitType
, @CBUmConvFactor				UmConvFactorType
, @SessionID					RowPointerType
, @TMoveReserve				FlagNyType
, @ParmsSite					SiteType
, @CustNum						CustNumType
, @QtyReserved					QtyUnitType

DECLARE
  @RsiRsvdNum			RsvdNumType
, @RsiItem				ItemType
, @RsiWhse				WhseType
, @RsiLoc				LocType
, @RsiLot				LotType
, @RsiQtyRsvd			QtyUnitNoNegType
, @RsiQtyRsvdConv		QtyUnitNoNegType
, @RsiRefNum			CoNumType
, @RsiRefLine			CoLineType
, @RsiRefRelease		CoReleaseType
, @RsiUM					UMType
, @RsiRowPointer		RowPointerType
, @RsiZWMRefType	RefTypeIJKOPRSTWType



DECLARE @Rsvd TABLE
(
  item		ItemType
, whse		WhseType
, loc			LocType
, lot			LotType
, qty_rsvd			QtyUnitNoNegType
, qty_rsvd_conv	QtyUnitNoNegType
, ref_num			CoNumType
, ref_line			CoLineType
, ref_release		CoReleaseType
, u_m					UMType
, ZWM_RefType		RefTypeIJKOPRSTWType
)

SET @Severity = 0
select @ParmsSite = site from parms with (readuncommitted)

-- Procesar cada uno de los requerimientos

SELECT 
	 @ItemCBLoc	= loc
	,@ItemCBRowPointer = RowPointer
	From zwm_item_col_box 
	WHERE item = @Item
	AND	whse = @Whse
	
IF @@ROWCOUNT <> 1
	RETURN @Severity

-- Obtener datos del item
SELECT 
	  @ItemUM	= u_m
	, @ItemLotTracked	= lot_tracked
	, @ItemRowPointer	= RowPointer 
	FROM item
		Where item = @item
		
IF @@ROWCOUNT <> 1
	RETURN @Severity		
	
		 -- Unreserve inventory no fijo
		  DECLARE
          ReserveSpCrs1 CURSOR local static FOR
        SELECT
          rsi.RowPointer
        , rsi.qty_rsvd_conv
        FROM rsvd_inv AS rsi
        WHERE item = @Item
			And  whse = @Whse
			And  loc  = @ItemCBLoc
			AND  zwm_fixed = 0
		   
		  
        OPEN ReserveSpCrs1
        WHILE @Severity = 0
        BEGIN
            FETCH ReserveSpCrs1 INTO
              @RsiRowPointer
            , @RsiQtyRsvdConv
            

            IF @@FETCH_STATUS = -1
                BREAK
            IF @@FETCH_STATUS = -2
                CONTINUE
                
                -- Guardar Cantidades para reservarlas al final del proceso
                INSERT INTO @Rsvd 
									 (
									     item
										, whse
										, loc
										, lot
										, qty_rsvd
										, qty_rsvd_conv
										, ref_num
										, ref_line
										, ref_release
										, u_m
										, ZWM_RefType
									 )
                SELECT  
								  item
								, whse
								, loc
								, lot
								, qty_rsvd
								, qty_rsvd_conv
								, ref_num
								, ref_line
								, ref_release
								, u_m
								, ZWM_RefType
							FROM rsvd_inv 
							WHERE RowPointer = @RsiRowPointer
           
					-- Unreserve 
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
         CLOSE ReserveSpCrs1
			DEALLOCATE ReserveSpCrs1



-- Procesar los requerimientos en firme para el item/whse
DECLARE CBReqCur CURSOR LOCAL STATIC FOR
SELECT 
  ref_type
, ref_num
, ref_line_suf
, ref_release
, due_date
, qty_req_conv
, u_m
, RowPointer
FROM zwm_col_box_req
WHERE item = @Item
	AND whse = @Whse
	AND ref_type  IN('O', 'T', 'P')
	
OPEN CBReqCur 

WHILE 1=1
BEGIN

	FETCH CBReqCur INTO
			  @CBReqRefType
			, @CBReqRefNum
			, @CBReqRefLineSuf
			, @CBReqRefRelease
			, @CBReqDueDate
			, @CBReqQtyReqConv
			, @CBReqUM
			, @CBReqRowPointer
			 
	IF @@FETCH_STATUS <> 0
		BREAK
		
	IF @CBReqRefType = 'P'
		SET @CBReqRefType = 'O'
		
	IF @CBReqRefType = 'O'
		SELECT @CustNum = cust_num 
			from co 
			WHERE co_num = @CBReqRefNum 
		
	-- Obtener datos de la existencia y reserva	
	IF @ItemLotTracked = 0
	BEGIN

		SELECT 
		  @TLocLoc = loc
		, @TLocQtyOnHand = qty_on_hand
		, @TLocQtyRsvd = qty_rsvd
		, @TLocRowPointer = RowPointer
		FROM itemloc 
		WHERE item = @Item
			AND whse = @Whse
			AND loc = @ItemCBLoc 
			AND mrb_flag = 0
			
			IF @@ROWCOUNT <> 1
				RETURN @Severity
				
						
	END
	ELSE
	BEGIN
		-- Obtener datos de la existencia y reserva
		SELECT TOP 1
		  @TLocLoc = loc
		, @TLocLoc = lot
		, @TLocQtyOnHand = qty_on_hand
		, @TLocQtyRsvd = qty_rsvd
		, @TLocRowPointer = RowPointer
		FROM lot_loc 
		WHERE item = @Item
			AND whse = @Whse
			AND loc = @ItemCBLoc 
			
			IF @@ROWCOUNT <> 1
				RETURN @Severity
				
	END
	
		
	-- Deterinar cantidad disponibles on hand - reservada
	SET @TLocQtyAvailable = @TLocQtyOnHand -  @TLocQtyRsvd

		
	/*
		Convertir la  cantida del requerimiento
	*/
	IF @ItemUM <> @CBReqUM 
	BEGIN
	
		SET @infobar = NULL									
									
					-- Obtener Factor de conversión
					EXECUTE [GetumcfSp] 		@ItemUM
												  ,@CBReqItem
												  ,NULL
												  ,'I'
												  ,@CBUmConvFactor OUTPUT
												  ,@Infobar OUTPUT
												  
		
					EXECUTE [UomConvQtySp] 
										@CBReqQtyReqConv
									  ,@CBUmConvFactor
									  ,'To Base'
									  ,@TCBReqQtyReq OUTPUT
									  ,@Infobar OUTPUT
	END
	ELSE
		SET @TCBReqQtyReq = @CBReqQtyReqConv
		
	 

	-- Si la cantidad requerida es menor a la disponible
	-- solo mover las reservas 
	IF @TCBReqQtyReq <=  @TLocQtyAvailable
	BEGIN	
	
		-- A) Quitar la reserva actual
		 DECLARE
          ReserveSpCrs2 CURSOR local static FOR
        SELECT
          rsi.RowPointer
        , rsi.qty_rsvd_conv
        FROM rsvd_inv AS rsi
        WHERE rsi.ref_num = @CBReqRefNum
        AND rsi.ref_line = @CBReqRefLineSuf
        AND rsi.ref_release = @CBReqRefRelease
        AND ISNULL(rsi.ZWM_RefType,'O') = @CBReqRefType

        OPEN ReserveSpCrs2
        WHILE @Severity = 0
        BEGIN
            FETCH ReserveSpCrs2 INTO
              @RsiRowPointer
            , @RsiQtyRsvdConv

            IF @@FETCH_STATUS <> 0 
                BREAK
                
                
            -- Borrar registro de reserva del requerimiento en caso que haya sido unreserved
            DELETE @Rsvd 
            WHERE ref_num = @CBReqRefNum
					  AND ref_line = @CBReqRefLineSuf
					  AND ref_release = @CBReqRefRelease
					  AND ISNULL(ZWM_RefType,'O') = @CBReqRefType 

             
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
        CLOSE ReserveSpCrs2
        DEALLOCATE ReserveSpCrs2
		 
		-- B) Reservar de caja recolectora
				EXECUTE @Severity = ZWM_InvRsvSp
					@Item
				  ,@CBReqRefNum
				  ,@CBReqRefLineSuf
				  ,@CBReqRefRelease
				  ,@CBReqQtyReqConv
				  ,@Whse
				  ,@CBReqUM
				  ,@CustNum
				  ,'reserve.p'
				  ,@QtyReserved OUTPUT
				  ,@Infobar OUTPUT
				  ,@ParmsSite
				  ,1				-- Reservar como fija
				  ,0
				  ,@CBReqRefType
			
			
		 
	END
	
			 
END

CLOSE CBReqCur
DEALLOCATE CBReqCur

-- Finalmente volver a asignar la reserva que ha sido eliminada al inicio del proceso
-- A) Quitar la reserva actual
		 DECLARE
          ReserveSpCrs2 CURSOR local static FOR
        SELECT
			  item
			, whse
			, loc
			, lot
			, qty_rsvd
			, qty_rsvd_conv
			, ref_num
			, ref_line
			, ref_release
			, u_m
			, ZWM_RefType
        FROM @Rsvd AS rsi
         

        OPEN ReserveSpCrs2
        WHILE @Severity = 0
        BEGIN
            FETCH ReserveSpCrs2 INTO
						  @RsiItem
						, @RsiWhse
						, @RsiLoc
						, @RsiLot
						, @RsiQtyRsvd
						, @RsiQtyRsvdConv
						, @RsiRefNum
						, @RsiRefLine
						, @RsiRefRelease
						, @RsiUM
						, @RsiZWMRefType

            IF @@FETCH_STATUS <> 0
					BREAK
                
                
             IF @RsiZWMRefType = 'O'
					SELECT @CustNum = cust_num 
						FROM co 
						WHERE co_num = @RsiRefNum 
                
				-- Reservar 
				EXECUTE @Severity = ZWM_InvRsvSp
					@RsiItem
				  ,@RsiRefNum
				  ,@RsiRefLine
				  ,@RsiRefRelease
				  ,@RsiQtyRsvdConv
				  ,@RsiWhse
				  ,@RsiUM
				  ,@CustNum
				  ,'reserve.p'
				  ,@QtyReserved OUTPUT
				  ,@Infobar OUTPUT
				  ,@ParmsSite
				  ,0				-- Reservar como NO fija
				  ,0
				  ,@RsiZWMRefType
			
			                
            
        END
        CLOSE ReserveSpCrs2
        DEALLOCATE ReserveSpCrs2


RETURN @Severity

GO


