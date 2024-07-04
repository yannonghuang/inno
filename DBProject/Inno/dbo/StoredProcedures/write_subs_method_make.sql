CREATE PROCEDURE [dbo].[write_subs_method_make]
AS

begin
    DECLARE @sSQL nvarchar(1000)
    --declare @table_name varchar(500)
    --set @table_name = 'BOM_1000_part1'


   declare @count bigint;
   declare @table_name varchar(500)
   select @count = (select count(*) from RawSubs_Tables)
   declare MyCursor cursor for (select raw_subs_table_name from RawSubs_Tables)
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
        ' ''VirtualProduct_'' + Assemble_P_N + ''_'' + substitution_group ' +   

        ',CASE   ' +
        --' WHEN (process_location.location is not null) and (process_location.manufacture = ''M'') THEN process_location.location ' +   
        ' WHEN (process.plant is not null) and (process_location.manufacture = ''M'') THEN process.plant ' +                   
        ' ELSE ''-'' ' +
        ' END ' +
        --',''1000'' ' +  
        
        ',''ROUTE_dummy'' ' +  

        ',''1'' ' +
        ',''0'' ' +

        -- ',''BOM_'' + ''VirtualProduct_'' + Assemble_P_N + ''_'' + substitution_group ' +
        ', ''BOM_'' + ''VirtualProduct_'' + Assemble_P_N + ''_'' + substitution_group + ''_'' + component ' + -- DB load

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
  
        'FROM ' + @table_name + ', Process, process_location, adx_product ' +       
        'where component = adx_product.PRODUCT_ID and ' + @table_name + '.Assemble_P_N = Process.P_N and ' +
            ' Process.process = process_location.process and process.plant = process_location.location and (process_location.manufacture = ''M'') '  
        --'FROM ' + @table_name + ' left outer JOIN Process on ' + @table_name + '.Assemble_P_N = Process.P_N ' +
        --    'left outer JOIN process_location on Process.process = process_location.process '
  
        print @sSQL
        EXEC(@sSQL)

        set @count = @count - 1
      end
   close MyCursor 
   deallocate MyCursor 
end
GO

