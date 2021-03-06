-------------------------------------------------------------------------------
-- SQL Script generated by FormSync 9.1.0.9 As of 10/10/2014 05:05 p.m.
-- Source Configuration: BAR_Forms
-------------------------------------------------------------------------------
DECLARE @FormID int
SET @FormID = NULL
SELECT @FormID = Forms.ID FROM Forms WHERE [Name] = N'ZWM_Zips' AND [ScopeType] = 0 
IF @FormID IS NOT NULL
BEGIN
   DELETE FROM Forms WHERE ID = @FormID
   DELETE FROM FormEventHandlers WHERE FormID = @FormID
   DELETE FROM FormComponents WHERE FormID = @FormID
   DELETE FROM ActiveXComponentProperties WHERE FormID = @FormID
   DELETE FROM Variables WHERE FormID = @FormID
   DELETE FROM FormComponentDragDropEvents WHERE FormID = @FormID
   DELETE FROM DerivedFormOverrides WHERE FormID = @FormID
END
INSERT INTO [Forms] (
  [ScopeType], [ScopeName], [Component], [Name], [SubComponent], [Type], [Caption], 
  [PrimaryDataSource], 
  [StandardOperations], [TopPos], [LeftPos], [Height], [Width], [IconFileName], [HelpFileName], [HelpContextID], [Flags], [LockedBy], 
  [FilterFormSpec], [PaneZeroSize], [Description], [MasterDeviceID], [BaseFormName] ) 
VALUES ( 
  0, N'[NULL]', NULL, N'ZWM_Zips', NULL, 0, N'fZWM_Zips', 
  N'ZWM_Zips(OBJNAME(oZWM_Zips))', 
  1019, CAST('0' AS float), CAST('0' AS float), CAST('28.800000000000001' AS float), CAST('109' AS float), NULL, N'default.html', -1, 10, NULL, 
  NULL, N'20', NULL, 0, NULL)
SELECT @FormID = Forms.ID FROM Forms WHERE [Name] = N'ZWM_Zips' AND [ScopeType] = 0 
INSERT INTO FormComponents (
  [FormID], [Name], [DeviceID], 
  [TabOrder], [Type], [TopPos], [LeftPos],[Height], [ListHeight], [Width], [Caption], 
  [Validators], 
  [ContainerName], [ContainerSequence], [DataSource], 
  [Binding], [EventToGenerate], [SelectionEventToGenerate], [LoseFocusEventToGenerate], [GainFocusEventToGenerate], [RadioButtonSelectedValue], 
  [ComboListSource], 
  [Flags], [DefaultData], [ReadOnly], [Hidden], [BitmapFileName], [HelpString], [HelpFileName], [HelpContextID], [MenuName], 
  [Format], [FindFromSpec], [MaintainFromSpec], 
  [MaxCharacters], [DefaultFrom], [DataType], [ActiveXControlName], [PropertyClassName], 
  [Post301DataType], [Post301Format], 
  [Description], [EffectiveCaption] )
VALUES (
  @FormID, N'DistanceEdit', -1, 
  5, 1, CAST('4.4615384615384563' AS float), CAST('17.666666666666671' AS float), CAST('1.3' AS float), CAST('0' AS float), CAST('18.5' AS float), N'C(DistanceStatic)', 
  NULL, 
  NULL, 0, N'object.Distance', 
  1, NULL, NULL, NULL, NULL, NULL, 
  NULL, 
  1, NULL, 0, 0, NULL, NULL, NULL, 0, NULL, 
  NULL, NULL, NULL, 
  N'0', NULL, NULL, NULL, N'QtyUnitNoNeg', 
  NULL, N'AUTOIME(NoControl)', 
  NULL, N'C(DistanceStatic)')
INSERT INTO FormComponents (
  [FormID], [Name], [DeviceID], 
  [TabOrder], [Type], [TopPos], [LeftPos],[Height], [ListHeight], [Width], [Caption], 
  [Validators], 
  [ContainerName], [ContainerSequence], [DataSource], 
  [Binding], [EventToGenerate], [SelectionEventToGenerate], [LoseFocusEventToGenerate], [GainFocusEventToGenerate], [RadioButtonSelectedValue], 
  [ComboListSource], 
  [Flags], [DefaultData], [ReadOnly], [Hidden], [BitmapFileName], [HelpString], [HelpFileName], [HelpContextID], [MenuName], 
  [Format], [FindFromSpec], [MaintainFromSpec], 
  [MaxCharacters], [DefaultFrom], [DataType], [ActiveXControlName], [PropertyClassName], 
  [Post301DataType], [Post301Format], 
  [Description], [EffectiveCaption] )
VALUES (
  @FormID, N'DistanceGridCol', -1, 
  3, 15, CAST('0' AS float), CAST('0' AS float), CAST('20.5' AS float), CAST('0' AS float), CAST('12' AS float), NULL, 
  NULL, 
  N'FormCollectionGrid', 2, N'object.Distance', 
  1, NULL, NULL, NULL, NULL, NULL, 
  NULL, 
  0, NULL, 0, 0, NULL, NULL, NULL, 0, NULL, 
  NULL, NULL, NULL, 
  N'0', NULL, NULL, NULL, N'QtyUnitNoNeg', 
  NULL, N'AUTOIME(NoControl)', 
  NULL, N'sZWM_Distance')
INSERT INTO FormComponents (
  [FormID], [Name], [DeviceID], 
  [TabOrder], [Type], [TopPos], [LeftPos],[Height], [ListHeight], [Width], [Caption], 
  [Validators], 
  [ContainerName], [ContainerSequence], [DataSource], 
  [Binding], [EventToGenerate], [SelectionEventToGenerate], [LoseFocusEventToGenerate], [GainFocusEventToGenerate], [RadioButtonSelectedValue], 
  [ComboListSource], 
  [Flags], [DefaultData], [ReadOnly], [Hidden], [BitmapFileName], [HelpString], [HelpFileName], [HelpContextID], [MenuName], 
  [Format], [FindFromSpec], [MaintainFromSpec], 
  [MaxCharacters], [DefaultFrom], [DataType], [ActiveXControlName], [PropertyClassName], 
  [Post301DataType], [Post301Format], 
  [Description], [EffectiveCaption] )
VALUES (
  @FormID, N'DistanceStatic', -1, 
  4, 0, CAST('4.5384615384615339' AS float), CAST('4.6666666666666661' AS float), CAST('1' AS float), CAST('0' AS float), CAST('12' AS float), NULL, 
  NULL, 
  NULL, 0, NULL, 
  0, NULL, NULL, NULL, NULL, NULL, 
  NULL, 
  1, NULL, 0, 0, NULL, NULL, NULL, 0, NULL, 
  NULL, NULL, NULL, 
  N'0', NULL, NULL, NULL, NULL, 
  NULL, N'AUTOIME(NoControl) JUSTIFY(R)', 
  NULL, N'sZWM_Distance')
INSERT INTO FormComponents (
  [FormID], [Name], [DeviceID], 
  [TabOrder], [Type], [TopPos], [LeftPos],[Height], [ListHeight], [Width], [Caption], 
  [Validators], 
  [ContainerName], [ContainerSequence], [DataSource], 
  [Binding], [EventToGenerate], [SelectionEventToGenerate], [LoseFocusEventToGenerate], [GainFocusEventToGenerate], [RadioButtonSelectedValue], 
  [ComboListSource], 
  [Flags], [DefaultData], [ReadOnly], [Hidden], [BitmapFileName], [HelpString], [HelpFileName], [HelpContextID], [MenuName], 
  [Format], [FindFromSpec], [MaintainFromSpec], 
  [MaxCharacters], [DefaultFrom], [DataType], [ActiveXControlName], [PropertyClassName], 
  [Post301DataType], [Post301Format], 
  [Description], [EffectiveCaption] )
VALUES (
  @FormID, N'FormCollectionGrid', -1, 
  0, 14, CAST('0' AS float), CAST('0' AS float), CAST('28.76923076923077' AS float), CAST('2' AS float), CAST('19.333333333333332' AS float), NULL, 
  NULL, 
  NULL, 0, N'objects', 
  3, NULL, NULL, NULL, NULL, NULL, 
  NULL, 
  384, NULL, 0, 0, NULL, NULL, NULL, 0, NULL, 
  NULL, NULL, NULL, 
  N'0', NULL, NULL, NULL, NULL, 
  NULL, N'AUTOIME(NoControl)', 
  NULL, NULL)
INSERT INTO FormComponents (
  [FormID], [Name], [DeviceID], 
  [TabOrder], [Type], [TopPos], [LeftPos],[Height], [ListHeight], [Width], [Caption], 
  [Validators], 
  [ContainerName], [ContainerSequence], [DataSource], 
  [Binding], [EventToGenerate], [SelectionEventToGenerate], [LoseFocusEventToGenerate], [GainFocusEventToGenerate], [RadioButtonSelectedValue], 
  [ComboListSource], 
  [Flags], [DefaultData], [ReadOnly], [Hidden], [BitmapFileName], [HelpString], [HelpFileName], [HelpContextID], [MenuName], 
  [Format], [FindFromSpec], [MaintainFromSpec], 
  [MaxCharacters], [DefaultFrom], [DataType], [ActiveXControlName], [PropertyClassName], 
  [Post301DataType], [Post301Format], 
  [Description], [EffectiveCaption] )
VALUES (
  @FormID, N'Group8', -1, 
  8, 6, CAST('8.0961538461277645' AS float), CAST('2.0833333333332913' AS float), CAST('19.23076923076923' AS float), CAST('0' AS float), CAST('83.666666666666671' AS float), NULL, 
  NULL, 
  N'ZWM_ZipAddressTab', 0, NULL, 
  0, NULL, NULL, NULL, NULL, NULL, 
  NULL, 
  385, NULL, 0, 0, NULL, NULL, NULL, 0, NULL, 
  NULL, NULL, NULL, 
  N'0', NULL, NULL, NULL, NULL, 
  NULL, N'AUTOIME(NoControl)', 
  NULL, NULL)
INSERT INTO FormComponents (
  [FormID], [Name], [DeviceID], 
  [TabOrder], [Type], [TopPos], [LeftPos],[Height], [ListHeight], [Width], [Caption], 
  [Validators], 
  [ContainerName], [ContainerSequence], [DataSource], 
  [Binding], [EventToGenerate], [SelectionEventToGenerate], [LoseFocusEventToGenerate], [GainFocusEventToGenerate], [RadioButtonSelectedValue], 
  [ComboListSource], 
  [Flags], [DefaultData], [ReadOnly], [Hidden], [BitmapFileName], [HelpString], [HelpFileName], [HelpContextID], [MenuName], 
  [Format], [FindFromSpec], [MaintainFromSpec], 
  [MaxCharacters], [DefaultFrom], [DataType], [ActiveXControlName], [PropertyClassName], 
  [Post301DataType], [Post301Format], 
  [Description], [EffectiveCaption] )
VALUES (
  @FormID, N'groupBox1', -1, 
  0, 6, CAST('0.076923076923071987' AS float), CAST('1' AS float), CAST('6.6923076923076925' AS float), CAST('0' AS float), CAST('62.333333333333336' AS float), NULL, 
  NULL, 
  NULL, 0, NULL, 
  0, NULL, NULL, NULL, NULL, NULL, 
  NULL, 
  1, NULL, 0, 0, NULL, NULL, NULL, 0, NULL, 
  NULL, NULL, NULL, 
  N'0', NULL, NULL, NULL, NULL, 
  NULL, N'AUTOIME(NoControl)', 
  NULL, NULL)
INSERT INTO FormComponents (
  [FormID], [Name], [DeviceID], 
  [TabOrder], [Type], [TopPos], [LeftPos],[Height], [ListHeight], [Width], [Caption], 
  [Validators], 
  [ContainerName], [ContainerSequence], [DataSource], 
  [Binding], [EventToGenerate], [SelectionEventToGenerate], [LoseFocusEventToGenerate], [GainFocusEventToGenerate], [RadioButtonSelectedValue], 
  [ComboListSource], 
  [Flags], [DefaultData], [ReadOnly], [Hidden], [BitmapFileName], [HelpString], [HelpFileName], [HelpContextID], [MenuName], 
  [Format], [FindFromSpec], [MaintainFromSpec], 
  [MaxCharacters], [DefaultFrom], [DataType], [ActiveXControlName], [PropertyClassName], 
  [Post301DataType], [Post301Format], 
  [Description], [EffectiveCaption] )
VALUES (
  @FormID, N'Notebook', -1, 
  6, 12, CAST('7' AS float), CAST('1' AS float), CAST('20.76923076923077' AS float), CAST('0' AS float), CAST('85.5' AS float), NULL, 
  NULL, 
  NULL, 0, NULL, 
  0, NULL, NULL, NULL, NULL, NULL, 
  NULL, 
  385, NULL, 0, 0, NULL, NULL, NULL, 0, NULL, 
  NULL, NULL, NULL, 
  N'0', NULL, NULL, NULL, NULL, 
  NULL, N'AUTOIME(NoControl)', 
  NULL, NULL)
INSERT INTO FormComponents (
  [FormID], [Name], [DeviceID], 
  [TabOrder], [Type], [TopPos], [LeftPos],[Height], [ListHeight], [Width], [Caption], 
  [Validators], 
  [ContainerName], [ContainerSequence], [DataSource], 
  [Binding], [EventToGenerate], [SelectionEventToGenerate], [LoseFocusEventToGenerate], [GainFocusEventToGenerate], [RadioButtonSelectedValue], 
  [ComboListSource], 
  [Flags], [DefaultData], [ReadOnly], [Hidden], [BitmapFileName], [HelpString], [HelpFileName], [HelpContextID], [MenuName], 
  [Format], [FindFromSpec], [MaintainFromSpec], 
  [MaxCharacters], [DefaultFrom], [DataType], [ActiveXControlName], [PropertyClassName], 
  [Post301DataType], [Post301Format], 
  [Description], [EffectiveCaption] )
VALUES (
  @FormID, N'RouteEdit', -1, 
  3, 27, CAST('2.923076923076918' AS float), CAST('17.666666666666671' AS float), CAST('1.2307692307692308' AS float), CAST('0' AS float), CAST('18.5' AS float), N'C(RouteStatic)', 
  NULL, 
  NULL, 0, N'object.Route', 
  1, NULL, NULL, NULL, NULL, NULL, 
  NULL, 
  1, NULL, 0, 0, NULL, NULL, NULL, 0, NULL, 
  NULL, NULL, NULL, 
  N'0', NULL, NULL, NULL, N'ZWM_Route', 
  NULL, N'AUTOIME(NoControl)', 
  NULL, N'C(RouteStatic)')
INSERT INTO FormComponents (
  [FormID], [Name], [DeviceID], 
  [TabOrder], [Type], [TopPos], [LeftPos],[Height], [ListHeight], [Width], [Caption], 
  [Validators], 
  [ContainerName], [ContainerSequence], [DataSource], 
  [Binding], [EventToGenerate], [SelectionEventToGenerate], [LoseFocusEventToGenerate], [GainFocusEventToGenerate], [RadioButtonSelectedValue], 
  [ComboListSource], 
  [Flags], [DefaultData], [ReadOnly], [Hidden], [BitmapFileName], [HelpString], [HelpFileName], [HelpContextID], [MenuName], 
  [Format], [FindFromSpec], [MaintainFromSpec], 
  [MaxCharacters], [DefaultFrom], [DataType], [ActiveXControlName], [PropertyClassName], 
  [Post301DataType], [Post301Format], 
  [Description], [EffectiveCaption] )
VALUES (
  @FormID, N'RouteGridCol', -1, 
  2, 15, CAST('0' AS float), CAST('0' AS float), CAST('20.5' AS float), CAST('0' AS float), CAST('7' AS float), NULL, 
  NULL, 
  N'FormCollectionGrid', 1, N'object.Route', 
  1, NULL, NULL, NULL, NULL, NULL, 
  NULL, 
  0, NULL, 0, 0, NULL, NULL, NULL, 0, NULL, 
  NULL, NULL, NULL, 
  N'0', NULL, NULL, NULL, N'ZWM_Route', 
  NULL, N'AUTOIME(NoControl)', 
  NULL, N'sZWM_Route')
INSERT INTO FormComponents (
  [FormID], [Name], [DeviceID], 
  [TabOrder], [Type], [TopPos], [LeftPos],[Height], [ListHeight], [Width], [Caption], 
  [Validators], 
  [ContainerName], [ContainerSequence], [DataSource], 
  [Binding], [EventToGenerate], [SelectionEventToGenerate], [LoseFocusEventToGenerate], [GainFocusEventToGenerate], [RadioButtonSelectedValue], 
  [ComboListSource], 
  [Flags], [DefaultData], [ReadOnly], [Hidden], [BitmapFileName], [HelpString], [HelpFileName], [HelpContextID], [MenuName], 
  [Format], [FindFromSpec], [MaintainFromSpec], 
  [MaxCharacters], [DefaultFrom], [DataType], [ActiveXControlName], [PropertyClassName], 
  [Post301DataType], [Post301Format], 
  [Description], [EffectiveCaption] )
VALUES (
  @FormID, N'RouteStatic', -1, 
  2, 0, CAST('2.9999999999999951' AS float), CAST('4.6666666666666661' AS float), CAST('1' AS float), CAST('0' AS float), CAST('12' AS float), NULL, 
  NULL, 
  NULL, 0, NULL, 
  0, NULL, NULL, NULL, NULL, NULL, 
  NULL, 
  1, NULL, 0, 0, NULL, NULL, NULL, 0, NULL, 
  NULL, NULL, NULL, 
  N'0', NULL, NULL, NULL, NULL, 
  NULL, N'AUTOIME(NoControl) JUSTIFY(R)', 
  NULL, N'sZWM_Route')
INSERT INTO FormComponents (
  [FormID], [Name], [DeviceID], 
  [TabOrder], [Type], [TopPos], [LeftPos],[Height], [ListHeight], [Width], [Caption], 
  [Validators], 
  [ContainerName], [ContainerSequence], [DataSource], 
  [Binding], [EventToGenerate], [SelectionEventToGenerate], [LoseFocusEventToGenerate], [GainFocusEventToGenerate], [RadioButtonSelectedValue], 
  [ComboListSource], 
  [Flags], [DefaultData], [ReadOnly], [Hidden], [BitmapFileName], [HelpString], [HelpFileName], [HelpContextID], [MenuName], 
  [Format], [FindFromSpec], [MaintainFromSpec], 
  [MaxCharacters], [DefaultFrom], [DataType], [ActiveXControlName], [PropertyClassName], 
  [Post301DataType], [Post301Format], 
  [Description], [EffectiveCaption] )
VALUES (
  @FormID, N'ZipEdit', -1, 
  1, 1, CAST('1.4615384615384568' AS float), CAST('17.666666666666671' AS float), CAST('1.2307692307692308' AS float), CAST('0' AS float), CAST('18.5' AS float), N'C(ZipStatic)', 
  NULL, 
  NULL, 0, N'object.Zip', 
  1, NULL, NULL, NULL, NULL, NULL, 
  NULL, 
  1, NULL, 0, 0, NULL, NULL, NULL, 0, NULL, 
  NULL, NULL, NULL, 
  N'0', NULL, NULL, NULL, N'PostalCode', 
  NULL, N'AUTOIME(NoControl)', 
  NULL, N'C(ZipStatic)')
INSERT INTO FormComponents (
  [FormID], [Name], [DeviceID], 
  [TabOrder], [Type], [TopPos], [LeftPos],[Height], [ListHeight], [Width], [Caption], 
  [Validators], 
  [ContainerName], [ContainerSequence], [DataSource], 
  [Binding], [EventToGenerate], [SelectionEventToGenerate], [LoseFocusEventToGenerate], [GainFocusEventToGenerate], [RadioButtonSelectedValue], 
  [ComboListSource], 
  [Flags], [DefaultData], [ReadOnly], [Hidden], [BitmapFileName], [HelpString], [HelpFileName], [HelpContextID], [MenuName], 
  [Format], [FindFromSpec], [MaintainFromSpec], 
  [MaxCharacters], [DefaultFrom], [DataType], [ActiveXControlName], [PropertyClassName], 
  [Post301DataType], [Post301Format], 
  [Description], [EffectiveCaption] )
VALUES (
  @FormID, N'ZipGridCol', -1, 
  1, 15, CAST('0' AS float), CAST('0' AS float), CAST('20.5' AS float), CAST('0' AS float), CAST('13' AS float), NULL, 
  NULL, 
  N'FormCollectionGrid', 0, N'object.Zip', 
  1, NULL, NULL, NULL, NULL, NULL, 
  NULL, 
  0, NULL, 0, 0, NULL, NULL, NULL, 0, NULL, 
  NULL, NULL, NULL, 
  N'0', NULL, NULL, NULL, N'PostalCode', 
  NULL, N'AUTOIME(NoControl)', 
  NULL, N'sPostal/ZIP')
INSERT INTO FormComponents (
  [FormID], [Name], [DeviceID], 
  [TabOrder], [Type], [TopPos], [LeftPos],[Height], [ListHeight], [Width], [Caption], 
  [Validators], 
  [ContainerName], [ContainerSequence], [DataSource], 
  [Binding], [EventToGenerate], [SelectionEventToGenerate], [LoseFocusEventToGenerate], [GainFocusEventToGenerate], [RadioButtonSelectedValue], 
  [ComboListSource], 
  [Flags], [DefaultData], [ReadOnly], [Hidden], [BitmapFileName], [HelpString], [HelpFileName], [HelpContextID], [MenuName], 
  [Format], [FindFromSpec], [MaintainFromSpec], 
  [MaxCharacters], [DefaultFrom], [DataType], [ActiveXControlName], [PropertyClassName], 
  [Post301DataType], [Post301Format], 
  [Description], [EffectiveCaption] )
VALUES (
  @FormID, N'ZipStatic', -1, 
  0, 0, CAST('1.5384615384615334' AS float), CAST('4.6666666666666661' AS float), CAST('1' AS float), CAST('0' AS float), CAST('12' AS float), NULL, 
  NULL, 
  NULL, 0, NULL, 
  0, NULL, NULL, NULL, NULL, NULL, 
  NULL, 
  1, NULL, 0, 0, NULL, NULL, NULL, 0, NULL, 
  NULL, NULL, NULL, 
  N'0', NULL, NULL, NULL, NULL, 
  NULL, N'AUTOIME(NoControl) JUSTIFY(R)', 
  NULL, N'sPostal/ZIP')
INSERT INTO FormComponents (
  [FormID], [Name], [DeviceID], 
  [TabOrder], [Type], [TopPos], [LeftPos],[Height], [ListHeight], [Width], [Caption], 
  [Validators], 
  [ContainerName], [ContainerSequence], [DataSource], 
  [Binding], [EventToGenerate], [SelectionEventToGenerate], [LoseFocusEventToGenerate], [GainFocusEventToGenerate], [RadioButtonSelectedValue], 
  [ComboListSource], 
  [Flags], [DefaultData], [ReadOnly], [Hidden], [BitmapFileName], [HelpString], [HelpFileName], [HelpContextID], [MenuName], 
  [Format], [FindFromSpec], [MaintainFromSpec], 
  [MaxCharacters], [DefaultFrom], [DataType], [ActiveXControlName], [PropertyClassName], 
  [Post301DataType], [Post301Format], 
  [Description], [EffectiveCaption] )
VALUES (
  @FormID, N'ZWM_ZipAddressTab', -1, 
  7, 13, CAST('7' AS float), CAST('1' AS float), CAST('20.76923076923077' AS float), CAST('0' AS float), CAST('85.5' AS float), N'fZWM_ZipAddress', 
  NULL, 
  N'Notebook', 0, NULL, 
  0, NULL, NULL, NULL, NULL, NULL, 
  NULL, 
  1, NULL, 0, 0, NULL, NULL, NULL, 0, NULL, 
  NULL, NULL, NULL, 
  N'0', NULL, NULL, NULL, NULL, 
  NULL, N'AUTOIME(NoControl)', 
  NULL, N'fZWM_ZipAddress')
INSERT INTO FormComponents (
  [FormID], [Name], [DeviceID], 
  [TabOrder], [Type], [TopPos], [LeftPos],[Height], [ListHeight], [Width], [Caption], 
  [Validators], 
  [ContainerName], [ContainerSequence], [DataSource], 
  [Binding], [EventToGenerate], [SelectionEventToGenerate], [LoseFocusEventToGenerate], [GainFocusEventToGenerate], [RadioButtonSelectedValue], 
  [ComboListSource], 
  [Flags], [DefaultData], [ReadOnly], [Hidden], [BitmapFileName], [HelpString], [HelpFileName], [HelpContextID], [MenuName], 
  [Format], [FindFromSpec], [MaintainFromSpec], 
  [MaxCharacters], [DefaultFrom], [DataType], [ActiveXControlName], [PropertyClassName], 
  [Post301DataType], [Post301Format], 
  [Description], [EffectiveCaption] )
VALUES (
  @FormID, N'ZWM_ZipAddrsCitySubGridCol', -1, 
  10, 15, CAST('10.25' AS float), CAST('12' AS float), CAST('6' AS float), CAST('0' AS float), CAST('12.333333333333334' AS float), NULL, 
  NULL, 
  N'ZWM_ZipAddrsGrid', 3, N'object.ZWM_ZipAddrs.City', 
  1, NULL, NULL, NULL, NULL, NULL, 
  NULL, 
  1, NULL, 0, 0, NULL, NULL, NULL, 0, N'StdDefault', 
  NULL, NULL, NULL, 
  N'0', NULL, NULL, NULL, N'City', 
  NULL, N'AUTOIME(NoControl)', 
  NULL, N'sCity')
INSERT INTO FormComponents (
  [FormID], [Name], [DeviceID], 
  [TabOrder], [Type], [TopPos], [LeftPos],[Height], [ListHeight], [Width], [Caption], 
  [Validators], 
  [ContainerName], [ContainerSequence], [DataSource], 
  [Binding], [EventToGenerate], [SelectionEventToGenerate], [LoseFocusEventToGenerate], [GainFocusEventToGenerate], [RadioButtonSelectedValue], 
  [ComboListSource], 
  [Flags], [DefaultData], [ReadOnly], [Hidden], [BitmapFileName], [HelpString], [HelpFileName], [HelpContextID], [MenuName], 
  [Format], [FindFromSpec], [MaintainFromSpec], 
  [MaxCharacters], [DefaultFrom], [DataType], [ActiveXControlName], [PropertyClassName], 
  [Post301DataType], [Post301Format], 
  [Description], [EffectiveCaption] )
VALUES (
  @FormID, N'ZWM_ZipAddrsCountrySubGridCol', -1, 
  11, 15, CAST('10.25' AS float), CAST('15' AS float), CAST('6' AS float), CAST('0' AS float), CAST('28.666666666666668' AS float), NULL, 
  NULL, 
  N'ZWM_ZipAddrsGrid', 6, N'object.ZWM_ZipAddrs.Country', 
  1, NULL, NULL, NULL, NULL, NULL, 
  NULL, 
  1, NULL, 0, 0, NULL, NULL, NULL, 0, N'StdDefault', 
  NULL, NULL, NULL, 
  N'0', NULL, NULL, NULL, N'Country', 
  NULL, N'AUTOIME(NoControl)', 
  NULL, N'sCountry')
INSERT INTO FormComponents (
  [FormID], [Name], [DeviceID], 
  [TabOrder], [Type], [TopPos], [LeftPos],[Height], [ListHeight], [Width], [Caption], 
  [Validators], 
  [ContainerName], [ContainerSequence], [DataSource], 
  [Binding], [EventToGenerate], [SelectionEventToGenerate], [LoseFocusEventToGenerate], [GainFocusEventToGenerate], [RadioButtonSelectedValue], 
  [ComboListSource], 
  [Flags], [DefaultData], [ReadOnly], [Hidden], [BitmapFileName], [HelpString], [HelpFileName], [HelpContextID], [MenuName], 
  [Format], [FindFromSpec], [MaintainFromSpec], 
  [MaxCharacters], [DefaultFrom], [DataType], [ActiveXControlName], [PropertyClassName], 
  [Post301DataType], [Post301Format], 
  [Description], [EffectiveCaption] )
VALUES (
  @FormID, N'ZWM_ZipAddrsCountySubGridCol', -1, 
  12, 15, CAST('10.25' AS float), CAST('18' AS float), CAST('6' AS float), CAST('0' AS float), CAST('11.833333333333334' AS float), NULL, 
  NULL, 
  N'ZWM_ZipAddrsGrid', 4, N'object.ZWM_ZipAddrs.County', 
  1, NULL, NULL, NULL, NULL, NULL, 
  NULL, 
  1, NULL, 0, 0, NULL, NULL, NULL, 0, N'StdDefault', 
  NULL, NULL, NULL, 
  N'0', NULL, NULL, NULL, N'County', 
  NULL, N'AUTOIME(NoControl)', 
  NULL, N'sCounty')
INSERT INTO FormComponents (
  [FormID], [Name], [DeviceID], 
  [TabOrder], [Type], [TopPos], [LeftPos],[Height], [ListHeight], [Width], [Caption], 
  [Validators], 
  [ContainerName], [ContainerSequence], [DataSource], 
  [Binding], [EventToGenerate], [SelectionEventToGenerate], [LoseFocusEventToGenerate], [GainFocusEventToGenerate], [RadioButtonSelectedValue], 
  [ComboListSource], 
  [Flags], [DefaultData], [ReadOnly], [Hidden], [BitmapFileName], [HelpString], [HelpFileName], [HelpContextID], [MenuName], 
  [Format], [FindFromSpec], [MaintainFromSpec], 
  [MaxCharacters], [DefaultFrom], [DataType], [ActiveXControlName], [PropertyClassName], 
  [Post301DataType], [Post301Format], 
  [Description], [EffectiveCaption] )
VALUES (
  @FormID, N'ZWM_ZipAddrsEndingNumSubGridCol', -1, 
  13, 15, CAST('10.25' AS float), CAST('21' AS float), CAST('6' AS float), CAST('0' AS float), CAST('13.333333333333334' AS float), NULL, 
  NULL, 
  N'ZWM_ZipAddrsGrid', 2, N'object.ZWM_ZipAddrs.EndingNum', 
  1, NULL, NULL, NULL, NULL, NULL, 
  NULL, 
  1, NULL, 0, 0, NULL, NULL, NULL, 0, N'StdDefault', 
  NULL, NULL, NULL, 
  N'0', NULL, NULL, NULL, N'GenericCode', 
  NULL, N'AUTOIME(NoControl)', 
  NULL, N'sZWM_ZipAddrEndingNum')
INSERT INTO FormComponents (
  [FormID], [Name], [DeviceID], 
  [TabOrder], [Type], [TopPos], [LeftPos],[Height], [ListHeight], [Width], [Caption], 
  [Validators], 
  [ContainerName], [ContainerSequence], [DataSource], 
  [Binding], [EventToGenerate], [SelectionEventToGenerate], [LoseFocusEventToGenerate], [GainFocusEventToGenerate], [RadioButtonSelectedValue], 
  [ComboListSource], 
  [Flags], [DefaultData], [ReadOnly], [Hidden], [BitmapFileName], [HelpString], [HelpFileName], [HelpContextID], [MenuName], 
  [Format], [FindFromSpec], [MaintainFromSpec], 
  [MaxCharacters], [DefaultFrom], [DataType], [ActiveXControlName], [PropertyClassName], 
  [Post301DataType], [Post301Format], 
  [Description], [EffectiveCaption] )
VALUES (
  @FormID, N'ZWM_ZipAddrsGrid', -1, 
  9, 14, CAST('9.3461538461277645' AS float), CAST('3.4999999999986393' AS float), CAST('17.307692307692307' AS float), CAST('2' AS float), CAST('81.333333333333329' AS float), NULL, 
  NULL, 
  N'ZWM_ZipAddressTab', 1, N'object.ZWM_ZipAddrs(LINKBY(Zip=Zip) CA(NDRIOSVG))', 
  4, NULL, NULL, NULL, NULL, NULL, 
  NULL, 
  385, NULL, 0, 0, NULL, NULL, NULL, 0, NULL, 
  NULL, NULL, NULL, 
  N'0', NULL, NULL, NULL, NULL, 
  NULL, N'AUTOIME(NoControl)', 
  NULL, NULL)
INSERT INTO FormComponents (
  [FormID], [Name], [DeviceID], 
  [TabOrder], [Type], [TopPos], [LeftPos],[Height], [ListHeight], [Width], [Caption], 
  [Validators], 
  [ContainerName], [ContainerSequence], [DataSource], 
  [Binding], [EventToGenerate], [SelectionEventToGenerate], [LoseFocusEventToGenerate], [GainFocusEventToGenerate], [RadioButtonSelectedValue], 
  [ComboListSource], 
  [Flags], [DefaultData], [ReadOnly], [Hidden], [BitmapFileName], [HelpString], [HelpFileName], [HelpContextID], [MenuName], 
  [Format], [FindFromSpec], [MaintainFromSpec], 
  [MaxCharacters], [DefaultFrom], [DataType], [ActiveXControlName], [PropertyClassName], 
  [Post301DataType], [Post301Format], 
  [Description], [EffectiveCaption] )
VALUES (
  @FormID, N'ZWM_ZipAddrsStartingNumSubGridCol', -1, 
  14, 15, CAST('10.25' AS float), CAST('24' AS float), CAST('6' AS float), CAST('0' AS float), CAST('18.166666666666668' AS float), NULL, 
  NULL, 
  N'ZWM_ZipAddrsGrid', 1, N'object.ZWM_ZipAddrs.StartingNum', 
  1, NULL, NULL, NULL, NULL, NULL, 
  NULL, 
  1, NULL, 0, 0, NULL, NULL, NULL, 0, N'StdDefault', 
  NULL, NULL, NULL, 
  N'0', NULL, NULL, NULL, N'GenericCode', 
  NULL, N'AUTOIME(NoControl)', 
  NULL, N'sZWM_ZipAddrStartingNum')
INSERT INTO FormComponents (
  [FormID], [Name], [DeviceID], 
  [TabOrder], [Type], [TopPos], [LeftPos],[Height], [ListHeight], [Width], [Caption], 
  [Validators], 
  [ContainerName], [ContainerSequence], [DataSource], 
  [Binding], [EventToGenerate], [SelectionEventToGenerate], [LoseFocusEventToGenerate], [GainFocusEventToGenerate], [RadioButtonSelectedValue], 
  [ComboListSource], 
  [Flags], [DefaultData], [ReadOnly], [Hidden], [BitmapFileName], [HelpString], [HelpFileName], [HelpContextID], [MenuName], 
  [Format], [FindFromSpec], [MaintainFromSpec], 
  [MaxCharacters], [DefaultFrom], [DataType], [ActiveXControlName], [PropertyClassName], 
  [Post301DataType], [Post301Format], 
  [Description], [EffectiveCaption] )
VALUES (
  @FormID, N'ZWM_ZipAddrsStateSubGridCol', -1, 
  15, 15, CAST('10.25' AS float), CAST('27' AS float), CAST('6' AS float), CAST('0' AS float), CAST('18.833333333333332' AS float), NULL, 
  NULL, 
  N'ZWM_ZipAddrsGrid', 5, N'object.ZWM_ZipAddrs.State', 
  1, NULL, NULL, NULL, NULL, NULL, 
  NULL, 
  1, NULL, 0, 0, NULL, NULL, NULL, 0, N'StdDefault', 
  NULL, NULL, NULL, 
  N'0', NULL, NULL, NULL, N'State', 
  NULL, N'AUTOIME(NoControl)', 
  NULL, N'sProv/St')
INSERT INTO FormComponents (
  [FormID], [Name], [DeviceID], 
  [TabOrder], [Type], [TopPos], [LeftPos],[Height], [ListHeight], [Width], [Caption], 
  [Validators], 
  [ContainerName], [ContainerSequence], [DataSource], 
  [Binding], [EventToGenerate], [SelectionEventToGenerate], [LoseFocusEventToGenerate], [GainFocusEventToGenerate], [RadioButtonSelectedValue], 
  [ComboListSource], 
  [Flags], [DefaultData], [ReadOnly], [Hidden], [BitmapFileName], [HelpString], [HelpFileName], [HelpContextID], [MenuName], 
  [Format], [FindFromSpec], [MaintainFromSpec], 
  [MaxCharacters], [DefaultFrom], [DataType], [ActiveXControlName], [PropertyClassName], 
  [Post301DataType], [Post301Format], 
  [Description], [EffectiveCaption] )
VALUES (
  @FormID, N'ZWM_ZipAddrsStreetSubGridCol', -1, 
  16, 15, CAST('10.25' AS float), CAST('30' AS float), CAST('6' AS float), CAST('0' AS float), CAST('20.166666666666668' AS float), NULL, 
  NULL, 
  N'ZWM_ZipAddrsGrid', 0, N'object.ZWM_ZipAddrs.Street', 
  1, NULL, NULL, NULL, NULL, NULL, 
  NULL, 
  1, NULL, 0, 0, NULL, NULL, NULL, 0, N'StdDefault', 
  NULL, NULL, NULL, 
  N'0', NULL, NULL, NULL, N'Address', 
  NULL, N'AUTOIME(NoControl)', 
  NULL, N'sAddress')
INSERT INTO FormComponents (
  [FormID], [Name], [DeviceID], 
  [TabOrder], [Type], [TopPos], [LeftPos],[Height], [ListHeight], [Width], [Caption], 
  [Validators], 
  [ContainerName], [ContainerSequence], [DataSource], 
  [Binding], [EventToGenerate], [SelectionEventToGenerate], [LoseFocusEventToGenerate], [GainFocusEventToGenerate], [RadioButtonSelectedValue], 
  [ComboListSource], 
  [Flags], [DefaultData], [ReadOnly], [Hidden], [BitmapFileName], [HelpString], [HelpFileName], [HelpContextID], [MenuName], 
  [Format], [FindFromSpec], [MaintainFromSpec], 
  [MaxCharacters], [DefaultFrom], [DataType], [ActiveXControlName], [PropertyClassName], 
  [Post301DataType], [Post301Format], 
  [Description], [EffectiveCaption] )
VALUES (
  @FormID, N'ZWM_ZipAddrsZipSubGridCol', -1, 
  17, 15, CAST('10.25' AS float), CAST('33' AS float), CAST('6' AS float), CAST('0' AS float), CAST('13' AS float), NULL, 
  NULL, 
  N'ZWM_ZipAddrsGrid', 7, N'object.ZWM_ZipAddrs.Zip', 
  1, NULL, NULL, NULL, NULL, NULL, 
  NULL, 
  1, NULL, 0, 1, NULL, NULL, NULL, 0, NULL, 
  NULL, NULL, NULL, 
  N'0', NULL, NULL, NULL, N'PostalCode', 
  NULL, N'AUTOIME(NoControl)', 
  NULL, N'sPostal/ZIP')
INSERT INTO Variables ( [FormID], [Name], [ScopeType], [ScopeName], [Value], [Value2], [Value3], [LockedBy], [Description] ) 
VALUES (@FormID, N'InitialCommand', 0, N'[NULL]', N'FilterInPlace', NULL, NULL, NULL, NULL)
