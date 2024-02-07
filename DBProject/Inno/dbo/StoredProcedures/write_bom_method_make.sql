CREATE PROCEDURE [dbo].[write_bom_method_make]
AS

begin
    DECLARE @sSQL nvarchar(1500)
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
        'insert into [adx_method_make]  (' +
        '[PRODUCT_ID] ' +
        ',[LOCATION] ' +
        ',[ROUTE_ID] ' +
        ',[PREFERENCE] ' +
        ',[COST] ' +
        ',[BOM_ID] ' +
        ',[BOG_ID] ' +
        ',[EFFECTIVE_START] ' +
        ',[EFFECTIVE_END] ' +
        ',[HIER_LEVEL_1] ' +
        ',[HIER_LEVEL] ' +
        ',[HIER_LEVEL_3] ' +
        ',[process_unit_cost] ' +
        ',[UDA_string_DMDSPEC] ' +
        ',[UDA_string_to_workorder_no_ASSY_LOC] ' +
        ',[UDA_string_to_workorder_no_FAB_LOC] ' +
        ') ' +

        'SELECT ' +
         @table_name + '.partnumber ' +

        ', CASE   ' +
        '  WHEN (process.plant is not null) and (process_location.manufacture = ''M'') THEN process.plant ' +   
        --' WHEN (process_location.location is not null) and (process_location.manufacture = ''M'') THEN process_location.location ' +                               
        ' ELSE  ' +
            ' CASE   ' +
            ' WHEN componenttype = ''P'' THEN ''VMI'' ' +
            ' ELSE ''1000'' ' +
            --' ELSE ''dummy'' ' +            
            ' END ' +          
        ' END ' +         
        --',''1000'' ' +  

        ', CASE   ' +
        '  WHEN Process.Process is not null THEN ''ROUTE_'' + Process.Process' +        
        '  ELSE ''ROUTE_dummy'' ' +
        '  END ' +

        ',''1'' ' +
        ',''0'' ' +
        ',''BOM_'' + [partnumber] ' +
        ',''-'' ' +
        ',''-'' ' +
        ',''-'' ' +   
        ',''HIER_LEVEL_1'' ' +
        ',''HIER_LEVEL_2'' ' +
        ',''HIER_LEVEL_3'' ' +
        ',''1'' ' +
        ',''-'' ' +
        ',''-'' ' +
        ',''-'' ' +   

        'FROM ' + @table_name + ', Process, process_location ' +       
        --'where componenttype is not null and componenttype <> ''P'' and ' + 
        'where componenttype <> ''P'' and ' + 
            @table_name + '.partnumber = Process.P_N and ' +
            ' Process.process = process_location.process and ' +
            ' process.plant = process_location.location '            
        --  'FROM ' + @table_name + ' left outer JOIN Process on ' + @table_name + '.partnumber = Process.P_N ' +
        --    'left outer JOIN process_location on Process.process = process_location.process ' +        
        -- 'where componenttype is not null and componenttype <> ''P'' '

        print @sSQL
        EXEC(@sSQL)

        set @count = @count - 1
      end
   close MyCursor 
   deallocate MyCursor 



end
GO

