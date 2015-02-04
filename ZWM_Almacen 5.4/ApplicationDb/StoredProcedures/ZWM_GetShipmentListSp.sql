/****** Object:  StoredProcedure [dbo].[ZWM_GetShipmentListSp]    Script Date: 01/09/2015 14:44:34 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ZWM_GetShipmentListSp]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ZWM_GetShipmentListSp]
GO

/****** Object:  StoredProcedure [dbo].[ZWM_GetShipmentListSp]    Script Date: 01/09/2015 14:44:34 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[ZWM_GetShipmentListSp] (
	@PickListId PickListIDType,
	@InfoBar InfoBarType OUTPUT
	)
AS

 -- Check for existence of Generic External Touch Point routine (this section was generated by SpETPCodeSp and inserted by CallETPs.exe):
   IF OBJECT_ID(N'dbo.EXTGEN_ZWM_GetShipmentListSp') IS NOT NULL
   BEGIN
      DECLARE @EXTGEN_SpName sysname
      SET @EXTGEN_SpName = N'dbo.EXTGEN_ZWM_GetShipmentListSp'
      -- Invoke the ETP routine, passing in (and out) this routine's parameters:
      DECLARE @EXTGEN_Severity int
      EXEC @EXTGEN_Severity = @EXTGEN_SpName
		@PickListId,
		@InfoBar  OUTPUT	
 
      -- ETP routine can RETURN 1 to signal that the remainder of this standard routine should now proceed:
      IF @EXTGEN_Severity <> 1
         RETURN @EXTGEN_Severity
   END
   -- End of Generic External Touch Point code.
   
   

DECLARE @Severity INT
SELECT @Severity = 0


IF @PickListID IS NOT NULL
	SELECT DISTINCT shipment.shipment_id,  dbo.MsgAppSubSp('&1', '@:ShipmentStatus' + ISNULL(shipment.status,''), '&1'),
	                custaddr.name, shipment.cust_seq, shipment.zla_do_num
	FROM shipment_line
	JOIN shipment ON shipment.shipment_id = shipment_line.shipment_id
	JOIN custaddr ON custaddr.cust_num = shipment.cust_num AND custaddr.cust_seq = shipment.cust_seq
	WHERE shipment_line.pick_list_id = @PickListId
	ORDER BY shipment_id DESC
ELSE
	SELECT shipment.shipment_id,  dbo.MsgAppSubSp('&1', '@:ShipmentStatus' + ISNULL(shipment.status,''), '&1'),
	                custaddr.name, shipment.cust_seq, shipment.zla_do_num
	FROM shipment	
	JOIN custaddr ON custaddr.cust_num = shipment.cust_num AND custaddr.cust_seq = shipment.cust_seq
	ORDER BY shipment_id DESC

RETURN @severity

GO


