CREATE PROCEDURE [dbo].[write_subs_bom]
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
        'insert into [adx_bom]  (' +
        '[BOM_ID] ' +
        ',[LOCATION_ID] ' +
        ',[PARENT_ID] ' +
        ',[ALT_GROUP] ' +
        ',[PREFERENCE] ' +
        ',[ELEM_IX] ' +
        ',[CHILD_ID] ' +
        ',[NEW_SUPPLY] ' +
        ',[GRADE] ' +
        ',[RATE] ' +
        ',[BATCH_SIZE] ' +
        ',[EFFECTIVE_START] ' +
        ',[EFFECTIVE_END] ' +
        ',[OBSOLETE] ' +
        ') ' +

        'SELECT ' +
        --' ''BOM_'' + ''VirtualProduct_'' + Assemble_P_N + ''_'' + component + ''_'' + substitution_group ' + 
        --' ''BOM_'' + ''VirtualProduct_'' + Assemble_P_N + ''_'' + substitution_group ' + 
        ' ''BOM_'' + ''VirtualProduct_'' + Assemble_P_N + ''_'' + substitution_group + ''_'' + component ' + -- DB load

        ',''-'' ' +
        --', process_location.location ' +

        ', ''VirtualProduct_'' + Assemble_P_N + ''_'' + substitution_group ' +           

        ', component ' +
        --', substitution_group ' +
        --', component + ''_'' + process_location.location ' +
        --', substitution_group + ''_'' + process_location.location ' +

        ',CASE ' +
        ' WHEN ([Usage_percentage] = ''0'') THEN ''1'' ' +        
        ' ELSE ''100'' ' +
        ' END ' +
        -- ',''1'' ' +

        ',''1'' ' +
        
        ', component ' +
        ',''-'' ' +
        ',''-'' ' +   
        ',''1'' ' +   
        ',''-'' ' +
        ',''-'' ' +
        ',''-'' ' +   

        ',CASE ' +
        ' WHEN ([Usage_percentage] = ''0'') THEN ''1'' ' +        
        ' ELSE ''-'' ' +
        ' END ' +
  
        --'FROM ' + @table_name + ', Process, process_location ' +
        --'WHERE not exists (select * from orphan where component = PRODUCT_ID) and ' + 
        'FROM ' + @table_name + ', adx_product ' + 
        -- ', Process, process_location ' +
        'WHERE component = adx_product.PRODUCT_ID ' +   
            ' and exists (select * from adx_product internalR where Assemble_P_N = internalR.PRODUCT_ID) '      
        --    @table_name + '.Assemble_P_N = Process.P_N and Process.process = process_location.process '
  
        print @sSQL
        EXEC(@sSQL)

        set @count = @count - 1
      end
   close MyCursor 
   deallocate MyCursor 
end
GO

