-------------------------------------------------------------------------------
-- SQL Script generated by FormSync 9.1.0.9 As of 10/10/2014 05:05 p.m.
-- Source Configuration: BAR_Forms
-------------------------------------------------------------------------------
DECLARE @FormID int
SET @FormID = NULL
SELECT @FormID = Forms.ID FROM Forms WHERE [Name] = N'ZWM_ZipAddress' AND [ScopeType] = 0 
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
  0, N'[NULL]', NULL, N'ZWM_ZipAddress', NULL, 1, N'fZWM_ZipAddress', 
  N'V(fds_DataSource)', 
  1019, CAST('0' AS float), CAST('0' AS float), CAST('22' AS float), CAST('87' AS float), NULL, N'default.html', -1, 8, NULL, 
  NULL, N'0', NULL, 0, NULL)
SELECT @FormID = Forms.ID FROM Forms WHERE [Name] = N'ZWM_ZipAddress' AND [ScopeType] = 0 
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
  @FormID, N'CityGridCol', -1, 
  1, 15, CAST('1' AS float), CAST('6' AS float), CAST('12.5' AS float), CAST('0' AS float), CAST('17.5' AS float), NULL, 
  NULL, 
  N'FormCollectionGrid', 4, N'object.City', 
  1, NULL, NULL, NULL, NULL, NULL, 
  NULL, 
  0, NULL, 0, 0, NULL, NULL, NULL, 0, NULL, 
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
  @FormID, N'CountryGridCol', -1, 
  2, 15, CAST('1' AS float), CAST('13' AS float), CAST('12.5' AS float), CAST('0' AS float), CAST('52.166666666666664' AS float), NULL, 
  NULL, 
  N'FormCollectionGrid', 7, N'object.Country', 
  1, NULL, NULL, NULL, NULL, NULL, 
  NULL, 
  0, NULL, 0, 0, NULL, NULL, NULL, 0, NULL, 
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
  @FormID, N'CountyGridCol', -1, 
  3, 15, CAST('1' AS float), CAST('23' AS float), CAST('12.5' AS float), CAST('0' AS float), CAST('16.833333333333332' AS float), NULL, 
  NULL, 
  N'FormCollectionGrid', 5, N'object.County', 
  1, NULL, NULL, NULL, NULL, NULL, 
  NULL, 
  0, NULL, 0, 0, NULL, NULL, NULL, 0, NULL, 
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
  @FormID, N'EndingNumGridCol', -1, 
  4, 15, CAST('1' AS float), CAST('32' AS float), CAST('12.5' AS float), CAST('0' AS float), CAST('28.833333333333332' AS float), NULL, 
  NULL, 
  N'FormCollectionGrid', 3, N'object.EndingNum', 
  1, NULL, NULL, NULL, NULL, NULL, 
  NULL, 
  0, NULL, 0, 0, NULL, NULL, NULL, 0, N'StdDefault', 
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
  @FormID, N'FormCollectionGrid', -1, 
  0, 14, CAST('0' AS float), CAST('-0.16666666666666666' AS float), CAST('25.384615384615383' AS float), CAST('2' AS float), CAST('98' AS float), NULL, 
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
  @FormID, N'StartingNumGridCol', -1, 
  5, 15, CAST('1' AS float), CAST('35' AS float), CAST('12.5' AS float), CAST('0' AS float), CAST('25.5' AS float), NULL, 
  NULL, 
  N'FormCollectionGrid', 2, N'object.StartingNum', 
  1, NULL, NULL, NULL, NULL, NULL, 
  NULL, 
  0, NULL, 0, 0, NULL, NULL, NULL, 0, N'StdDefault', 
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
  @FormID, N'StateGridCol', -1, 
  6, 15, CAST('1' AS float), CAST('38' AS float), CAST('12.5' AS float), CAST('0' AS float), CAST('22' AS float), NULL, 
  NULL, 
  N'FormCollectionGrid', 6, N'object.State', 
  1, NULL, NULL, NULL, NULL, NULL, 
  NULL, 
  0, NULL, 0, 0, NULL, NULL, NULL, 0, NULL, 
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
  @FormID, N'StreetGridCol', -1, 
  7, 15, CAST('1' AS float), CAST('48' AS float), CAST('12.5' AS float), CAST('0' AS float), CAST('34' AS float), NULL, 
  NULL, 
  N'FormCollectionGrid', 1, N'object.Street', 
  1, NULL, NULL, NULL, NULL, NULL, 
  NULL, 
  0, NULL, 0, 0, NULL, NULL, NULL, 0, NULL, 
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
  @FormID, N'ZipGridCol', -1, 
  8, 15, CAST('1' AS float), CAST('58' AS float), CAST('12.5' AS float), CAST('0' AS float), CAST('21.666666666666668' AS float), NULL, 
  NULL, 
  N'FormCollectionGrid', 0, N'object.Zip', 
  1, NULL, NULL, NULL, NULL, NULL, 
  NULL, 
  0, NULL, 0, 0, NULL, NULL, NULL, 0, NULL, 
  NULL, NULL, NULL, 
  N'0', NULL, NULL, NULL, N'PostalCode', 
  NULL, N'AUTOIME(NoControl)', 
  NULL, N'sPostal/ZIP')
INSERT INTO Variables ( [FormID], [Name], [ScopeType], [ScopeName], [Value], [Value2], [Value3], [LockedBy], [Description] ) 
VALUES (@FormID, N'fds_DataSource', 0, N'[NULL]', N'ZWM_ZipAddrs( OBJNAME(oZWM_ZipAddrs) ORDERBY(Zip) )', NULL, NULL, NULL, NULL)
INSERT INTO Variables ( [FormID], [Name], [ScopeType], [ScopeName], [Value], [Value2], [Value3], [LockedBy], [Description] ) 
VALUES (@FormID, N'InitialCommand', 0, N'[NULL]', N'Refresh', NULL, NULL, NULL, NULL)