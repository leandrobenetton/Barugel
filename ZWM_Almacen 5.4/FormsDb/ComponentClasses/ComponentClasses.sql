
-------------------------------------------------------------------------------
-- SQL Script generated by FormSync 9.1.0.9 As of 26/08/2014 10:17
-- Source Configuration: ZLA_Dev_Forms
-- Objects Scripted:
--   PropertyDefaults - Component Class: ProdCodVar, UserDefinedType
-------------------------------------------------------------------------------
DECLARE @FormID int
DELETE FROM PropertyDefaults WHERE [PropertyName] = N'ProdCodVar' AND [IsPropertyClassExtension] = 0 AND [ScopeType] = 1 AND [ScopeName] = N'[NULL]' 

DELETE FROM PropertyDefaultDragDropEvents WHERE [PropertyName] = N'ProdCodVar' AND [IsPropertyClassExtension] = 0 AND [ScopeType] = 1 AND [ScopeName] = N'[NULL]' 

INSERT INTO PropertyDefaults ( 
 [PropertyName], [ScopeType], [ScopeName], 
 [Description], [Label], [ListSource], 
 [FindFromForm], [FindFromProperty], [MaintainFromSpec], 
 [Validators], [MaxCharacters], [ValidateImmediately], [ValueIsListIndex], 
 [LockedBy], [DataType], [IsPropertyClassExtension], [Flags], [ComponentFlags], 
 [EventToGenerate], [SelectionEventToGenerate], [LoseFocusEventToGenerate], [GainFocusEventToGenerate], 
 [HelpString], [HelpFileName], [HelpContextID], [MenuName], 
 [Post301DataType], [Post301Format] ) 
VALUES ( 
 N'ProdCodVar', 1, N'[NULL]', 
 NULL, NULL, N'STDOLE SLProdcodes(  PROPERTIES(ProductCode) DISPLAY(1))', 
 NULL, NULL, NULL, 
 N'DefaultStartingToEnding(%1,%2)', 0, 0, 0, 
 NULL, NULL, 0, 0, 0, 
 NULL, NULL, NULL, NULL, 
 NULL, NULL, 0, NULL, 
 NULL, N'AUTOIME(NoControl)' ) 


-------------------------------------------------------------------------------
DELETE FROM PropertyDefaults WHERE [PropertyName] = N'UserDefinedType' AND [IsPropertyClassExtension] = 0 AND [ScopeType] = 1 AND [ScopeName] = N'[NULL]' 

DELETE FROM PropertyDefaultDragDropEvents WHERE [PropertyName] = N'UserDefinedType' AND [IsPropertyClassExtension] = 0 AND [ScopeType] = 1 AND [ScopeName] = N'[NULL]' 

INSERT INTO PropertyDefaults ( 
 [PropertyName], [ScopeType], [ScopeName], 
 [Description], [Label], [ListSource], 
 [FindFromForm], [FindFromProperty], [MaintainFromSpec], 
 [Validators], [MaxCharacters], [ValidateImmediately], [ValueIsListIndex], 
 [LockedBy], [DataType], [IsPropertyClassExtension], [Flags], [ComponentFlags], 
 [EventToGenerate], [SelectionEventToGenerate], [LoseFocusEventToGenerate], [GainFocusEventToGenerate], 
 [HelpString], [HelpFileName], [HelpContextID], [MenuName], 
 [Post301DataType], [Post301Format] ) 
VALUES ( 
 N'UserDefinedType', 1, N'[NULL]', 
 N'Parm: name of type; use this for standard facilities for value corresponding to a user-defined type', NULL, N'STDOLE MGCore.UserDefinedTypeValues(  PROPERTIES( Value, Description ) DISPLAY(1,2)FILTER(TypeName = ''%1''))', 
 N'UserDefinedTypeValuesQuery( FILTERPERM( TypeName = ''%1'' ) )', N'Value', N'UserDefinedTypeValues( FILTERPERM( TypeName = ''%1'' ) SETVARVALUES( TypeName=%1 ) )', 
 N'UserDefinedTypeValue(%1)', 0, 1, 0, 
 NULL, NULL, 0, 0, 0, 
 NULL, NULL, NULL, NULL, 
 NULL, NULL, 0, N'StdDetailsAddFind', 
 NULL, N'AUTOIME(NoControl)' ) 


---------------------------------------------------------------------------------------------------------------------
DELETE FROM PropertyDefaults WHERE [PropertyName] = N'ZWM_ShipCodeMode' AND [IsPropertyClassExtension] = 0 AND [ScopeType] = 0  AND [ScopeName] = N'[NULL]' 

DELETE FROM PropertyDefaultDragDropEvents WHERE [PropertyName] = N'ZWM_ShipCodeMode' AND [IsPropertyClassExtension] = 0 AND [ScopeType] = 0  AND [ScopeName] = N'[NULL]' 

INSERT INTO PropertyDefaults ( 
 [PropertyName], [ScopeType], [ScopeName], 
 [Description], [Label], [ListSource], 
 [FindFromForm], [FindFromProperty], [MaintainFromSpec], 
 [Validators], [MaxCharacters], [ValidateImmediately], [ValueIsListIndex], 
 [LockedBy], [DataType], [IsPropertyClassExtension], [Flags], [ComponentFlags], 
 [EventToGenerate], [SelectionEventToGenerate], [LoseFocusEventToGenerate], [GainFocusEventToGenerate], 
 [HelpString], [HelpFileName], [HelpContextID], [MenuName], 
 [Post301DataType], [Post301Format] ) 
VALUES ( 
 N'ZWM_ShipCodeMode', 0, N'[NULL]', 
 NULL, NULL, N'INLINE ENTRIES(C\sZWM_ShipViaMode=C,F\sZWM_ShipViaMode=F) DISPLAY(2) VALUE(1)', 
 NULL, NULL, NULL, 
 NULL, 0, 0, 0, 
 NULL, NULL, 0, 0, 0, 
 NULL, NULL, NULL, NULL, 
 NULL, NULL, 0, N'StdHelp', 
 NULL, N'AUTOIME(NoControl)' ) 

-------------------------------------------------------------------------------------------------------------------
DELETE FROM PropertyDefaults WHERE [PropertyName] = N'ZwmIdRouteMap' AND [IsPropertyClassExtension] = 0 AND [ScopeType] = 1 AND [ScopeName] = N'[NULL]' 

DELETE FROM PropertyDefaultDragDropEvents WHERE [PropertyName] = N'ZwmIdRouteMap' AND [IsPropertyClassExtension] = 0 AND [ScopeType] = 1 AND [ScopeName] = N'[NULL]' 

INSERT INTO PropertyDefaults ( 
 [PropertyName], [ScopeType], [ScopeName], 
 [Description], [Label], [ListSource], 
 [FindFromForm], [FindFromProperty], [MaintainFromSpec], 
 [Validators], [MaxCharacters], [ValidateImmediately], [ValueIsListIndex], 
 [LockedBy], [DataType], [IsPropertyClassExtension], [Flags], [ComponentFlags], 
 [EventToGenerate], [SelectionEventToGenerate], [LoseFocusEventToGenerate], [GainFocusEventToGenerate], 
 [HelpString], [HelpFileName], [HelpContextID], [MenuName], 
 [Post301DataType], [Post301Format] ) 
VALUES ( 
 N'ZwmIdRouteMap', 1, N'[NULL]', 
 NULL, NULL, N'STDOLE ZWM_SLPickWorkbenchs(  PROPERTIES(ZwmIdRouteMap) DISPLAY(1)READMODE(COMMITTED)DISTINCT() FILTER(ZwmIdRouteMap is not null)ORDERBY(ZwmIdRouteMap))', 
 NULL, NULL, NULL, 
 N'DefaultStartingToEnding(%1,%2)', 0, 1, 0, 
 NULL, NULL, 0, 0, 0, 
 NULL, NULL, NULL, NULL, 
 NULL, NULL, 0, NULL, 
 NULL, N'AUTOIME(NoControl)' ) 


-------------------------------------------------------------------------------
DELETE FROM PropertyDefaults WHERE [PropertyName] = N'ZwmPickList' AND [IsPropertyClassExtension] = 0 AND [ScopeType] = 1 AND [ScopeName] = N'[NULL]' 

DELETE FROM PropertyDefaultDragDropEvents WHERE [PropertyName] = N'ZwmPickList' AND [IsPropertyClassExtension] = 0 AND [ScopeType] = 1 AND [ScopeName] = N'[NULL]' 

INSERT INTO PropertyDefaults ( 
 [PropertyName], [ScopeType], [ScopeName], 
 [Description], [Label], [ListSource], 
 [FindFromForm], [FindFromProperty], [MaintainFromSpec], 
 [Validators], [MaxCharacters], [ValidateImmediately], [ValueIsListIndex], 
 [LockedBy], [DataType], [IsPropertyClassExtension], [Flags], [ComponentFlags], 
 [EventToGenerate], [SelectionEventToGenerate], [LoseFocusEventToGenerate], [GainFocusEventToGenerate], 
 [HelpString], [HelpFileName], [HelpContextID], [MenuName], 
 [Post301DataType], [Post301Format] ) 
VALUES ( 
 N'ZwmPickList', 1, N'[NULL]', 
 NULL, NULL, N'STDOLE ZWM_SLPickWorkbenchs(  PROPERTIES(ZwmPickListId) DISPLAY(1)DISTINCT() FILTER(ZwmPickListId is not null)ORDERBY(ZwmPickListId))', 
 NULL, NULL, NULL, 
 N'DefaultStartingToEnding(%1,%2)', 0, 1, 0, 
 NULL, NULL, 0, 0, 0, 
 NULL, NULL, NULL, NULL, 
 NULL, NULL, 0, NULL, 
 NULL, N'AUTOIME(NoControl)' ) 


-------------------------------------------------------------------------------
DELETE FROM PropertyDefaults WHERE [PropertyName] = N'ZwmRoute' AND [IsPropertyClassExtension] = 0 AND [ScopeType] = 1 AND [ScopeName] = N'[NULL]' 

DELETE FROM PropertyDefaultDragDropEvents WHERE [PropertyName] = N'ZwmRoute' AND [IsPropertyClassExtension] = 0 AND [ScopeType] = 1 AND [ScopeName] = N'[NULL]' 

INSERT INTO PropertyDefaults ( 
 [PropertyName], [ScopeType], [ScopeName], 
 [Description], [Label], [ListSource], 
 [FindFromForm], [FindFromProperty], [MaintainFromSpec], 
 [Validators], [MaxCharacters], [ValidateImmediately], [ValueIsListIndex], 
 [LockedBy], [DataType], [IsPropertyClassExtension], [Flags], [ComponentFlags], 
 [EventToGenerate], [SelectionEventToGenerate], [LoseFocusEventToGenerate], [GainFocusEventToGenerate], 
 [HelpString], [HelpFileName], [HelpContextID], [MenuName], 
 [Post301DataType], [Post301Format] ) 
VALUES ( 
 N'ZwmRoute', 1, N'[NULL]', 
 NULL, NULL, N'STDOLE ZWM_Routes(  PROPERTIES(Route) DISPLAY(1)ORDERBY(Route))', 
 NULL, NULL, NULL, 
 N'DefaultStartingToEnding(%1,%2)', 0, 1, 0, 
 NULL, NULL, 0, 0, 0, 
 NULL, NULL, NULL, NULL, 
 NULL, NULL, 0, NULL, 
 NULL, N'AUTOIME(NoControl)' ) 
--------------------------------------------------------------------------------

DELETE FROM PropertyDefaults WHERE [PropertyName] = N'ZwmTransferOrder' AND [IsPropertyClassExtension] = 0 AND [ScopeType] = 1 AND [ScopeName] = N'[NULL]' 

DELETE FROM PropertyDefaultDragDropEvents WHERE [PropertyName] = N'ZwmTransferOrder' AND [IsPropertyClassExtension] = 0 AND [ScopeType] = 1 AND [ScopeName] = N'[NULL]' 

INSERT INTO PropertyDefaults ( 
 [PropertyName], [ScopeType], [ScopeName], 
 [Description], [Label], [ListSource], 
 [FindFromForm], [FindFromProperty], [MaintainFromSpec], 
 [Validators], [MaxCharacters], [ValidateImmediately], [ValueIsListIndex], 
 [LockedBy], [DataType], [IsPropertyClassExtension], [Flags], [ComponentFlags], 
 [EventToGenerate], [SelectionEventToGenerate], [LoseFocusEventToGenerate], [GainFocusEventToGenerate], 
 [HelpString], [HelpFileName], [HelpContextID], [MenuName], 
 [Post301DataType], [Post301Format] ) 
VALUES ( 
 N'ZwmTransferOrder', 1, N'[NULL]', 
 NULL, NULL, N'STDOLE ZWM_TransferPickList(  PROPERTIES(TrnNum) DISPLAY(1)DISTINCT() )', 
 NULL, NULL, NULL, 
 N'DefaultStartingToEnding(%1,%2)', 0, 0, 0, 
 NULL, NULL, 0, 0, 0, 
 NULL, NULL, NULL, NULL, 
 NULL, NULL, 0, NULL, 
 NULL, N'AUTOIME(NoControl)' ) 
----------------------------------------------------------------------------------------

DELETE FROM PropertyDefaults WHERE [PropertyName] = N'ZwmProdCodVar' AND [IsPropertyClassExtension] = 0 AND [ScopeType] = 1 AND [ScopeName] = N'[NULL]' 

DELETE FROM PropertyDefaultDragDropEvents WHERE [PropertyName] = N'ZwmProdCodVar' AND [IsPropertyClassExtension] = 0 AND [ScopeType] = 1 AND [ScopeName] = N'[NULL]' 

INSERT INTO PropertyDefaults ( 
 [PropertyName], [ScopeType], [ScopeName], 
 [Description], [Label], [ListSource], 
 [FindFromForm], [FindFromProperty], [MaintainFromSpec], 
 [Validators], [MaxCharacters], [ValidateImmediately], [ValueIsListIndex], 
 [LockedBy], [DataType], [IsPropertyClassExtension], [Flags], [ComponentFlags], 
 [EventToGenerate], [SelectionEventToGenerate], [LoseFocusEventToGenerate], [GainFocusEventToGenerate], 
 [HelpString], [HelpFileName], [HelpContextID], [MenuName], 
 [Post301DataType], [Post301Format] ) 
VALUES ( 
 N'ZwmProdCodVar', 1, N'[NULL]', 
 NULL, NULL, N'STDOLE SLProdcodes(  PROPERTIES(ProductCode) DISPLAY(1))', 
 NULL, NULL, NULL, 
 N'DefaultStartingToEnding(%1,%2)', 0, 1, 0, 
 NULL, NULL, 0, 0, 0, 
 NULL, NULL, NULL, NULL, 
 NULL, NULL, 0, NULL, 
 NULL, N'AUTOIME(NoControl)' ) 


-------------------------------------------------------------------------------
DELETE FROM PropertyDefaults WHERE [PropertyName] = N'ZwmTrnNumVar' AND [IsPropertyClassExtension] = 0 AND [ScopeType] = 1 AND [ScopeName] = N'[NULL]' 

DELETE FROM PropertyDefaultDragDropEvents WHERE [PropertyName] = N'ZwmTrnNumVar' AND [IsPropertyClassExtension] = 0 AND [ScopeType] = 1 AND [ScopeName] = N'[NULL]' 

INSERT INTO PropertyDefaults ( 
 [PropertyName], [ScopeType], [ScopeName], 
 [Description], [Label], [ListSource], 
 [FindFromForm], [FindFromProperty], [MaintainFromSpec], 
 [Validators], [MaxCharacters], [ValidateImmediately], [ValueIsListIndex], 
 [LockedBy], [DataType], [IsPropertyClassExtension], [Flags], [ComponentFlags], 
 [EventToGenerate], [SelectionEventToGenerate], [LoseFocusEventToGenerate], [GainFocusEventToGenerate], 
 [HelpString], [HelpFileName], [HelpContextID], [MenuName], 
 [Post301DataType], [Post301Format] ) 
VALUES ( 
 N'ZwmTrnNumVar', 1, N'[NULL]', 
 NULL, NULL, N'STDOLE SL.SLTransfers(  PROPERTIES(TrnNum, Stat) DISPLAY(1,2)FILTER(Stat <> ''C''))', 
 NULL, NULL, NULL, 
 N'DefaultStartingToEnding(%1,%2)', 0, 1, 0, 
 NULL, NULL, 0, 0, 0, 
 NULL, NULL, NULL, NULL, 
 NULL, NULL, 0, NULL, 
 NULL, N'AUTOIME(NoControl)' ) 


