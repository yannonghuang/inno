
CREATE PROCEDURE [dbo].[Trim_BOM_Tables_Full] 
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
            ' where (' + @table_name + '.[projecttype] = ''N'' and ' + @table_name + '.[componenttype] <> ''virtual'')' +
            ' or exists (' +
            ' select * ' +
            ' from [PackageMaterial]' +
            ' where [PackageMaterial].[MATNR] = ' + @table_name + '.[partnumber]) ' +
            ' or (' + 
                ' not exists (' +
                ' select * ' +
                ' from [InnoLight_Forecast]' +
                ' where [InnoLight_Forecast].[FG_PN] = ' + @table_name + '.[FG]) ' +
                ' and not exists (' +
                ' select * ' +
                ' from [FG_In_Demand]' +
                ' where [FG_In_Demand].[PN] = ' + @table_name + '.[FG]) ' + 
            ') '               
/*
            ' or ( ' +
                ' not exists ( ' +
                    ' select * from ' + @table_name  + ' internalR where ' + @table_name + '.partnumber = internalR.ParentPart ' +
                ' ) AND ' +
                ' not exists ( ' +
                    ' select * from [Method_Buy] where ' + @table_name + '.partnumber = Method_Buy.PRODUCT_ID ' +
                ' ) ' +
            ' ) '
*/            
/*
            + ' or ( ' +
                ' exists ( ' +
                    ' select * from ' + @table_name  + ' internalR where ' + @table_name + '.partnumber = internalR.ParentPart ' +
                ' ) AND ' +
                ' not exists ( ' +
                    ' select * from Process where ' + @table_name + '.partnumber = process.P_N ' +
                ' ) ' +
            ' ) '
*/
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

