CREATE PROCEDURE [dbo].[write_raw_productlocation]
AS

begin
    insert into [adx_productlocation]  (
      [PRODUCT_ID] 
      ,[DESCRIPTION] 
      ,[LOCATION] 
      ,[PRODUCT_TYPE] 
      ,[RESOLUTION] 
      ,[MIN_LOT_SIZE] 
      ,[MAX_LOT_SIZE] 
      ,[STD_LOT_SIZE] 
      ,[INCR_LOT_SIZE] 
      ,[BUILD_PERIOD] 
      ,[OBSOLETE] 
      ,[TIME_FENCE] 
      ,[CYCLE_TYPE] 
      ,[CYCLE_FAMILY] 
      ,[INVENTORY] 
      ,[REVENUE] 
      ,[SHARE_FLAG] 
      ,[MIX] 
      ,[PROD_AREA] 
      ,[HIER_LEVEL_1] 
      ,[HIER_LEVEL_2] 
      ,[HIER_LEVEL_3] 
      ,[Product_Unit_Cost] 
      ,[UDA_string_LOC_ID] 
      ,[UDA_float_HOLD_COST] 
      ,[UDA_string_PRODUCT_FAMILY] 
      ,[UDA_string_PRODUCT_GROUP] 
      ,[UDA_string_TECHNOLOGY] 
      ,[UDA_string_PACKAGE] 
      ,[UDA_string_SHARED] 
      ,[UDA_string_FAB_LOC] 
      ,[UDA_string_MASK_LAYERS] 
      ,[UDA_string_WAFER_SIZE] 
      ,[UDA_string_BUMP_LOC] 
      ,[UDA_string_BUMP_TYPE] 
      ,[UDA_string_PROBE_LOC] 
      ,[UDA_string_PACKAGE_FAMILY] 
      ,[UDA_string_ASSY_LOC] 
      ,[UDA_string_TEST_LOC] 
      ,[UDA_string_A_MAT_STATUS] 
    ) 
    SELECT 
        Method_Buy.PRODUCT_ID
        ,adx_product.[DESCRIPTION] 'Raw material from VMI' 

        ,process.[Plant]
        --,process_location.[location]
        --,adx_productlocation.LOCATION 
        
        ,'1' 
        ,'D' 
        ,'10' 
        ,'1000' 
        ,'1000' 
        ,'10' 
        ,'-' 
        ,'-' 
        ,'-' 
        ,'factor' 
        ,'2' 
        ,'-' 
        ,'-' 
        ,'1' 
        ,'1' 

        ,CASE   
         WHEN Process.Process is not null THEN 
             CASE   
             WHEN Process.Process = 'Module' THEN 'MODULE' 
             ELSE 'OPTICAL' 
             END              
         ELSE 'OPTICAL' 
         END 

        ,CASE   
         WHEN Process.Process is not null THEN 
             CASE   
             WHEN Process.Process = 'Module' THEN 'MODULE' 
             ELSE 'OPTICAL' 
             END             
         ELSE 'OPTICAL' 
         END 

        ,'FACTORY' 
        ,'ALL' 
 /*
        ,adx_productlocation.[PROD_AREA] 
        ,adx_productlocation.[HIER_LEVEL_1] 
        ,adx_productlocation.[HIER_LEVEL_2] 
        ,adx_productlocation.[HIER_LEVEL_3] 
*/
        ,'-' 
        ,'-' 
        ,'-' 
        ,'-' 
        ,'-' 
        ,'-' 
        ,'-'    
        ,'-' 
        ,'-' 
        ,'-' 
        ,'-' 
        ,'-' 
        ,'-' 
        ,'-'    
        ,'-' 
        ,'-' 
        ,'-' 
        ,'-' 
    --FROM [Method_Buy], [adx_bom], [adx_bom] adx_bom2, process, process_location
    --where Method_Buy.PRODUCT_ID = adx_bom.CHILD_ID and (
    -- ((Not adx_bom.PARENT_ID like 'Virtual%') and adx_bom.PARENT_ID = process.P_N) or
    -- ((adx_bom.PARENT_ID like 'Virtual%') and adx_bom.PARENT_ID = adx_bom2.CHILD_ID and adx_bom2.PARENT_ID = process.P_N) 
    -- ) and process.Process = process_location.process and process_location.Manufacture = 'M'  

    --FROM [Method_Buy], [adx_bom], process, process_location
    --where ((Method_Buy.PRODUCT_ID = adx_bom.CHILD_ID and adx_bom.PARENT_ID = process.P_N) or
    --  exists (select * from COP_RAW_SUBSTITUTES where Method_Buy.PRODUCT_ID = COP_RAW_SUBSTITUTES.component and COP_RAW_SUBSTITUTES.Assemble_P_N = process.P_N) or
    --  exists (select * from AOC_RAW_SUBSTITUTES where Method_Buy.PRODUCT_ID = AOC_RAW_SUBSTITUTES.component and AOC_RAW_SUBSTITUTES.Assemble_P_N = process.P_N) or   
    --  exists (select * from SR4_RAW_SUBSTITUTES where Method_Buy.PRODUCT_ID = SR4_RAW_SUBSTITUTES.component and SR4_RAW_SUBSTITUTES.Assemble_P_N = process.P_N) 
    --) and process.Process = process_location.process and process_location.Manufacture = 'M' 
  
    --FROM [Method_Buy], [adx_bom], adx_productlocation -- [process], [process_location]
    --    where Method_Buy.PRODUCT_ID = adx_bom.CHILD_ID and adx_bom.PARENT_ID = adx_productlocation.PRODUCT_ID --process.P_N  and process.process = process_location.process    
  
    --FROM [Method_Buy], [adx_bom], [process], [process_location]
    --    where Method_Buy.PRODUCT_ID = adx_bom.CHILD_ID and adx_bom.PARENT_ID = process.P_N  and process.process = process_location.process and process_location.Manufacture = 'M'  
  
    FROM [Method_Buy], adx_product, process, process_location
    where Method_Buy.PRODUCT_ID = adx_product.PRODUCT_ID and (
      exists (select * from [adx_bom] where Method_Buy.PRODUCT_ID = adx_bom.CHILD_ID and adx_bom.PARENT_ID = process.P_N) or    
      exists (select * from RAW_SUBSTITUTES where Method_Buy.PRODUCT_ID = RAW_SUBSTITUTES.component and RAW_SUBSTITUTES.Assemble_P_N = process.P_N)
    ) 
    -- and (process.Plant = 'SUB_PCBA' or process.Plant = Method_Buy.[LOCATION])
    and process.Plant = 'SUB_PCBA'     
    and process.Process = process_location.process 
    and process.Plant = process_location.location and process_location.Manufacture = 'M' 


---------------

    insert into [adx_productlocation]  (
      [PRODUCT_ID] 
      ,[DESCRIPTION] 
      ,[LOCATION] 
      ,[PRODUCT_TYPE] 
      ,[RESOLUTION] 
      ,[MIN_LOT_SIZE] 
      ,[MAX_LOT_SIZE] 
      ,[STD_LOT_SIZE] 
      ,[INCR_LOT_SIZE] 
      ,[BUILD_PERIOD] 
      ,[OBSOLETE] 
      ,[TIME_FENCE] 
      ,[CYCLE_TYPE] 
      ,[CYCLE_FAMILY] 
      ,[INVENTORY] 
      ,[REVENUE] 
      ,[SHARE_FLAG] 
      ,[MIX] 
      ,[PROD_AREA] 
      ,[HIER_LEVEL_1] 
      ,[HIER_LEVEL_2] 
      ,[HIER_LEVEL_3] 
      ,[Product_Unit_Cost] 
      ,[UDA_string_LOC_ID] 
      ,[UDA_float_HOLD_COST] 
      ,[UDA_string_PRODUCT_FAMILY] 
      ,[UDA_string_PRODUCT_GROUP] 
      ,[UDA_string_TECHNOLOGY] 
      ,[UDA_string_PACKAGE] 
      ,[UDA_string_SHARED] 
      ,[UDA_string_FAB_LOC] 
      ,[UDA_string_MASK_LAYERS] 
      ,[UDA_string_WAFER_SIZE] 
      ,[UDA_string_BUMP_LOC] 
      ,[UDA_string_BUMP_TYPE] 
      ,[UDA_string_PROBE_LOC] 
      ,[UDA_string_PACKAGE_FAMILY] 
      ,[UDA_string_ASSY_LOC] 
      ,[UDA_string_TEST_LOC] 
      ,[UDA_string_A_MAT_STATUS] 
    ) 
    SELECT 
        Method_Buy.PRODUCT_ID
        ,adx_product.[DESCRIPTION] --'Raw material from VMI' 

        ,Method_Buy.[LOCATION]
        
        ,'1' 
        ,'D' 
        ,'10' 
        ,'1000' 
        ,'1000' 
        ,'10' 
        ,'-' 
        ,'-' 
        ,'-' 
        ,'factor' 
        ,'2' 
        ,'-' 
        ,'-' 
        ,'1' 
        ,'1' 

        ,'OPTICAL' 
        ,'OPTICAL' 
        ,'FACTORY' 
        ,'ALL' 

        ,'-' 
        ,'-' 
        ,'-' 
        ,'-' 
        ,'-' 
        ,'-' 
        ,'-'    
        ,'-' 
        ,'-' 
        ,'-' 
        ,'-' 
        ,'-' 
        ,'-' 
        ,'-'    
        ,'-' 
        ,'-' 
        ,'-' 
        ,'-' 

    FROM [Method_Buy], adx_product
    where Method_Buy.PRODUCT_ID = adx_product.PRODUCT_ID  


end
GO

