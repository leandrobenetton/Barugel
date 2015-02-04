/****** Object:  StoredProcedure [dbo].[ZWM_ShipmentConformityTransferSp]    Script Date: 01/09/2015 14:59:23 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ZWM_ShipmentConformityTransferSp]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ZWM_ShipmentConformityTransferSp]
GO

/****** Object:  StoredProcedure [dbo].[ZWM_ShipmentConformityTransferSp]    Script Date: 01/09/2015 14:59:24 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[ZWM_ShipmentConformityTransferSp] (
	@ShipmentId					ShipmentIDType
	,@Infobar					InfobarType OUTPUT
)as

declare @Severity int
declare
  @SpTrnNum               TrnNumType
, @SpTransferFromSite     SiteType
, @SpTransferToSite       SiteType
, @SpTransferFobSite      SiteType
, @SpTransferFromWhse     WhseType
, @SpTransferToWhse       WhseType
, @SpTrnLine              TrnLineType
, @SpTQtyShipped          QtyUnitType
, @SpTUM                  UMType
, @SpTShipDate            DateType
, @SpTFromLoc             LocType
, @SpTFromLot             LotType
, @SpTToLot               LotType
, @SpTitle                LongListType
, @SpRemoteSiteLotProcess ListExistingCreateBothType
, @SpUseExistingSerials   ListYesNoType
, @SpSerialPrefix         SerialPrefixType
, @SpPReasonCode          ReasonCodeType
, @SpTImportDocId         ImportDocIdType
, @SpExportDocId          ExportDocIdType
, @SpMoveZeroCostItem     ListYesNoType                = NULL
, @SpEmpNum               EmpNumType                   = NULL
, @SpRecordDate           CurrentDateType              = NULL
, @SpShipLine			  ShipmentLineType

BEGIN TRANSACTION

DECLARE TrnCur CURSOR LOCAL STATIC FOR
SELECT
trn.trn_num, trn.from_site, trn.to_site, trn.fob_site, trn.from_whse, trn.to_whse,
trni.trn_line, 
(s.qty_shipped * (-1) ) --la cantidad a devolver
, trni.u_m, trni.ship_date
, trni.trn_loc, ll.lot, ll.lot
,sl.shipment_line
FROM transfer_mst trn
JOIN trnitem_mst trni
ON trn.trn_num = trni.trn_num
LEFT JOIN lot_loc_mst ll
ON ll.item = trni.item and ll.loc = trni.trn_loc and ll.whse = trn.from_whse
JOIN pick_list_ref_mst plr
ON plr.ref_num = trn.trn_num
JOIN shipment_line_mst sl
ON sl.pick_list_id = plr.pick_list_id
JOIN shipment_seq_mst s
ON s.shipment_id = sl.shipment_id
WHERE s.shipment_id = @ShipmentID

OPEN TrnCur
	WHILE 1 = 1
	BEGIN
		FETCH TrnCur INTO
	@SpTrnNum,@SpTransferFromSite,@SpTransferToSite,@SpTransferFobSite,@SpTransferFromWhse,@SpTransferToWhse,@SpTrnLine,@SpTQtyShipped, @SpTUM,@SpTShipDate,@SpTFromLoc,@SpTFromLot,@SpTToLot, @SpShipLine
	   IF @@FETCH_STATUS <> 0 BREAK

			exec @Severity = dbo.[TransferOrderShipSp]
			  @TrnNum						=	@SpTrnNum
			, @TransferFromSite				=	@SpTransferFromSite
			, @TransferToSite				=	@SpTransferToSite
			, @TransferFobSite				=	@SpTransferFobSite
			, @TransferFromWhse				=	@SpTransferFromWhse
			, @TransferToWhse				=	@SpTransferToWhse
			, @TrnLine						=	@SpTrnLine
			, @TQtyShipped					=	@SpTQtyShipped
			, @TUM							=	@SpTUM
			, @TShipDate					=	@SpTShipDate
			, @TFromLoc						=	@SpTFromLoc
			, @TFromLot						=	@SpTFromLot
			, @TToLot						=	@SpTToLot
			, @Title						=	null
			, @RemoteSiteLotProcess			=	null
			, @UseExistingSerials			=	null
			, @SerialPrefix					=	null
			, @PReasonCode					=	null
			, @Infobar						=	@Infobar OUTPUT
			, @TImportDocId					=	null
			, @ExportDocId					=	null
			, @MoveZeroCostItem				=	NULL
			, @EmpNum						=	null
			, @RecordDate                   =   null
	
	END

CLOSE TrnCur
DEALLOCATE TrnCur

COMMIT

UPDATE shipment_seq SET 
ZWM_UndeliveredQtyProcessed = (isnull(ZWM_UndeliveredQtyProcessed,0) + isnull(ZWM_UndeliveredQty,0)) 
WHERE shipment_id = @ShipmentId

UPDATE shipment_seq SET ZWM_UndeliveredQty = 0 where shipment_id = @ShipmentId

RETURN @Severity

GO


