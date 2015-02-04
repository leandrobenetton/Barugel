/****** Object:  StoredProcedure [dbo].[ZWM_PopulateTmpTransferPickListSp]    Script Date: 12/10/2014 09:41:45 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ZWM_PopulateTmpTransferPickListSp]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ZWM_PopulateTmpTransferPickListSp]
GO

/****** Object:  StoredProcedure [dbo].[ZWM_PopulateTmpTransferPickListSp]    Script Date: 12/10/2014 09:41:45 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Completa la tabla tmp_pick_list

CREATE PROCEDURE [dbo].[ZWM_PopulateTmpTransferPickListSp] (
	@ProcessId			RowPointerType
	,@PickGroup			PickGroupType
	,@PackLoc			LocType = null
	,@Whse				WhseType
	,@RefType			RefTypeIJOPRSTType
	,@TrnNum			EmpJobCoPoRmaProjPsTrnNumType
	,@TrnLine			CoLineSuffixPoLineProjTaskRmaTrnLineType
	,@DueDate			DateType
	,@Item				ItemType
	,@QtyToPick			QtyUnitNoNegType
	,@QtyRemaining		QtyUnitNoNegType
	,@Picker			UsernameType = NULL
	,@UM				UMType
	,@ToWhse			WhseType
	,@PickListId		PickListIDType = NULL
    ,@Infobar			InfobarType      = NULL OUTPUT
)
AS

select top 1 @PickListId = (pick_list_id+1) from pick_list where ZWM_RefType = 'T' order by pick_list_id desc
if @PickListId is null set @PickListId = 1
	
INSERT INTO tmp_pick_list 
([process_id]
,[pick_group]
,[pack_loc]
,[whse]
,[ref_type]
,[ref_num]
,[ref_line_suf]
,[due_date]
,[item]
,[qty_to_pick]
,[qty_remaining]
,[picker]
,[u_m]
,[pick_list_id]
,[ZWM_ToWhse])
VALUES
(@ProcessId
,@PickGroup
,@PackLoc			
,@Whse				
,@RefType			
,@TrnNum
,@TrnLine			
,@DueDate			
,@Item				
,@QtyToPick			
,@QtyRemaining		
,@Picker			
,@UM		
,@PickListId
,@ToWhse
)
GO


