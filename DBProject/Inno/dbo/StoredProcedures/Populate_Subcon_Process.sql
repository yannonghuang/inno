
CREATE PROCEDURE [dbo].[Populate_Subcon_Process] 
AS

truncate TABLE Subcon_Process

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

        SET @sSQL = 'insert into Subcon_Process (P_N, Plant, Process) ' +
            'SELECT [partnumber], ''SUB_PCBA'', ''subcon'' ' +
            'FROM [dbo].' + @table_name + 
            ' where componenttype = ''SUBCON'' '
        print @sSQL
        EXEC(@sSQL)
        set @count = @count - 1
      end
   close MyCursor 
   deallocate MyCursor 
END
GO

