
/****** Object:  StoredProcedure [dbo].[BAR_ZWM_RFItemBarCode1Sp]    Script Date: 10/29/2014 17:12:47 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BAR_ZWM_RFItemBarCode1Sp]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BAR_ZWM_RFItemBarCode1Sp]
GO

/****** Object:  StoredProcedure [dbo].[BAR_ZWM_RFItemBarCode1Sp]    Script Date: 10/29/2014 17:12:47 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[BAR_ZWM_RFItemBarCode1Sp] (
  @Site		         SiteType	
, @UserName			 UserNameType = NULL
, @FlagItemBarCode	 FlagNyType = 0	
, @ItemBarCode	     ZwmBarCodeType = NULL OUTPUT
, @ItemItem		     ItemType		 = NULL OUTPUT
, @ItemDescription	 DescriptionType = NULL OUTPUT
, @UMItem            UMType = NULL OUTPUT
, @UMStk1			 UMType = NULL OUTPUT
, @UMStk2			 UMType = NULL OUTPUT
, @LotTracked		 ListYesNoType = NULL OUTPUT
, @Lot_Attr_Group	 AttributeGroupType = NULL OUTPUT
, @tDA1				 AttributeLabelType = NULL OUTPUT
, @tDA2				 AttributeLabelType = NULL OUTPUT
, @tDA3				 AttributeLabelType = NULL OUTPUT
, @tDA4				 AttributeLabelType = NULL OUTPUT
, @tDA5				 AttributeLabelType = NULL OUTPUT
, @tDA6				 AttributeLabelType = NULL OUTPUT
, @tDA7				 AttributeLabelType = NULL OUTPUT
, @tDA8				 AttributeLabelType = NULL OUTPUT
, @tDA9				 AttributeLabelType = NULL OUTPUT
, @tDA10			 AttributeLabelType = NULL OUTPUT
, @tCA1				 AttributeLabelType = NULL OUTPUT
, @tCA2				 AttributeLabelType = NULL OUTPUT
, @tCA3				 AttributeLabelType = NULL OUTPUT
, @tCA4				 AttributeLabelType = NULL OUTPUT
, @tCA5				 AttributeLabelType = NULL OUTPUT
, @tCA6				 AttributeLabelType = NULL OUTPUT
, @tCA7				 AttributeLabelType = NULL OUTPUT
, @tCA8				 AttributeLabelType = NULL OUTPUT
, @tCA9				 AttributeLabelType = NULL OUTPUT
, @tCA10			 AttributeLabelType = NULL OUTPUT
, @UF_BarDesc1		 nvarchar(25) = NULL OUTPUT
, @UF_BarDesc2		 nvarchar(25) = NULL OUTPUT
, @UF_BarDesc3		 nvarchar(25) = NULL OUTPUT
, @IdRecCons		 ZwmIdRFConsType = NULL
, @RefCount			 int = NULL OUTPUT
, @Infobar           InfobarType = NULL OUTPUT
)
AS

DECLARE	@return_value int,
		@sessionId            RowPointerType

SET @UserName = isnull(@UserName,'sa')

EXEC	@return_value = [dbo].[InitSessionContextWithUserSp]
		@ContextName = 'ZWM',
		@UserName = @UserName,
		@SessionID = @SessionID OUTPUT,
		@Site = @Site

--Solo para implementacion Barugel Azulay
DECLARE @BAR FlagNyTYpe
IF (Select count(*) from zwm_parms where customer = 'BAR') > 0
	Set @BAR = 1 

DECLARE
 @Severity int
,@ItemRowPointer	RowPointerType

	
SET @Severity = 0
SET @ItemRowPointer =  NULL

   -- Check for existence of Generic External Touch Point routine (this section was generated by SpETPCodeSp and inserted by CallETPs.exe):
   IF OBJECT_ID(N'dbo.EXTGEN_BAR_ZWM_RFItemBarCode1Sp') IS NOT NULL
   BEGIN
      DECLARE @EXTGEN_SpName sysname
      SET @EXTGEN_SpName = N'dbo.EXTGEN_BAR_ZWM_RFItemBarCode1Sp'
      -- Invoke the ETP routine, passing in (and out) this routine's parameters:
      DECLARE @EXTGEN_Severity int
      EXEC @EXTGEN_Severity = @EXTGEN_SpName
			  @Site
			, @UserName
			, @FlagItemBarCode
		    , @ItemBarCode	     OUTPUT
			, @ItemItem		     OUTPUT
			, @ItemDescription	 OUTPUT
			, @UMItem            OUTPUT
			, @UMStk1			 OUTPUT
			, @UMStk2			 OUTPUT
			, @LotTracked		 OUTPUT
			, @Lot_Attr_Group	 OUTPUT
			, @tDA1				 OUTPUT
			, @tDA2				 OUTPUT
			, @tDA3				 OUTPUT
			, @tDA4				 OUTPUT
			, @tDA5				 OUTPUT
			, @tDA6				 OUTPUT
			, @tDA7				 OUTPUT
			, @tDA8				 OUTPUT
			, @tDA9				 OUTPUT
			, @tDA10			 OUTPUT
			, @tCA1				 OUTPUT
			, @tCA2				 OUTPUT
			, @tCA3				 OUTPUT
			, @tCA4				 OUTPUT
			, @tCA5				 OUTPUT
			, @tCA6				 OUTPUT
			, @tCA7				 OUTPUT
			, @tCA8				 OUTPUT
			, @tCA9				 OUTPUT
			, @tCA10			 OUTPUT
			, @UF_BarDesc1		 OUTPUT
			, @UF_BarDesc2		 OUTPUT
			, @UF_BarDesc3		 OUTPUT
			, @IdRecCons
			, @RefCount			 OUTPUT
			, @Infobar           OUTPUT
 
      -- ETP routine can RETURN 1 to signal that the remainder of this standard routine should now proceed:
      IF @EXTGEN_Severity <> 1
         RETURN @EXTGEN_Severity
   END
   -- End of Generic External Touch Point code.

IF (@ItemBarCode is not null)
BEGIN
	SELECT @ItemRowPointer = RowPointer
		  ,@ItemItem = item
		  ,@ItemBarCode = ZWM_BarCode
		  ,@ItemDescription = description
		  ,@UMItem = u_m
		  ,@UMStk1 = ZWM_UMStock1
		  ,@UMStk2 = ZWM_UMStock2
		  ,@LotTracked = lot_tracked
		  ,@Lot_Attr_Group = lot_attr_group
		  ,@UF_BarDesc1 = Uf_BarDesc1
		  ,@UF_BarDesc2 = Uf_BarDesc2
		  ,@UF_BarDesc3 = Uf_BarDesc3
	FROM item
	WHERE ZWM_BarCode = @ItemBarCode
END
ELSE IF (@ItemItem is not null) 
BEGIN
	SELECT @ItemRowPointer = RowPointer
		  ,@ItemItem = item
		  ,@ItemBarCode = ZWM_BarCode
		  ,@ItemDescription = description
		  ,@UMItem = u_m
		  ,@UMStk1 = ZWM_UMStock1
		  ,@UMStk2 = ZWM_UMStock2
		  ,@LotTracked = lot_tracked
		  ,@Lot_Attr_Group = lot_attr_group
		  ,@UF_BarDesc1 = Uf_BarDesc1
		  ,@UF_BarDesc2 = Uf_BarDesc2
		  ,@UF_BarDesc3 = Uf_BarDesc3
	FROM item
	WHERE Item = @ItemItem
END

--En caso que el c�digo de barras sea el art�culo (para permitir una sola lectura)
IF @ItemRowPointer IS NULL and @ItemBarCode is not null and @FlagItemBarCode = 1
BEGIN
	SELECT @ItemRowPointer = RowPointer
		  ,@ItemItem = item
		  ,@ItemBarCode = ZWM_BarCode
		  ,@ItemDescription = description
		  ,@UMItem = u_m
		  ,@UMStk1 = ZWM_UMStock1
		  ,@UMStk2 = ZWM_UMStock2
		  ,@LotTracked = lot_tracked
		  ,@Lot_Attr_Group = lot_attr_group
		  ,@UF_BarDesc1 = Uf_BarDesc1
		  ,@UF_BarDesc2 = Uf_BarDesc2
		  ,@UF_BarDesc3 = Uf_BarDesc3
	FROM item
	WHERE item = @ItemBarCode
END

IF @ItemRowPointer IS NULL
	BEGIN
		set @Severity = 16
		set @Infobar = 'El producto ' + isnull(@ItemBarCode,@ItemItem) + ' no existe'
	END


--En caso de atributos de Lote
If (@Lot_Attr_Group is not null)
BEGIN
	SELECT 
	@tDA1 = deci_attr1_label
	,@tDA2 = deci_attr2_label
	,@tDA3 = deci_attr3_label
	,@tDA4 = deci_attr4_label
	,@tDA5 = deci_attr5_label
	,@tDA6 = deci_attr6_label
	,@tDA7 = deci_attr7_label
	,@tDA8 = deci_attr8_label
	,@tDA9 = deci_attr9_label
	,@tDA10 = deci_attr10_label
	,@tCA1 = char_attr1_label
	,@tCA2 = char_attr2_label
	,@tCA3 = char_attr3_label
	,@tCA4 = char_attr4_label
	,@tCA5 = char_attr5_label
	,@tCA6 = char_attr6_label
	,@tCA7 = char_attr7_label
	,@tCA8 = char_attr8_label
	,@tCA9 = char_attr9_label
	,@tCA10 = char_attr10_label
	FROM attribute_group
	WHERE attr_group_class = 'LotAttr' and attr_group = @Lot_Attr_Group
END

-- En caso de IDRecCons (sirve para recepcion consolidada, verifica que exista el item en el id)
IF @IdRecCons is not null
BEGIN
	IF(SELECT top 1 id_rec_cons FROM zwm_tmp_rf_cons1_mst rf WHERE id_rec_cons = @IdRecCons)IS NULL
	BEGIN
		SET @Infobar = 'El Id '+ @IdRecCons + ' no existe'
		SET @Severity = 16
		RETURN @severity
	END
	ELSE
	IF(
	select top 1 poi.item 
	from poitem poi 
	join grn_line grn
	on poi.po_num = grn.po_num and poi.po_line = grn.po_line and poi.po_release = grn.po_release
	join zwm_tmp_rf_cons1_mst rf
	on grn.grn_num = rf.grn_num and grn.vend_num = rf.vend_num
	where rf.id_rec_cons = @IdRecCons
	and poi.item = @ItemItem
	)IS NULL
	BEGIN
		SET @Infobar = 'El Art�culo no se encuentra en el Id'
		SET @Severity = 16
		RETURN @severity
	END

	select @RefCount = Count(*)
	from poitem poi
	join grn_line grn
	on poi.po_num = grn.po_num and poi.po_line = grn.po_line and poi.po_release = grn.po_release
	join zwm_tmp_rf_cons1_mst rf
	on grn.grn_num = rf.grn_num and grn.vend_num = rf.vend_num
	where rf.id_rec_cons = @IdRecCons
	and poi.item = @ItemItem
END

EXEC dbo.CloseSessionContextSp @SessionID = @SessionID
	
RETURN @Severity


GO


