/****** Object:  StoredProcedure [dbo].[ZWM_CoItemTmpRsvdSp]    Script Date: 22/01/2015 11:35:52 a.m. ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ZWM_CoItemTmpRsvdSp]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ZWM_CoItemTmpRsvdSp]
GO

/****** Object:  StoredProcedure [dbo].[ZWM_CoItemTmpRsvdSp]    Script Date: 22/01/2015 11:35:52 a.m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/* $Header: /ApplicationDB/Stored Procedures/ZWM_CoItemTmpRsvdSp.sp 1    8/29/11 11:58a mfarias $  */
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
 *
 * $NoKeywords: $
 */
CREATE PROCEDURE [dbo].[ZWM_CoItemTmpRsvdSp] (
  @pCoNum     CoNumType
, @pCoLine    CoLineType
, @pCoRelease CoLineType
, @pQtyToReserve		QtyUnitType
, @pReserveTime		int			-- Cantidad de horas donde se reservara el material, si es NULL es infinito
, @pType					nchar(1)		-- D = Elimina Reserva, C = Genera o Actualiza reserva
, @pQtyReserved		QtyUnitType OUTPUT
, @Infobar        Infobar     OUTPUT
)
AS

DECLARE
  @Severity        INT
, @QtyReserved     QtyUnitType
, @ItmUM           UMType
, @CotCoNum        CoNumType
, @CotCoLine       CoLineType
, @CotCoRelease    CoLineType
, @CotItem			 ItemType
, @CotQtyToReserve QtyUnitType
, @CotWhse         WhseType
, @CotUM           UMType
, @CotDueDate      GenericDate
, @CoCustNum       CustNumType
, @CadCustName     NameType
, @RsiRowPointer   RowPointerType
, @RsiQtyRsvdConv  QtyUnitType
, @CoOrderDate     GenericDate
, @CotQtyOrdered   QtyUnitType
, @SessionID       RowPointerType
, @UseStat nvarchar(10)
, @ParmsSite SiteType
, @PostCount int

SET @Severity    = 0
SET @Infobar     = NULL
SET @QtyReserved = 0
select @ParmsSite = site from parms with (readuncommitted)


exec dbo.ApsSyncDeferSp @Infobar output
, @Context = 'ReserveSp'


SELECT
  @CotCoNum = cot.co_num
, @CotCoLine = cot.co_line
, @CotCoRelease  = cot.co_release
, @CotItem		= cot.item 
, @CotQtyToReserve  = ( cot.qty_ordered - cot.qty_rsvd - cot.qty_shipped)
, @CotWhse = cot.whse
, @CotUM = cot.u_m
, @CotDueDate =   cot.due_date
, @CotQtyOrdered = cot.qty_ordered
FROM coitem AS cot WITH (READUNCOMMITTED)
WHERE  cot.co_num =  @pCoNum
	AND cot.co_line = @pCoLine
	AND cot.co_release = @pCoRelease


IF @@ROWCOUNT <> 1
	RETURN @Severity
	
	
SET @CotQtyToReserve  = dbo.MinQty( @pQtyToReserve,@CotQtyToReserve) 

IF @pType = 'C'	-- Commit Reserve 
BEGIN
            EXEC @Severity = dbo.ZWM_InvRsvSp
              @CotItem
            , @CotCoNum
            , @CotCoLine
            , @CotCoRelease
            , @CotQtyToReserve
            , @CotWhse
            , @CotUM
            , @CoCustNum
            , 'reserve.p'
            , @QtyReserved OUTPUT
            , @Infobar     OUTPUT
            , @ParmsSite
            , 1				--  realizar reservar fijas (No hace reservas para item Clase C)
            , @pReserveTime 
			, null
            
			set @pQtyReserved = @QtyReserved

			IF @Severity <> 0
				Return @Severity
				
				     
				 IF ISNULL(@pReserveTime,0) > 0
				 BEGIN
					UPDATE rsvd_inv SET ZWM_ExpDate = DATEADD(HOUR,@pReserveTime,GetDate())
					WHERE ref_num = @pCoNum
						AND ref_line = @pCoLine 
						AND ref_release = @pCoRelease 
				 END
       			
END  
ELSE	
BEGIN	-- D=Delete Reserve
        DECLARE
          ReserveSpCrs2 CURSOR local static FOR
        SELECT
          rsi.RowPointer
        , rsi.qty_rsvd_conv
        FROM rsvd_inv AS rsi
        WHERE rsi.ref_num = @CotCoNum
        AND rsi.ref_line = @CotCoLine
        AND rsi.ref_release = @CotCoRelease

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

		set @pQtyReserved = 0
END -- @RsvdType <> 'R'


exec dbo.ApsSyncImmediateSp @Infobar output
, @Context = 'ReserveSp'


RETURN @Severity
GO

