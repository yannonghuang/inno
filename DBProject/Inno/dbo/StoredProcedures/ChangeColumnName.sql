
CREATE PROCEDURE [dbo].[ChangeColumnName] 
AS
BEGIN
EXECUTE sp_rename @objname = N'[dbo].[BOM_1000_part2].[项目类别]', @newname = N'projecttype', @objtype = N'COLUMN';
EXECUTE sp_rename @objname = N'[dbo].[BOM_1000_part2].[组件属性]', @newname = N'componenttype', @objtype = N'COLUMN';
END
GO

