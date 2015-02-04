/****** Object:  StoredProcedure [dbo].[ZWM_FreightCalcSp]    Script Date: 11/07/2014 13:23:56 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ZWM_FreightCalcSp]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ZWM_FreightCalcSp]
GO

/****** Object:  StoredProcedure [dbo].[ZWM_FreightCalcSp]    Script Date: 11/07/2014 13:23:56 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ZWM_FreightCalcSp]
(
 @pCoNum	CoNumType
,@pFreightAmount	AmountType	= 0 OUTPUT
,@CurrCode     CurrCodeType = NULL
,@RateDate     GenericDate = NULL
,@Infobar	InfobarType = NULL OUTPUT
)
AS

BEGIN


--
DECLARE
  @CoCoNum	CoNumType
, @CoCustNum	CustNumType
, @CoCustSeq	CustSeqType
, @CoShipCode	ShipCodeType
, @CoFreight	AmountType
, @CoRowPointer	RowPointerType
, @CoZrtShipZip	PostalCodeType

-- coitem
, @CoItemCoLine			CoLineType
, @CoItemCoRelease		CoReleaseType
, @CoItemItem				ItemType
, @CoItemQtyOrdered		QtyUnitNoNegType
, @CoItemDisc				LineDiscType
, @CoItemPrice				CostPrcType
, @CoItemStat				CoitemStatusType
, @CoItemCustNum			CustNumType
, @CoItemCustSeq			CustSeqType
, @CoItemRowPointer		RowPointerType
, @CoItemZwmShipCode		ShipCodeType
, @CoItemDueDate			DateType
--
, @ZFreightWWeight				WeightType
, @ZFreightWDistance				QtyUnitNoNegType
, @ZCurFreightWFreightMinAmount	AmountType
, @ZCurFreightWFreightAmount		AmountType
, @ZFreightWFreightMinAmount	AmountType
, @ZFreightWFreightAmount		AmountType
, @ZFreightWUM						UMType
, @ZFreightWRowPointer			RowPointerType
--
, @ZWMParmsVolWeightUm	UMType
, @ZWMParmsRowPointer	RowPointerType
--
, @ZCurr				CurrCodeType
, @ZSystemCurr			CurrCodeType

DECLARE
 @Severity int
,@TItemPesoAforado	DECIMAL(11,3)
,@TItemUnitWeight		DECIMAL(11,3)
,@TLineWeight			DECIMAL(11,3)
,@TlineWeightTotal	DECIMAL(11,3)
,@TotalFreight			AmountType
,@TFreight				AmountType
,@TTFreight				AmountType
,@TCoZip				PostalCodeType
,@TLineZip				PostalCodeType

SET @Severity = 0
SET @TotalFreight = 0

SELECT  @ZWMParmsVolWeightUm	= um_weight	
		, @ZWMParmsRowPointer= RowPointer		
	FROM zwm_parms
	WHERE parm_key = 0 

SELECT @ZSystemCurr = curr_code from currparms

-- Procesar Orden agrupando por Cliente,Shipto, Ship Via, y Due Date
DECLARE FrtCur	CURSOR LOCAL STATIC  FOR
SELECT distinct co.co_num
		, co.ship_code
		, co.cust_num
		, co.cust_seq
		, coi.cust_num
		, coi.cust_seq
		, coi.zwm_ship_code
		, coi.due_date
FROM coitem coi
INNER JOIN co_mst co ON coi.co_num = co.co_num
WHERE co.co_num = @pCoNum
	GROUP BY
		 co.co_num
		, co.ship_code
		, co.cust_num
		, co.cust_seq
		, coi.cust_num
		, coi.cust_seq
		, coi.zwm_ship_code
		, coi.due_date

OPEN FrtCur

WHILE 1=1	-- Loop pricipal
BEGIN

		FETCH FrtCur INTO 
						 @CoCoNum
						, @CoShipCode
						, @CoCustNum
						, @CoCustSeq
						, @CoItemCustNum
						, @CoItemCustSeq
						, @CoItemZwmShipCode
						, @CoItemDueDate
		
		IF @@FETCH_STATUS <> 0
			BREAK
			
		
		SET @TFreight  = 0

			-- Solo calcular flete para l
			IF EXISTS(SELECT 1 FROM shipcode 
							WHERE ship_code = CASE 
														WHEN @CoItemZwmShipCode IS NOT NULL THEN @CoItemZwmShipCode
														ELSE @CoShipCode
														END
							AND shipcode.transport = 'F'
						)
			BEGIN
			
				--Modificado por LSH - 20141106				
				SET @TLineWeight = 0
				--Modificado por LSH - 20141106				
				
				DECLARE FrtItemCur CURSOR LOCAL STATIC  FOR
					SELECT coi.co_line
							,coi.co_release
							,coi.item
							,coi.qty_ordered
							,coi.price
							,coi.stat
							,coi.cust_num
							,coi.cust_seq
							,coi.RowPointer

						FROM coitem coi
							LEFT OUTER JOIN co ON co.co_num = coi.co_num	
						WHERE  co.co_num = @CoCoNum
							AND co.ship_code = @CoShipCode
							AND co.cust_num  = @CoCustNum
							AND co.cust_seq  = @CoCustSeq
							AND ISNULL(coi.cust_num,'')= ISNULL(@CoItemCustNum,'')
							AND ISNULL(coi.cust_seq,0) = ISNULL(@CoItemCustSeq,0)
							AND ISNULL(coi.zwm_ship_code,'') = ISNULL(@CoItemZwmShipCode,'')
							AND ISNULL(coi.due_date,dbo.LowDate()) = IsNULL(@CoItemDueDate,dbo.LowDate())
							
							
						OPEN FrtItemCur 
						
						WHILE 1=1
						BEGIN
						
								FETCH FrtItemCur INTO
													 @CoItemCoLine			
													, @CoItemCoRelease		
													, @CoItemItem				
													, @CoItemQtyOrdered		
													, @CoItemPrice				
													, @CoItemStat				
													, @CoItemCustNum			
													, @CoItemCustSeq			
													, @CoItemRowPointer	
													
								IF @@FETCH_STATUS <> 0
									BREAK
									
						
							-- Calcula el peso Aforado del item
							SET @TItemPesoAforado = dbo.ZWM_VolumetricWeight(@CoItemItem)
							--Modificado por LSH - 20141106, el peso unitario del articulo puede estar en cualquier um y se debe convertir a la misma de zwm_parms
							/*SELECT @TItemUnitWeight = item.unit_weight
									FROM item 
									WHERE item = @CoItemItem*/
							SET @TItemUnitWeight = dbo.ZWM_UnitWeight(@CoItemItem)
							--Modificado por LSH
									
							SET @TItemPesoAforado = ISNULL(@TItemPesoAforado,0)
							SET @TItemUnitWeight  = ISNULL(@TItemUnitWeight ,0)		
							
							--Modificado por LSH - 20141106
							/*-- Calcular el peso total, siempre tomando el mayor entre peso unitario y peso aforado
							SET @TLineWeight = 	@CoItemQtyOrdered * CASE WHEN @TItemPesoAforado > @TItemUnitWeight
																					THEN @TItemPesoAforado
																					ELSE @TItemUnitWeight */
							-- Calcular el peso total, siempre tomando el mayor entre peso unitario y peso aforado (sumado para todas las lineas de misma direccion y fecha)
							SET @TLineWeight = @TLineWeight + (@CoItemQtyOrdered * CASE WHEN @TItemPesoAforado > 
							@TItemUnitWeight THEN @TItemPesoAforado ELSE @TItemUnitWeight END)
							--Modificado por LSH - 20141106
											
						END
						CLOSE FrtItemCur
						DEALLOCATE FrtItemCur
						
			END
			
			-- Hasta aqui ya tenemos calculado el peso de todas las lineas para la misma entrega
			-- Determinar el monto de flete en base al peso acumulado y la distancia
			
			-- OBtener el Zip Code, desde la dirección de entrega a nivel linea o si no desde el ship to del pedido
			SELECT @TCoZip = zip
				FROM custaddr 
				WHERE cust_num = @CoCustNum AND cust_seq = @CoCustSeq
				
			IF @CoItemCustNum IS NOT NULL
			BEGIN
				SELECT @TLineZip = zip
					FROM custaddr 
					WHERE cust_num = @CoItemCustNum 
							AND cust_seq = @CoItemCustSeq 

				SET @TCoZip = @TLineZip 
			END
			
			-- Buscar la distancia para el zip code
			SELECT @ZFreightWDistance = zwm_zip.distance 
				FROM zwm_zip
				WHERE zip = @TCoZip
		
			SET @ZFreightWWeight = @TLineWeight

			SELECT TOP 1  
					@ZCurFreightWFreightMinAmount	= zfrt.freight_min_amount
					, @ZCurFreightWFreightAmount		= zfrt.freight_amount
					, @ZFreightWUM						= zfrt.u_m
					, @ZFreightWRowPointer			= zfrt.RowPointer
					, @ZCurr						= zfrt.currency
			FROM zwm_freight_weight zfrt
			WHERE  @ZFreightWWeight <= [weight]
					AND @ZFreightWDistance <= [distance]
			ORDER BY [weight] ,[distance]
						
			SET @ZCurr = ISNULL(@ZCurr,@ZSystemCurr)
			
			-- Calcular el flete si existe registro 
			IF @ZFreightWRowPointer IS NOT NULL
				BEGIN

					--Convierto la moneda de los valores
					EXEC @Severity = [dbo].[CurrCnvtSp]
						@CurrCode = @ZCurr,
						@FromDomestic = 0,
						@UseBuyRate = 1,
						@RoundResult = 0,
						@Date = @RateDate,
						@Infobar = @Infobar OUTPUT,
						@Amount1 = @ZCurFreightWFreightMinAmount,
						@Result1 = @ZFreightWFreightMinAmount OUTPUT,
						@Amount2 = @ZCurFreightWFreightAmount,
						@Result2 = @ZFreightWFreightAmount OUTPUT

					--Modificado por LSH, 20141106
					-- Obtener el precio en base a la um de zwm_parms
					SET @TTFreight = @ZFreightWWeight * (@ZFreightWFreightAmount *  
					dbo.ZWM_GetGlobalUmCfSp(@ZWMParmsVolWeightUm,@ZFreightWUM))	
					
					--Modificado por LSH, 20141106
					
					-- Aplicar el monto mayor entre el calculado y el monto mínimo	
					SET @TFreight =	CASE 
											WHEN @TTFreight <= @ZFreightWFreightMinAmount
												THEN @ZFreightWFreightMinAmount
											ELSE
												@TTFreight
											END
				END
				 
			

		SET @TotalFreight = @TotalFreight + ISNULL(@TFreight,0)
END			-- Loop Principal

--CLOSE FreightCalCur
--DEALLOCATE FreightCalCur
CLOSE FrtCur
DEALLOCATE FrtCur



END

IF @CurrCode is not NULL
BEGIN
	EXEC @Severity = [dbo].[CurrCnvtSp]
	@CurrCode = @CurrCode,
	@FromDomestic = 1,
	@UseBuyRate = 1,
	@RoundResult = 0,
	@Date = @RateDate,
	@Infobar = @Infobar OUTPUT,
	@Amount1 = @TotalFreight,
	@Result1 = @pFreightAmount OUTPUT
END
ELSE
	SET @pFreightAmount = @TotalFreight

RETURN @Severity
GO
