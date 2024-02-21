
CREATE PROCEDURE [dbo].[Trim_BOM_Tables_Reduced] 
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
        SET @sSQL = 'delete FROM ' + @table_name +
            ' where ' + 
            ' not exists (select * ' +
            ' FROM [POCModel], [POCFG] ' +
            ' where Work_order_code = work_order_model ' +
            ' and (Work_order_code = ''F01'' or Work_order_code = ''F30'' or Work_order_code = ''F29'') ' +
            ' and FG_PN = [FG] ' +
            ') '

            --  + ' or (''500-6035'' <> ' + @table_name + '.[FG]) '                        
        print @sSQL
        EXEC(@sSQL)
        set @count = @count - 1
    end
    close MyCursor 
    deallocate MyCursor 
    EXEC Trim_BOM_Tables_Common   
END
GO

