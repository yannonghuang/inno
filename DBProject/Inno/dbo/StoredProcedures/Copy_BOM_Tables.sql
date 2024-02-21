
CREATE PROCEDURE [dbo].[Copy_BOM_Tables] 
AS
BEGIN
DECLARE @sSQL nvarchar(1500)
   declare @count bigint;
   declare @table_name varchar(500)
   select @count = (select count(*) from BOM_Tables)
   declare MyCursor cursor for (select bom_table_name from BOM_Tables)
   open MyCursor 
   while @count > 0
      begin
        fetch MyCursor into @table_name
        print @table_name
        SET @sSQL = 'insert into reduced_'+ @table_name + 
            ' select * from ' + @table_name
                      
        print @sSQL
        EXEC(@sSQL)
        set @count = @count - 1
      end
   close MyCursor 
   deallocate MyCursor 
END
GO

