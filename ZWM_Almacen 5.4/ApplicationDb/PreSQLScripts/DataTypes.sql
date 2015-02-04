IF NOT EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'ZwmBarCodeType' AND ss.name = N'dbo')

CREATE TYPE [dbo].[ZwmBarCodeType] FROM [varchar](40) NOT NULL
GO

-------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'ZwmContNumberType' AND ss.name = N'dbo')

CREATE TYPE [dbo].[ZwmContNumberType] FROM [nvarchar](15) NOT NULL
GO

-------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'ZwmIdRFConsType' AND ss.name = N'dbo')

CREATE TYPE [dbo].[ZwmIdRFConsType] FROM [nvarchar](15) NOT NULL
GO

-------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'ZwmUMQtyByTag' AND ss.name = N'dbo')

CREATE TYPE [dbo].[ZwmUMQtyByTag] FROM [int] NOT NULL
GO

-------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'ZwmUMStock' AND ss.name = N'dbo')

CREATE TYPE [dbo].[ZwmUMStock] FROM [decimal](19, 8) NOT NULL
GO

-------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'ZwmUser' AND ss.name = N'dbo')

CREATE TYPE [dbo].[ZwmUser] FROM [nvarchar](39) NOT NULL
GO

-------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'GrnPackNumType' AND ss.name = N'dbo')

CREATE TYPE [dbo].[GrnPackNumType] FROM [nvarchar](30) NULL
GO
-------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'ZwmStockMeasuresType' AND ss.name = N'dbo')

CREATE TYPE [dbo].[ZwmStockMeasuresType] FROM [decimal](11, 3) NOT NULL
GO

-------------------------------------------------------------------------------------------------------------------------

IF NOT EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'ZwmCoefVolWeightType' AND ss.name = N'dbo')

CREATE TYPE [dbo].[ZwmCoefVolWeightType] FROM [decimal](5, 2) NOT NULL
GO

-------------------------------------------------------------------------------------------------------------------------

IF NOT EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'ZwmIdRouteMapType' AND ss.name = N'dbo')

CREATE TYPE [dbo].[ZwmIdRouteMapType] FROM [nvarchar](15) NOT NULL
GO

-------------------------------------------------------------------------------------------------------------------------

IF NOT EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'ZwmUMQtyByTagType' AND ss.name = N'dbo')

CREATE TYPE [dbo].[ZwmUMQtyByTagType] FROM [tinyint] NOT NULL
GO
-------------------------------------------------------------------------------------------------------------------------

IF NOT EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'UMQtyByTagType' AND ss.name = N'dbo')

CREATE TYPE [dbo].[UMQtyByTagType] FROM [int] NOT NULL
GO
-------------------------------------------------------------------------------------------------------------------------

IF NOT EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'UMQtyByTag' AND ss.name = N'dbo')

CREATE TYPE [dbo].[UMQtyByTag] FROM [int] NOT NULL
GO

-------------------------------------------------------------------------------------------------------------------------

IF NOT EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'GrnPrefixType' AND ss.name = N'dbo')

CREATE TYPE [dbo].[GrnPrefixType] FROM [nvarchar](7) NOT NULL
GO

-------------------------------------------------------------------------------------------------------------------------

IF NOT (EXISTS(SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'ZWM_RouteType' AND ss.name = N'dbo'))

CREATE TYPE [dbo].[ZWM_RouteType] FROM [nvarchar](15) NULL
GO

-------------------------------------------------------------------------------------------------------------------------

IF NOT EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'ZwmVolumeWeightType' AND ss.name = N'dbo')

CREATE TYPE [dbo].[ZwmVolumeWeightType] FROM [decimal](19, 9) NOT NULL
GO

--------------------------------------------------

/****** Object:  UserDefinedDataType [dbo].[ZwmCoefVolWeight]    Script Date: 01/14/2015 13:09:34 ******/
IF NOT EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'ZwmCoefVolWeight' AND ss.name = N'dbo')

CREATE TYPE [dbo].[ZwmCoefVolWeight] FROM [decimal](5, 2) NOT NULL
GO


