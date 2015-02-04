-- Create Class:	ZWM_trnitem
IF NOT EXISTS(Select 1 from user_class where class_name = N'ZWM_trnitem') 
 INSERT INTO user_class ( class_name, class_label, class_desc,
sys_has_fields, sys_has_tables, sys_apply, sys_delete ) VALUES ( N'ZWM_trnitem', NULL, NULL,          0,          0, NULL,          0 )

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

-- Create Table / Class xRef :	trnitem_mst, ZWM_trnitem
IF NOT EXISTS(Select 1 from table_class where table_name = N'trnitem_mst' AND class_name = N'ZWM_trnitem' )
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
							,N'ZWM_trnitem' 
							,NULL
							,         1 
							,NULL
							,         0
							,         0
							,         1
							) 
