
CREATE PROCEDURE [dbo].[Trim_BOM_Tables_Common] 
AS
EXEC Trim_BOM_Tables_No_Buy
EXEC Trim_BOM_Tables_No_Process
GO

