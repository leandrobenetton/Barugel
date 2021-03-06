/****** Object:  StoredProcedure [dbo].[ZWM_RFRecConsReportSp]    Script Date: 01/20/2015 15:15:57 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ZWM_RFRecConsReportSp]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ZWM_RFRecConsReportSp]
GO

/****** Object:  StoredProcedure [dbo].[ZWM_RFRecConsReportSp]    Script Date: 01/20/2015 15:15:57 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[ZWM_RFRecConsReportSp] (
	@Site         SiteType
	,@IdRecCons	  ZwmIdRFConsType   = NULL
)
AS

 -- Check for existence of Generic External Touch Point routine (this section was generated by SpETPCodeSp and inserted by CallETPs.exe):
   IF OBJECT_ID(N'dbo.EXTGEN_ZWM_RFRecConsReportSp') IS NOT NULL
   BEGIN
      DECLARE @EXTGEN_SpName sysname
      SET @EXTGEN_SpName = N'dbo.EXTGEN_ZWM_RFRecConsReportSp'
      -- Invoke the ETP routine, passing in (and out) this routine's parameters:
      DECLARE @EXTGEN_Severity int
      EXEC @EXTGEN_Severity = @EXTGEN_SpName
		@Site
		,@IdRecCons
 
      -- ETP routine can RETURN 1 to signal that the remainder of this standard routine should now proceed:
      IF @EXTGEN_Severity <> 1
         RETURN @EXTGEN_Severity
   END
   -- End of Generic External Touch Point code.



DECLARE @Infobar InfobarType
,@BinVar varbinary(128)

SET @BinVar = CAST(@Site AS varbinary(128))
SET CONTEXT_INFO @BinVar

DECLARE @Severity int
SET @Severity = 0

------------------------------ SET NULLs
IF LEN(LTRIM(@IdRecCons)) = 0 SET @IdRecCons = NULL
------------------------------ SET NULLs

DECLARE @Table TABLE(
id			ZwmIdRFConsType
,item		ItemType
,qtyGrn		QtyUnitType
,qtyRec		QtyUnitType	
)
DECLARE 
@item ItemType
,@um	umtype
,@QtyGrn QtyUnitType
,@QtyRec QtyUnitType
,@QtyConverted         decimal(19,8)
,@UMItem               UMType
,@itemOld ItemType


DECLARE cur CURSOR LOCAL STATIC FOR
SELECT DISTINCT
poi.item, grn.u_m
FROM poitem poi
INNER JOIN grn_line grn
ON poi.po_num = grn.po_num AND poi.po_line = grn.po_line AND poi.po_release = grn.po_release
INNER JOIN zwm_tmp_rf_cons1_mst rf
ON grn.grn_num = rf.grn_num
WHERE rf.id_rec_cons = @IdRecCons
GROUP BY poi.item, grn.u_m

OPEN cur
WHILE 1=1
BEGIN
	
	FETCH cur INTO @item, @um
		
	SET @QtyRec = 0
	
	IF @@FETCH_STATUS <> 0 BREAK
	
	--cantidad por item de grn
	SELECT
	@QtyGrn = sum(grn.qty_shipped_conv)
	FROM grn_line grn
	INNER JOIN zwm_tmp_rf_cons1_mst rf
	ON grn.grn_num = rf.grn_num
	INNER JOIN poitem poi
	ON poi.po_num = grn.po_num and poi.po_line = grn.po_line and poi.po_release = grn.po_release
	WHERE rf.id_rec_cons = @IdRecCons 
	AND poi.item = @item
	AND grn.u_m = @um

	--convierte las cantidades a UM estandar
	SET @UMItem = ( SELECT u_m FROM item WHERE item = @item )
	
	EXEC @Severity = dbo.UMConvQtySp
		@UM               = @UMItem
	  , @Item             = @item
	  , @VendNum          = NULL
	  , @Area             = NULL
	  , @ConvertToBase    = 1
	  , @QtyToBeConverted = @QtyGrn 
	  , @OutQty           = @QtyConverted OUTPUT --devuelve la cantidad convertida
	  , @Infobar          = @Infobar      OUTPUT
	  
	SET @QtyGrn = @QtyConverted

	--cantidad por item recibida
	SELECT @QtyRec = sum(rec.qty_um_std + rec.qty_um_stk1 + rec.qty_um_stk2)
	FROM zwm_tmp_rf_rec_cons2_mst rec
	WHERE rec.id = @IdRecCons
	AND rec.item = @item
	GROUP BY rec.item

	IF @item = @itemOld
		UPDATE @Table SET qtyGrn = qtyGrn + @QtyGrn WHERE item = @item and id = @IdRecCons
	ELSE
		INSERT INTO @Table (id,item,qtyGrn,qtyRec) VALUES(@IdRecCons,@item,@QtyGrn,@QtyRec)
	
	SET @ItemOld = @Item
		
END
CLOSE cur
DEALLOCATE cur

SELECT 
GETDATE() as Fecha
,@IdRecCons as Id
,ta.item as Item
,i.description as ItemDesc
,ta.qtyGrn as QtyGrn
,ta.qtyRec as QtyRec
,(ta.qtyGrn - ta.qtyRec) as dif
,rec.cont_number as contenedor
,rec.lot as lote
,rec.qty_um_stk1_conv as cant_umstock1
,i.ZWM_UMStock1 as umstock1
,rec.qty_um_stk2_conv as cant_umstock2
,i.ZWM_UMStock2 as umstock2
,rec.qty_um_std as cant_umstd
,i.u_m as umstd
,rec.co_num as OrdenVenta
,rec.co_line as Linea
,rec.co_release as Release
FROM
@Table ta
INNER JOIN item i
ON ta.item = i.item
LEFT JOIN zwm_tmp_rf_rec_cons2_mst rec
ON rec.id = ta.id and rec.item = ta.item
WHERE ta.qtyGrn <> ta.qtyRec


IF @@ROWCOUNT = 0
	set @Infobar = 'GRN Sin diferencia'
GO


