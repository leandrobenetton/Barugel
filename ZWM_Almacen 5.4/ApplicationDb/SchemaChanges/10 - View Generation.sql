DECLARE @RC int
DECLARE @StartingTable TableNameType
DECLARE @EndingTable TableNameType
DECLARE @Infobar InfobarType

-- TODO: Set parameter values here.

EXECUTE @RC = [dbo].[CreateViewsOverMultiSiteTablesSp] 
   @StartingTable
  ,@EndingTable
  ,@Infobar OUTPUT

GO

