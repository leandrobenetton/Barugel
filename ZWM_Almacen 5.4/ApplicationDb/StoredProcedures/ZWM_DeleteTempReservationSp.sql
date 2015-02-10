/****** Object:  StoredProcedure [dbo].[ZWM_DeleteTempReservationSp]    Script Date: 02/05/2015 18:49:49 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ZWM_DeleteTempReservationSp]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ZWM_DeleteTempReservationSp]
GO

/****** Object:  StoredProcedure [dbo].[ZWM_DeleteTempReservationSp]    Script Date: 02/05/2015 18:49:49 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[ZWM_DeleteTempReservationSp](
 @pWhseStart	WhseType = NULL
,@pWhseEnd		WhseType = NULL
,@pItemStart	ItemType = NULL
,@pItemEnd		ItemType = NULL
)
AS

SET @pItemStart = ISNULL(@pItemStart,dbo.LowCharacter())
SET @pItemEnd = ISNULL(@pItemEnd,dbo.HighCharacter())

SET @pWhseStart = ISNULL(@pWhseStart,dbo.LowCharacter())
SET @pWhseEnd = ISNULL(@pWhseEnd,dbo.HighCharacter())

DECLARE @TmpRsvd TABLE(
  rsvd_num	RsvdNumType
, item	ItemType
, whse	WhseType
, loc	LocType
, lot	LotType
, qty_rsvd	QtyUnitNoNegType
, qty_rsvd_conv	QtyUnitNoNegType
, ref_num	CoNumType
, ref_line	CoLineType
, ref_release	CoReleaseType
, u_m	UMType
, RowPointer	RowPointerType
, ZWM_Fixed	FlagNyType
, ZWM_RefType	RefTypeIJKOPRSTWType
, ZWM_ExpDate	DateTimeType
)

DECLARE
  @RsiRsvdNum	RsvdNumType
, @RsiItem	ItemType
, @RsiWhse	WhseType
, @RsiLoc		LocType
, @RsiLot		LotType
, @RsiQtyRsvd		 QtyUnitNoNegType
, @RsiQtyRsvdConv	 QtyUnitNoNegType
, @RsiRefNum		 CoNumType
, @RsiRefLine		 CoLineType
, @RsiRefRelease	 CoReleaseType
, @RsiUM			 UMType
, @RsiNoteExistsFlag FlagNyType
, @RsiRecordDate	CurrentDateType
, @RsiRowPointer	RowPointerType
, @RsiCreatedBy	UsernameType
, @RsiUpdatedBy	UsernameType
, @RsiCreateDate	CurrentDateType
, @RsiInWorkflow	FlagNyType
, @RsiImportDocId	ImportDocIdType
, @RsiZWMFixed	FlagNyType
, @RsiZWMRefType	RefTypeIJKOPRSTWType
, @RsiZWMExpDate	DateTimeType

DECLARE @Severity int
,@ConvFactor       UMConvFactorType
,@Infobar		   InfobarType
,@HighDate			DateType

DECLARE
@TaskNumber		TokenType
,@SeverityFlag	FlagNyType	= 0

DECLARE @Today DateType
SET @Today = dbo.GetSiteDate(GETDATE())

SET @Severity = 0
SET @HighDate = dbo.HighDate()

IF (SELECT count(*) FROM ActiveBGTasks where TaskName = 'ZWM_DeleteTempReservation') = 1
	SELECT @TaskNumber = TaskNumber FROM ActiveBGTasks where TaskName = 'ZWM_DeleteTempReservation'

INSERT INTO @TmpRsvd (
  rsvd_num	
, item	
, whse	
, loc	
, lot	
, qty_rsvd	
, qty_rsvd_conv	
, ref_num	
, ref_line	
, ref_release	
, u_m	
, RowPointer
, ZWM_Fixed	
, ZWM_RefType	
, ZWM_ExpDate		
)
SELECT rsvd_num	
, rsvd_inv.item	
, rsvd_inv.whse	
, rsvd_inv.loc	
, rsvd_inv.lot	
, rsvd_inv.qty_rsvd	
, rsvd_inv.qty_rsvd_conv	
, rsvd_inv.ref_num	
, rsvd_inv.ref_line	
, rsvd_inv.ref_release	
, rsvd_inv.u_m	
, rsvd_inv.RowPointer	
, ZWM_Fixed	
, ZWM_RefType	
, ZWM_ExpDate
  FROM rsvd_inv
  WHERE whse BETWEEN @pWhseStart AND @pWhseEnd 
	AND item BETWEEN @pItemStart AND @pItemEnd 
	AND ISNULL(ZWM_ExpDate,@HighDate ) <= @Today
	 
DECLARE RsvdCur CURSOR LOCAL STATIC FOR 
   SELECT  rsvd_num	
	    , qty_rsvd	
	    , u_m	
	    , RowPointer	
	 FROM @TmpRsvd

OPEN RsvdCur

WHILE 1=1
BEGIN	

   FETCH RsvdCur INTO

		@RsiRsvdNum	
	    , @RsiQtyRsvd		 
	    , @RsiUM
	    , @RsiRowPointer

	    IF @@FETCH_STATUS <> 0
		  BREAK	

	    SET @ConvFactor = dbo.Getumcf(@RsiUm,@RsiItem,NULL,'I')
		
	    EXECUTE @severity = UpdResvSp
					   1		    --  @DelRsvd
				    ,@RsiRowPointer
				    ,@RsiQtyRsvd	    -- @AdjQty
				    ,@ConvFactor	    
				    ,'FromBase'	    --@FROMBase
				    ,@Infobar OUTPUT
				    ,null
				    ,0
				    ,0

		IF @Severity <> 0
		BEGIN
			SET @SeverityFlag = 1
			INSERT INTO ZWM_DeleteRsvdLog ([TaskNumber], [Rsvd_Num], [Ref_RowPointer], [TaskErrorMsg])
			VALUES (@TaskNumber, @RsiRsvdNum, @RsiRowPointer, @Infobar)	
		END
		
END
CLOSE RsvdCur
DEALLOCATE RsvdCur

IF @SeverityFlag = 1
	SET @Severity = 1

RETURN @Severity

GO


