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
