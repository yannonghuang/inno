
CREATE PROCEDURE [dbo].[Trim] @tablename sysname
AS
BEGIN
DECLARE @sSQL nvarchar(500)


   declare @count bigint;
   declare @table_name varchar(500)
   select @count = (select count(*) from BOM_Tables)
   declare MyCursor cursor for (select bom_table_name from BOM_Tables)
   open MyCursor 
   while @count > 0
      begin
        fetch MyCursor into @table_name
        print @table_name
        SET @sSQL = 'delete FROM ' + @table_name +
            ' where (' + @table_name + '.[projecttype] = ''N'' and ' + @table_name + '.[componenttype] <> ''virtual'')' +
            ' or exists (' +
            ' select * ' +
            ' from [PackageMaterial]' +
            ' where [PackageMaterial].[MATNR] = ' + @table_name + '.[partnumber]) ' +
            ' or componenttype is null ' +
            ' or exists (select * from orphan where partnumber = product_id)'

        EXEC(@sSQL)
        set @count = @count - 1
      end
   close MyCursor 
   deallocate MyCursor 
END
GO

