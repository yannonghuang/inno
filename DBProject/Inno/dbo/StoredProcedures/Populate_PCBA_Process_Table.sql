
CREATE PROCEDURE [dbo].[Populate_PCBA_Process_Table] 
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

        SET @sSQL = 'insert into PCBA_Process([P_N],[Plant],[Process]) ' +
        ' SELECT distinct [partnumber], ''Subcon_PCBA'', ''PCBA'' FROM ' + @table_name + ' where PartDescription like ''%PCBA%'' '

        EXEC(@sSQL)
        set @count = @count - 1
      end
   close MyCursor 
   deallocate MyCursor 
END
GO

