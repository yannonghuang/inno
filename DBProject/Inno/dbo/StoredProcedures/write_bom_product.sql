CREATE PROCEDURE [dbo].[write_bom_product]
AS

begin
    DECLARE @sSQL nvarchar(1000)
    --declare @table_name varchar(500)
    --set @table_name = 'BOM_1000_part1'


   declare @count bigint;
   declare @table_name varchar(500)
   select @count = (select count(*) from BOM_Tables)
   declare MyCursor cursor for (select bom_table_name from BOM_Tables)
   open MyCursor 
   while @count > 0
      begin
        fetch MyCursor into @table_name
        print @table_name                

        SET @sSQL = 
        'insert into [adx_product]  (' +
        '[PRODUCT_ID] ' +
        ',[DESCRIPTION] ' +
        ',[PRODUCT_TYPE] ' +
        ',[PRODAREA] ' +
        ',[HIER_LEVEL_1] ' +
        ',[HIER_LEVEL_2] ' +
        ',[HIER_LEVEL_3] ' +
        ',[FG_HIER_LEVEL_1] ' +
        ',[FG_HIER_LEVEL_2] ' +
        ',[FG_HIER_LEVEL_3] ' +
        ',[END_ITEM] ' +
        ',[A_MAT_STATUS] ' +
        ',[LATE_FORECAST] ' +
        ',[LATE_SALES] ' +
        ') ' +

        'SELECT ' +
         @table_name + '.partnumber ' +

        -- ',' + @table_name + '.PartDescription ' +
        ', REPLACE(PartDescription, '','', '';'') ' +

        ',CASE  ' +
        ' WHEN ' + @table_name + '.componenttype = ''P'' THEN ''P'' ' +
        ' ELSE ''M'' ' +
        ' END  ' +

        ',CASE   ' +
        ' WHEN Process.Process is not null THEN ' +
            ' CASE   ' +
            ' WHEN Process.Process = ''Module'' THEN ''MODULE'' ' +
            ' ELSE ''OPTICAL'' ' +
            ' END ' +             
        ' ELSE ''OPTICAL'' ' +
        ' END ' +

        ',CASE   ' +
        ' WHEN Process.Process is not null THEN ' +
            ' CASE   ' +
            ' WHEN Process.Process = ''Module'' THEN ''MODULE'' ' +
            ' ELSE ''OPTICAL'' ' +
            ' END ' +             
        ' ELSE ''OPTICAL'' ' +
        ' END ' +

        ',''FACTORY'' ' +
        ',''ALL'' ' +
        
        ',''-'' ' +
        ',''-'' ' +
        ',''-'' ' +
        ',''-'' ' +
        ',''-'' ' +
        ',''-'' ' +
        ',''-'' ' +   
        'FROM ' + @table_name + ' left outer JOIN Process on ' + @table_name + '.partnumber = Process.P_N ' 
            -- + 'where componenttype is not null  ' 
  
        print @sSQL
        EXEC(@sSQL)

        set @count = @count - 1
      end
   close MyCursor 
   deallocate MyCursor 



end
GO
