
CREATE PROCEDURE [dbo].[Trim_BOM_Tables_No_Buy] 
AS
BEGIN
DECLARE @sSQL nvarchar(1500)
   declare @count int;
   declare @countAffected int;   
   declare @table_name varchar(500)
   select @count = (select count(*) from BOM_Tables)
   declare MyCursor cursor for (select bom_table_name from BOM_Tables)
   open MyCursor 
   while @count > 0
      begin
        fetch MyCursor into @table_name
        print @table_name
        SET @sSQL = 'delete FROM ' + @table_name +
            ' where ( ' +
                ' not exists ( ' +
                    ' select * from ' + @table_name  + ' internalR where ' + @table_name + '.partnumber = internalR.ParentPart ' +
                ' ) AND ' +
                ' not exists ( ' +
                    ' select * from [Method_Buy] where ' + @table_name + '.partnumber = Method_Buy.PRODUCT_ID ' +
                ' ) ' +
            ' ) '
                       
        print @sSQL
        set @countAffected = 1
        while @countAffected > 0
        BEGIN
            EXEC(@sSQL)
            set @countAffected = @@rowcount;
        END
        set @count = @count - 1
      end
   close MyCursor 
   deallocate MyCursor 
END
GO

