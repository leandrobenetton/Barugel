/****** Object:  StoredProcedure [dbo].[BAR_Rpt_ShipmentPackingSlipSp]    Script Date: 11/13/2014 17:22:04 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BAR_Rpt_ShipmentPackingSlipSp]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[BAR_Rpt_ShipmentPackingSlipSp]
GO

/****** Object:  StoredProcedure [dbo].[BAR_Rpt_ShipmentPackingSlipSp]    Script Date: 11/13/2014 17:22:04 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[BAR_Rpt_ShipmentPackingSlipSp] (
  @PrintBlankPickupDate            FlagNyType          = NULL
, @IncludeSerialNumbers            ListYesNoType       = NULL
, @PrintShipmentSequenceText       FlagNyType          = NULL
, @DisplayShipmentSeqNotes         FlagNyType          = NULL
, @DisplayShipmentPackageNotes     FlagNyType          = NULL
, @MinShipNum                      ShipmentIDType      = NULL --Decimal(19,0)
, @MaxShipNum                      ShipmentIDType      = NULL --Decimal(19,0)
, @CustomerStarting                CustNumType         = NULL --nvarchar(7)
, @CustomerEnding                  CustNumType         = NULL
, @ShiptoStarting                  CustSeqType         = NULL
, @ShiptoEnding                    CustSeqType         = NULL
, @PickupDateStarting              DateType            = NULL
, @PickupDateEnding                DateType            = NULL
, @DateStartingOffset              DateOffsetType      = NULL
, @DateENDingOffset                DateOffsetType      = NULL
, @ShowInternal                    FlagNyType          = NULL
, @ShowExternal                    FlagNyType          = NULL
, @DisplayHeader                   FlagNyType          = NULL
, @UseProfile                      FlagNyType          = 0
, @LangCode                        LangCodeType        = NULL
, @pSite                           SiteType            = NULL
, @PrintDescription                ListYesNoType       = NULL
--nuevo
, @ZwmCONumStarting				   CoNumType		   = NULL
, @ZwmCONumEnding				   CoNumType		   = NULL
, @ZwmRouteStarting				   ZwmIdRouteMapType   = NULL
, @ZwmRouteEnding				   ZwmIdRouteMapType   = NULL
, @ZwmRePrint					   ListYesNoType       = NULL
) AS

select @ZwmRouteStarting,@ZwmRouteEnding

if @ShowInternal is null set @ShowInternal = 0
if @ShowExternal is null set @ShowExternal = 0
if @DisplayHeader is null set @DisplayHeader = 0
if @PrintDescription is null set @PrintDescription = 0
DECLARE
  @RptSessionID RowPointerType
EXEC dbo.InitSessionContextSp
  @ContextName = 'Rpt_ShipmentPackingSlipSp'
, @SessionID   = @RptSessionID OUTPUT
, @Site        = @pSite
DECLARE
  @Severity                   INT
, @UserParmSite               SiteType
, @Item                       ItemType
, @OfficeAddr                 LongAddress
, @OfficePhone                PhoneType
, @OfficeContact              ContactType
, @PackNum                    PackNumType
, @CoNum                      CoNumType
, @CustNum                    CustNumType
, @Weight                     WeightType
, @QtyPackages                PackagesType
, @PackDate                   DateType
, @ShipCode                   ShipCodeType
, @DropNum                    CustNumType
, @DropSeq                    DropSeqType
, @Whse                       WhseType
, @CoContact                  ContactType
, @CoLcrNum                   LcrNumType
, @CoCustPo                   CustPoType
, @CoType                     CoTypeType
, @CoOrderDate                DateType
, @BillToContact              ContactType
, @BillAddr                   LongAddress
, @ShipToContact              ContactType
, @ShipAddr                   LongAddress
, @ShipcodeDescription        DescriptionType
, @TCreditHold                ListYesNoType
, @CreditHoldMessage          InfobarType
, @CoLine                     CoLineType
, @CoRelease                  CoReleaseType
, @UM                         UMType
, @QtyOrdered                 QtyUnitType
, @QtyPacked                  QtyUnitType
, @QtyPackedConv              QtyUnitType
, @CoitemRowPointer           RowPointerType
, @QtyOrderedConv             QtyUnitType
, @CoitemCustItem             CustItemType
, @CoitemFeatStr              FeatStrType
, @FeatureDisplayQty          QtyPerType
, @FeatureDisplayUM           UMType
, @FeatureDisplayDesc         DescriptionType
, @FeatureDisplayStr          FeatStrType
, @CastCoRelease              nvarchar(5)
, @CastDropSeq                nvarchar(20)
, @ItemSerialTracked          ListYesNoType
, @ItemDescription            DescriptionType
, @MatltrackTrackNum          MatlTransNumType
, @TPackQty                   QtyUnitType
, @CoRowPointer               RowPointerType
, @CoNoteFlag                 FlagNyType
, @CoBlnRowPointer            RowPointerType
, @CoBlnNoteFlag              FlagNyType
, @CoitemNoteFlag             FlagNyType
, @CoitemShipSite             SiteType
, @InvparmsPlacesQtyCum       DecimalPlacesType
, @FirstRelease               CoReleaseType
, @MinSeq                     int
, @CoItemPrintKitComps        FlagNyType
, @KitItem                    ItemType
, @Component                  ItemType
, @CompDesc                   DescriptionType
, @CompQtyRequired            QtyUnitType
, @CompUM                     UMType
, @PrintPlanningItemMaterials ListYesNoType
, @PrintOrderText             ListYesNoType
, @PrintLineText              ListYesNoType
, @CoTypeRegular              FlagNyType
, @CoTypeBlanket              FlagNyType
, @Today                      DateType
, @IsThaiFlag                 int
DECLARE
  @QtyUnitFormat nvarchar(60)
, @PlacesQtyUnit tinyint
DECLARE @reportset TABLE (
  pack_num                          ShipmentIDType
, pack_date                         CurrentDateType
, whse                              WhseType
, co_num                            nvarchar(10)
, cust_num                          CustNumType
, weight                            TotalWeightType
, qty_packages                      PackagesType
, ship_code                         ShipCodeType
, carrier                           CarrierCodeType
, office_addr                       AddressType
, office_addr2                      AddressType
, office_addr3                      AddressType
, office_addr4                      AddressType
, office_city                       CityType
, office_state                      StateType
, office_zip                        PostalCodeType
, office_country                    CountyType
, office_contact                    ContactType
, office_phone                      PhoneType
, ship_contact                      ContactType
, ship_addr                         AddressType
, ship_addr2                        AddressType
, ship_addr3                        AddressType
, ship_addr4                        AddressType
, ship_city                         CityType
, ship_state                        StateType
, ship_zip                          PostalCodeType
, ship_country                      CountyType
, shipment_TH_fob_point             FOBType
, shipment_TH_item_category         TH_ItemCategoryType
, shipment_TH_from_shipping_port    TH_ShippingPortType
, shipment_TH_to_shipping_port      TH_ShippingPortType
, bill_contact                      ContactType
, bill_addr                         AddressType
, bill_addr2                        AddressType
, bill_addr3                        AddressType
, bill_addr4                        AddressType
, bill_city                         CityType
, bill_state                        StateType
, bill_zip                          PostalCodeType
, bill_country                      CountyType
, lcr_num                           nvarchar(20)
, credit_hold                       int
, cust_po                           nvarchar(22)
, co_line                           int
, co_release                        int
, item                              nvarchar(30)
, item_desc                         nvarchar(40)
, serial_num                        nvarchar(30)
, u_m                               UMType
, ship_rowpointer                   RowPointerType
, ship_package_rowpointer           uniqueidentifier
, ship_seq_rowpointer               uniqueidentifier
, qty_unit_format                   nvarchar(60)
, places_qty_unit                   tinyint
, shipment_id                       ShipmentIDType
, shipment_line                     ShipmentLineType
, shipment_seq                      ShipmentSequenceType
, qty_picked                        QtyUnitNoNegType
, package_id                        PackageIDType
, shipment_notes                    int
, shipmentSeq_notes                 int
, shipmentPackage_notes             int
, shipmentPackage_TH_carton_prefix  TH_CartonPrefixType
, shipmentPackage_TH_measurement    TH_MeasurementType
, shipmentPackage_TH_carton_size    TH_CartonSizeType
, cust_seq                          CustSeqType
, from_CompanyName                  NameType
, ship_CompanyName                  NameType
, bill_CompanyName                  NameType
, lot                               LotType
, contact                           ContactType
, OfficeLongAddr                    LongAddress
, BillToLongAddr                    LongAddress
, ShipToLongAddr                    LongAddress
)
declare @Features table (
  JobrouteJob nvarchar(20)
, JobrouteSuffix int
, JobrouteOperNum int
, FeatureDisplayQty decimal(25,8)
, FeatureDisplayUM nvarchar(10)
, FeatureDisplayDesc nvarchar(60)
, FeatureDisplayStr nvarchar(60)
, CoitemAllRowPointer uniqueidentifier
, seq int identity
)
DECLARE @AllExPickupDate    FlagNyType
---SETS
SET @Severity               = 0
SET @MinShipNum             = ISNULL(@MinShipNum, dbo.LowInt())
SET @MaxShipNum             = ISNULL(@MaxShipNum, dbo.HighInt())
SET @CustomerStarting       = ISNULL(@CustomerStarting, dbo.LowCharacter())
SET @CustomerEnding         = ISNULL(@CustomerEnding, dbo.HighCharacter())
SET @ShiptoStarting         = ISNULL(@ShiptoStarting, dbo.LowInt())
SET @ShiptoEnding           = ISNULL(@ShiptoEnding, dbo.HighInt())
SET @AllExPickupDate  = CASE WHEN @PickupDateStarting IS NULL AND @PickupDateEnding IS NULL THEN 1 ELSE 0 END
EXEC dbo.ApplyDateOffsetSp @PickupDateStarting OUTPUT, @DateStartingOffset, 0
EXEC dbo.ApplyDateOffsetSp @PickupDateEnding   OUTPUT, @DateENDingOffset, 1

   -- Check for existence of Generic External Touch Point routine (this section was generated by SpETPCodeSp and inserted by CallETPs.exe):
   IF OBJECT_ID(N'dbo.EXTGEN_Rpt_ShipmentPackingSlipSp') IS NOT NULL
   BEGIN
      DECLARE @EXTGEN_SpName sysname
      SET @EXTGEN_SpName = N'dbo.EXTGEN_Rpt_ShipmentPackingSlipSp'
      -- Invoke the ETP routine, passing in (and out) this routine's parameters:
      EXEC @EXTGEN_SpName
        @PrintBlankPickupDate
      , @IncludeSerialNumbers
      , @PrintShipmentSequenceText
      , @DisplayShipmentSeqNotes
      , @DisplayShipmentPackageNotes
      , @MinShipNum
      , @MaxShipNum
      , @CustomerStarting
      , @CustomerEnding
      , @ShiptoStarting
      , @ShiptoEnding
      , @PickupDateStarting
      , @PickupDateEnding
      , @DateStartingOffset
      , @DateENDingOffset
      , @ShowInternal
      , @ShowExternal
      , @DisplayHeader
      , @UseProfile
      , @LangCode
      , @pSite
      , @PrintDescription

      IF @@TRANCOUNT > 0
         COMMIT TRANSACTION
      EXEC dbo.CloseSessionContextSp @SessionID = @RptSessionID
      -- ETP routine must take over all desired functionality of this standard routine:
      RETURN
   END
   -- End of Generic External Touch Point code.

--Check for Thai License
SELECT @IsThaiFlag = dbo.IsAddonAvailable('SyteLineTH')
SELECT @QtyUnitFormat = qty_unit_format, 
       @PlacesQtyUnit = places_qty_unit
FROM invparms
SET @QtyUnitFormat = dbo.FixMaskForCrystal( @QtyUnitFormat, dbo.GetWinRegDecGroup() )
INSERT INTO @ReportSet (
   pack_num,
   pack_date,
   whse,
   co_num,
   cust_num,
   weight,
   qty_packages,
   ship_code,
   carrier,
   office_addr,
   office_addr2,
   office_addr3,
   office_addr4,
   office_city,
   office_state,
   office_zip,
   office_country,
   office_contact,
   office_phone,
   ship_contact,
   ship_addr,
   ship_addr2,
   ship_addr3,
   ship_addr4,
   ship_city,
   ship_state,
   ship_zip,
   ship_country,
   bill_contact,
   bill_addr,
   bill_addr2,
   bill_addr3,
   bill_addr4,
   bill_city,
   bill_state,
   bill_zip,
   bill_country,
   shipment_TH_fob_point,
   shipment_TH_item_category,
   shipment_TH_from_shipping_port,
   shipment_TH_to_shipping_port,
   co_line,
   co_release,   
   item,
   item_desc,
   u_m,
   ship_rowpointer,
   ship_package_rowpointer,   
   ship_seq_rowpointer,  
   qty_unit_format,
   places_qty_unit,   
   shipment_id,
   shipment_line,
   shipment_seq,
   qty_picked,
   package_id,
   shipment_notes,
   shipmentSeq_notes,
   shipmentPackage_notes,
   shipmentPackage_TH_carton_prefix,
   shipmentPackage_TH_measurement,
   shipmentPackage_TH_carton_size,
   cust_seq,
   from_CompanyName,
   ship_CompanyName,
   bill_CompanyName,
   serial_num,
   lot,
   cust_po,
   contact,
   OfficeLongAddr,
   BillToLongAddr,
   ShipToLongAddr
)
SELECT
   ship.shipment_id
   , isnull(ship.createdate, @Today)
   , ship.whse
   , coship.ref_num
   , ship.cust_num
   , ship.weight
   , ship.qty_packages
   , ship.ship_code
   , ship.carrier_code
   , consignor_addr##1
   , consignor_addr##2
   , consignor_addr##3
   , consignor_addr##4
   , ship.consignor_city
   , ship.consignor_state
   , ship.consignor_zip
   , ship.consignor_country
   , ship.consignor_contact
   , ship.consignor_phone
   , ship.consignee_contact
   , ship.consignee_addr##1
   , ship.consignee_addr##2
   , ship.consignee_addr##3
   , ship.consignee_addr##4
   , ship.consignee_city
   , ship.consignee_state
   , ship.consignee_zip
   , ship.consignee_country
   , ship.invoicee_contact
   , ship.invoicee_addr##1
   , ship.invoicee_addr##2
   , ship.invoicee_addr##3
   , ship.invoicee_addr##4
   , ship.invoicee_city
   , ship.invoicee_state
   , ship.invoicee_zip
   , ship.invoicee_country
   , ship.TH_fob_point
   , ship.TH_item_category
   , ship.TH_from_shipping_port
   , ship.TH_to_shipping_port
   , coship.ref_line_suf
   , coship.ref_release   
   , coitem.item
   , case when @PrintDescription = 1
          then coitem.description
          else null
     end
   , coitem.u_m
   , ship.RowPointer   
   , shipment_package.RowPointer   
   , shipment_seq.RowPointer
   , @QtyUnitFormat
   , @PlacesQtyUnit   
   ,shipment_seq.shipment_id
   ,shipment_seq.shipment_line
   ,shipment_seq.shipment_seq
   ,shipment_seq.qty_picked
   ,shipment_seq.package_id
   ,Case When @PrintShipmentSequenceText   = 1  Then dbo.ReportNotesExist('shipment', ship.RowPointer, @ShowInternal, @ShowExternal, ship.NoteExistsFlag)
    Else 0 End
   ,Case When @DisplayShipmentSeqNotes     = 1  Then dbo.ReportNotesExist('shipment_seq', shipment_seq.RowPointer, @ShowInternal, @ShowExternal, shipment_seq.NoteExistsFlag)
    Else 0 End
   ,Case when @DisplayShipmentPackageNotes = 1  Then dbo.ReportNotesExist('shipment_package', shipment_package.RowPointer, @ShowInternal, @ShowExternal, shipment_package.NoteExistsFlag)
    Else 0 End
   ,shipment_package.TH_carton_prefix
   ,shipment_package.TH_measurement
   ,shipment_package.TH_carton_size
   ,ship.cust_seq
   ,consignor_name
   ,consignee_name
   ,invoicee_name
   ,CASE WHEN  @IncludeSerialNumbers = 1 THEN shipment_seq_serial.ser_num
    ELSE NULL
    END
   ,CASE WHEN  @IncludeSerialNumbers = 1 THEN shipment_seq.lot
    ELSE NULL
    END
   ,co.cust_po
   ,co.contact
   ,dbo.MultiLineAddressSp(CASE WHEN invoicee_name is NULL THEN invoicee_name ELSE consignor_name END,consignor_addr##1,consignor_addr##2,consignor_addr##3,consignor_addr##4,
                           ship.consignor_city,ship.consignor_state,ship.consignor_zip,ship.consignor_country,ship.consignor_contact)                                                  
   ,dbo.MultiLineAddressSp(invoicee_name,ship.invoicee_addr##1,ship.invoicee_addr##2,ship.invoicee_addr##3,ship.invoicee_addr##4,
                           ship.invoicee_city,ship.invoicee_state,ship.invoicee_zip,ship.invoicee_country,ship.invoicee_contact)
   ,dbo.MultiLineAddressSp(consignee_name,ship.consignee_addr##1,ship.consignee_addr##2,ship.consignee_addr##3,ship.consignee_addr##4,
                           ship.consignee_city,ship.consignee_state,ship.consignee_zip,ship.consignee_country,ship.consignee_contact)
FROM shipment ship with(nolock)
   LEFT join shipment_line with(nolock) on
     ship.shipment_id = shipment_line.shipment_id
   LEFT join shipment_seq  with(nolock) on
      shipment_seq.shipment_line = shipment_line.shipment_line
      AND  shipment_seq.shipment_id = shipment_line.shipment_id
   LEFT join shipment_package with(nolock) on
      shipment_package.shipment_id = ship.shipment_id
   LEFT Join pick_list_ref coship with(nolock) ON
      shipment_line.pick_list_id = coship.pick_list_id
      AND shipment_line.pick_list_ref_sequence = coship.sequence
   LEFT JOIN shipment_seq_serial with(nolock) on
      shipment_seq_serial.shipment_id = shipment_seq.shipment_id
      AND shipment_seq_serial.shipment_line = shipment_seq.shipment_line
      AND shipment_seq_serial.shipment_seq = shipment_seq.shipment_seq
   LEFT join customer as shipto  with(nolock) on
      shipto.cust_num = ship.cust_num
      and shipto.cust_seq = 0
   LEFT join custaddr with(nolock) on
      custaddr.cust_num = ship.cust_num
      AND custaddr.cust_seq = ship.cust_seq
   LEFT outer join whse with(nolock) on
      whse.whse = ship.whse
   LEFT outer join shipcode on
      shipcode.ship_code = ship.ship_code
   LEFT JOIN coitem with(nolock) ON
      coship.ref_num = coitem.co_num
      AND coship.ref_line_suf = coitem.co_line
      AND coship.ref_release = coitem.co_release
   LEFT JOIN co with(nolock) ON
      coship.ref_num = co.co_num
   LEFT outer join co_bln with(nolock) on
      co_bln.co_num = coship.ref_num
      AND co_bln.co_line = coship.ref_line_suf
   LEFT join item with(nolock) on
      item.item = coitem.item
   LEFT OUTER JOIN ship_lang with(nolock) on
      ship_lang.ship_code = shipcode.ship_code
      AND ship_lang.lang_code = shipto.lang_code
   LEFT OUTER JOIN item_lang with(nolock) on
      item_lang.item = coitem.item
      AND item_lang.lang_code = shipto.lang_code
   WHERE ship.shipment_id >= @MinShipNum
   AND   ship.shipment_id <= @MaxShipNum
   AND   ((ship.pickup_date >= @PickupDateStarting
   AND   ship.pickup_date <= @PickupDateEnding)
   OR    @AllExPickupDate = 1)
   AND   (ship.pickup_date IS NOT NULL OR @PrintBlankPickupDate =1)
   AND   ship.cust_num    >= @CustomerStarting
   AND   ship.cust_num    <= @CustomerEnding
   AND   ship.cust_seq    >= @ShiptoStarting
   AND   ship.cust_seq    <= @ShiptoEnding
   AND   (@UseProfile = 0 OR @UseProfile IS NULL OR isnull(@LangCode,'') = (SELECT isnull(customer.lang_Code,'') from customer where
    customer.cust_num=ship.cust_num and customer.cust_seq=0))

select distinct *,@IsThaiFlag AS THALicense from @ReportSet Where shipment_id is not null  order by pack_num
update shipment set pack_slip_printed = 1
where shipment_id in (select pack_num from @ReportSet) and shipment_id is not null
EXEC dbo.CloseSessionContextSp @SessionID = @RptSessionID
GO


