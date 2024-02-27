CREATE PROCEDURE [dbo].[write_bom_productlocation]
AS

begin
    DECLARE @sSQL nvarchar(2000)
    --declare @table_name varchar(500)
    --set @table_name = 'BOM_1000_part1'


   declare @count bigint;
   declare @table_name varchar(500)
   declare @raw_subs_table_name varchar(500)   
   select @count = (select count(*) from BOM_Tables)
   declare MyCursor cursor for (select bom_table_name, raw_subs_table_name from BOM_Tables)
   open MyCursor 
   while @count > 0
      begin
        fetch MyCursor into @table_name, @raw_subs_table_name
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
         @table_name + '.partnumber ' +

        -- ',' + @table_name + '.PartDescription ' +
        ', REPLACE(PartDescription, '','', '';'') ' +

        ',CASE   ' +
        --' WHEN process_location.location is not null THEN process_location.location ' +            
        ' WHEN process.plant is not null THEN process.plant ' +                       
        ' ELSE  ' +
            ' CASE   ' +
            ' WHEN componenttype = ''P'' AND Method_Buy.LOCATION is not null THEN Method_Buy.LOCATION ' +
            ' ELSE ''1000'' ' +            
            --' WHEN componenttype = ''P'' THEN ''VMI'' ' +
            --' ELSE ''VMI'' ' +
            --' ELSE ''dummy'' ' +            
            ' END ' +          
        ' END ' +

        ',''1'' ' +
        ',''D'' ' +
        ',''10'' ' +
        ',''1000'' ' +
        ',''1000'' ' +
        ',''10'' ' +
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
        
        ',CASE   ' +
        ' WHEN Process.Process is not null and Process.Process <> ''dummy'' THEN Process.Process ' +           
        ' ELSE ''-'' ' +
        ' END ' +        
        -- [UDA_string_TECHNOLOGY]

        ',CASE   ' +
        ' WHEN POCFG.Work_order_code is not null THEN POCFG.Work_order_code ' +           
        ' ELSE ''-'' ' +
        ' END ' +  
        -- UDA_string_PACKAGE

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
                
        'FROM ' + @table_name + ' left outer JOIN Process on ' + @table_name + '.partnumber = Process.P_N '  
            + ' left outer JOIN Method_Buy on partnumber = Method_Buy.PRODUCT_ID ' 
            + ' left outer JOIN POCFG on FG = POCFG.FG_PN '                       
        -- + ' left outer JOIN process_location on Process.process = process_location.process '
        --'where componenttype is not null ' 
  
        print @sSQL
        EXEC(@sSQL)

------------------------------

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
         @table_name + '.partnumber ' +

        -- ',' + @table_name + '.PartDescription ' +
        ', REPLACE(PartDescription, '','', '';'') ' +

        ', process.plant ' +

        ',''1'' ' +
        ',''D'' ' +
        ',''10'' ' +
        ',''1000'' ' +
        ',''1000'' ' +
        ',''10'' ' +
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
                
        'FROM ' + @table_name + ', process, process_location ' +
        ' where   ' +
        ' (ParentPart = process.P_N) ' +    
        ' and process.Process = process_location.process and process.Plant = process_location.location and process_location.Manufacture = ''M''  '

        print @sSQL
        EXEC(@sSQL)

------------------------------


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
         @table_name + '.partnumber ' +

        -- ',' + @table_name + '.PartDescription ' +
        ', REPLACE(PartDescription, '','', '';'') ' +

        ', process.plant ' +

        ',''1'' ' +
        ',''D'' ' +
        ',''10'' ' +
        ',''1000'' ' +
        ',''1000'' ' +
        ',''10'' ' +
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
                
        'FROM ' + @table_name + ', process, process_location ' +
        ' where  ( ' +
        ' exists (select * from ' + @raw_subs_table_name + ' where ' + @table_name + '.partnumber = ' + @raw_subs_table_name + '.component and ' + @raw_subs_table_name + '.Assemble_P_N = process.P_N) ' +
        ') and process.Process = process_location.process and process.Plant = process_location.location and process_location.Manufacture = ''M''  '

        print @sSQL
        EXEC(@sSQL)

        set @count = @count - 1
      end
   close MyCursor 
   deallocate MyCursor 

end
GO

