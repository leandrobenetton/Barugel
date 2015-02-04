-- Coloca 0 en la columna ZWM_Delivered donde el valor es NULL para que funcione correctamente el form ZWM_ShipmentConformity
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'shipment_mst' AND COLUMN_NAME = 'ZWM_Delivered')
update shipment_mst set ZWM_Delivered = 0 where ZWM_Delivered is null