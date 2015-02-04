/****** Object:  StoredProcedure [dbo].[ZWM_RPT_CollectBoxSupplySp]    Script Date: 01/09/2015 14:57:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ZWM_RPT_CollectBoxSupplySp]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ZWM_RPT_CollectBoxSupplySp]
GO

/****** Object:  StoredProcedure [dbo].[ZWM_RPT_CollectBoxSupplySp]    Script Date: 01/09/2015 14:57:18 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[ZWM_RPT_CollectBoxSupplySp]
(
 @RefTypeOpt				nvarchar(4) = 'ROPT'
,@UmStocked					UmType = 'I'
,@DisplayHeader			FlagNyType = 0
,@WhseStarting				WhseType = NULL
,@WhseEnding				WhseType = NULL
,@ItemStarting				ItemType	= NULL
,@ItemEnding				ItemType = NULL
,@ProductCodeStarting	ProductCodeType = NULL
,@ProductCodeEnding		ProductCodeType = NULL
,@FamilyCodeStarting		FamilyCodeType  = NULL
,@FamilyCodeEnding		FamilyCodeType  = NULL
,@OrderStarting			CoNumType		 = NULL
,@OrderEnding				CoNumType		 = NULL
,@DueDateStarting			DateType			 = NULL
,@DueDateEnding			DateType			 = NULL
,@PickListStarting		PickListIdType	 = NULL
,@PickListEnding			PickListIdType	 = NULL
,@TrnNumStarting			TrnNumType		 = NULL
,@TrnNumEnding				TrnNumType		 = NULL
,@SchShipDateStarting	DateType			 = NULL
,@SchShipDateEnding		DateType			 = NULL
,@Post						FlagNyType		 = 0
)
AS 

-- Transaction management.
BEGIN TRANSACTION
SET XACT_ABORT ON

-- Set the isolation level specified for the background task
-- or use the system default.
IF dbo.GetIsolationLevel(N'ZWM_CollectBoxSupplyReport') = N'COMMITTED'
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
ELSE
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED


DECLARE
  @RptSessionID	RowPointerType
, @LowDate			DateType
, @HighDate			DateType
, @LowCharacter	HighLowCharType
, @HighCharacter	HighLowCharType


-- A session context is created so session variables can be used.
EXEC InitSessionContextSp
  @ContextName = 'ZWM_CollectBoxSupplyReport'
, @SessionID = @RptSessionID OUTPUT


-- Set the low and high values used for defaulting.
SET @LowDate = dbo.LowDate()
SET @HighDate = dbo.HighDate()
SET @LowCharacter = dbo.LowCharacter()
SET @HighCharacter = dbo.HighCharacter()

-- Replace NULL input parameters with Min or Max values.
SET @WhseStarting  = ISNULL(@WhseStarting,@LowCharacter)
SET @WhseEnding = ISNULL(@WhseEnding,@HighCharacter)

SET @ItemStarting = ISNULL(@ItemStarting,@LowCharacter)
SET @ItemEnding = ISNULL(@ItemEnding,@HighCharacter)

SET @ProductCodeStarting	= ISNULL(@ProductCodeStarting,@LowCharacter)
SET @ProductCodeEnding		= ISNULL(@ProductCodeEnding,@HighCharacter)

SET @FamilyCodeStarting		= ISNULL(@FamilyCodeStarting,@LowCharacter)
SET @FamilyCodeEnding		= ISNULL(@FamilyCodeEnding,@HighCharacter)

SET @OrderStarting			= ISNULL(dbo.ExpandKyByType('CoNumType',@OrderStarting),@LowCharacter)
SET @OrderEnding				= ISNULL(dbo.ExpandKyByType('CoNumType',@OrderEnding),@HighCharacter)

SET @DueDateStarting			= ISNULL(@DueDateStarting,@LowDate )		
SET @DueDateEnding			= ISNULL(@DueDateEnding,@HighDate )	
	
SET @PickListStarting		= ISNULL(@PickListStarting,0)	
SET @PickListEnding			= ISNULL(@PickListEnding,9999999)	

SET @TrnNumStarting			= ISNULL(dbo.ExpandKyByType('TrnNumType',@TrnNumStarting),@LowCharacter)
SET @TrnNumEnding				= ISNULL(dbo.ExpandKyByType('TrnNumType',@TrnNumEnding),@HighCharacter)

SET @SchShipDateStarting	= ISNULL(@SchShipDateStarting,@LowDate )			
SET @SchShipDateEnding		= ISNULL(@SchShipDateEnding,@HighDate )	

SET @UmStocked	= ISNULL(@UmStocked,'I')
DECLARE
  @CBItemItem				ItemType
, @CBItemWhse				WhseType
, @CBItemLoc				LocType
, @CBItemLocDescription DescriptionType 
, @CBItemReorderQty		QtyUnitType
, @CBItemMinQty			QtyUnitType
, @CBItemRowpointer	RowPointerType
, @ItemDescription	DescriptionType
, @ItemUM				UMType
, @ItemProductCode	ProductCodeType
, @ItemFamilyCode		FamilyCodeType
, @ItemReservable		ListYesNoType
, @ItemSerialTracked	ListYesNoType
, @ItemLotTracked		ListYesNoType
, @ItemUfUMStock1		UMType
, @ItemUfUMStock2		UMType
, @LocLoc				LocType
, @LocDescription		DescriptionType
, @LocLot				LotType
, @LocQtyOnHand		QtyUnitType
, @LocQtyRsvd			QtyUnitType
, @LocUfZone			DescriptionType
, @LocUfColBox			FlagNyType
--
, @CBItemRefType		RefTypeIJKPRTType
, @CBItemRefNum		JobPoProjReqTrnNumType
, @CBItemRefLineSuf	SuffixPoLineProjTaskReqTrnLineType
, @CBItemRefRelease	OperNumPoReleaseType
, @CBItemDueDate		DateType
, @CBItemQtyReq		QtyUnitNoNegType
, @CBItemQtyReqConv	QtyUnitNoNegType
, @CBItemUm				UmType
, @ReqItemUm					UmType
, @CBUmConvFactor		UmConvFactorType
, @Infobar				InfobarType

-- invpams
DECLARE 
  @InvParmsPackLoc	LocType
, @InvParmsShipLoc	LocType

SELECT  TOP 1
  @InvParmsPackLoc = pack_loc
, @InvParmsShipLoc = ship_loc
FROM invparms
WHERE parm_key = 0



SELECT 
  @CBItemItem					AS	CBItemItem
, @CBItemWhse					AS	CBItemWhse
, @CBItemLoc					AS	CBItemLoc
, @CBItemLocDescription		AS	CBItemLocDescription
, @CBItemReorderQty			AS	CBItemReorderQty
, @CBItemMinQty				AS	CBItemMinQty
, @CBItemQtyReqConv			AS CBItemQtyReqConv		-- Cantidad Requerida para surtir
, @CBItemRowpointer			AS	Rowpointer
, @CBItemUm				AS CBItemUm
, @ItemDescription	AS	CBItemDescription
, @ItemUM				AS	CBItemItemUM
, @ItemProductCode	AS	CBItemProductCode
, @ItemFamilyCode		AS	CBItemFamilyCode
, @ItemReservable		AS	CBItemReservable
, @ItemLotTracked		AS	CBItemLotTracked
, @ItemUfUMStock1		AS	CBItemUfUMStock1
, @ItemUfUMStock2		AS	CBItemUfUMStock2
, @LocLot				AS	CBLocLot
, @LocQtyOnHand		AS	CBLocQtyOnHand
, @LocQtyRsvd			AS	CBLocQtyRsvd
, @LocUfZone			AS	CBLocUfZone
INTO #RptSetCBItem 


WHERE 1=2
SELECT 
  @CBItemItem			AS	ReqItem
, @CBItemWhse			AS	ReqWhse
, @CBItemRefType		AS ReqRefType
, @CBItemRefNum		AS ReqRefNum
, @CBItemRefLineSuf	AS ReqRefLineSuf
, @CBItemRefRelease	AS ReqRefRelease
, @CBItemDueDate		AS ReqDueDate
, @CBItemQtyReqConv  AS ReqQtyReqConv
, @CBItemUm				AS ReqUm
, @LocLoc				AS	LocLoc
, @LocDescription		AS	LocDescription
, @LocLot				AS	LocLot
, @LocQtyOnHand		AS	LocQtyOnHand
, @LocQtyRsvd			AS	LocQtyRsvd
, @Infobar				AS ErrorMessage
INTO #RptSetReq 
WHERE 1=2


SELECT 
  @CBItemItem			AS	CBItemItem
, @CBItemWhse			AS	CBItemWhse
, @CBItemLoc			AS	CBItemLoc
, @CBItemReorderQty	AS	CBItemReorderQty
, @CBItemMinQty		AS	CBItemMinQty
, @CBItemRowpointer	AS	Rowpointer
, @CBItemRefType		AS CBItemRefType
, @CBItemRefNum		AS CBItemRefNum
, @CBItemRefLineSuf	AS CBItemRefLineSuf
, @CBItemRefRelease	AS CBItemRefRelease
, @CBItemDueDate		AS CBItemDueDate
, @CBItemQtyReqConv	AS CBItemQtyReq
, @CBItemUm				AS CBItemUm

INTO #CBItemRequirement
WHERE 1=2

-- Reorder Point
IF Charindex( 'R', @RefTypeOpt ) > 0
	 BEGIN
		  INSERT INTO #CBItemRequirement(
			  CBItemItem
			, CBItemWhse
			, CBItemLoc
			, CBItemReorderQty
			, CBItemMinQty
			, Rowpointer 
			, CBItemRefType
			, CBItemQtyReq
			, CBItemUm		
			)
		  SELECT
			  itc.Item
			, Whse
			, Loc
			, Reorder_Qty
			, Min_Qty
			, itc.Rowpointer
			, 'R'
			, Reorder_Qty
			, it.u_m 
					FROM Zwm_Item_Col_Box Itc 
					INNER JOIN item it on it.item = itc.item
					WHERE itc.Item BETWEEN @ItemStarting  AND @ItemEnding
					  AND Whse BETWEEN @WhseStarting  AND @WhseEnding
						AND ISNULL(it.product_code,'') BETWEEN @ProductCodeStarting AND @ProductCodeEnding
						AND ISNULL(it.family_code,'') BETWEEN  @FamilyCodeStarting AND @FamilyCodeEnding 
 

	 END

-- Customer Order	
IF Charindex( 'O', @RefTypeOpt ) > 0
	 BEGIN

		  INSERT INTO #CBItemRequirement(
			  CBItemItem
			, CBItemWhse
			, CBItemLoc
			, CBItemReorderQty
			, CBItemMinQty
			, Rowpointer 
			, CBItemRefType 
			, CBItemRefNum		
			, CBItemRefLineSuf	
			, CBItemRefRelease
			, CBItemDueDate	
			, CBItemQtyReq
			, CBItemUm 
			)
		  SELECT
			  Itc.Item
			, Itc.Whse
			, Itc.Loc
			, Itc.Reorder_Qty
			, Itc.Min_Qty
			, Itc.Rowpointer
			, 'O'
			, coi.co_num
			, coi.co_line
			, coi.co_release
			, coi.due_date 
			, coi.qty_ordered  
			, it.u_m 
					FROM Zwm_Item_Col_Box Itc
					INNER JOIN item it on it.item = itc.item
					INNER JOIN Coitem Coi ON Coi.Item = Itc.Item  AND Coi.Whse = Itc.Whse
					WHERE Itc.Item BETWEEN @ItemStarting AND @ItemEnding
					  AND Itc.Whse BETWEEN @WhseStarting AND @WhseEnding
						AND ISNULL(it.product_code,'') BETWEEN @ProductCodeStarting AND @ProductCodeEnding
						AND ISNULL(it.family_code,'') BETWEEN  @FamilyCodeStarting AND @FamilyCodeEnding 
					  AND Coi.Co_Num BETWEEN @OrderStarting AND @OrderEnding
					  AND Coi.Due_Date BETWEEN @DueDateStarting AND @DueDateEnding
	END	
	
-- Pick LIST Customer Order
IF Charindex( 'P', @RefTypeOpt ) > 0
	 BEGIN

		  INSERT INTO #CBItemRequirement(
			  CBItemItem
			, CBItemWhse
			, CBItemLoc
			, CBItemReorderQty
			, CBItemMinQty
			, Rowpointer
			, CBItemRefType 
			, CBItemRefNum		
			, CBItemRefLineSuf	
			, CBItemRefRelease
			, CBItemDueDate	
			, CBItemQtyReq
			, CBItemUm 
			 )
		  SELECT
			  Itc.Item
			, Itc.Whse
			, Itc.Loc
			, Itc.Reorder_Qty
			, Itc.Min_Qty
			, Itc.RowPointer
			, 'P'
			, pcki.ref_num
			, pcki.ref_line_suf 
			, pcki.ref_release 
			, coi.due_date 
			, pcki.qty_to_pick - pcki.qty_picked 
			, it.u_m 
					FROM Zwm_Item_Col_Box Itc
					INNER JOIN item it on it.item = itc.item
					INNER JOIN coitem coi on coi.item = itc.item AND coi.whse = coi.whse 
					INNER JOIN pick_list_ref  pcki ON pcki.ref_num  = coi.co_num 
															AND pcki.ref_line_suf = coi.ref_line_suf
															AND pcki.ref_release = coi.ref_release
															AND NOT EXISTS(SELECT 1 FROM #CBItemRequirement itr
																					WHERE itr.ref_type = 'O'
																					AND itr.ref_num = pcki.ref_num
																					AND itr.ref_line_suf = pcki.ref_line_suf
																					AND itr.ref_release = pcki.ref_release )
					INNER JOIN pick_list pckh ON pckh.pick_list_id = pcki.pick_list_id 
					
					WHERE Itc.Item BETWEEN @ItemStarting AND @ItemEnding
					  AND Itc.Whse BETWEEN @ItemStarting AND @ItemEnding
						AND ISNULL(it.product_code,'') BETWEEN @ProductCodeStarting AND @ProductCodeEnding
						AND ISNULL(it.family_code,'') BETWEEN  @FamilyCodeStarting AND @FamilyCodeEnding 
					  AND pcki.qty_to_pick > pcki.qty_picked			-- Solo lineas pendientes
					  AND pckh.status = 'O' -- Solo Open
					   
	 END	
	
-- Transfer Orders
IF Charindex( 'T', @RefTypeOpt ) > 0
	 BEGIN

		  INSERT INTO #CBItemRequirement(
			  CBItemItem
			, CBItemWhse
			, CBItemLoc
			, CBItemReorderQty
			, CBItemMinQty
			, Rowpointer
			, CBItemRefType 
			, CBItemRefNum		
			, CBItemRefLineSuf	
			, CBItemRefRelease
			, CBItemDueDate	
			, CBItemQtyReq
			, CBItemUm		
			 )
		  SELECT
			  Itc.Item
			, Itc.Whse
			, Itc.Loc
			, Itc.Reorder_Qty
			, Itc.Min_Qty
			, Itc.RowPointer
			, 'T'
			, trni.trn_num
			, trni.trn_line
			, 0
			, trni.sch_ship_date
			, trni.qty_req - trni.qty_received 
			, it.u_m 
					FROM Zwm_Item_Col_Box Itc
					INNER JOIN item it on it.item = itc.item
					INNER JOIN trnitem trni on trni.item = itc.item AND trni.from_whse = itc.whse 
					WHERE Itc.Item BETWEEN @ItemStarting AND @ItemEnding
					  AND Itc.Whse BETWEEN @ItemStarting AND @ItemEnding
					  AND it.product_code BETWEEN @ProductCodeStarting AND @ProductCodeEnding
					  AND it.family_code BETWEEN  @FamilyCodeStarting AND @FamilyCodeEnding 
					  AND trni.trn_num  BETWEEN @TrnNumStarting  AND @TrnNumEnding 
					  AND trni.sch_ship_date BETWEEN @SchShipDateStarting  AND @SchShipDateEnding 
					  AND trni.qty_req >= trni.qty_received		-- Transfer no embarcadas
	 END	
	

-- Hasta aqui ya  tenemos los items de CR que se deben procesar.	
DECLARE CBItemCur CURSOR LOCAL STATIC FOR
	SELECT 		  
			  CBItemItem
			, CBItemWhse
			, CBItemLoc
			, CBItemReorderQty
			, CBItemMinQty
			, Rowpointer 
			, CBItemRefType 
			, CBItemRefNum		
			, CBItemRefLineSuf	
			, CBItemRefRelease
			, CBItemDueDate	
			, CBItemQtyReq 
			, CBItemUm			
		FROM #CBItemRequirement
		
		
OPEN CBItemCur

WHILE 1=1
BEGIN

	FETCH CBItemCur INTO
			  @CBItemItem
			, @CBItemWhse
			, @CBItemLoc
			, @CBItemReorderQty
			, @CBItemMinQty
			, @CBItemRowpointer 
			, @CBItemRefType 
			, @CBItemRefNum		
			, @CBItemRefLineSuf	
			, @CBItemRefRelease
			, @CBItemDueDate	
			, @CBItemQtyReq 
			, @CBItemUm
			
			IF @@FETCH_STATUS <> 0
				BREAK
				
			 -- OBtener datos del Item
			 SELECT 
				  @ItemDescription = description
				, @ItemUM = u_m
				, @ItemProductCode = product_code
				, @ItemFamilyCode = family_code
				, @ItemSerialTracked = serial_tracked
				, @ItemLotTracked = lot_tracked
				, @ItemUfUMStock1 = ZWM_UMStock1
				, @ItemUfUMStock2 = ZWM_UMStock2
				FROM item
				WHERE item = @CBItemItem 

			-- Obtener los datos del inventario de la localización de CB
				IF @ItemLotTracked = 0
				BEGIN
				SELECT
					
				   @CBItemLocDescription = loc.description
				 , @locQtyOnHand = Qty_On_Hand
				 , @LocQtyRsvd = Qty_Rsvd
				 , @LocUfZone = loc.ZWM_Zone 
						 FROM Itemloc itl
						 INNER JOIN location loc on loc.loc = itl.loc 
						 WHERE itl.Item = @CBItemItem
							AND itl.Whse = @CBItemWhse
							AND itl.Loc = @CBItemLoc  
				END
				ELSE
				BEGIN
				SELECT TOP 1
					
				   @LocLot = itl.lot
				 , @CBItemLocDescription = loc.description
				 , @locQtyOnHand = Qty_On_Hand
				 , @LocQtyRsvd = Qty_Rsvd
				 , @LocUfZone = loc.ZWM_Zone 
						 FROM lot_loc itl
						 INNER JOIN location loc on loc.loc = itl.loc 
						 WHERE itl.Item = @CBItemItem
							AND itl.Whse = @CBItemWhse
							AND itl.Loc = @CBItemLoc  

				END
							
				-- Determina la Um a mostrar
				SET @ReqItemUm = CASE 
										WHEN @UmStocked = 'I'
											THEN @ItemUM 
											
										WHEN @UmStocked = '1'
											THEN @ItemUfUMStock1 
											
										WHEN @UmStocked = 2 
											THEN @ItemUfUMStock2
									END
									
									
					SET @infobar = NULL																		
					-- Comprar Req UM, vs Item Um
					IF @ReqItemUm <> @ItemUm
					BEGIN
					
							EXECUTE [GetumcfSp] 		@ReqItemUm
														  ,@CBItemItem
														  ,NULL
														  ,'I'
														  ,@CBUmConvFactor OUTPUT
														  ,@Infobar OUTPUT
														  
				
				
							EXECUTE [UomConvQtySp] 
												@CBItemQtyReq
											  ,@CBUmConvFactor
											  ,'From Base'
											  ,@CBItemQtyReqConv OUTPUT
											  ,@Infobar OUTPUT
					END
					ELSE
					BEGIN
					
							SET  @CBItemQtyReqConv = @CBItemQtyReq 
							SET @ReqItemUm = @ItemUM

					END	
				 
					-- Verificar si existe registro principal del Item
					IF NOT EXISTS( SELECT 1 
												From #RptSetCBItem 
												WHERE RowPointer = @CBItemRowPointer 
										)
							BEGIN	-- Insertarlo
							
								INSERT INTO #RptSetCBItem
								(
								   CBItemItem
								, 	CBItemWhse
								, 	CBItemLoc
								, 	CBItemLocDescription
								, 	CBItemReorderQty
								, 	CBItemMinQty
								,  CBItemQtyReqConv		-- Cantidad Requerida para surtir
								, 	Rowpointer
								,  CBItemUm
								, 	CBItemDescription	
								, 	CBItemItemUM	
								, 	CBItemProductCode
								, 	CBItemFamilyCode
								, 	CBItemReservable
								, 	CBItemLotTracked
								, 	CBItemUfUMStock1
								, 	CBItemUfUMStock2
								, 	CBLocLot
								, 	CBLocQtyOnHand
								, 	CBLocQtyRsvd
								, 	CBLocUfZone
								)
								SELECT 
								  @CBItemItem					
								, @CBItemWhse					
								, @CBItemLoc					
								, @CBItemLocDescription		
								, @CBItemReorderQty			
								, @CBItemMinQty				
								, ISNULL(@CBItemQtyReqConv,0)		
								, @CBItemRowpointer			
								, @ReqItemUm				
								, @ItemDescription	
								, @ItemUM				
								, @ItemProductCode	
								, @ItemFamilyCode		
								, @ItemReservable		
								, @ItemLotTracked		
								, @ItemUfUMStock1		
								, @ItemUfUMStock2		
								, @LocLot				
								, ISNULL(@LocQtyOnHand,0)		
								, ISNULL(@LocQtyRsvd,0)			
								, @LocUfZone		
							
							END
						ELSE	-- Update Qty Required
						BEGIN
								UPDATE #RptSetCBItem SET CBItemQtyReqConv =  ISNULL(CBItemQtyReqConv,0) +  ISNULL(@CBItemQtyReqConv ,0)
										WHERE RowPointer = @CBItemRowPointer
						END
									  
					INSERT INTO #RptSetReq  
						(
						  ReqItem
						, ReqWhse
						, ReqRefType	
						, ReqRefNum	
						, ReqRefLineSuf
						, ReqRefRelease
						, ReqDueDate	
						, ReqQtyReqConv
						, ReqUm				
						, ErrorMessage				
						)
					VALUES
						(
						  @CBItemItem	
						, @CBItemWhse	
						, @CBItemRefType	
						, @CBItemRefNum	
						, @CBItemRefLineSuf
						, @CBItemRefRelease
						, @CBItemDueDate	
						, @CBItemQtyReqConv 
						, @CBItemUm				
						, @Infobar	
						)								  
			
			
				

END
CLOSE CBItemCur
DEALLOCATE CBItemCur


-- Insertar los registrs de las ubicaciones / lotes para cada item pero es necesario convertirlos a la unidad de medida seleccionada
DECLARE ItemLocCur CURSOR LOCAL STATIC
	 FOR SELECT
			  CBItemItem
			, CBItemWhse
			, itloc.Loc
			, loc.description
			, null
			, SUM(itloc.Qty_on_hand)
			, SUM(itloc.qty_rsvd)
					FROM #RptSetCBItem Rs
						  INNER JOIN Item ON Item.Item = Rs.Cbitemitem
						  INNER JOIN Itemloc itloc ON itloc.Item = Rs.Cbitemitem AND itloc.Whse = rs.CBItemWhse
						  INNER JOIN location loc on loc.loc = itloc.loc

					WHERE Item.Lot_Tracked = 0
						and itloc.mrb_flag = 0
--							AND ISNULL(loc.ZWM_colbox,0) = 0
--							AND itloc.Loc NOT IN(  @InvParmsPackLoc, @InvParmsShipLoc )
							AND rs.CBItemQtyReqConv > rs.CBLocQtyOnHand
							AND rs.CBItemQtyReqConv > 0
					GROUP BY
				  CBItemItem
				, CBItemWhse
			, itloc.Loc
			, loc.description
		UNION ALL
		SELECT
		     CBItemItem
			, CBItemWhse
			, lloc.Loc
			, loc.description
			, lloc.lot
			, SUM(lloc.Qty_on_hand)
			, SUM(lloc.qty_rsvd)
					FROM #RptSetCBItem Rs
						  INNER JOIN Item ON Item.Item = Rs.Cbitemitem
						  INNER JOIN lot_loc lloc ON lloc.Item = Rs.Cbitemitem AND  lloc.whse = Cbitemwhse
						  INNER JOIN location loc on loc.loc = lloc.loc


					WHERE	Item.Lot_Tracked = 1
							and loc.mrb_flag = 0
--							AND ISNULL(loc.ZWM_colbox,0) = 0
--					AND lloc.Loc NOT IN(  @InvParmsPackLoc, @InvParmsShipLoc )
					AND rs.CBItemQtyReqConv > rs.CBLocQtyOnHand
					AND rs.CBItemQtyReqConv > 0
					GROUP BY
			  Cbitemitem
			, Cbitemwhse
			, lloc.Loc
			, loc.description
			, lloc.lot

			
OPEN ItemLocCur

WHILE 1 =1 
BEGIN
	FETCH ItemLocCur INTO 
			  @CBItemItem
			, @CBItemWhse
			, @LocLoc				
			, @LocDescription		
			, @LocLot				
			, @LocQtyOnHand		
			, @LocQtyRsvd			
	 			
			
			IF @@FETCH_STATUS <> 0
				BREAK
				
			 -- OBtener datos del Item
			 SELECT 
				  @ItemDescription = description
				, @ItemUM = u_m
				, @ItemProductCode = product_code
				, @ItemFamilyCode = family_code
				, @ItemSerialTracked = serial_tracked
				, @ItemLotTracked = lot_tracked
				, @ItemUfUMStock1 = ZWM_UMStock1
				, @ItemUfUMStock2 = ZWM_UMStock2
				FROM item
				WHERE item = @CBItemItem 
			
							
				-- Determina la Um a mostrar
				SET @CBItemUm = CASE 
										WHEN @UmStocked = 'I'
											THEN @ItemUM 
											
										WHEN @UmStocked = '1'
											THEN @ItemUfUMStock1 
											
										WHEN @UmStocked = 2 
											THEN @ItemUfUMStock2
									END
									
				SET @infobar = NULL									
									
					-- Obtener Factor de conversión
					EXECUTE [GetumcfSp] 		@ItemUM
												  ,@CBItemItem
												  ,NULL
												  ,'I'
												  ,@CBUmConvFactor OUTPUT
												  ,@Infobar OUTPUT
												  
		
		
					EXECUTE [UomConvQtySp] 
										@LocQtyOnHand
									  ,@CBUmConvFactor
									  ,'From Base'
									  ,@LocQtyOnHand OUTPUT
									  ,@Infobar OUTPUT
									  
					-- Inserta el detalle de ubicaciones				  
					INSERT INTO #RptSetReq 
						(
						  ReqItem	
						, ReqWhse	
						, ReqRefType	
						, LocLoc				
						, LocDescription		
						, LocLot				
						, LocQtyOnHand		
						, LocQtyRsvd			
						, ErrorMessage				
						)
					VALUES
						(
						  @CBItemItem	
						, @CBItemWhse	
						, 'L'	
						, @LocLoc				
						, @LocDescription		
						, @LocLot				
						, @LocQtyOnHand		
						, @LocQtyRsvd			
						, @Infobar	
						)								


END
CLOSE ItemLocCur
DEALLOCATE ItemLocCur

IF @Post = 1
BEGIN

	INSERT INTO zwm_mvtran
	(
	    [whse]
      ,[item]
      ,[to_loc]
      ,[to_lot]
      ,[stat]
      ,[trans_type]
      ,[trans_date]
      ,[qty_moved]
      ,[u_m]
      ,[exchange]
      ,[exchange_loc]
      ,[exchange_lot]
	)
	SELECT  
			  	CBItemWhse
			,  CBItemItem
			, 	CBItemLoc
			, 	CBLocLot
			,  'N'
			,  'M'		-- Exchange Trans
			, GetDate()
			,  CBItemQtyReqConv		-- Cantidad Requerida para surtir
			,  CBItemUm
			, 0		-- Default 0=No intercambiar loc/lot
			, 	CBItemLoc
			, 	CBLocLot
	FROM #RptSetCBItem
	WHERE CBItemQtyReqConv > 0
	
	-- Borrar registro previos
	DELETE zwm_col_box_req
	
	INSERT INTO zwm_col_box_req
	(
		 [item]
      ,[whse]
      ,[ref_type]
      ,[ref_num]
      ,[ref_line_suf]
      ,[ref_release]
      ,[due_date]
      ,[qty_req_conv]
      ,[u_m]
	)
		SELECT req.ReqItem
				,req.ReqWhse
				,req.ReqRefType
				,req.ReqRefNum
				,req.ReqRefLineSuf
				,req.ReqRefRelease
				,req.ReqDueDate
				,req.ReqQtyReqConv
				,req.ReqUm
			FROM #RptSetReq req
			WHERE ISNULL(req.ref_type,'') <> 'L' 
	
 
END
 
SELECT * from #RptSetCBItem rsi
INNER JOIN #RptSetReq rsr on	rsr.ReqItem = rsi.CBItemItem 
								AND	rsr.ReqWhse = rsi.CBItemWhse 
WHERE rsi.CBItemQtyReqConv > 0

 
COMMIT TRANSACTION


EXEC CloseSessionContextSp @SessionID = @RptSessionID


GO


