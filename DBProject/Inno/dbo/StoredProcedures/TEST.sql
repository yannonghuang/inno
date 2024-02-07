CREATE procedure [dbo].[TEST]
as
begin
    DECLARE @sSQL nvarchar(500)

   declare @count bigint;
   declare @table_name varchar(500)
   select @count = (select count(*) from INFORMATION_SCHEMA.TABLES where TABLE_NAME like 'adx%')
   declare MyCursor cursor for (select TABLE_NAME from INFORMATION_SCHEMA.TABLES where TABLE_NAME like 'adx%')
   open MyCursor 
   while @count > 0
      begin
        fetch MyCursor into @table_name
        print @table_name
        SET @sSQL = 'truncate table ' + @table_name
        EXEC(@sSQL)
        set @count = @count - 1
      end
   close MyCursor 
   deallocate MyCursor 
end
GO

