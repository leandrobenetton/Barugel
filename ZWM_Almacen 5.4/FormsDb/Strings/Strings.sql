-------------------------------------------------------------------------------
DECLARE @FormID int
DELETE FROM [Strings] WHERE [Name] = N'fZWM_ItmWhse' AND [ScopeType] = 1 AND [ScopeName] = N'[NULL]' 

INSERT INTO [Strings] ([Name], [String], [String2], [String3], [ScopeType], [ScopeName], [LockedBy] ) 
VALUES (N'fZWM_ItmWhse', N'Storage criteria', NULL, NULL, 1, N'[NULL]', NULL)
-------------------------------------------------------------------------------
DELETE FROM [Strings] WHERE [Name] = N'fZwmImportGrn' AND [ScopeType] = 1 AND [ScopeName] = N'[NULL]' 

INSERT INTO [Strings] ([Name], [String], [String2], [String3], [ScopeType], [ScopeName], [LockedBy] ) 
VALUES (N'fZwmImportGrn', N'Load NRM', NULL, NULL, 1, N'[NULL]', NULL)
-------------------------------------------------------------------------------
DELETE FROM [Strings] WHERE [Name] = N'fZwmItemParms' AND [ScopeType] = 1 AND [ScopeName] = N'[NULL]' 

INSERT INTO [Strings] ([Name], [String], [String2], [String3], [ScopeType], [ScopeName], [LockedBy] ) 
VALUES (N'fZwmItemParms', N'Item parameters', NULL, NULL, 1, N'[NULL]', NULL)
-------------------------------------------------------------------------------
DELETE FROM [Strings] WHERE [Name] = N'fZwmItemStorageReport' AND [ScopeType] = 1 AND [ScopeName] = N'[NULL]' 

INSERT INTO [Strings] ([Name], [String], [String2], [String3], [ScopeType], [ScopeName], [LockedBy] ) 
VALUES (N'fZwmItemStorageReport', N'List of storage problems', NULL, NULL, 1, N'[NULL]', NULL)
-------------------------------------------------------------------------------
DELETE FROM [Strings] WHERE [Name] = N'fZwmItemsUpdate' AND [ScopeType] = 1 AND [ScopeName] = N'[NULL]' 

INSERT INTO [Strings] ([Name], [String], [String2], [String3], [ScopeType], [ScopeName], [LockedBy] ) 
VALUES (N'fZwmItemsUpdate', N'Items updates', NULL, NULL, 1, N'[NULL]', NULL)
-------------------------------------------------------------------------------
DELETE FROM [Strings] WHERE [Name] = N'fZwmParameters' AND [ScopeType] = 1 AND [ScopeName] = N'[NULL]' 

INSERT INTO [Strings] ([Name], [String], [String2], [String3], [ScopeType], [ScopeName], [LockedBy] ) 
VALUES (N'fZwmParameters', N'Par' + NCHAR(225) + N'metros Gesti' + NCHAR(243) + N'n Almac' + NCHAR(233) + N'n', NULL, NULL, 1, N'[NULL]', NULL)
-------------------------------------------------------------------------------
DELETE FROM [Strings] WHERE [Name] = N'fZwmRecCons' AND [ScopeType] = 1 AND [ScopeName] = N'[NULL]' 

INSERT INTO [Strings] ([Name], [String], [String2], [String3], [ScopeType], [ScopeName], [LockedBy] ) 
VALUES (N'fZwmRecCons', N'Recepci' + NCHAR(243) + N'n Consolidada', NULL, NULL, 1, N'[NULL]', NULL)
-------------------------------------------------------------------------------
DELETE FROM [Strings] WHERE [Name] = N'fZwmWhseZone' AND [ScopeType] = 1 AND [ScopeName] = N'[NULL]' 

INSERT INTO [Strings] ([Name], [String], [String2], [String3], [ScopeType], [ScopeName], [LockedBy] ) 
VALUES (N'fZwmWhseZone', N'Warehouses areas', NULL, NULL, 1, N'[NULL]', NULL)
-------------------------------------------------------------------------------
DELETE FROM [Strings] WHERE [Name] = N'sZwmBarCode' AND [ScopeType] = 1 AND [ScopeName] = N'[NULL]' 

INSERT INTO [Strings] ([Name], [String], [String2], [String3], [ScopeType], [ScopeName], [LockedBy] ) 
VALUES (N'sZwmBarCode', N'Bar codes', NULL, NULL, 1, N'[NULL]', NULL)
-------------------------------------------------------------------------------
DELETE FROM [Strings] WHERE [Name] = N'sZwmCharAttr' AND [ScopeType] = 1 AND [ScopeName] = N'[NULL]' 

INSERT INTO [Strings] ([Name], [String], [String2], [String3], [ScopeType], [ScopeName], [LockedBy] ) 
VALUES (N'sZwmCharAttr', N'Char', NULL, NULL, 1, N'[NULL]', NULL)
-------------------------------------------------------------------------------
DELETE FROM [Strings] WHERE [Name] = N'sZwmCoefficient' AND [ScopeType] = 1 AND [ScopeName] = N'[NULL]' 

INSERT INTO [Strings] ([Name], [String], [String2], [String3], [ScopeType], [ScopeName], [LockedBy] ) 
VALUES (N'sZwmCoefficient', N'Coefficient (volumetric weight)', NULL, NULL, 1, N'[NULL]', NULL)
-------------------------------------------------------------------------------
DELETE FROM [Strings] WHERE [Name] = N'sZwmContBarCode' AND [ScopeType] = 1 AND [ScopeName] = N'[NULL]' 

INSERT INTO [Strings] ([Name], [String], [String2], [String3], [ScopeType], [ScopeName], [LockedBy] ) 
VALUES (N'sZwmContBarCode', N'Barcode control', NULL, NULL, 1, N'[NULL]', NULL)
-------------------------------------------------------------------------------
DELETE FROM [Strings] WHERE [Name] = N'sZwmContDimUM' AND [ScopeType] = 1 AND [ScopeName] = N'[NULL]' 

INSERT INTO [Strings] ([Name], [String], [String2], [String3], [ScopeType], [ScopeName], [LockedBy] ) 
VALUES (N'sZwmContDimUM', N'Controla Dimensiones UM', NULL, NULL, 1, N'[NULL]', NULL)
-------------------------------------------------------------------------------
DELETE FROM [Strings] WHERE [Name] = N'sZwmContNum' AND [ScopeType] = 1 AND [ScopeName] = N'[NULL]' 

INSERT INTO [Strings] ([Name], [String], [String2], [String3], [ScopeType], [ScopeName], [LockedBy] ) 
VALUES (N'sZwmContNum', N'N' + NCHAR(250) + N'mero de Contenedor', NULL, NULL, 1, N'[NULL]', NULL)
-------------------------------------------------------------------------------
DELETE FROM [Strings] WHERE [Name] = N'sZwmContSeqStor' AND [ScopeType] = 1 AND [ScopeName] = N'[NULL]' 

INSERT INTO [Strings] ([Name], [String], [String2], [String3], [ScopeType], [ScopeName], [LockedBy] ) 
VALUES (N'sZwmContSeqStor', N'Controla Secuencia de Almacenamiento', NULL, NULL, 1, N'[NULL]', NULL)
-------------------------------------------------------------------------------
DELETE FROM [Strings] WHERE [Name] = N'sZwmContUM' AND [ScopeType] = 1 AND [ScopeName] = N'[NULL]' 

INSERT INTO [Strings] ([Name], [String], [String2], [String3], [ScopeType], [ScopeName], [LockedBy] ) 
VALUES (N'sZwmContUM', N'Controla UM', NULL, NULL, 1, N'[NULL]', NULL)
-------------------------------------------------------------------------------
DELETE FROM [Strings] WHERE [Name] = N'sZwmContWeight' AND [ScopeType] = 1 AND [ScopeName] = N'[NULL]' 

INSERT INTO [Strings] ([Name], [String], [String2], [String3], [ScopeType], [ScopeName], [LockedBy] ) 
VALUES (N'sZwmContWeight', N'Controla Peso', NULL, NULL, 1, N'[NULL]', NULL)
-------------------------------------------------------------------------------
DELETE FROM [Strings] WHERE [Name] = N'sZwmConVolVol' AND [ScopeType] = 1 AND [ScopeName] = N'[NULL]' 

INSERT INTO [Strings] ([Name], [String], [String2], [String3], [ScopeType], [ScopeName], [LockedBy] ) 
VALUES (N'sZwmConVolVol', N'Controla Vol' + NCHAR(250) + N'men Aforado', NULL, NULL, 1, N'[NULL]', NULL)
-------------------------------------------------------------------------------
DELETE FROM [Strings] WHERE [Name] = N'sZwmConVolWeight' AND [ScopeType] = 1 AND [ScopeName] = N'[NULL]' 

INSERT INTO [Strings] ([Name], [String], [String2], [String3], [ScopeType], [ScopeName], [LockedBy] ) 
VALUES (N'sZwmConVolWeight', N'Controla Peso Aforado', NULL, NULL, 1, N'[NULL]', NULL)
-------------------------------------------------------------------------------
DELETE FROM [Strings] WHERE [Name] = N'sZwmDeciAttr' AND [ScopeType] = 1 AND [ScopeName] = N'[NULL]' 

INSERT INTO [Strings] ([Name], [String], [String2], [String3], [ScopeType], [ScopeName], [LockedBy] ) 
VALUES (N'sZwmDeciAttr', N'Decimal', NULL, NULL, 1, N'[NULL]', NULL)
-------------------------------------------------------------------------------
DELETE FROM [Strings] WHERE [Name] = N'sZwmDeleteGrnLines' AND [ScopeType] = 1 AND [ScopeName] = N'[NULL]' 

INSERT INTO [Strings] ([Name], [String], [String2], [String3], [ScopeType], [ScopeName], [LockedBy] ) 
VALUES (N'sZwmDeleteGrnLines', N'Borrar Lineas GRN', NULL, NULL, 1, N'[NULL]', NULL)
-------------------------------------------------------------------------------
DELETE FROM [Strings] WHERE [Name] = N'sZwmDepth' AND [ScopeType] = 1 AND [ScopeName] = N'[NULL]' 

INSERT INTO [Strings] ([Name], [String], [String2], [String3], [ScopeType], [ScopeName], [LockedBy] ) 
VALUES (N'sZwmDepth', N'Profundidad', NULL, NULL, 1, N'[NULL]', NULL)
-------------------------------------------------------------------------------
DELETE FROM [Strings] WHERE [Name] = N'sZwmDepthStk1' AND [ScopeType] = 1 AND [ScopeName] = N'[NULL]' 

INSERT INTO [Strings] ([Name], [String], [String2], [String3], [ScopeType], [ScopeName], [LockedBy] ) 
VALUES (N'sZwmDepthStk1', N'Profundidad Stk1', NULL, NULL, 1, N'[NULL]', NULL)
-------------------------------------------------------------------------------
DELETE FROM [Strings] WHERE [Name] = N'sZwmDepthStk2' AND [ScopeType] = 1 AND [ScopeName] = N'[NULL]' 

INSERT INTO [Strings] ([Name], [String], [String2], [String3], [ScopeType], [ScopeName], [LockedBy] ) 
VALUES (N'sZwmDepthStk2', N'Profundidad Stk2', NULL, NULL, 1, N'[NULL]', NULL)
-------------------------------------------------------------------------------
DELETE FROM [Strings] WHERE [Name] = N'sZwmDepthStorage' AND [ScopeType] = 1 AND [ScopeName] = N'[NULL]' 

INSERT INTO [Strings] ([Name], [String], [String2], [String3], [ScopeType], [ScopeName], [LockedBy] ) 
VALUES (N'sZwmDepthStorage', N'Profundidad Almacenamiento', NULL, NULL, 1, N'[NULL]', NULL)
-------------------------------------------------------------------------------
DELETE FROM [Strings] WHERE [Name] = N'sZwmHeight' AND [ScopeType] = 1 AND [ScopeName] = N'[NULL]' 

INSERT INTO [Strings] ([Name], [String], [String2], [String3], [ScopeType], [ScopeName], [LockedBy] ) 
VALUES (N'sZwmHeight', N'Altura', NULL, NULL, 1, N'[NULL]', NULL)
-------------------------------------------------------------------------------
DELETE FROM [Strings] WHERE [Name] = N'sZwmHeightStk1' AND [ScopeType] = 1 AND [ScopeName] = N'[NULL]' 

INSERT INTO [Strings] ([Name], [String], [String2], [String3], [ScopeType], [ScopeName], [LockedBy] ) 
VALUES (N'sZwmHeightStk1', N'Altura Stk1', NULL, NULL, 1, N'[NULL]', NULL)
-------------------------------------------------------------------------------
DELETE FROM [Strings] WHERE [Name] = N'sZwmHeightStk2' AND [ScopeType] = 1 AND [ScopeName] = N'[NULL]' 

INSERT INTO [Strings] ([Name], [String], [String2], [String3], [ScopeType], [ScopeName], [LockedBy] ) 
VALUES (N'sZwmHeightStk2', N'Altura Stk2', NULL, NULL, 1, N'[NULL]', NULL)
-------------------------------------------------------------------------------
DELETE FROM [Strings] WHERE [Name] = N'sZwmHeightStorage' AND [ScopeType] = 1 AND [ScopeName] = N'[NULL]' 

INSERT INTO [Strings] ([Name], [String], [String2], [String3], [ScopeType], [ScopeName], [LockedBy] ) 
VALUES (N'sZwmHeightStorage', N'Altura Almacenamiento', NULL, NULL, 1, N'[NULL]', NULL)
-------------------------------------------------------------------------------
DELETE FROM [Strings] WHERE [Name] = N'sZwmLoc' AND [ScopeType] = 1 AND [ScopeName] = N'[NULL]' 

INSERT INTO [Strings] ([Name], [String], [String2], [String3], [ScopeType], [ScopeName], [LockedBy] ) 
VALUES (N'sZwmLoc', N'Ubicaci' + NCHAR(243) + N'n de Recepci' + NCHAR(243) + N'n', NULL, NULL, 1, N'[NULL]', NULL)
-------------------------------------------------------------------------------
DELETE FROM [Strings] WHERE [Name] = N'sZwmMaxWeight' AND [ScopeType] = 1 AND [ScopeName] = N'[NULL]' 

INSERT INTO [Strings] ([Name], [String], [String2], [String3], [ScopeType], [ScopeName], [LockedBy] ) 
VALUES (N'sZwmMaxWeight', N'Peso M' + NCHAR(225) + N'x', NULL, NULL, 1, N'[NULL]', NULL)
-------------------------------------------------------------------------------
DELETE FROM [Strings] WHERE [Name] = N'sZwmMultLot' AND [ScopeType] = 1 AND [ScopeName] = N'[NULL]' 

INSERT INTO [Strings] ([Name], [String], [String2], [String3], [ScopeType], [ScopeName], [LockedBy] ) 
VALUES (N'sZwmMultLot', N'Permitir lotes m' + NCHAR(250) + N'ltiples', NULL, NULL, 1, N'[NULL]', NULL)
-------------------------------------------------------------------------------
DELETE FROM [Strings] WHERE [Name] = N'sZwmMultProd' AND [ScopeType] = 1 AND [ScopeName] = N'[NULL]' 

INSERT INTO [Strings] ([Name], [String], [String2], [String3], [ScopeType], [ScopeName], [LockedBy] ) 
VALUES (N'sZwmMultProd', N'Permitir M' + NCHAR(250) + N'ltiples productos', NULL, NULL, 1, N'[NULL]', NULL)
-------------------------------------------------------------------------------
DELETE FROM [Strings] WHERE [Name] = N'sZwmPalletQtyByTag' AND [ScopeType] = 1 AND [ScopeName] = N'[NULL]' 

INSERT INTO [Strings] ([Name], [String], [String2], [String3], [ScopeType], [ScopeName], [LockedBy] ) 
VALUES (N'sZwmPalletQtyByTag', N'Etiqueta Pallet: cantidad x etiqueta', NULL, NULL, 1, N'[NULL]', NULL)
-------------------------------------------------------------------------------
DELETE FROM [Strings] WHERE [Name] = N'sZwmPrefixGrn' AND [ScopeType] = 1 AND [ScopeName] = N'[NULL]' 

INSERT INTO [Strings] ([Name], [String], [String2], [String3], [ScopeType], [ScopeName], [LockedBy] ) 
VALUES (N'sZwmPrefixGrn', N'Prefijo NRM', NULL, NULL, 1, N'[NULL]', NULL)
-------------------------------------------------------------------------------
DELETE FROM [Strings] WHERE [Name] = N'sZwmProductQtyByTag' AND [ScopeType] = 1 AND [ScopeName] = N'[NULL]' 

INSERT INTO [Strings] ([Name], [String], [String2], [String3], [ScopeType], [ScopeName], [LockedBy] ) 
VALUES (N'sZwmProductQtyByTag', N'Etiqueta Producto: cantidad x etiqueta', NULL, NULL, 1, N'[NULL]', NULL)
-------------------------------------------------------------------------------
DELETE FROM [Strings] WHERE [Name] = N'sZwmShipDate' AND [ScopeType] = 1 AND [ScopeName] = N'[NULL]' 

INSERT INTO [Strings] ([Name], [String], [String2], [String3], [ScopeType], [ScopeName], [LockedBy] ) 
VALUES (N'sZwmShipDate', N'Ship Date', NULL, NULL, 1, N'[NULL]', NULL)
-------------------------------------------------------------------------------
DELETE FROM [Strings] WHERE [Name] = N'sZwmStk2Height' AND [ScopeType] = 1 AND [ScopeName] = N'[NULL]' 

INSERT INTO [Strings] ([Name], [String], [String2], [String3], [ScopeType], [ScopeName], [LockedBy] ) 
VALUES (N'sZwmStk2Height', N'Altura UMStk2:', NULL, NULL, 1, N'[NULL]', NULL)
-------------------------------------------------------------------------------
DELETE FROM [Strings] WHERE [Name] = N'sZwmStock1' AND [ScopeType] = 1 AND [ScopeName] = N'[NULL]' 

INSERT INTO [Strings] ([Name], [String], [String2], [String3], [ScopeType], [ScopeName], [LockedBy] ) 
VALUES (N'sZwmStock1', N'Stock 1', NULL, NULL, 1, N'[NULL]', NULL)
-------------------------------------------------------------------------------
DELETE FROM [Strings] WHERE [Name] = N'sZwmStock2' AND [ScopeType] = 1 AND [ScopeName] = N'[NULL]' 

INSERT INTO [Strings] ([Name], [String], [String2], [String3], [ScopeType], [ScopeName], [LockedBy] ) 
VALUES (N'sZwmStock2', N'Stock 2', NULL, NULL, 1, N'[NULL]', NULL)
-------------------------------------------------------------------------------
DELETE FROM [Strings] WHERE [Name] = N'sZwmTotVolVol' AND [ScopeType] = 1 AND [ScopeName] = N'[NULL]' 

INSERT INTO [Strings] ([Name], [String], [String2], [String3], [ScopeType], [ScopeName], [LockedBy] ) 
VALUES (N'sZwmTotVolVol', N'Volumen Aforado Total', NULL, NULL, 1, N'[NULL]', NULL)
-------------------------------------------------------------------------------
DELETE FROM [Strings] WHERE [Name] = N'sZwmTotVolWeight' AND [ScopeType] = 1 AND [ScopeName] = N'[NULL]' 

INSERT INTO [Strings] ([Name], [String], [String2], [String3], [ScopeType], [ScopeName], [LockedBy] ) 
VALUES (N'sZwmTotVolWeight', N'Peso Aforado Total', NULL, NULL, 1, N'[NULL]', NULL)
-------------------------------------------------------------------------------
DELETE FROM [Strings] WHERE [Name] = N'sZwmUM' AND [ScopeType] = 1 AND [ScopeName] = N'[NULL]' 

INSERT INTO [Strings] ([Name], [String], [String2], [String3], [ScopeType], [ScopeName], [LockedBy] ) 
VALUES (N'sZwmUM', N'Unidad de Medida', NULL, NULL, 1, N'[NULL]', NULL)
-------------------------------------------------------------------------------
DELETE FROM [Strings] WHERE [Name] = N'sZwmUMBox' AND [ScopeType] = 1 AND [ScopeName] = N'[NULL]' 

INSERT INTO [Strings] ([Name], [String], [String2], [String3], [ScopeType], [ScopeName], [LockedBy] ) 
VALUES (N'sZwmUMBox', N'UM Stock1', NULL, NULL, 1, N'[NULL]', NULL)
-------------------------------------------------------------------------------
DELETE FROM [Strings] WHERE [Name] = N'sZwmUMBoxConv' AND [ScopeType] = 1 AND [ScopeName] = N'[NULL]' 

INSERT INTO [Strings] ([Name], [String], [String2], [String3], [ScopeType], [ScopeName], [LockedBy] ) 
VALUES (N'sZwmUMBoxConv', N'UM Stock1 conv', NULL, NULL, 1, N'[NULL]', NULL)
-------------------------------------------------------------------------------
DELETE FROM [Strings] WHERE [Name] = N'sZwmUmDimension' AND [ScopeType] = 1 AND [ScopeName] = N'[NULL]' 

INSERT INTO [Strings] ([Name], [String], [String2], [String3], [ScopeType], [ScopeName], [LockedBy] ) 
VALUES (N'sZwmUmDimension', N'UM Dimension', NULL, NULL, 1, N'[NULL]', NULL)
-------------------------------------------------------------------------------
DELETE FROM [Strings] WHERE [Name] = N'sZwmUMDimensionStock1' AND [ScopeType] = 1 AND [ScopeName] = N'[NULL]' 

INSERT INTO [Strings] ([Name], [String], [String2], [String3], [ScopeType], [ScopeName], [LockedBy] ) 
VALUES (N'sZwmUMDimensionStock1', N'UMDimension Stock1', NULL, NULL, 1, N'[NULL]', NULL)
-------------------------------------------------------------------------------
DELETE FROM [Strings] WHERE [Name] = N'sZwmUMDimensionStock2' AND [ScopeType] = 1 AND [ScopeName] = N'[NULL]' 

INSERT INTO [Strings] ([Name], [String], [String2], [String3], [ScopeType], [ScopeName], [LockedBy] ) 
VALUES (N'sZwmUMDimensionStock2', N'UMDimension Stock2', NULL, NULL, 1, N'[NULL]', NULL)
-------------------------------------------------------------------------------
DELETE FROM [Strings] WHERE [Name] = N'sZwmUmDimStock1' AND [ScopeType] = 1 AND [ScopeName] = N'[NULL]' 

INSERT INTO [Strings] ([Name], [String], [String2], [String3], [ScopeType], [ScopeName], [LockedBy] ) 
VALUES (N'sZwmUmDimStock1', N'UM Dimensiones Stock1', NULL, NULL, 1, N'[NULL]', NULL)
-------------------------------------------------------------------------------
DELETE FROM [Strings] WHERE [Name] = N'sZwmUmDimStock2' AND [ScopeType] = 1 AND [ScopeName] = N'[NULL]' 

INSERT INTO [Strings] ([Name], [String], [String2], [String3], [ScopeType], [ScopeName], [LockedBy] ) 
VALUES (N'sZwmUmDimStock2', N'UM Dimensiones Stock2', NULL, NULL, 1, N'[NULL]', NULL)
-------------------------------------------------------------------------------
DELETE FROM [Strings] WHERE [Name] = N'sZwmUMPallet' AND [ScopeType] = 1 AND [ScopeName] = N'[NULL]' 

INSERT INTO [Strings] ([Name], [String], [String2], [String3], [ScopeType], [ScopeName], [LockedBy] ) 
VALUES (N'sZwmUMPallet', N'UM Stock2', NULL, NULL, 1, N'[NULL]', NULL)
-------------------------------------------------------------------------------
DELETE FROM [Strings] WHERE [Name] = N'sZwmUMPalletConv' AND [ScopeType] = 1 AND [ScopeName] = N'[NULL]' 

INSERT INTO [Strings] ([Name], [String], [String2], [String3], [ScopeType], [ScopeName], [LockedBy] ) 
VALUES (N'sZwmUMPalletConv', N'UM Stock2 conv', NULL, NULL, 1, N'[NULL]', NULL)
-------------------------------------------------------------------------------
DELETE FROM [Strings] WHERE [Name] = N'sZwmUMSk1' AND [ScopeType] = 1 AND [ScopeName] = N'[NULL]' 

INSERT INTO [Strings] ([Name], [String], [String2], [String3], [ScopeType], [ScopeName], [LockedBy] ) 
VALUES (N'sZwmUMSk1', N'UM Sk1', NULL, NULL, 1, N'[NULL]', NULL)
-------------------------------------------------------------------------------
DELETE FROM [Strings] WHERE [Name] = N'sZwmUMStk1' AND [ScopeType] = 1 AND [ScopeName] = N'[NULL]' 

INSERT INTO [Strings] ([Name], [String], [String2], [String3], [ScopeType], [ScopeName], [LockedBy] ) 
VALUES (N'sZwmUMStk1', N'UM Stk1', NULL, NULL, 1, N'[NULL]', NULL)
-------------------------------------------------------------------------------
DELETE FROM [Strings] WHERE [Name] = N'sZwmUMStk2' AND [ScopeType] = 1 AND [ScopeName] = N'[NULL]' 

INSERT INTO [Strings] ([Name], [String], [String2], [String3], [ScopeType], [ScopeName], [LockedBy] ) 
VALUES (N'sZwmUMStk2', N'UM Stk2', NULL, NULL, 1, N'[NULL]', NULL)
-------------------------------------------------------------------------------
DELETE FROM [Strings] WHERE [Name] = N'sZwmUMVol' AND [ScopeType] = 1 AND [ScopeName] = N'[NULL]' 

INSERT INTO [Strings] ([Name], [String], [String2], [String3], [ScopeType], [ScopeName], [LockedBy] ) 
VALUES (N'sZwmUMVol', N'UM Volumen', NULL, NULL, 1, N'[NULL]', NULL)
-------------------------------------------------------------------------------
DELETE FROM [Strings] WHERE [Name] = N'sZwmUMWeight' AND [ScopeType] = 1 AND [ScopeName] = N'[NULL]' 

INSERT INTO [Strings] ([Name], [String], [String2], [String3], [ScopeType], [ScopeName], [LockedBy] ) 
VALUES (N'sZwmUMWeight', N'UM Peso', NULL, NULL, 1, N'[NULL]', NULL)
-------------------------------------------------------------------------------
DELETE FROM [Strings] WHERE [Name] = N'sZwmVol' AND [ScopeType] = 1 AND [ScopeName] = N'[NULL]' 

INSERT INTO [Strings] ([Name], [String], [String2], [String3], [ScopeType], [ScopeName], [LockedBy] ) 
VALUES (N'sZwmVol', N'Vol' + NCHAR(250) + N'men', NULL, NULL, 1, N'[NULL]', NULL)
-------------------------------------------------------------------------------
DELETE FROM [Strings] WHERE [Name] = N'sZwmVolFactor' AND [ScopeType] = 1 AND [ScopeName] = N'[NULL]' 

INSERT INTO [Strings] ([Name], [String], [String2], [String3], [ScopeType], [ScopeName], [LockedBy] ) 
VALUES (N'sZwmVolFactor', N'Factor Volumetrico (peso aforado)', NULL, NULL, 1, N'[NULL]', NULL)
-------------------------------------------------------------------------------
DELETE FROM [Strings] WHERE [Name] = N'sZwmVolStk1' AND [ScopeType] = 1 AND [ScopeName] = N'[NULL]' 

INSERT INTO [Strings] ([Name], [String], [String2], [String3], [ScopeType], [ScopeName], [LockedBy] ) 
VALUES (N'sZwmVolStk1', N'Vol' + NCHAR(250) + N'men Stk1', NULL, NULL, 1, N'[NULL]', NULL)
-------------------------------------------------------------------------------
DELETE FROM [Strings] WHERE [Name] = N'sZwmVolStk2' AND [ScopeType] = 1 AND [ScopeName] = N'[NULL]' 

INSERT INTO [Strings] ([Name], [String], [String2], [String3], [ScopeType], [ScopeName], [LockedBy] ) 
VALUES (N'sZwmVolStk2', N'Vol' + NCHAR(250) + N'men Stk2', NULL, NULL, 1, N'[NULL]', NULL)
-------------------------------------------------------------------------------
DELETE FROM [Strings] WHERE [Name] = N'sZwmVolume' AND [ScopeType] = 1 AND [ScopeName] = N'[NULL]' 

INSERT INTO [Strings] ([Name], [String], [String2], [String3], [ScopeType], [ScopeName], [LockedBy] ) 
VALUES (N'sZwmVolume', N'Volumen', NULL, NULL, 1, N'[NULL]', NULL)
-------------------------------------------------------------------------------
DELETE FROM [Strings] WHERE [Name] = N'sZwmVolumetricWeight' AND [ScopeType] = 1 AND [ScopeName] = N'[NULL]' 

INSERT INTO [Strings] ([Name], [String], [String2], [String3], [ScopeType], [ScopeName], [LockedBy] ) 
VALUES (N'sZwmVolumetricWeight', N'Peso aforado', NULL, NULL, 1, N'[NULL]', NULL)
-------------------------------------------------------------------------------
DELETE FROM [Strings] WHERE [Name] = N'sZwmVolVolUM' AND [ScopeType] = 1 AND [ScopeName] = N'[NULL]' 

INSERT INTO [Strings] ([Name], [String], [String2], [String3], [ScopeType], [ScopeName], [LockedBy] ) 
VALUES (N'sZwmVolVolUM', N'UM Vol' + NCHAR(250) + N'men', NULL, NULL, 1, N'[NULL]', NULL)
-------------------------------------------------------------------------------
DELETE FROM [Strings] WHERE [Name] = N'sZwmVolWeightUM' AND [ScopeType] = 1 AND [ScopeName] = N'[NULL]' 

INSERT INTO [Strings] ([Name], [String], [String2], [String3], [ScopeType], [ScopeName], [LockedBy] ) 
VALUES (N'sZwmVolWeightUM', N'UM Peso', NULL, NULL, 1, N'[NULL]', NULL)
-------------------------------------------------------------------------------
DELETE FROM [Strings] WHERE [Name] = N'sZwmWidth' AND [ScopeType] = 1 AND [ScopeName] = N'[NULL]' 

INSERT INTO [Strings] ([Name], [String], [String2], [String3], [ScopeType], [ScopeName], [LockedBy] ) 
VALUES (N'sZwmWidth', N'Ancho', NULL, NULL, 1, N'[NULL]', NULL)
-------------------------------------------------------------------------------
DELETE FROM [Strings] WHERE [Name] = N'sZwmWidthStk1' AND [ScopeType] = 1 AND [ScopeName] = N'[NULL]' 

INSERT INTO [Strings] ([Name], [String], [String2], [String3], [ScopeType], [ScopeName], [LockedBy] ) 
VALUES (N'sZwmWidthStk1', N'Ancho Stk1', NULL, NULL, 1, N'[NULL]', NULL)
-------------------------------------------------------------------------------
DELETE FROM [Strings] WHERE [Name] = N'sZwmWidthStk2' AND [ScopeType] = 1 AND [ScopeName] = N'[NULL]' 

INSERT INTO [Strings] ([Name], [String], [String2], [String3], [ScopeType], [ScopeName], [LockedBy] ) 
VALUES (N'sZwmWidthStk2', N'Ancho Stk2', NULL, NULL, 1, N'[NULL]', NULL)
-------------------------------------------------------------------------------
DELETE FROM [Strings] WHERE [Name] = N'sZwmWidthStorage' AND [ScopeType] = 1 AND [ScopeName] = N'[NULL]' 

INSERT INTO [Strings] ([Name], [String], [String2], [String3], [ScopeType], [ScopeName], [LockedBy] ) 
VALUES (N'sZwmWidthStorage', N'Ancho Almacenamiento', NULL, NULL, 1, N'[NULL]', NULL)
-------------------------------------------------------------------------------
DELETE FROM [Strings] WHERE [Name] = N'sZwmZone' AND [ScopeType] = 1 AND [ScopeName] = N'[NULL]' 

INSERT INTO [Strings] ([Name], [String], [String2], [String3], [ScopeType], [ScopeName], [LockedBy] ) 
VALUES (N'sZwmZone', N'Zone', NULL, NULL, 1, N'[NULL]', NULL)
-------------------------------------------------------------------------------
DELETE FROM [Strings] WHERE [Name] = N'fZwmRFRecConsReport' AND [ScopeType] = 1 AND [ScopeName] = N'[NULL]' 

INSERT INTO [Strings] ([Name], [String], [String2], [String3], [ScopeType], [ScopeName], [LockedBy] ) 
VALUES (N'fZwmRFRecConsReport', N'Reporte de Recepci' + NCHAR(243) + N'n Consolidada', NULL, NULL, 1, N'[NULL]', NULL)
-------------------------------------------------------------------------------
DELETE FROM [Strings] WHERE [Name] = N'sZwmIdRecCons' AND [ScopeType] = 1 AND [ScopeName] = N'[NULL]' 

INSERT INTO [Strings] ([Name], [String], [String2], [String3], [ScopeType], [ScopeName], [LockedBy] ) 
VALUES (N'sZwmIdRecCons', N'Id Recepcion Consolidada', NULL, NULL, 1, N'[NULL]', NULL)
-------------------------------------------------------------------------------
DELETE FROM [Strings] WHERE [Name] = N'sZwmQtyGrn' AND [ScopeType] = 1 AND [ScopeName] = N'[NULL]' 

INSERT INTO [Strings] ([Name], [String], [String2], [String3], [ScopeType], [ScopeName], [LockedBy] ) 
VALUES (N'sZwmQtyGrn', N'GRN Qty', NULL, NULL, 1, N'[NULL]', NULL)
-------------------------------------------------------------------------------
DELETE FROM [Strings] WHERE [Name] = N'sZwmStk1PrintLabels' AND [ScopeType] = 1 AND [ScopeName] = N'[NULL]' 

INSERT INTO [Strings] ([Name], [String], [String2], [String3], [ScopeType], [ScopeName], [LockedBy] ) 
VALUES (N'sZwmStk1PrintLabels', N'Imprime Etiquetas UMStk1', NULL, NULL, 1, N'[NULL]', NULL)
-------------------------------------------------------------------------------
DELETE FROM [Strings] WHERE [Name] = N'sZwmStk2PrintLabels' AND [ScopeType] = 1 AND [ScopeName] = N'[NULL]' 

INSERT INTO [Strings] ([Name], [String], [String2], [String3], [ScopeType], [ScopeName], [LockedBy] ) 
VALUES (N'sZwmStk2PrintLabels', N'Imprime Etiquetas UMStk2', NULL, NULL, 1, N'[NULL]', NULL)
-------------------------------------------------------------------------------
DELETE FROM [Strings] WHERE [Name] = N'sZwmEarlyShip' AND [ScopeType] = 1 AND [ScopeName] = N'[NULL]' 

INSERT INTO [Strings] ([Name], [String], [String2], [String3], [ScopeType], [ScopeName], [LockedBy] ) 
VALUES (N'sZwmEarlyShip', N'Orders with Early Ship', NULL, NULL, 1, N'[NULL]', NULL)
-------------------------------------------------------------------------------
DELETE FROM [Strings] WHERE [Name] = N'sZwmObs' AND [ScopeType] = 1 AND [ScopeName] = N'[NULL]' 

INSERT INTO [Strings] ([Name], [String], [String2], [String3], [ScopeType], [ScopeName], [LockedBy] ) 
VALUES (N'sZwmObs', N'Observations', NULL, NULL, 1, N'[NULL]', NULL)
-------------------------------------------------------------------------------
DELETE FROM [Strings] WHERE [Name] = N'sZwmRouteId' AND [ScopeType] = 1 AND [ScopeName] = N'[NULL]' 

INSERT INTO [Strings] ([Name], [String], [String2], [String3], [ScopeType], [ScopeName], [LockedBy] ) 
VALUES (N'sZwmRouteId', N'Hoja de Ruta de Pickeo', NULL, NULL, 1, N'[NULL]', NULL)
-------------------------------------------------------------------------------
DELETE FROM [Strings] WHERE [Name] = N'sZwmShipType' AND [ScopeType] = 1 AND [ScopeName] = N'[NULL]' 

INSERT INTO [Strings] ([Name], [String], [String2], [String3], [ScopeType], [ScopeName], [LockedBy] ) 
VALUES (N'sZwmShipType', N'Ship Type', NULL, NULL, 1, N'[NULL]', NULL)
-------------------------------------------------------------------------------
DELETE FROM [Strings] WHERE [Name] = N'fZWMLocationLabelsReport' AND [ScopeType] = 1 AND [ScopeName] = N'[NULL]' 

INSERT INTO [Strings] ([Name], [String], [String2], [String3], [ScopeType], [ScopeName], [LockedBy] ) 
VALUES (N'fZWMLocationLabelsReport', N'Reporte etiquetas ubicaciones', NULL, NULL, 1, N'[NULL]', NULL)
-------------------------------------------------------------------------------
DELETE FROM [Strings] WHERE [Name] = N'fZWMPickRouteReport' AND [ScopeType] = 1 AND [ScopeName] = N'[NULL]' 

INSERT INTO [Strings] ([Name], [String], [String2], [String3], [ScopeType], [ScopeName], [LockedBy] ) 
VALUES (N'fZWMPickRouteReport', N'Reporte Hoja de Ruta', NULL, NULL, 1, N'[NULL]', NULL)
-------------------------------------------------------------------------------
DELETE FROM [Strings] WHERE [Name] = N'sZwmStk1PrintLabels' AND [ScopeType] = 1 AND [ScopeName] = N'[NULL]' 

INSERT INTO [Strings] ([Name], [String], [String2], [String3], [ScopeType], [ScopeName], [LockedBy] ) 
VALUES (N'sZwmStk1PrintLabels', N'Imprime Etiquetas Producto', NULL, NULL, 1, N'[NULL]', NULL)
-------------------------------------------------------------------------------
DELETE FROM [Strings] WHERE [Name] = N'sZwmStk2PrintLabels' AND [ScopeType] = 1 AND [ScopeName] = N'[NULL]' 

INSERT INTO [Strings] ([Name], [String], [String2], [String3], [ScopeType], [ScopeName], [LockedBy] ) 
VALUES (N'sZwmStk2PrintLabels', N'Imprime Etiquetas Pallet', NULL, NULL, 1, N'[NULL]', NULL)
-------------------------------------------------------------------------------
DELETE FROM [Strings] WHERE [Name] = N'fZwmRouteMapLabels' AND [ScopeType] = 1 AND [ScopeName] = N'[NULL]' 

INSERT INTO [Strings] ([Name], [String], [String2], [String3], [ScopeType], [ScopeName], [LockedBy] ) 
VALUES (N'fZwmRouteMapLabels', N'Etiquetas por Hoja de Ruta', NULL, NULL, 1, N'[NULL]', NULL)
-------------------------------------------------------------------------------
DELETE FROM [Strings] WHERE [Name] = N'sZwmEmptyLoc' AND [ScopeType] = 1 AND [ScopeName] = N'[NULL]' 

INSERT INTO [Strings] ([Name], [String], [String2], [String3], [ScopeType], [ScopeName], [LockedBy] ) 
VALUES (N'sZwmEmptyLoc', N'Solo ubicaciones vac' + NCHAR(237) + N'as', NULL, NULL, 1, N'[NULL]', NULL)
-------------------------------------------------------------------------------
DELETE FROM [Strings] WHERE [Name] = N'sZwmPickQtyByTag' AND [ScopeType] = 1 AND [ScopeName] = N'[NULL]' 

INSERT INTO [Strings] ([Name], [String], [String2], [String3], [ScopeType], [ScopeName], [LockedBy] ) 
VALUES (N'sZwmPickQtyByTag', N'Etiqueta Picking: cantidad x etiqueta', NULL, NULL, 1, N'[NULL]', NULL)
-------------------------------------------------------------------------------
DELETE FROM [Strings] WHERE [Name] = N'fZwmRouteMapLabels' AND [ScopeType] = 1 AND [ScopeName] = N'[NULL]' 

INSERT INTO [Strings] ([Name], [String], [String2], [String3], [ScopeType], [ScopeName], [LockedBy] ) 
VALUES (N'fZwmRouteMapLabels', N'Etiquetas de Pickeo', NULL, NULL, 1, N'[NULL]', NULL)
-------------------------------------------------------------------------------
DELETE FROM [Strings] WHERE [Name] = N'sZwmPickQtyByTag' AND [ScopeType] = 1 AND [ScopeName] = N'[NULL]' 

INSERT INTO [Strings] ([Name], [String], [String2], [String3], [ScopeType], [ScopeName], [LockedBy] ) 
VALUES (N'sZwmPickQtyByTag', N'Etiqueta Picking: cantidad x etiqueta', NULL, NULL, 1, N'[NULL]', NULL)
-------------------------------------------------------------------------------
DELETE FROM [Strings] WHERE [Name] = N'sZwmReservationType' AND [ScopeType] = 1 AND [ScopeName] = N'[NULL]' 

INSERT INTO [Strings] ([Name], [String], [String2], [String3], [ScopeType], [ScopeName], [LockedBy] ) 
VALUES (N'sZwmReservationType', N'Tipo de Reserva', NULL, NULL, 1, N'[NULL]', NULL)
-------------------------------------------------------------------------------
DELETE FROM [Strings] WHERE [Name] = N'sZwmReservPct' AND [ScopeType] = 1 AND [ScopeName] = N'[NULL]' 

INSERT INTO [Strings] ([Name], [String], [String2], [String3], [ScopeType], [ScopeName], [LockedBy] ) 
VALUES (N'sZwmReservPct', N'Porcentaje de Reserva', NULL, NULL, 1, N'[NULL]', NULL)
-------------------------------------------------------------------------------
DELETE FROM [Strings] WHERE [Name] = N'sZwmRouteSheet' AND [ScopeType] = 1 AND [ScopeName] = N'[NULL]' 

INSERT INTO [Strings] ([Name], [String], [String2], [String3], [ScopeType], [ScopeName], [LockedBy] ) 
VALUES (N'sZwmRouteSheet', N'Hoja de Ruta', NULL, NULL, 1, N'[NULL]', NULL)
-------------------------------------------------------------------------------
DELETE FROM [Strings] WHERE [Name] = N'sZwmUndeliveredQty' AND [ScopeType] = 1 AND [ScopeName] = N'[NULL]' 

INSERT INTO [Strings] ([Name], [String], [String2], [String3], [ScopeType], [ScopeName], [LockedBy] ) 
VALUES (N'sZwmUndeliveredQty', N'Cantidad no entregada', NULL, NULL, 1, N'[NULL]', NULL)
-------------------------------------------------------------------------------
DELETE FROM [Strings] WHERE [Name] = N'sZwmUndeliveredQtyProc' AND [ScopeType] = 1 AND [ScopeName] = N'[NULL]' 

INSERT INTO [Strings] ([Name], [String], [String2], [String3], [ScopeType], [ScopeName], [LockedBy] ) 
VALUES (N'sZwmUndeliveredQtyProc', N'Cantidad no entregada procesada', NULL, NULL, 1, N'[NULL]', NULL)
-------------------------------------------------------------------------------
DELETE FROM [Strings] WHERE [Name] = N'fZwmShipmentConformity' AND [ScopeType] = 1 AND [ScopeName] = N'[NULL]' 

INSERT INTO [Strings] ([Name], [String], [String2], [String3], [ScopeType], [ScopeName], [LockedBy] ) 
VALUES (N'fZwmShipmentConformity', N'Conformidad de Entrega', NULL, NULL, 1, N'[NULL]', NULL)
-------------------------------------------------------------------------------
DELETE FROM [Strings] WHERE [Name] = N'fZwmShipmentConformityLines' AND [ScopeType] = 1 AND [ScopeName] = N'[NULL]' 

INSERT INTO [Strings] ([Name], [String], [String2], [String3], [ScopeType], [ScopeName], [LockedBy] ) 
VALUES (N'fZwmShipmentConformityLines', N'Lineas de conformidad de Entrega', NULL, NULL, 1, N'[NULL]', NULL)
-------------------------------------------------------------------------------
DELETE FROM [Strings] WHERE [Name] = N'sZwmPackNumber' AND [ScopeType] = 1 AND [ScopeName] = N'[NULL]' 

INSERT INTO [Strings] ([Name], [String], [String2], [String3], [ScopeType], [ScopeName], [LockedBy] ) 
VALUES (N'sZwmPackNumber', N'Pack Number', NULL, NULL, 1, N'[NULL]', NULL)
-------------------------------------------------------------------------------
DELETE FROM [Strings] WHERE [Name] = N'fZwmTrnPickWorkbench' AND [ScopeType] = 1 AND [ScopeName] = N'[NULL]' 

INSERT INTO [Strings] ([Name], [String], [String2], [String3], [ScopeType], [ScopeName], [LockedBy] ) 
VALUES (N'fZwmTrnPickWorkbench', N'Pick Workbench Ordenes de Transferencias ', NULL, NULL, 1, N'[NULL]', NULL)
-------------------------------------------------------------------------------
DELETE FROM [Strings] WHERE [Name] = N'sZwmPrefixTransferPicklist' AND [ScopeType] = 1 AND [ScopeName] = N'[NULL]' 

INSERT INTO [Strings] ([Name], [String], [String2], [String3], [ScopeType], [ScopeName], [LockedBy] ) 
VALUES (N'sZwmPrefixTransferPicklist', N'Prefijo Ordenes de Transferencias', NULL, NULL, 1, N'[NULL]', NULL)
-------------------------------------------------------------------------------
DELETE FROM [Strings] WHERE [Name] = N'sZwmShipNum' AND [ScopeType] = 1 AND [ScopeName] = N'[NULL]' 

INSERT INTO [Strings] ([Name], [String], [String2], [String3], [ScopeType], [ScopeName], [LockedBy] ) 
VALUES (N'sZwmShipNum', N'Nro Remito', NULL, NULL, 1, N'[NULL]', NULL)
-------------------------------------------------------------------------------
DELETE FROM [Strings] WHERE [Name] = N'sZwmShipViaPickList' AND [ScopeType] = 1 AND [ScopeName] = N'[NULL]' 

INSERT INTO [Strings] ([Name], [String], [String2], [String3], [ScopeType], [ScopeName], [LockedBy] ) 
VALUES (N'sZwmShipViaPickList', N'Ship Via Pick List', NULL, NULL, 1, N'[NULL]', NULL)
-------------------------------------------------------------------------------
DELETE FROM [Strings] WHERE [Name] = N'sZwmTrnShipViaDefault' AND [ScopeType] = 1 AND [ScopeName] = N'[NULL]' 

INSERT INTO [Strings] ([Name], [String], [String2], [String3], [ScopeType], [ScopeName], [LockedBy] ) 
VALUES (N'sZwmTrnShipViaDefault', N'Ship Via Ordenes de Transferencias', NULL, NULL, 1, N'[NULL]', NULL)
-------------------------------------------------------------------------------
DELETE FROM [Strings] WHERE [Name] = N'fZwmTransferOrders' AND [ScopeType] = 1 AND [ScopeName] = N'[NULL]' 

INSERT INTO [Strings] ([Name], [String], [String2], [String3], [ScopeType], [ScopeName], [LockedBy] ) 
VALUES (N'fZwmTransferOrders', N'Generacion de Ordenes de Transferencias segun reservas', NULL, NULL, 1, N'[NULL]', NULL)
-------------------------------------------------------------------------------
DELETE FROM [Strings] WHERE [Name] = N'fZwmTrnPickWorkbench' AND [ScopeType] = 1 AND [ScopeName] = N'[NULL]' 

INSERT INTO [Strings] ([Name], [String], [String2], [String3], [ScopeType], [ScopeName], [LockedBy] ) 
VALUES (N'fZwmTrnPickWorkbench', N'Pick Workbench Ordenes de Transferencias ', NULL, NULL, 1, N'[NULL]', NULL)
-------------------------------------------------------------------------------
DELETE FROM [Strings] WHERE [Name] = N'sZwmLocFromRsvd' AND [ScopeType] = 1 AND [ScopeName] = N'[NULL]' 

INSERT INTO [Strings] ([Name], [String], [String2], [String3], [ScopeType], [ScopeName], [LockedBy] ) 
VALUES (N'sZwmLocFromRsvd', N'Asignar cantidad desde las reservas', NULL, NULL, 1, N'[NULL]', NULL)
-------------------------------------------------------------------------------
DELETE FROM [Strings] WHERE [Name] = N'sZwmWhseDest' AND [ScopeType] = 1 AND [ScopeName] = N'[NULL]' 

INSERT INTO [Strings] ([Name], [String], [String2], [String3], [ScopeType], [ScopeName], [LockedBy] ) 
VALUES (N'sZwmWhseDest', N'Dep' + NCHAR(243) + N'sito Destino', NULL, NULL, 1, N'[NULL]', NULL)
-------------------------------------------------------------------------------
DELETE FROM [Strings] WHERE [Name] = N'sZwmWhseOrig' AND [ScopeType] = 1 AND [ScopeName] = N'[NULL]' 

INSERT INTO [Strings] ([Name], [String], [String2], [String3], [ScopeType], [ScopeName], [LockedBy] ) 
VALUES (N'sZwmWhseOrig', N'Dep' + NCHAR(243) + N'sito Or' + NCHAR(237) + N'gen', NULL, NULL, 1, N'[NULL]', NULL)
-------------------------------------------------------------------------------
DELETE FROM [Strings] WHERE [Name] = N'fZwmTransferOrders' AND [ScopeType] = 1 AND [ScopeName] = N'[NULL]' 

INSERT INTO [Strings] ([Name], [String], [String2], [String3], [ScopeType], [ScopeName], [LockedBy] ) 
VALUES (N'fZwmTransferOrders', N'Generacion de Ordenes de Transferencias segun reservas', NULL, NULL, 1, N'[NULL]', NULL)
-------------------------------------------------------------------------------
DELETE FROM [Strings] WHERE [Name] = N'fZwmTrnPickWorkbench' AND [ScopeType] = 1 AND [ScopeName] = N'[NULL]' 

INSERT INTO [Strings] ([Name], [String], [String2], [String3], [ScopeType], [ScopeName], [LockedBy] ) 
VALUES (N'fZwmTrnPickWorkbench', N'Pick Workbench Ordenes de Transferencias ', NULL, NULL, 1, N'[NULL]', NULL)
-------------------------------------------------------------------------------
DELETE FROM [Strings] WHERE [Name] = N'sZwmLocFromRsvd' AND [ScopeType] = 1 AND [ScopeName] = N'[NULL]' 

INSERT INTO [Strings] ([Name], [String], [String2], [String3], [ScopeType], [ScopeName], [LockedBy] ) 
VALUES (N'sZwmLocFromRsvd', N'Asignar cantidad desde las reservas', NULL, NULL, 1, N'[NULL]', NULL)
-------------------------------------------------------------------------------
DELETE FROM [Strings] WHERE [Name] = N'sZwmPrefixTransferPicklist' AND [ScopeType] = 1 AND [ScopeName] = N'[NULL]' 

INSERT INTO [Strings] ([Name], [String], [String2], [String3], [ScopeType], [ScopeName], [LockedBy] ) 
VALUES (N'sZwmPrefixTransferPicklist', N'Prefijo Ordenes de Transferencias', NULL, NULL, 1, N'[NULL]', NULL)
-------------------------------------------------------------------------------
DELETE FROM [Strings] WHERE [Name] = N'sZwmShipNum' AND [ScopeType] = 1 AND [ScopeName] = N'[NULL]' 

INSERT INTO [Strings] ([Name], [String], [String2], [String3], [ScopeType], [ScopeName], [LockedBy] ) 
VALUES (N'sZwmShipNum', N'Nro Remito', NULL, NULL, 1, N'[NULL]', NULL)
-------------------------------------------------------------------------------
DELETE FROM [Strings] WHERE [Name] = N'sZwmShipTrn' AND [ScopeType] = 1 AND [ScopeName] = N'[NULL]' 

INSERT INTO [Strings] ([Name], [String], [String2], [String3], [ScopeType], [ScopeName], [LockedBy] ) 
VALUES (N'sZwmShipTrn', N'Ship Transfer', NULL, NULL, 1, N'[NULL]', NULL)
-------------------------------------------------------------------------------
DELETE FROM [Strings] WHERE [Name] = N'sZwmShipViaPickList' AND [ScopeType] = 1 AND [ScopeName] = N'[NULL]' 

INSERT INTO [Strings] ([Name], [String], [String2], [String3], [ScopeType], [ScopeName], [LockedBy] ) 
VALUES (N'sZwmShipViaPickList', N'Ship Via Pick List', NULL, NULL, 1, N'[NULL]', NULL)
-------------------------------------------------------------------------------
DELETE FROM [Strings] WHERE [Name] = N'sZwmTransferPickList' AND [ScopeType] = 1 AND [ScopeName] = N'[NULL]' 

INSERT INTO [Strings] ([Name], [String], [String2], [String3], [ScopeType], [ScopeName], [LockedBy] ) 
VALUES (N'sZwmTransferPickList', N'Transfer Pick List', NULL, NULL, 1, N'[NULL]', NULL)
-------------------------------------------------------------------------------
DELETE FROM [Strings] WHERE [Name] = N'sZwmTrnShipViaDefault' AND [ScopeType] = 1 AND [ScopeName] = N'[NULL]' 

INSERT INTO [Strings] ([Name], [String], [String2], [String3], [ScopeType], [ScopeName], [LockedBy] ) 
VALUES (N'sZwmTrnShipViaDefault', N'Ship Via Ordenes de Transferencias', NULL, NULL, 1, N'[NULL]', NULL)
-------------------------------------------------------------------------------
DELETE FROM [Strings] WHERE [Name] = N'sZwmWhseDest' AND [ScopeType] = 1 AND [ScopeName] = N'[NULL]' 

INSERT INTO [Strings] ([Name], [String], [String2], [String3], [ScopeType], [ScopeName], [LockedBy] ) 
VALUES (N'sZwmWhseDest', N'Dep' + NCHAR(243) + N'sito Destino', NULL, NULL, 1, N'[NULL]', NULL)
-------------------------------------------------------------------------------
DELETE FROM [Strings] WHERE [Name] = N'sZwmWhseOrig' AND [ScopeType] = 1 AND [ScopeName] = N'[NULL]' 

INSERT INTO [Strings] ([Name], [String], [String2], [String3], [ScopeType], [ScopeName], [LockedBy] ) 
VALUES (N'sZwmWhseOrig', N'Dep' + NCHAR(243) + N'sito Or' + NCHAR(237) + N'gen', NULL, NULL, 1, N'[NULL]', NULL)
-------------------------------------------------------------------------------
DELETE FROM [Strings] WHERE [Name] = N'sZwmColBox' AND [ScopeType] = 1 AND [ScopeName] = N'[NULL]' 

INSERT INTO [Strings] ([Name], [String], [String2], [String3], [ScopeType], [ScopeName], [LockedBy] ) 
VALUES (N'sZwmColBox', N'Collected Box', NULL, NULL, 1, N'[NULL]', NULL)
-------------------------------------------------------------------------------
DELETE FROM [Strings] WHERE [Name] = N'sZwmOrdersWithRsvd' AND [ScopeType] = 1 AND [ScopeName] = N'[NULL]' 

INSERT INTO [Strings] ([Name], [String], [String2], [String3], [ScopeType], [ScopeName], [LockedBy] ) 
VALUES (N'sZwmOrdersWithRsvd', N'Only orders with associated reserve', NULL, NULL, 1, N'[NULL]', NULL)
-------------------------------------------------------------------------------
DELETE FROM [Strings] WHERE [Name] = N'sZwmCustomRsvd' AND [ScopeType] = 1 AND [ScopeName] = N'[NULL]' 

INSERT INTO [Strings] ([Name], [String], [String2], [String3], [ScopeType], [ScopeName], [LockedBy] ) 
VALUES (N'sZwmCustomRsvd', N'Logica de Reserva particular del cliente', NULL, NULL, 1, N'[NULL]', NULL)
-------------------------------------------------------------------------------
DELETE FROM [Strings] WHERE [Name] = N'sZwmFreightCalcAcumDueDate' AND [ScopeType] = 1 AND [ScopeName] = N'[NULL]' 

INSERT INTO [Strings] ([Name], [String], [String2], [String3], [ScopeType], [ScopeName], [LockedBy] ) 
VALUES (N'sZwmFreightCalcAcumDueDate', N'Acumula fecha de entrega p/ calculo de flete', NULL, NULL, 1, N'[NULL]', NULL)
-------------------------------------------------------------------------------
DELETE FROM [Strings] WHERE [Name] = N'sZwmPrefixCustomCustomer' AND [ScopeType] = 1 AND [ScopeName] = N'[NULL]' 

INSERT INTO [Strings] ([Name], [String], [String2], [String3], [ScopeType], [ScopeName], [LockedBy] ) 
VALUES (N'sZwmPrefixCustomCustomer', N'Prefijo customizaci' + NCHAR(243) + N'n cliente', NULL, NULL, 1, N'[NULL]', NULL)
-------------------------------------------------------------------------------
DELETE FROM [Strings] WHERE [Name] = N'sZwmLocTrnOrder' AND [ScopeType] = 1 AND [ScopeName] = N'[NULL]' 

INSERT INTO [Strings] ([Name], [String], [String2], [String3], [ScopeType], [ScopeName], [LockedBy] ) 
VALUES (N'sZwmLocTrnOrder', N'Ubicaci' + NCHAR(243) + N'n de Recepci' + NCHAR(243) + N'n Transferencias', NULL, NULL, 1, N'[NULL]', NULL)
-------------------------------------------------------------------------------
DELETE FROM [Strings] WHERE [Name] = N'sZwmTrnShipViaDefault' AND [ScopeType] = 1 AND [ScopeName] = N'[NULL]' 

INSERT INTO [Strings] ([Name], [String], [String2], [String3], [ScopeType], [ScopeName], [LockedBy] ) 
VALUES (N'sZwmTrnShipViaDefault', N'Ship Via Transferencias', NULL, NULL, 1, N'[NULL]', NULL)
-------------------------------------------------------------------------------