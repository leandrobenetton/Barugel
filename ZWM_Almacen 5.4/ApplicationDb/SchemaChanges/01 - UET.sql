-- Create Class:	ZWM_famcode
IF NOT EXISTS(Select 1 from user_class where class_name = N'ZWM_famcode') 
 INSERT INTO user_class ( class_name, class_label, class_desc,
sys_has_fields, sys_has_tables, sys_apply, sys_delete ) VALUES ( N'ZWM_famcode', NULL, NULL,          0,          0, NULL,          0 )

-- Create Field :	ZWM_VolCoefficient
IF NOT EXISTS(Select 1 from user_fld where fld_name = N'ZWM_VolCoefficient')
	INSERT INTO user_fld (   fld_name
							,fld_data_type
							,fld_initial
							,fld_decimals
							,fld_desc
							,sys_apply
							,sys_delete
							,fld_UDT
							,fld_prec
						 )
				 VALUES ( 
						N'ZWM_VolCoefficient'
						, N'decimal'
						, NULL
						,          2
						, NULL
						, NULL
						,          0
						, N'ZwmCoefVolWeightType'
						,          5 )

-- Create Class / Field xRef:	ZWM_famcode, ZWM_VolCoefficient
IF NOT EXISTS(Select 1 from user_class_fld where class_name = N'ZWM_famcode'AND fld_name = N'ZWM_VolCoefficient')
	INSERT INTO user_class_fld ( 
							 class_name
							,fld_name
							,sys_apply
							,sys_delete
								)
						VALUES (
								 N'ZWM_famcode'
								, N'ZWM_VolCoefficient'
								, NULL
								,          0 
								)

-- Create Table / Class xRef :	famcode_mst, ZWM_famcode
IF NOT EXISTS(Select 1 from table_class where table_name = N'famcode_mst' AND class_name = N'ZWM_famcode' )
	INSERT INTO table_class ( 
							 table_name
							,class_name
							,table_rule
							,extend_all_recs
							,sys_apply
							,sys_delete
							,allow_record_assoc
							,active )
					 VALUES ( 
							N'famcode_mst'
							,N'ZWM_famcode' 
							,NULL
							,         0 
							,NULL
							,         0
							,         0
							,         1
							) 
-- Create Class:	ZWM_grn_hdr
IF NOT EXISTS(Select 1 from user_class where class_name = N'ZWM_grn_hdr') 
 INSERT INTO user_class ( class_name, class_label, class_desc,
sys_has_fields, sys_has_tables, sys_apply, sys_delete ) VALUES ( N'ZWM_grn_hdr', NULL, N'Pack Number',          0,          0, NULL,          0 )

-- Create Field :	ZWM_packNumber
IF NOT EXISTS(Select 1 from user_fld where fld_name = N'ZWM_packNumber')
	INSERT INTO user_fld (   fld_name
							,fld_data_type
							,fld_initial
							,fld_decimals
							,fld_desc
							,sys_apply
							,sys_delete
							,fld_UDT
							,fld_prec
						 )
				 VALUES ( 
						N'ZWM_packNumber'
						, N'nvarchar'
						, NULL
						,          0
						, NULL
						, NULL
						,          0
						, N'VendInvoiceType'
						,         22 )

-- Create Class / Field xRef:	ZWM_grn_hdr, ZWM_packNumber
IF NOT EXISTS(Select 1 from user_class_fld where class_name = N'ZWM_grn_hdr'AND fld_name = N'ZWM_packNumber')
	INSERT INTO user_class_fld ( 
							 class_name
							,fld_name
							,sys_apply
							,sys_delete
								)
						VALUES (
								 N'ZWM_grn_hdr'
								, N'ZWM_packNumber'
								, NULL
								,          0 
								)

-- Create Table / Class xRef :	grn_hdr_mst, ZWM_grn_hdr
IF NOT EXISTS(Select 1 from table_class where table_name = N'grn_hdr_mst' AND class_name = N'ZWM_grn_hdr' )
	INSERT INTO table_class ( 
							 table_name
							,class_name
							,table_rule
							,extend_all_recs
							,sys_apply
							,sys_delete
							,allow_record_assoc
							,active )
					 VALUES ( 
							N'grn_hdr_mst'
							,N'ZWM_grn_hdr' 
							,NULL
							,         0 
							,NULL
							,         0
							,         0
							,         1
							) 
-- Create Class:	ZWM_item
IF NOT EXISTS(Select 1 from user_class where class_name = N'ZWM_item') 
 INSERT INTO user_class ( class_name, class_label, class_desc,
sys_has_fields, sys_has_tables, sys_apply, sys_delete ) VALUES ( N'ZWM_item', NULL, NULL,          0,          0, NULL,          0 )

-- Create Field :	ZWM_BarCode
IF NOT EXISTS(Select 1 from user_fld where fld_name = N'ZWM_BarCode')
	INSERT INTO user_fld (   fld_name
							,fld_data_type
							,fld_initial
							,fld_decimals
							,fld_desc
							,sys_apply
							,sys_delete
							,fld_UDT
							,fld_prec
						 )
				 VALUES ( 
						N'ZWM_BarCode'
						, N'nvarchar'
						, NULL
						,          0
						, NULL
						, NULL
						,          0
						, NULL
						,         40 )

-- Create Class / Field xRef:	ZWM_item, ZWM_BarCode
IF NOT EXISTS(Select 1 from user_class_fld where class_name = N'ZWM_item'AND fld_name = N'ZWM_BarCode')
	INSERT INTO user_class_fld ( 
							 class_name
							,fld_name
							,sys_apply
							,sys_delete
								)
						VALUES (
								 N'ZWM_item'
								, N'ZWM_BarCode'
								, NULL
								,          0 
								)

-- Create Field :	ZWM_PickQtyByTag
IF NOT EXISTS(Select 1 from user_fld where fld_name = N'ZWM_PickQtyByTag')
	INSERT INTO user_fld (   fld_name
							,fld_data_type
							,fld_initial
							,fld_decimals
							,fld_desc
							,sys_apply
							,sys_delete
							,fld_UDT
							,fld_prec
						 )
				 VALUES ( 
						N'ZWM_PickQtyByTag'
						, N'int'
						, NULL
						,          0
						, NULL
						, NULL
						,          0
						, N'UMQtyByTag'
						,         40 )

-- Create Class / Field xRef:	ZWM_item, ZWM_PickQtyByTag
IF NOT EXISTS(Select 1 from user_class_fld where class_name = N'ZWM_item'AND fld_name = N'ZWM_PickQtyByTag')
	INSERT INTO user_class_fld ( 
							 class_name
							,fld_name
							,sys_apply
							,sys_delete
								)
						VALUES (
								 N'ZWM_item'
								, N'ZWM_PickQtyByTag'
								, NULL
								,          0 
								)

-- Create Field :	ZWM_ReservationType
IF NOT EXISTS(Select 1 from user_fld where fld_name = N'ZWM_ReservationType')
	INSERT INTO user_fld (   fld_name
							,fld_data_type
							,fld_initial
							,fld_decimals
							,fld_desc
							,sys_apply
							,sys_delete
							,fld_UDT
							,fld_prec
						 )
				 VALUES ( 
						N'ZWM_ReservationType'
						, N'nvarchar'
						, NULL
						,          0
						, NULL
						, NULL
						,          0
						, N'GenericCodeType'
						,          6 )

-- Create Class / Field xRef:	ZWM_item, ZWM_ReservationType
IF NOT EXISTS(Select 1 from user_class_fld where class_name = N'ZWM_item'AND fld_name = N'ZWM_ReservationType')
	INSERT INTO user_class_fld ( 
							 class_name
							,fld_name
							,sys_apply
							,sys_delete
								)
						VALUES (
								 N'ZWM_item'
								, N'ZWM_ReservationType'
								, NULL
								,          0 
								)

-- Create Field :	ZWM_Stk1Depth
IF NOT EXISTS(Select 1 from user_fld where fld_name = N'ZWM_Stk1Depth')
	INSERT INTO user_fld (   fld_name
							,fld_data_type
							,fld_initial
							,fld_decimals
							,fld_desc
							,sys_apply
							,sys_delete
							,fld_UDT
							,fld_prec
						 )
				 VALUES ( 
						N'ZWM_Stk1Depth'
						, N'decimal'
						, NULL
						,          3
						, NULL
						, NULL
						,          0
						, N'ZwmStockMeasuresType'
						,         11 )

-- Create Class / Field xRef:	ZWM_item, ZWM_Stk1Depth
IF NOT EXISTS(Select 1 from user_class_fld where class_name = N'ZWM_item'AND fld_name = N'ZWM_Stk1Depth')
	INSERT INTO user_class_fld ( 
							 class_name
							,fld_name
							,sys_apply
							,sys_delete
								)
						VALUES (
								 N'ZWM_item'
								, N'ZWM_Stk1Depth'
								, NULL
								,          0 
								)

-- Create Field :	ZWM_Stk1Height
IF NOT EXISTS(Select 1 from user_fld where fld_name = N'ZWM_Stk1Height')
	INSERT INTO user_fld (   fld_name
							,fld_data_type
							,fld_initial
							,fld_decimals
							,fld_desc
							,sys_apply
							,sys_delete
							,fld_UDT
							,fld_prec
						 )
				 VALUES ( 
						N'ZWM_Stk1Height'
						, N'decimal'
						, NULL
						,          3
						, NULL
						, NULL
						,          0
						, N'ZwmStockMeasuresType'
						,         11 )

-- Create Class / Field xRef:	ZWM_item, ZWM_Stk1Height
IF NOT EXISTS(Select 1 from user_class_fld where class_name = N'ZWM_item'AND fld_name = N'ZWM_Stk1Height')
	INSERT INTO user_class_fld ( 
							 class_name
							,fld_name
							,sys_apply
							,sys_delete
								)
						VALUES (
								 N'ZWM_item'
								, N'ZWM_Stk1Height'
								, NULL
								,          0 
								)

-- Create Field :	ZWM_Stk1Vol
IF NOT EXISTS(Select 1 from user_fld where fld_name = N'ZWM_Stk1Vol')
	INSERT INTO user_fld (   fld_name
							,fld_data_type
							,fld_initial
							,fld_decimals
							,fld_desc
							,sys_apply
							,sys_delete
							,fld_UDT
							,fld_prec
						 )
				 VALUES ( 
						N'ZWM_Stk1Vol'
						, N'decimal'
						, NULL
						,          9
						, NULL
						, NULL
						,          0
						, N'ZwmVolumeWeightType'
						,         19 )

-- Create Class / Field xRef:	ZWM_item, ZWM_Stk1Vol
IF NOT EXISTS(Select 1 from user_class_fld where class_name = N'ZWM_item'AND fld_name = N'ZWM_Stk1Vol')
	INSERT INTO user_class_fld ( 
							 class_name
							,fld_name
							,sys_apply
							,sys_delete
								)
						VALUES (
								 N'ZWM_item'
								, N'ZWM_Stk1Vol'
								, NULL
								,          0 
								)

-- Create Field :	ZWM_Stk1Weight
IF NOT EXISTS(Select 1 from user_fld where fld_name = N'ZWM_Stk1Weight')
	INSERT INTO user_fld (   fld_name
							,fld_data_type
							,fld_initial
							,fld_decimals
							,fld_desc
							,sys_apply
							,sys_delete
							,fld_UDT
							,fld_prec
						 )
				 VALUES ( 
						N'ZWM_Stk1Weight'
						, N'decimal'
						, NULL
						,          2
						, NULL
						, NULL
						,          0
						, N'GenericCodeType'
						,          9 )

-- Create Class / Field xRef:	ZWM_item, ZWM_Stk1Weight
IF NOT EXISTS(Select 1 from user_class_fld where class_name = N'ZWM_item'AND fld_name = N'ZWM_Stk1Weight')
	INSERT INTO user_class_fld ( 
							 class_name
							,fld_name
							,sys_apply
							,sys_delete
								)
						VALUES (
								 N'ZWM_item'
								, N'ZWM_Stk1Weight'
								, NULL
								,          0 
								)

-- Create Field :	ZWM_Stk1Width
IF NOT EXISTS(Select 1 from user_fld where fld_name = N'ZWM_Stk1Width')
	INSERT INTO user_fld (   fld_name
							,fld_data_type
							,fld_initial
							,fld_decimals
							,fld_desc
							,sys_apply
							,sys_delete
							,fld_UDT
							,fld_prec
						 )
				 VALUES ( 
						N'ZWM_Stk1Width'
						, N'decimal'
						, NULL
						,          3
						, NULL
						, NULL
						,          0
						, N'ZwmStockMeasuresType'
						,         11 )

-- Create Class / Field xRef:	ZWM_item, ZWM_Stk1Width
IF NOT EXISTS(Select 1 from user_class_fld where class_name = N'ZWM_item'AND fld_name = N'ZWM_Stk1Width')
	INSERT INTO user_class_fld ( 
							 class_name
							,fld_name
							,sys_apply
							,sys_delete
								)
						VALUES (
								 N'ZWM_item'
								, N'ZWM_Stk1Width'
								, NULL
								,          0 
								)

-- Create Field :	ZWM_Stk2Depth
IF NOT EXISTS(Select 1 from user_fld where fld_name = N'ZWM_Stk2Depth')
	INSERT INTO user_fld (   fld_name
							,fld_data_type
							,fld_initial
							,fld_decimals
							,fld_desc
							,sys_apply
							,sys_delete
							,fld_UDT
							,fld_prec
						 )
				 VALUES ( 
						N'ZWM_Stk2Depth'
						, N'decimal'
						, NULL
						,          3
						, NULL
						, NULL
						,          0
						, N'ZwmStockMeasuresType'
						,         11 )

-- Create Class / Field xRef:	ZWM_item, ZWM_Stk2Depth
IF NOT EXISTS(Select 1 from user_class_fld where class_name = N'ZWM_item'AND fld_name = N'ZWM_Stk2Depth')
	INSERT INTO user_class_fld ( 
							 class_name
							,fld_name
							,sys_apply
							,sys_delete
								)
						VALUES (
								 N'ZWM_item'
								, N'ZWM_Stk2Depth'
								, NULL
								,          0 
								)

-- Create Field :	ZWM_Stk2Height
IF NOT EXISTS(Select 1 from user_fld where fld_name = N'ZWM_Stk2Height')
	INSERT INTO user_fld (   fld_name
							,fld_data_type
							,fld_initial
							,fld_decimals
							,fld_desc
							,sys_apply
							,sys_delete
							,fld_UDT
							,fld_prec
						 )
				 VALUES ( 
						N'ZWM_Stk2Height'
						, N'decimal'
						, NULL
						,          3
						, NULL
						, NULL
						,          0
						, N'ZwmStockMeasuresType'
						,         11 )

-- Create Class / Field xRef:	ZWM_item, ZWM_Stk2Height
IF NOT EXISTS(Select 1 from user_class_fld where class_name = N'ZWM_item'AND fld_name = N'ZWM_Stk2Height')
	INSERT INTO user_class_fld ( 
							 class_name
							,fld_name
							,sys_apply
							,sys_delete
								)
						VALUES (
								 N'ZWM_item'
								, N'ZWM_Stk2Height'
								, NULL
								,          0 
								)

-- Create Field :	ZWM_Stk2Vol
IF NOT EXISTS(Select 1 from user_fld where fld_name = N'ZWM_Stk2Vol')
	INSERT INTO user_fld (   fld_name
							,fld_data_type
							,fld_initial
							,fld_decimals
							,fld_desc
							,sys_apply
							,sys_delete
							,fld_UDT
							,fld_prec
						 )
				 VALUES ( 
						N'ZWM_Stk2Vol'
						, N'decimal'
						, NULL
						,          9
						, NULL
						, NULL
						,          0
						, N'ZwmVolumeWeightType'
						,         19 )

-- Create Class / Field xRef:	ZWM_item, ZWM_Stk2Vol
IF NOT EXISTS(Select 1 from user_class_fld where class_name = N'ZWM_item'AND fld_name = N'ZWM_Stk2Vol')
	INSERT INTO user_class_fld ( 
							 class_name
							,fld_name
							,sys_apply
							,sys_delete
								)
						VALUES (
								 N'ZWM_item'
								, N'ZWM_Stk2Vol'
								, NULL
								,          0 
								)

-- Create Field :	ZWM_Stk2Weight
IF NOT EXISTS(Select 1 from user_fld where fld_name = N'ZWM_Stk2Weight')
	INSERT INTO user_fld (   fld_name
							,fld_data_type
							,fld_initial
							,fld_decimals
							,fld_desc
							,sys_apply
							,sys_delete
							,fld_UDT
							,fld_prec
						 )
				 VALUES ( 
						N'ZWM_Stk2Weight'
						, N'decimal'
						, NULL
						,          2
						, NULL
						, NULL
						,          0
						, N'WeightType'
						,          9 )

-- Create Class / Field xRef:	ZWM_item, ZWM_Stk2Weight
IF NOT EXISTS(Select 1 from user_class_fld where class_name = N'ZWM_item'AND fld_name = N'ZWM_Stk2Weight')
	INSERT INTO user_class_fld ( 
							 class_name
							,fld_name
							,sys_apply
							,sys_delete
								)
						VALUES (
								 N'ZWM_item'
								, N'ZWM_Stk2Weight'
								, NULL
								,          0 
								)

-- Create Field :	ZWM_Stk2Width
IF NOT EXISTS(Select 1 from user_fld where fld_name = N'ZWM_Stk2Width')
	INSERT INTO user_fld (   fld_name
							,fld_data_type
							,fld_initial
							,fld_decimals
							,fld_desc
							,sys_apply
							,sys_delete
							,fld_UDT
							,fld_prec
						 )
				 VALUES ( 
						N'ZWM_Stk2Width'
						, N'decimal'
						, NULL
						,          3
						, NULL
						, NULL
						,          0
						, N'ZwmStockMeasuresType'
						,         11 )

-- Create Class / Field xRef:	ZWM_item, ZWM_Stk2Width
IF NOT EXISTS(Select 1 from user_class_fld where class_name = N'ZWM_item'AND fld_name = N'ZWM_Stk2Width')
	INSERT INTO user_class_fld ( 
							 class_name
							,fld_name
							,sys_apply
							,sys_delete
								)
						VALUES (
								 N'ZWM_item'
								, N'ZWM_Stk2Width'
								, NULL
								,          0 
								)

-- Create Field :	ZWM_UMQtyByTag
IF NOT EXISTS(Select 1 from user_fld where fld_name = N'ZWM_UMQtyByTag')
	INSERT INTO user_fld (   fld_name
							,fld_data_type
							,fld_initial
							,fld_decimals
							,fld_desc
							,sys_apply
							,sys_delete
							,fld_UDT
							,fld_prec
						 )
				 VALUES ( 
						N'ZWM_UMQtyByTag'
						, N'int'
						, NULL
						,          0
						, NULL
						, NULL
						,          0
						, N'UMQtyByTag'
						,          0 )

-- Create Class / Field xRef:	ZWM_item, ZWM_UMQtyByTag
IF NOT EXISTS(Select 1 from user_class_fld where class_name = N'ZWM_item'AND fld_name = N'ZWM_UMQtyByTag')
	INSERT INTO user_class_fld ( 
							 class_name
							,fld_name
							,sys_apply
							,sys_delete
								)
						VALUES (
								 N'ZWM_item'
								, N'ZWM_UMQtyByTag'
								, NULL
								,          0 
								)

-- Create Field :	ZWM_UMQtyByTagPallet
IF NOT EXISTS(Select 1 from user_fld where fld_name = N'ZWM_UMQtyByTagPallet')
	INSERT INTO user_fld (   fld_name
							,fld_data_type
							,fld_initial
							,fld_decimals
							,fld_desc
							,sys_apply
							,sys_delete
							,fld_UDT
							,fld_prec
						 )
				 VALUES ( 
						N'ZWM_UMQtyByTagPallet'
						, N'int'
						, NULL
						,          0
						, NULL
						, NULL
						,          0
						, N'UMQtyByTag'
						,          0 )

-- Create Class / Field xRef:	ZWM_item, ZWM_UMQtyByTagPallet
IF NOT EXISTS(Select 1 from user_class_fld where class_name = N'ZWM_item'AND fld_name = N'ZWM_UMQtyByTagPallet')
	INSERT INTO user_class_fld ( 
							 class_name
							,fld_name
							,sys_apply
							,sys_delete
								)
						VALUES (
								 N'ZWM_item'
								, N'ZWM_UMQtyByTagPallet'
								, NULL
								,          0 
								)

-- Create Field :	ZWM_UMStock1
IF NOT EXISTS(Select 1 from user_fld where fld_name = N'ZWM_UMStock1')
	INSERT INTO user_fld (   fld_name
							,fld_data_type
							,fld_initial
							,fld_decimals
							,fld_desc
							,sys_apply
							,sys_delete
							,fld_UDT
							,fld_prec
						 )
				 VALUES ( 
						N'ZWM_UMStock1'
						, N'nvarchar'
						, NULL
						,          0
						, NULL
						, NULL
						,          0
						, N'UMType'
						,          3 )

-- Create Class / Field xRef:	ZWM_item, ZWM_UMStock1
IF NOT EXISTS(Select 1 from user_class_fld where class_name = N'ZWM_item'AND fld_name = N'ZWM_UMStock1')
	INSERT INTO user_class_fld ( 
							 class_name
							,fld_name
							,sys_apply
							,sys_delete
								)
						VALUES (
								 N'ZWM_item'
								, N'ZWM_UMStock1'
								, NULL
								,          0 
								)

-- Create Field :	ZWM_UMStock2
IF NOT EXISTS(Select 1 from user_fld where fld_name = N'ZWM_UMStock2')
	INSERT INTO user_fld (   fld_name
							,fld_data_type
							,fld_initial
							,fld_decimals
							,fld_desc
							,sys_apply
							,sys_delete
							,fld_UDT
							,fld_prec
						 )
				 VALUES ( 
						N'ZWM_UMStock2'
						, N'nvarchar'
						, NULL
						,          0
						, NULL
						, NULL
						,          0
						, N'UMType'
						,          3 )

-- Create Class / Field xRef:	ZWM_item, ZWM_UMStock2
IF NOT EXISTS(Select 1 from user_class_fld where class_name = N'ZWM_item'AND fld_name = N'ZWM_UMStock2')
	INSERT INTO user_class_fld ( 
							 class_name
							,fld_name
							,sys_apply
							,sys_delete
								)
						VALUES (
								 N'ZWM_item'
								, N'ZWM_UMStock2'
								, NULL
								,          0 
								)

-- Create Field :	ZWM_VolCoefficient
IF NOT EXISTS(Select 1 from user_fld where fld_name = N'ZWM_VolCoefficient')
	INSERT INTO user_fld (   fld_name
							,fld_data_type
							,fld_initial
							,fld_decimals
							,fld_desc
							,sys_apply
							,sys_delete
							,fld_UDT
							,fld_prec
						 )
				 VALUES ( 
						N'ZWM_VolCoefficient'
						, N'decimal'
						, NULL
						,          2
						, NULL
						, NULL
						,          0
						, N'ZwmCoefVolWeightType'
						,          5 )

-- Create Class / Field xRef:	ZWM_item, ZWM_VolCoefficient
IF NOT EXISTS(Select 1 from user_class_fld where class_name = N'ZWM_item'AND fld_name = N'ZWM_VolCoefficient')
	INSERT INTO user_class_fld ( 
							 class_name
							,fld_name
							,sys_apply
							,sys_delete
								)
						VALUES (
								 N'ZWM_item'
								, N'ZWM_VolCoefficient'
								, NULL
								,          0 
								)

-- Create Field :	ZWM_VolumetricWeight
IF NOT EXISTS(Select 1 from user_fld where fld_name = N'ZWM_VolumetricWeight')
	INSERT INTO user_fld (   fld_name
							,fld_data_type
							,fld_initial
							,fld_decimals
							,fld_desc
							,sys_apply
							,sys_delete
							,fld_UDT
							,fld_prec
						 )
				 VALUES ( 
						N'ZWM_VolumetricWeight'
						, N'decimal'
						, NULL
						,          2
						, NULL
						, NULL
						,          0
						, N'WeightType'
						,          9 )

-- Create Class / Field xRef:	ZWM_item, ZWM_VolumetricWeight
IF NOT EXISTS(Select 1 from user_class_fld where class_name = N'ZWM_item'AND fld_name = N'ZWM_VolumetricWeight')
	INSERT INTO user_class_fld ( 
							 class_name
							,fld_name
							,sys_apply
							,sys_delete
								)
						VALUES (
								 N'ZWM_item'
								, N'ZWM_VolumetricWeight'
								, NULL
								,          0 
								)

-- Create Field :	ZWM_VolVol
IF NOT EXISTS(Select 1 from user_fld where fld_name = N'ZWM_VolVol')
	INSERT INTO user_fld (   fld_name
							,fld_data_type
							,fld_initial
							,fld_decimals
							,fld_desc
							,sys_apply
							,sys_delete
							,fld_UDT
							,fld_prec
						 )
				 VALUES ( 
						N'ZWM_VolVol'
						, N'decimal'
						, NULL
						,          9
						, NULL
						, NULL
						,          0
						, N'ZwmVolumeWeightType'
						,         19 )

-- Create Class / Field xRef:	ZWM_item, ZWM_VolVol
IF NOT EXISTS(Select 1 from user_class_fld where class_name = N'ZWM_item'AND fld_name = N'ZWM_VolVol')
	INSERT INTO user_class_fld ( 
							 class_name
							,fld_name
							,sys_apply
							,sys_delete
								)
						VALUES (
								 N'ZWM_item'
								, N'ZWM_VolVol'
								, NULL
								,          0 
								)

-- Create Table / Class xRef :	item_mst, ZWM_item
IF NOT EXISTS(Select 1 from table_class where table_name = N'item_mst' AND class_name = N'ZWM_item' )
	INSERT INTO table_class ( 
							 table_name
							,class_name
							,table_rule
							,extend_all_recs
							,sys_apply
							,sys_delete
							,allow_record_assoc
							,active )
					 VALUES ( 
							N'item_mst'
							,N'ZWM_item' 
							,NULL
							,         1 
							,NULL
							,         0
							,         0
							,         1
							) 
-- Create Class:	ZWM_location
IF NOT EXISTS(Select 1 from user_class where class_name = N'ZWM_location') 
 INSERT INTO user_class ( class_name, class_label, class_desc,
sys_has_fields, sys_has_tables, sys_apply, sys_delete ) VALUES ( N'ZWM_location', NULL, NULL,          0,          0, NULL,          0 )

-- Create Field :	ZWM_ColBox
IF NOT EXISTS(Select 1 from user_fld where fld_name = N'ZWM_ColBox')
	INSERT INTO user_fld (   fld_name
							,fld_data_type
							,fld_initial
							,fld_decimals
							,fld_desc
							,sys_apply
							,sys_delete
							,fld_UDT
							,fld_prec
						 )
				 VALUES ( 
						N'ZWM_ColBox'
						, N'tinyint'
						, NULL
						,          0
						, NULL
						, NULL
						,          0
						, N'FlagNyType'
						,          0 )

-- Create Class / Field xRef:	ZWM_location, ZWM_ColBox
IF NOT EXISTS(Select 1 from user_class_fld where class_name = N'ZWM_location'AND fld_name = N'ZWM_ColBox')
	INSERT INTO user_class_fld ( 
							 class_name
							,fld_name
							,sys_apply
							,sys_delete
								)
						VALUES (
								 N'ZWM_location'
								, N'ZWM_ColBox'
								, NULL
								,          0 
								)

-- Create Field :	ZWM_Depth
IF NOT EXISTS(Select 1 from user_fld where fld_name = N'ZWM_Depth')
	INSERT INTO user_fld (   fld_name
							,fld_data_type
							,fld_initial
							,fld_decimals
							,fld_desc
							,sys_apply
							,sys_delete
							,fld_UDT
							,fld_prec
						 )
				 VALUES ( 
						N'ZWM_Depth'
						, N'decimal'
						, NULL
						,          3
						, NULL
						, NULL
						,          0
						, N'ZwmStockMeasuresType'
						,         11 )

-- Create Class / Field xRef:	ZWM_location, ZWM_Depth
IF NOT EXISTS(Select 1 from user_class_fld where class_name = N'ZWM_location'AND fld_name = N'ZWM_Depth')
	INSERT INTO user_class_fld ( 
							 class_name
							,fld_name
							,sys_apply
							,sys_delete
								)
						VALUES (
								 N'ZWM_location'
								, N'ZWM_Depth'
								, NULL
								,          0 
								)

-- Create Field :	ZWM_Height
IF NOT EXISTS(Select 1 from user_fld where fld_name = N'ZWM_Height')
	INSERT INTO user_fld (   fld_name
							,fld_data_type
							,fld_initial
							,fld_decimals
							,fld_desc
							,sys_apply
							,sys_delete
							,fld_UDT
							,fld_prec
						 )
				 VALUES ( 
						N'ZWM_Height'
						, N'decimal'
						, NULL
						,          3
						, NULL
						, NULL
						,          0
						, N'ZwmStockMeasuresType'
						,         11 )

-- Create Class / Field xRef:	ZWM_location, ZWM_Height
IF NOT EXISTS(Select 1 from user_class_fld where class_name = N'ZWM_location'AND fld_name = N'ZWM_Height')
	INSERT INTO user_class_fld ( 
							 class_name
							,fld_name
							,sys_apply
							,sys_delete
								)
						VALUES (
								 N'ZWM_location'
								, N'ZWM_Height'
								, NULL
								,          0 
								)

-- Create Field :	ZWM_MaxWeight
IF NOT EXISTS(Select 1 from user_fld where fld_name = N'ZWM_MaxWeight')
	INSERT INTO user_fld (   fld_name
							,fld_data_type
							,fld_initial
							,fld_decimals
							,fld_desc
							,sys_apply
							,sys_delete
							,fld_UDT
							,fld_prec
						 )
				 VALUES ( 
						N'ZWM_MaxWeight'
						, N'decimal'
						, NULL
						,          2
						, NULL
						, NULL
						,          0
						, N'WeightType'
						,          9 )

-- Create Class / Field xRef:	ZWM_location, ZWM_MaxWeight
IF NOT EXISTS(Select 1 from user_class_fld where class_name = N'ZWM_location'AND fld_name = N'ZWM_MaxWeight')
	INSERT INTO user_class_fld ( 
							 class_name
							,fld_name
							,sys_apply
							,sys_delete
								)
						VALUES (
								 N'ZWM_location'
								, N'ZWM_MaxWeight'
								, NULL
								,          0 
								)

-- Create Field :	ZWM_MultLot
IF NOT EXISTS(Select 1 from user_fld where fld_name = N'ZWM_MultLot')
	INSERT INTO user_fld (   fld_name
							,fld_data_type
							,fld_initial
							,fld_decimals
							,fld_desc
							,sys_apply
							,sys_delete
							,fld_UDT
							,fld_prec
						 )
				 VALUES ( 
						N'ZWM_MultLot'
						, N'tinyint'
						, NULL
						,          0
						, NULL
						, NULL
						,          0
						, N'FlagNyType'
						,          0 )

-- Create Class / Field xRef:	ZWM_location, ZWM_MultLot
IF NOT EXISTS(Select 1 from user_class_fld where class_name = N'ZWM_location'AND fld_name = N'ZWM_MultLot')
	INSERT INTO user_class_fld ( 
							 class_name
							,fld_name
							,sys_apply
							,sys_delete
								)
						VALUES (
								 N'ZWM_location'
								, N'ZWM_MultLot'
								, NULL
								,          0 
								)

-- Create Field :	ZWM_MultProd
IF NOT EXISTS(Select 1 from user_fld where fld_name = N'ZWM_MultProd')
	INSERT INTO user_fld (   fld_name
							,fld_data_type
							,fld_initial
							,fld_decimals
							,fld_desc
							,sys_apply
							,sys_delete
							,fld_UDT
							,fld_prec
						 )
				 VALUES ( 
						N'ZWM_MultProd'
						, N'tinyint'
						, NULL
						,          0
						, NULL
						, NULL
						,          0
						, N'FlagNyType'
						,          0 )

-- Create Class / Field xRef:	ZWM_location, ZWM_MultProd
IF NOT EXISTS(Select 1 from user_class_fld where class_name = N'ZWM_location'AND fld_name = N'ZWM_MultProd')
	INSERT INTO user_class_fld ( 
							 class_name
							,fld_name
							,sys_apply
							,sys_delete
								)
						VALUES (
								 N'ZWM_location'
								, N'ZWM_MultProd'
								, NULL
								,          0 
								)

-- Create Field :	ZWM_Vol
IF NOT EXISTS(Select 1 from user_fld where fld_name = N'ZWM_Vol')
	INSERT INTO user_fld (   fld_name
							,fld_data_type
							,fld_initial
							,fld_decimals
							,fld_desc
							,sys_apply
							,sys_delete
							,fld_UDT
							,fld_prec
						 )
				 VALUES ( 
						N'ZWM_Vol'
						, N'decimal'
						, NULL
						,          9
						, NULL
						, NULL
						,          0
						, N'ZwmVolumeWeightType'
						,         19 )

-- Create Class / Field xRef:	ZWM_location, ZWM_Vol
IF NOT EXISTS(Select 1 from user_class_fld where class_name = N'ZWM_location'AND fld_name = N'ZWM_Vol')
	INSERT INTO user_class_fld ( 
							 class_name
							,fld_name
							,sys_apply
							,sys_delete
								)
						VALUES (
								 N'ZWM_location'
								, N'ZWM_Vol'
								, NULL
								,          0 
								)

-- Create Field :	ZWM_WeightUnit
IF NOT EXISTS(Select 1 from user_fld where fld_name = N'ZWM_WeightUnit')
	INSERT INTO user_fld (   fld_name
							,fld_data_type
							,fld_initial
							,fld_decimals
							,fld_desc
							,sys_apply
							,sys_delete
							,fld_UDT
							,fld_prec
						 )
				 VALUES ( 
						N'ZWM_WeightUnit'
						, N'nvarchar'
						, NULL
						,          0
						, NULL
						, NULL
						,          0
						, N'UMType'
						,          3 )

-- Create Class / Field xRef:	ZWM_location, ZWM_WeightUnit
IF NOT EXISTS(Select 1 from user_class_fld where class_name = N'ZWM_location'AND fld_name = N'ZWM_WeightUnit')
	INSERT INTO user_class_fld ( 
							 class_name
							,fld_name
							,sys_apply
							,sys_delete
								)
						VALUES (
								 N'ZWM_location'
								, N'ZWM_WeightUnit'
								, NULL
								,          0 
								)

-- Create Field :	ZWM_Width
IF NOT EXISTS(Select 1 from user_fld where fld_name = N'ZWM_Width')
	INSERT INTO user_fld (   fld_name
							,fld_data_type
							,fld_initial
							,fld_decimals
							,fld_desc
							,sys_apply
							,sys_delete
							,fld_UDT
							,fld_prec
						 )
				 VALUES ( 
						N'ZWM_Width'
						, N'decimal'
						, NULL
						,          3
						, NULL
						, NULL
						,          0
						, N'ZwmStockMeasuresType'
						,         11 )

-- Create Class / Field xRef:	ZWM_location, ZWM_Width
IF NOT EXISTS(Select 1 from user_class_fld where class_name = N'ZWM_location'AND fld_name = N'ZWM_Width')
	INSERT INTO user_class_fld ( 
							 class_name
							,fld_name
							,sys_apply
							,sys_delete
								)
						VALUES (
								 N'ZWM_location'
								, N'ZWM_Width'
								, NULL
								,          0 
								)

-- Create Field :	ZWM_Zone
IF NOT EXISTS(Select 1 from user_fld where fld_name = N'ZWM_Zone')
	INSERT INTO user_fld (   fld_name
							,fld_data_type
							,fld_initial
							,fld_decimals
							,fld_desc
							,sys_apply
							,sys_delete
							,fld_UDT
							,fld_prec
						 )
				 VALUES ( 
						N'ZWM_Zone'
						, N'nvarchar'
						, NULL
						,          0
						, NULL
						, NULL
						,          0
						, N'DescriptionType'
						,         40 )

-- Create Class / Field xRef:	ZWM_location, ZWM_Zone
IF NOT EXISTS(Select 1 from user_class_fld where class_name = N'ZWM_location'AND fld_name = N'ZWM_Zone')
	INSERT INTO user_class_fld ( 
							 class_name
							,fld_name
							,sys_apply
							,sys_delete
								)
						VALUES (
								 N'ZWM_location'
								, N'ZWM_Zone'
								, NULL
								,          0 
								)

-- Create Table / Class xRef :	location_mst, ZWM_location
IF NOT EXISTS(Select 1 from table_class where table_name = N'location_mst' AND class_name = N'ZWM_location' )
	INSERT INTO table_class ( 
							 table_name
							,class_name
							,table_rule
							,extend_all_recs
							,sys_apply
							,sys_delete
							,allow_record_assoc
							,active )
					 VALUES ( 
							N'location_mst'
							,N'ZWM_location' 
							,NULL
							,         0 
							,NULL
							,         0
							,         0
							,         1
							) 

-- Create Table / Class xRef :	location_mst_all, ZWM_location
IF NOT EXISTS(Select 1 from table_class where table_name = N'location_mst_all' AND class_name = N'ZWM_location' )
	INSERT INTO table_class ( 
							 table_name
							,class_name
							,table_rule
							,extend_all_recs
							,sys_apply
							,sys_delete
							,allow_record_assoc
							,active )
					 VALUES ( 
							N'location_mst_all'
							,N'ZWM_location' 
							,NULL
							,         0 
							,NULL
							,         0
							,         0
							,         1
							) 
-- Create Class:	ZWM_pick_list_loc
IF NOT EXISTS(Select 1 from user_class where class_name = N'ZWM_pick_list_loc') 
 INSERT INTO user_class ( class_name, class_label, class_desc,
sys_has_fields, sys_has_tables, sys_apply, sys_delete ) VALUES ( N'ZWM_pick_list_loc', NULL, NULL,          0,          0, NULL,          0 )

-- Create Field :	ZWM_printed
IF NOT EXISTS(Select 1 from user_fld where fld_name = N'ZWM_printed')
	INSERT INTO user_fld (   fld_name
							,fld_data_type
							,fld_initial
							,fld_decimals
							,fld_desc
							,sys_apply
							,sys_delete
							,fld_UDT
							,fld_prec
						 )
				 VALUES ( 
						N'ZWM_printed'
						, N'tinyint'
						, NULL
						,          0
						, NULL
						, NULL
						,          0
						, N'FlagNyType'
						,          0 )

-- Create Class / Field xRef:	ZWM_pick_list_loc, ZWM_printed
IF NOT EXISTS(Select 1 from user_class_fld where class_name = N'ZWM_pick_list_loc'AND fld_name = N'ZWM_printed')
	INSERT INTO user_class_fld ( 
							 class_name
							,fld_name
							,sys_apply
							,sys_delete
								)
						VALUES (
								 N'ZWM_pick_list_loc'
								, N'ZWM_printed'
								, NULL
								,          0 
								)

-- Create Table / Class xRef :	pick_list_loc_mst, ZWM_pick_list_loc
IF NOT EXISTS(Select 1 from table_class where table_name = N'pick_list_loc_mst' AND class_name = N'ZWM_pick_list_loc' )
	INSERT INTO table_class ( 
							 table_name
							,class_name
							,table_rule
							,extend_all_recs
							,sys_apply
							,sys_delete
							,allow_record_assoc
							,active )
					 VALUES ( 
							N'pick_list_loc_mst'
							,N'ZWM_pick_list_loc' 
							,NULL
							,         0 
							,NULL
							,         0
							,         0
							,         1
							) 
-- Create Class:	ZWM_PickList
IF NOT EXISTS(Select 1 from user_class where class_name = N'ZWM_PickList') 
 INSERT INTO user_class ( class_name, class_label, class_desc,
sys_has_fields, sys_has_tables, sys_apply, sys_delete ) VALUES ( N'ZWM_PickList', NULL, NULL,          0,          0, NULL,          0 )

-- Create Field :	ZWM_IdRouteMap
IF NOT EXISTS(Select 1 from user_fld where fld_name = N'ZWM_IdRouteMap')
	INSERT INTO user_fld (   fld_name
							,fld_data_type
							,fld_initial
							,fld_decimals
							,fld_desc
							,sys_apply
							,sys_delete
							,fld_UDT
							,fld_prec
						 )
				 VALUES ( 
						N'ZWM_IdRouteMap'
						, N'nvarchar'
						, NULL
						,          0
						, NULL
						, NULL
						,          0
						, N'ZwmIdRouteMapType'
						,         15 )

-- Create Class / Field xRef:	ZWM_PickList, ZWM_IdRouteMap
IF NOT EXISTS(Select 1 from user_class_fld where class_name = N'ZWM_PickList'AND fld_name = N'ZWM_IdRouteMap')
	INSERT INTO user_class_fld ( 
							 class_name
							,fld_name
							,sys_apply
							,sys_delete
								)
						VALUES (
								 N'ZWM_PickList'
								, N'ZWM_IdRouteMap'
								, NULL
								,          0 
								)

-- Create Field :	ZWM_RefType
IF NOT EXISTS(Select 1 from user_fld where fld_name = N'ZWM_RefType')
	INSERT INTO user_fld (   fld_name
							,fld_data_type
							,fld_initial
							,fld_decimals
							,fld_desc
							,sys_apply
							,sys_delete
							,fld_UDT
							,fld_prec
						 )
				 VALUES ( 
						N'ZWM_RefType'
						, N'nchar'
						, NULL
						,          0
						, NULL
						, NULL
						,          0
						, N'RefTypeIJKOPRSTWType'
						,          1 )

-- Create Class / Field xRef:	ZWM_PickList, ZWM_RefType
IF NOT EXISTS(Select 1 from user_class_fld where class_name = N'ZWM_PickList'AND fld_name = N'ZWM_RefType')
	INSERT INTO user_class_fld ( 
							 class_name
							,fld_name
							,sys_apply
							,sys_delete
								)
						VALUES (
								 N'ZWM_PickList'
								, N'ZWM_RefType'
								, NULL
								,          0 
								)

-- Create Field :	ZWM_ToWhse
IF NOT EXISTS(Select 1 from user_fld where fld_name = N'ZWM_ToWhse')
	INSERT INTO user_fld (   fld_name
							,fld_data_type
							,fld_initial
							,fld_decimals
							,fld_desc
							,sys_apply
							,sys_delete
							,fld_UDT
							,fld_prec
						 )
				 VALUES ( 
						N'ZWM_ToWhse'
						, N'nvarchar'
						, NULL
						,          0
						, NULL
						, NULL
						,          0
						, N'WhseType'
						,          4 )

-- Create Class / Field xRef:	ZWM_PickList, ZWM_ToWhse
IF NOT EXISTS(Select 1 from user_class_fld where class_name = N'ZWM_PickList'AND fld_name = N'ZWM_ToWhse')
	INSERT INTO user_class_fld ( 
							 class_name
							,fld_name
							,sys_apply
							,sys_delete
								)
						VALUES (
								 N'ZWM_PickList'
								, N'ZWM_ToWhse'
								, NULL
								,          0 
								)

-- Create Table / Class xRef :	pick_list_mst, ZWM_PickList
IF NOT EXISTS(Select 1 from table_class where table_name = N'pick_list_mst' AND class_name = N'ZWM_PickList' )
	INSERT INTO table_class ( 
							 table_name
							,class_name
							,table_rule
							,extend_all_recs
							,sys_apply
							,sys_delete
							,allow_record_assoc
							,active )
					 VALUES ( 
							N'pick_list_mst'
							,N'ZWM_PickList' 
							,NULL
							,         0 
							,NULL
							,         0
							,         0
							,         1
							) 
-- Create Class:	ZWM_poitem
IF NOT EXISTS(Select 1 from user_class where class_name = N'ZWM_poitem') 
 INSERT INTO user_class ( class_name, class_label, class_desc,
sys_has_fields, sys_has_tables, sys_apply, sys_delete ) VALUES ( N'ZWM_poitem', NULL, NULL,          0,          0, NULL,          0 )

-- Create Field :	ZWM_QtyShipped
IF NOT EXISTS(Select 1 from user_fld where fld_name = N'ZWM_QtyShipped')
	INSERT INTO user_fld (   fld_name
							,fld_data_type
							,fld_initial
							,fld_decimals
							,fld_desc
							,sys_apply
							,sys_delete
							,fld_UDT
							,fld_prec
						 )
				 VALUES ( 
						N'ZWM_QtyShipped'
						, N'decimal'
						, NULL
						,          8
						, NULL
						, NULL
						,          0
						, N'QtyUnitNoNegType'
						,         19 )

-- Create Class / Field xRef:	ZWM_poitem, ZWM_QtyShipped
IF NOT EXISTS(Select 1 from user_class_fld where class_name = N'ZWM_poitem'AND fld_name = N'ZWM_QtyShipped')
	INSERT INTO user_class_fld ( 
							 class_name
							,fld_name
							,sys_apply
							,sys_delete
								)
						VALUES (
								 N'ZWM_poitem'
								, N'ZWM_QtyShipped'
								, NULL
								,          0 
								)

-- Create Table / Class xRef :	poitem_mst, ZWM_poitem
IF NOT EXISTS(Select 1 from table_class where table_name = N'poitem_mst' AND class_name = N'ZWM_poitem' )
	INSERT INTO table_class ( 
							 table_name
							,class_name
							,table_rule
							,extend_all_recs
							,sys_apply
							,sys_delete
							,allow_record_assoc
							,active )
					 VALUES ( 
							N'poitem_mst'
							,N'ZWM_poitem' 
							,NULL
							,         0 
							,NULL
							,         0
							,         0
							,         1
							) 

-- Create Table / Class xRef :	poitem_mst_all, ZWM_poitem
IF NOT EXISTS(Select 1 from table_class where table_name = N'poitem_mst_all' AND class_name = N'ZWM_poitem' )
	INSERT INTO table_class ( 
							 table_name
							,class_name
							,table_rule
							,extend_all_recs
							,sys_apply
							,sys_delete
							,allow_record_assoc
							,active )
					 VALUES ( 
							N'poitem_mst_all'
							,N'ZWM_poitem' 
							,NULL
							,         0 
							,NULL
							,         0
							,         0
							,         1
							) 
-- Create Class:	ZWM_rsvd_inv
IF NOT EXISTS(Select 1 from user_class where class_name = N'ZWM_rsvd_inv') 
 INSERT INTO user_class ( class_name, class_label, class_desc,
sys_has_fields, sys_has_tables, sys_apply, sys_delete ) VALUES ( N'ZWM_rsvd_inv', NULL, NULL,          0,          0, NULL,          0 )

-- Create Field :	ZWM_ExpDate
IF NOT EXISTS(Select 1 from user_fld where fld_name = N'ZWM_ExpDate')
	INSERT INTO user_fld (   fld_name
							,fld_data_type
							,fld_initial
							,fld_decimals
							,fld_desc
							,sys_apply
							,sys_delete
							,fld_UDT
							,fld_prec
						 )
				 VALUES ( 
						N'ZWM_ExpDate'
						, N'datetime'
						, NULL
						,          0
						, NULL
						, NULL
						,          0
						, N'DateTimeType'
						,          0 )

-- Create Class / Field xRef:	ZWM_rsvd_inv, ZWM_ExpDate
IF NOT EXISTS(Select 1 from user_class_fld where class_name = N'ZWM_rsvd_inv'AND fld_name = N'ZWM_ExpDate')
	INSERT INTO user_class_fld ( 
							 class_name
							,fld_name
							,sys_apply
							,sys_delete
								)
						VALUES (
								 N'ZWM_rsvd_inv'
								, N'ZWM_ExpDate'
								, NULL
								,          0 
								)

-- Create Field :	ZWM_Fixed
IF NOT EXISTS(Select 1 from user_fld where fld_name = N'ZWM_Fixed')
	INSERT INTO user_fld (   fld_name
							,fld_data_type
							,fld_initial
							,fld_decimals
							,fld_desc
							,sys_apply
							,sys_delete
							,fld_UDT
							,fld_prec
						 )
				 VALUES ( 
						N'ZWM_Fixed'
						, N'tinyint'
						, N'0'
						,          0
						, N'Flag para indicar que la reserva no debe reasignarse / Reserva fija'
						, NULL
						,          0
						, N'FlagNyType'
						,          0 )

-- Create Class / Field xRef:	ZWM_rsvd_inv, ZWM_Fixed
IF NOT EXISTS(Select 1 from user_class_fld where class_name = N'ZWM_rsvd_inv'AND fld_name = N'ZWM_Fixed')
	INSERT INTO user_class_fld ( 
							 class_name
							,fld_name
							,sys_apply
							,sys_delete
								)
						VALUES (
								 N'ZWM_rsvd_inv'
								, N'ZWM_Fixed'
								, NULL
								,          0 
								)

-- Create Field :	ZWM_RefType
IF NOT EXISTS(Select 1 from user_fld where fld_name = N'ZWM_RefType')
	INSERT INTO user_fld (   fld_name
							,fld_data_type
							,fld_initial
							,fld_decimals
							,fld_desc
							,sys_apply
							,sys_delete
							,fld_UDT
							,fld_prec
						 )
				 VALUES ( 
						N'ZWM_RefType'
						, N'nchar'
						, NULL
						,          0
						, NULL
						, NULL
						,          0
						, N'RefTypeIJKOPRSTWType'
						,          1 )

-- Create Class / Field xRef:	ZWM_rsvd_inv, ZWM_RefType
IF NOT EXISTS(Select 1 from user_class_fld where class_name = N'ZWM_rsvd_inv'AND fld_name = N'ZWM_RefType')
	INSERT INTO user_class_fld ( 
							 class_name
							,fld_name
							,sys_apply
							,sys_delete
								)
						VALUES (
								 N'ZWM_rsvd_inv'
								, N'ZWM_RefType'
								, NULL
								,          0 
								)

-- Create Table / Class xRef :	rsvd_inv_mst, ZWM_rsvd_inv
IF NOT EXISTS(Select 1 from table_class where table_name = N'rsvd_inv_mst' AND class_name = N'ZWM_rsvd_inv' )
	INSERT INTO table_class ( 
							 table_name
							,class_name
							,table_rule
							,extend_all_recs
							,sys_apply
							,sys_delete
							,allow_record_assoc
							,active )
					 VALUES ( 
							N'rsvd_inv_mst'
							,N'ZWM_rsvd_inv' 
							,NULL
							,         0 
							,NULL
							,         0
							,         0
							,         1
							) 
-- Create Class:	ZWM_Shipment
IF NOT EXISTS(Select 1 from user_class where class_name = N'ZWM_Shipment') 
 INSERT INTO user_class ( class_name, class_label, class_desc,
sys_has_fields, sys_has_tables, sys_apply, sys_delete ) VALUES ( N'ZWM_Shipment', NULL, NULL,          0,          0, NULL,          0 )

-- Create Field :	ZWM_DefaultLoc
IF NOT EXISTS(Select 1 from user_fld where fld_name = N'ZWM_DefaultLoc')
	INSERT INTO user_fld (   fld_name
							,fld_data_type
							,fld_initial
							,fld_decimals
							,fld_desc
							,sys_apply
							,sys_delete
							,fld_UDT
							,fld_prec
						 )
				 VALUES ( 
						N'ZWM_DefaultLoc'
						, N'nvarchar'
						, NULL
						,          0
						, NULL
						, NULL
						,          0
						, N'LocType'
						,         15 )

-- Create Class / Field xRef:	ZWM_Shipment, ZWM_DefaultLoc
IF NOT EXISTS(Select 1 from user_class_fld where class_name = N'ZWM_Shipment'AND fld_name = N'ZWM_DefaultLoc')
	INSERT INTO user_class_fld ( 
							 class_name
							,fld_name
							,sys_apply
							,sys_delete
								)
						VALUES (
								 N'ZWM_Shipment'
								, N'ZWM_DefaultLoc'
								, NULL
								,          0 
								)

-- Create Field :	ZWM_Delivered
IF NOT EXISTS(Select 1 from user_fld where fld_name = N'ZWM_Delivered')
	INSERT INTO user_fld (   fld_name
							,fld_data_type
							,fld_initial
							,fld_decimals
							,fld_desc
							,sys_apply
							,sys_delete
							,fld_UDT
							,fld_prec
						 )
				 VALUES ( 
						N'ZWM_Delivered'
						, N'tinyint'
						, NULL
						,          0
						, NULL
						, NULL
						,          0
						, N'FlagNyType'
						,          0 )

-- Create Class / Field xRef:	ZWM_Shipment, ZWM_Delivered
IF NOT EXISTS(Select 1 from user_class_fld where class_name = N'ZWM_Shipment'AND fld_name = N'ZWM_Delivered')
	INSERT INTO user_class_fld ( 
							 class_name
							,fld_name
							,sys_apply
							,sys_delete
								)
						VALUES (
								 N'ZWM_Shipment'
								, N'ZWM_Delivered'
								, NULL
								,          0 
								)

-- Create Field :	ZWM_DeliveredDate
IF NOT EXISTS(Select 1 from user_fld where fld_name = N'ZWM_DeliveredDate')
	INSERT INTO user_fld (   fld_name
							,fld_data_type
							,fld_initial
							,fld_decimals
							,fld_desc
							,sys_apply
							,sys_delete
							,fld_UDT
							,fld_prec
						 )
				 VALUES ( 
						N'ZWM_DeliveredDate'
						, N'datetime'
						, NULL
						,          0
						, NULL
						, NULL
						,          0
						, N'CurrentDateType'
						,          0 )

-- Create Class / Field xRef:	ZWM_Shipment, ZWM_DeliveredDate
IF NOT EXISTS(Select 1 from user_class_fld where class_name = N'ZWM_Shipment'AND fld_name = N'ZWM_DeliveredDate')
	INSERT INTO user_class_fld ( 
							 class_name
							,fld_name
							,sys_apply
							,sys_delete
								)
						VALUES (
								 N'ZWM_Shipment'
								, N'ZWM_DeliveredDate'
								, NULL
								,          0 
								)

-- Create Field :	ZWM_DeliveredObs
IF NOT EXISTS(Select 1 from user_fld where fld_name = N'ZWM_DeliveredObs')
	INSERT INTO user_fld (   fld_name
							,fld_data_type
							,fld_initial
							,fld_decimals
							,fld_desc
							,sys_apply
							,sys_delete
							,fld_UDT
							,fld_prec
						 )
				 VALUES ( 
						N'ZWM_DeliveredObs'
						, N'nvarchar'
						, NULL
						,          0
						, NULL
						, NULL
						,          0
						, NULL
						,        200 )

-- Create Class / Field xRef:	ZWM_Shipment, ZWM_DeliveredObs
IF NOT EXISTS(Select 1 from user_class_fld where class_name = N'ZWM_Shipment'AND fld_name = N'ZWM_DeliveredObs')
	INSERT INTO user_class_fld ( 
							 class_name
							,fld_name
							,sys_apply
							,sys_delete
								)
						VALUES (
								 N'ZWM_Shipment'
								, N'ZWM_DeliveredObs'
								, NULL
								,          0 
								)

-- Create Field :	ZWM_ReasonCode
IF NOT EXISTS(Select 1 from user_fld where fld_name = N'ZWM_ReasonCode')
	INSERT INTO user_fld (   fld_name
							,fld_data_type
							,fld_initial
							,fld_decimals
							,fld_desc
							,sys_apply
							,sys_delete
							,fld_UDT
							,fld_prec
						 )
				 VALUES ( 
						N'ZWM_ReasonCode'
						, N'nvarchar'
						, NULL
						,          0
						, NULL
						, NULL
						,          0
						, N'ReasonCodeType'
						,          3 )

-- Create Class / Field xRef:	ZWM_Shipment, ZWM_ReasonCode
IF NOT EXISTS(Select 1 from user_class_fld where class_name = N'ZWM_Shipment'AND fld_name = N'ZWM_ReasonCode')
	INSERT INTO user_class_fld ( 
							 class_name
							,fld_name
							,sys_apply
							,sys_delete
								)
						VALUES (
								 N'ZWM_Shipment'
								, N'ZWM_ReasonCode'
								, NULL
								,          0 
								)

-- Create Field :	ZWM_ToWhse
IF NOT EXISTS(Select 1 from user_fld where fld_name = N'ZWM_ToWhse')
	INSERT INTO user_fld (   fld_name
							,fld_data_type
							,fld_initial
							,fld_decimals
							,fld_desc
							,sys_apply
							,sys_delete
							,fld_UDT
							,fld_prec
						 )
				 VALUES ( 
						N'ZWM_ToWhse'
						, N'nvarchar'
						, NULL
						,          0
						, NULL
						, NULL
						,          0
						, N'WhseType'
						,          4 )

-- Create Class / Field xRef:	ZWM_Shipment, ZWM_ToWhse
IF NOT EXISTS(Select 1 from user_class_fld where class_name = N'ZWM_Shipment'AND fld_name = N'ZWM_ToWhse')
	INSERT INTO user_class_fld ( 
							 class_name
							,fld_name
							,sys_apply
							,sys_delete
								)
						VALUES (
								 N'ZWM_Shipment'
								, N'ZWM_ToWhse'
								, NULL
								,          0 
								)

-- Create Table / Class xRef :	shipment_mst, ZWM_Shipment
IF NOT EXISTS(Select 1 from table_class where table_name = N'shipment_mst' AND class_name = N'ZWM_Shipment' )
	INSERT INTO table_class ( 
							 table_name
							,class_name
							,table_rule
							,extend_all_recs
							,sys_apply
							,sys_delete
							,allow_record_assoc
							,active )
					 VALUES ( 
							N'shipment_mst'
							,N'ZWM_Shipment' 
							,NULL
							,         0 
							,NULL
							,         0
							,         0
							,         1
							) 
-- Create Class:	ZWM_shipment_seq
IF NOT EXISTS(Select 1 from user_class where class_name = N'ZWM_shipment_seq') 
 INSERT INTO user_class ( class_name, class_label, class_desc,
sys_has_fields, sys_has_tables, sys_apply, sys_delete ) VALUES ( N'ZWM_shipment_seq', NULL, NULL,          0,          0, NULL,          0 )

-- Create Field :	ZWM_UndeliveredQty
IF NOT EXISTS(Select 1 from user_fld where fld_name = N'ZWM_UndeliveredQty')
	INSERT INTO user_fld (   fld_name
							,fld_data_type
							,fld_initial
							,fld_decimals
							,fld_desc
							,sys_apply
							,sys_delete
							,fld_UDT
							,fld_prec
						 )
				 VALUES ( 
						N'ZWM_UndeliveredQty'
						, N'decimal'
						, NULL
						,          8
						, NULL
						, NULL
						,          0
						, N'QtyUnitNoNegType'
						,         19 )

-- Create Class / Field xRef:	ZWM_shipment_seq, ZWM_UndeliveredQty
IF NOT EXISTS(Select 1 from user_class_fld where class_name = N'ZWM_shipment_seq'AND fld_name = N'ZWM_UndeliveredQty')
	INSERT INTO user_class_fld ( 
							 class_name
							,fld_name
							,sys_apply
							,sys_delete
								)
						VALUES (
								 N'ZWM_shipment_seq'
								, N'ZWM_UndeliveredQty'
								, NULL
								,          0 
								)

-- Create Field :	ZWM_UndeliveredQtyProcessed
IF NOT EXISTS(Select 1 from user_fld where fld_name = N'ZWM_UndeliveredQtyProcessed')
	INSERT INTO user_fld (   fld_name
							,fld_data_type
							,fld_initial
							,fld_decimals
							,fld_desc
							,sys_apply
							,sys_delete
							,fld_UDT
							,fld_prec
						 )
				 VALUES ( 
						N'ZWM_UndeliveredQtyProcessed'
						, N'decimal'
						, NULL
						,          8
						, NULL
						, NULL
						,          0
						, N'QtyUnitNoNegType'
						,         19 )

-- Create Class / Field xRef:	ZWM_shipment_seq, ZWM_UndeliveredQtyProcessed
IF NOT EXISTS(Select 1 from user_class_fld where class_name = N'ZWM_shipment_seq'AND fld_name = N'ZWM_UndeliveredQtyProcessed')
	INSERT INTO user_class_fld ( 
							 class_name
							,fld_name
							,sys_apply
							,sys_delete
								)
						VALUES (
								 N'ZWM_shipment_seq'
								, N'ZWM_UndeliveredQtyProcessed'
								, NULL
								,          0 
								)

-- Create Table / Class xRef :	shipment_seq_mst, ZWM_shipment_seq
IF NOT EXISTS(Select 1 from table_class where table_name = N'shipment_seq_mst' AND class_name = N'ZWM_shipment_seq' )
	INSERT INTO table_class ( 
							 table_name
							,class_name
							,table_rule
							,extend_all_recs
							,sys_apply
							,sys_delete
							,allow_record_assoc
							,active )
					 VALUES ( 
							N'shipment_seq_mst'
							,N'ZWM_shipment_seq' 
							,NULL
							,         0 
							,NULL
							,         0
							,         0
							,         1
							) 
-- Create Class:	ZWM_Trnitem
IF NOT EXISTS(Select 1 from user_class where class_name = N'ZWM_Trnitem') 
 INSERT INTO user_class ( class_name, class_label, class_desc,
sys_has_fields, sys_has_tables, sys_apply, sys_delete ) VALUES ( N'ZWM_Trnitem', NULL, NULL,          0,          0, NULL,          0 )

-- Create Field :	ZWM_PickListStatus
IF NOT EXISTS(Select 1 from user_fld where fld_name = N'ZWM_PickListStatus')
	INSERT INTO user_fld (   fld_name
							,fld_data_type
							,fld_initial
							,fld_decimals
							,fld_desc
							,sys_apply
							,sys_delete
							,fld_UDT
							,fld_prec
						 )
				 VALUES ( 
						N'ZWM_PickListStatus'
						, N'tinyint'
						, NULL
						,          0
						, NULL
						, NULL
						,          0
						, N'ListYesNoType'
						,          0 )

-- Create Class / Field xRef:	ZWM_Trnitem, ZWM_PickListStatus
IF NOT EXISTS(Select 1 from user_class_fld where class_name = N'ZWM_Trnitem'AND fld_name = N'ZWM_PickListStatus')
	INSERT INTO user_class_fld ( 
							 class_name
							,fld_name
							,sys_apply
							,sys_delete
								)
						VALUES (
								 N'ZWM_Trnitem'
								, N'ZWM_PickListStatus'
								, NULL
								,          0 
								)

-- Create Field :	ZWM_QtyRsvd
IF NOT EXISTS(Select 1 from user_fld where fld_name = N'ZWM_QtyRsvd')
	INSERT INTO user_fld (   fld_name
							,fld_data_type
							,fld_initial
							,fld_decimals
							,fld_desc
							,sys_apply
							,sys_delete
							,fld_UDT
							,fld_prec
						 )
				 VALUES ( 
						N'ZWM_QtyRsvd'
						, N'decimal'
						, N'0'
						,          8
						, NULL
						, NULL
						,          0
						, N'QtyUnitType'
						,         19 )

-- Create Class / Field xRef:	ZWM_trnitem, ZWM_QtyRsvd
IF NOT EXISTS(Select 1 from user_class_fld where class_name = N'ZWM_trnitem'AND fld_name = N'ZWM_QtyRsvd')
	INSERT INTO user_class_fld ( 
							 class_name
							,fld_name
							,sys_apply
							,sys_delete
								)
						VALUES (
								 N'ZWM_trnitem'
								, N'ZWM_QtyRsvd'
								, NULL
								,          0 
								)

-- Create Table / Class xRef :	trnitem_mst, ZWM_Trnitem
IF NOT EXISTS(Select 1 from table_class where table_name = N'trnitem_mst' AND class_name = N'ZWM_Trnitem' )
	INSERT INTO table_class ( 
							 table_name
							,class_name
							,table_rule
							,extend_all_recs
							,sys_apply
							,sys_delete
							,allow_record_assoc
							,active )
					 VALUES ( 
							N'trnitem_mst'
							,N'ZWM_Trnitem' 
							,NULL
							,         0 
							,NULL
							,         0
							,         0
							,         1
							) 
