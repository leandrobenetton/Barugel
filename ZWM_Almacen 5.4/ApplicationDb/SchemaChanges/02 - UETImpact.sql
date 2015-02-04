GO
--Impact Data Base Tables
Declare
@RedoViews tinyint,
@Infobar InfobarType
EXEC UETImpactWrapperSp 
1,
0,
1,
@RedoViews OUTPUT,
@Infobar OUTPUT
GO