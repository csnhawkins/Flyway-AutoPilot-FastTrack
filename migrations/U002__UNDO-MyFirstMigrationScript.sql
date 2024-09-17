SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
PRINT N'Dropping [dbo].[CurrentPrices]'
GO
DROP VIEW [dbo].[CurrentPrices]
GO
PRINT N'Dropping [dbo].[GetAllWidgets]'
GO
DROP PROCEDURE [dbo].[GetAllWidgets]
GO
PRINT N'Altering [dbo].[WidgetPrices]'
GO
ALTER TABLE [dbo].[WidgetPrices] ALTER COLUMN [Price] [decimal] (19, 4) NULL
GO

