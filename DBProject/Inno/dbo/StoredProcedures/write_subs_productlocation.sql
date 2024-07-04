CREATE PROCEDURE [dbo].[write_subs_productlocation]
AS

begin
    DECLARE @sSQL nvarchar(2000)
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
        'insert into [adx_productlocation]  (' +

        '[PRODUCT_ID] ' +
      ',[DESCRIPTION] ' +
      ',[LOCATION] ' +
      ',[PRODUCT_TYPE] ' +
      ',[RESOLUTION] ' +
      ',[MIN_LOT_SIZE] ' +
      ',[MAX_LOT_SIZE] ' +
      ',[STD_LOT_SIZE] ' +
      ',[INCR_LOT_SIZE] ' +
      ',[BUILD_PERIOD] ' +
      ',[OBSOLETE] ' +
      ',[TIME_FENCE] ' +
      ',[CYCLE_TYPE] ' +
      ',[CYCLE_FAMILY] ' +
      ',[INVENTORY] ' +
      ',[REVENUE] ' +
      ',[SHARE_FLAG] ' +
      ',[MIX] ' +
      ',[PROD_AREA] ' +
      ',[HIER_LEVEL_1] ' +
      ',[HIER_LEVEL_2] ' +
      ',[HIER_LEVEL_3] ' +
      ',[Product_Unit_Cost] ' +
      ',[UDA_string_LOC_ID] ' +
      ',[UDA_float_HOLD_COST] ' +
      ',[UDA_string_PRODUCT_FAMILY] ' +
      ',[UDA_string_PRODUCT_GROUP] ' +
      ',[UDA_string_TECHNOLOGY] ' +
      ',[UDA_string_PACKAGE] ' +
      ',[UDA_string_SHARED] ' +
      ',[UDA_string_FAB_LOC] ' +
      ',[UDA_string_MASK_LAYERS] ' +
      ',[UDA_string_WAFER_SIZE] ' +
      ',[UDA_string_BUMP_LOC] ' +
      ',[UDA_string_BUMP_TYPE] ' +
      ',[UDA_string_PROBE_LOC] ' +
      ',[UDA_string_PACKAGE_FAMILY] ' +
      ',[UDA_string_ASSY_LOC] ' +
      ',[UDA_string_TEST_LOC] ' +
      ',[UDA_string_A_MAT_STATUS] ' +
      ') ' +

        'SELECT ' +        
        ' ''VirtualProduct_'' + Assemble_P_N + ''_'' + substitution_group ' +   
        ',''Virtual Product for Raw Material Substitutions'' ' +  

        ',CASE   ' +
        --' WHEN (process_location.location is not null) and (process_location.manufacture = ''M'') THEN process_location.location ' +     
        ' WHEN (process.plant is not null) and (process_location.manufacture = ''M'') THEN process.plant ' +                  
        ' ELSE ''-'' ' +
        ' END ' +

        ',''1'' ' +
        ',''D'' ' +
        ',''1'' ' +
        ',''1000'' ' +
        ',''1000'' ' +
        ',''1'' ' +
        ',''-'' ' +
        ',''-'' ' +
        ',''-'' ' +
        ',''factor'' ' +
        ',''2'' ' +
        ',''-'' ' +
        ',''-'' ' +
        ',''1'' ' +
        ',''1'' ' +

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
        ',''-'' ' +
        ',''-'' ' +
        ',''-'' ' +
        ',''-'' ' +
        ',''-'' ' +
        ',''-'' ' +
        ',''-'' ' +   
        ',''-'' ' +
        ',''-'' ' +
        ',''-'' ' +
        ',''-'' ' +
  
        'FROM ' + @table_name + ', Process, process_location, adx_product ' +       
        'where component = adx_product.PRODUCT_ID and ' + @table_name + '.Assemble_P_N = Process.P_N and ' +
            ' Process.process = process_location.process and process.plant = process_location.location and (process_location.manufacture = ''M'') ' +
            ' and exists (select * from adx_product internalR where Assemble_P_N = internalR.PRODUCT_ID) '   
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

