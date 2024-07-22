CREATE PROCEDURE [dbo].[write_transportation]
AS

insert into [dbo].[adx_transportation] (
    [PRODUCT]
      ,[FROM_LOCATION]
      ,[TO_LOCATION]
      ,[TRANS_RT]
      ,[MODE]
      ,[PREFERENCE]
      ,[COST]
      ,[TRANSIT_TIME]
      ,[TRANSIT_TIME_UOM]
      ,[EFFECTIVE_START]
      ,[EFFECTIVE_END]
      ,[DEST_TYPE]
      ,[ASSY_LOC]
      ,[HIER_LEVEL_1]
      ,[HIER_LEVEL]
      ,[HIER_LEVEL_3]
      ,[process_unit_cost]
)
SELECT 
    Process.[P_N]
    ,transportation.[from]
    ,transportation.[to]
      ,'-'
      ,'ROAD'
      ,'1'
      ,'1'
      ,transportation.length
      ,'DAYS'
      ,'-'
      ,'-'
      ,'-'
      ,'-'
      ,'HIER_LEVEL_1'
      ,'HIER_LEVEL_2'
      ,'HIER_LEVEL_3'
      ,'1'               
FROM [dbo].[Process], transportation, adx_productlocation 
where [Process].process = transportation.process 
    and Process.plant = transportation.[from] 
    and Process.[P_N] = adx_productlocation.[PRODUCT_ID] and transportation.[to] = adx_productlocation.[LOCATION]



insert into [dbo].[adx_transportation] (
    [PRODUCT]
      ,[FROM_LOCATION]
      ,[TO_LOCATION]
      ,[TRANS_RT]
      ,[MODE]
      ,[PREFERENCE]
      ,[COST]
      ,[TRANSIT_TIME]
      ,[TRANSIT_TIME_UOM]
      ,[EFFECTIVE_START]
      ,[EFFECTIVE_END]
      ,[DEST_TYPE]
      ,[ASSY_LOC]
      ,[HIER_LEVEL_1]
      ,[HIER_LEVEL]
      ,[HIER_LEVEL_3]
      ,[process_unit_cost]
)
SELECT 
    Method_Buy.PRODUCT_ID

    ,Method_Buy.[LOCATION]
    
      ,VMI.Plant      
      ,'-'
      ,'ROAD'
      ,'1'
      ,'1'
      ,VMI.length
      ,'DAYS'
      ,'-'
      ,'-'
      ,'-'
      ,'-'
      ,'HIER_LEVEL_1'
      ,'HIER_LEVEL_2'
      ,'HIER_LEVEL_3'
      ,'1'
FROM [Method_Buy], adx_productlocation, [VMI]
--, [process_location] -- adx_productlocation, 
where Method_Buy.PRODUCT_ID = adx_productlocation.PRODUCT_ID 
--and (
--    exists (select * from [adx_bom] where Method_Buy.PRODUCT_ID = adx_bom.CHILD_ID and adx_bom.PARENT_ID = process.P_N)
--    or exists (select * from [NATIVE_RAW_SUBSTITUTES] where Method_Buy.PRODUCT_ID = NATIVE_RAW_SUBSTITUTES.component and NATIVE_RAW_SUBSTITUTES.Assemble_P_N = process.P_N)
--) 
and adx_productlocation.[LOCATION] = VMI.Plant and VMI.VMI = Method_Buy.[LOCATION]
-- and process.Process = process_location.process and process.Plant = process_location.location and process_location.Manufacture = 'M'  
    --and adx_bom.PARENT_ID = adx_productlocation.PRODUCT_ID and adx_productlocation.location = VMI.Plant
  
  -- process.P_N  and process.process = process_location.process and process_location.location = VMI.Plant                    
  --FROM [Method_Buy], VMI, adx_product
  --where Method_Buy.PRODUCT_ID = adx_product.PRODUCT_ID  
    --and adx_bom.PARENT_ID = adx_productlocation.PRODUCT_ID and adx_productlocation.location = VMI.Plant
  
  -- process.P_N  and process.process = process_location.process and process_location.location = VMI.Plant                    
  --FROM [Method_Buy], VMI, adx_product
  --where Method_Buy.PRODUCT_ID = adx_product.PRODUCT_ID  
    --and adx_bom.PARENT_ID = adx_productlocation.PRODUCT_ID and adx_productlocation.location = VMI.Plant
  
  -- process.P_N  and process.process = process_location.process and process_location.location = VMI.Plant                    
  --FROM [Method_Buy], VMI, adx_product
  --where Method_Buy.PRODUCT_ID = adx_product.PRODUCT_ID  
    --and adx_bom.PARENT_ID = adx_productlocation.PRODUCT_ID and adx_productlocation.location = VMI.Plant
  
  -- process.P_N  and process.process = process_location.process and process_location.location = VMI.Plant                    
  --FROM [Method_Buy], VMI, adx_product
  --where Method_Buy.PRODUCT_ID = adx_product.PRODUCT_ID  
    --and adx_bom.PARENT_ID = adx_productlocation.PRODUCT_ID and adx_productlocation.location = VMI.Plant
  
  -- process.P_N  and process.process = process_location.process and process_location.location = VMI.Plant                    
  --FROM [Method_Buy], VMI, adx_product
  --where Method_Buy.PRODUCT_ID = adx_product.PRODUCT_ID  
    --and adx_bom.PARENT_ID = adx_productlocation.PRODUCT_ID and adx_productlocation.location = VMI.Plant
  
  -- process.P_N  and process.process = process_location.process and process_location.location = VMI.Plant                    
  --FROM [Method_Buy], VMI, adx_product
  --where Method_Buy.PRODUCT_ID = adx_product.PRODUCT_ID  
    --and adx_bom.PARENT_ID = adx_productlocation.PRODUCT_ID and adx_productlocation.location = VMI.Plant
  
  -- process.P_N  and process.process = process_location.process and process_location.location = VMI.Plant                    
  --FROM [Method_Buy], VMI, adx_product
  --where Method_Buy.PRODUCT_ID = adx_product.PRODUCT_ID  
    --and adx_bom.PARENT_ID = adx_productlocation.PRODUCT_ID and adx_productlocation.location = VMI.Plant
  
  -- process.P_N  and process.process = process_location.process and process_location.location = VMI.Plant                    
  --FROM [Method_Buy], VMI, adx_product
  --where Method_Buy.PRODUCT_ID = adx_product.PRODUCT_ID  
    --and adx_bom.PARENT_ID = adx_productlocation.PRODUCT_ID and adx_productlocation.location = VMI.Plant
  
  -- process.P_N  and process.process = process_location.process and process_location.location = VMI.Plant                    
  --FROM [Method_Buy], VMI, adx_product
  --where Method_Buy.PRODUCT_ID = adx_product.PRODUCT_ID  
    --and adx_bom.PARENT_ID = adx_productlocation.PRODUCT_ID and adx_productlocation.location = VMI.Plant
  
  -- process.P_N  and process.process = process_location.process and process_location.location = VMI.Plant                    
  --FROM [Method_Buy], VMI, adx_product
  --where Method_Buy.PRODUCT_ID = adx_product.PRODUCT_ID  
    --and adx_bom.PARENT_ID = adx_productlocation.PRODUCT_ID and adx_productlocation.location = VMI.Plant
  
  -- process.P_N  and process.process = process_location.process and process_location.location = VMI.Plant                    
  --FROM [Method_Buy], VMI, adx_product
  --where Method_Buy.PRODUCT_ID = adx_product.PRODUCT_ID  
    --and adx_bom.PARENT_ID = adx_productlocation.PRODUCT_ID and adx_productlocation.location = VMI.Plant
  
  -- process.P_N  and process.process = process_location.process and process_location.location = VMI.Plant                    
  --FROM [Method_Buy], VMI, adx_product
  --where Method_Buy.PRODUCT_ID = adx_product.PRODUCT_ID  
    --and adx_bom.PARENT_ID = adx_productlocation.PRODUCT_ID and adx_productlocation.location = VMI.Plant
  
  -- process.P_N  and process.process = process_location.process and process_location.location = VMI.Plant                    
  --FROM [Method_Buy], VMI, adx_product
  --where Method_Buy.PRODUCT_ID = adx_product.PRODUCT_ID  
    --and adx_bom.PARENT_ID = adx_productlocation.PRODUCT_ID and adx_productlocation.location = VMI.Plant
  
  -- process.P_N  and process.process = process_location.process and process_location.location = VMI.Plant                    
  --FROM [Method_Buy], VMI, adx_product
  --where Method_Buy.PRODUCT_ID = adx_product.PRODUCT_ID  
    --and adx_bom.PARENT_ID = adx_productlocation.PRODUCT_ID and adx_productlocation.location = VMI.Plant
  
  -- process.P_N  and process.process = process_location.process and process_location.location = VMI.Plant                    
  --FROM [Method_Buy], VMI, adx_product
  --where Method_Buy.PRODUCT_ID = adx_product.PRODUCT_ID  
    --and adx_bom.PARENT_ID = adx_productlocation.PRODUCT_ID and adx_productlocation.location = VMI.Plant
  
  -- process.P_N  and process.process = process_location.process and process_location.location = VMI.Plant                    
  --FROM [Method_Buy], VMI, adx_product
  --where Method_Buy.PRODUCT_ID = adx_product.PRODUCT_ID  
    --and adx_bom.PARENT_ID = adx_productlocation.PRODUCT_ID and adx_productlocation.location = VMI.Plant
  
  -- process.P_N  and process.process = process_location.process and process_location.location = VMI.Plant                    
  --FROM [Method_Buy], VMI, adx_product
  --where Method_Buy.PRODUCT_ID = adx_product.PRODUCT_ID  
    --and adx_bom.PARENT_ID = adx_productlocation.PRODUCT_ID and adx_productlocation.location = VMI.Plant
  
  -- process.P_N  and process.process = process_location.process and process_location.location = VMI.Plant                    
  --FROM [Method_Buy], VMI, adx_product
  --where Method_Buy.PRODUCT_ID = adx_product.PRODUCT_ID  
    --and adx_bom.PARENT_ID = adx_productlocation.PRODUCT_ID and adx_productlocation.location = VMI.Plant
  
  -- process.P_N  and process.process = process_location.process and process_location.location = VMI.Plant                    
  --FROM [Method_Buy], VMI, adx_product
  --where Method_Buy.PRODUCT_ID = adx_product.PRODUCT_ID  
    --and adx_bom.PARENT_ID = adx_productlocation.PRODUCT_ID and adx_productlocation.location = VMI.Plant
  
  -- process.P_N  and process.process = process_location.process and process_location.location = VMI.Plant                    
  --FROM [Method_Buy], VMI, adx_product
  --where Method_Buy.PRODUCT_ID = adx_product.PRODUCT_ID  
    --and adx_bom.PARENT_ID = adx_productlocation.PRODUCT_ID and adx_productlocation.location = VMI.Plant
  
  -- process.P_N  and process.process = process_location.process and process_location.location = VMI.Plant                    
  --FROM [Method_Buy], VMI, adx_product
  --where Method_Buy.PRODUCT_ID = adx_product.PRODUCT_ID  
    --and adx_bom.PARENT_ID = adx_productlocation.PRODUCT_ID and adx_productlocation.location = VMI.Plant
  
  -- process.P_N  and process.process = process_location.process and process_location.location = VMI.Plant                    
  --FROM [Method_Buy], VMI, adx_product
  --where Method_Buy.PRODUCT_ID = adx_product.PRODUCT_ID  
    --and adx_bom.PARENT_ID = adx_productlocation.PRODUCT_ID and adx_productlocation.location = VMI.Plant
  
  -- process.P_N  and process.process = process_location.process and process_location.location = VMI.Plant                    
  --FROM [Method_Buy], VMI, adx_product
  --where Method_Buy.PRODUCT_ID = adx_product.PRODUCT_ID  
    --and adx_bom.PARENT_ID = adx_productlocation.PRODUCT_ID and adx_productlocation.location = VMI.Plant
  
  -- process.P_N  and process.process = process_location.process and process_location.location = VMI.Plant                    
  --FROM [Method_Buy], VMI, adx_product
  --where Method_Buy.PRODUCT_ID = adx_product.PRODUCT_ID  
    --and adx_bom.PARENT_ID = adx_productlocation.PRODUCT_ID and adx_productlocation.location = VMI.Plant
  
  -- process.P_N  and process.process = process_location.process and process_location.location = VMI.Plant                    
  --FROM [Method_Buy], VMI, adx_product
  --where Method_Buy.PRODUCT_ID = adx_product.PRODUCT_ID  
    --and adx_bom.PARENT_ID = adx_productlocation.PRODUCT_ID and adx_productlocation.location = VMI.Plant
  
  -- process.P_N  and process.process = process_location.process and process_location.location = VMI.Plant                    
  --FROM [Method_Buy], VMI, adx_product
  --where Method_Buy.PRODUCT_ID = adx_product.PRODUCT_ID  
    --and adx_bom.PARENT_ID = adx_productlocation.PRODUCT_ID and adx_productlocation.location = VMI.Plant
  
  -- process.P_N  and process.process = process_location.process and process_location.location = VMI.Plant                    
  --FROM [Method_Buy], VMI, adx_product
  --where Method_Buy.PRODUCT_ID = adx_product.PRODUCT_ID  
    --and adx_bom.PARENT_ID = adx_productlocation.PRODUCT_ID and adx_productlocation.location = VMI.Plant
  
  -- process.P_N  and process.process = process_location.process and process_location.location = VMI.Plant                    
  --FROM [Method_Buy], VMI, adx_product
  --where Method_Buy.PRODUCT_ID = adx_product.PRODUCT_ID  
    --and adx_bom.PARENT_ID = adx_productlocation.PRODUCT_ID and adx_productlocation.location = VMI.Plant
  
  -- process.P_N  and process.process = process_location.process and process_location.location = VMI.Plant                    
  --FROM [Method_Buy], VMI, adx_product
  --where Method_Buy.PRODUCT_ID = adx_product.PRODUCT_ID  
    --and adx_bom.PARENT_ID = adx_productlocation.PRODUCT_ID and adx_productlocation.location = VMI.Plant
  
  -- process.P_N  and process.process = process_location.process and process_location.location = VMI.Plant                    
  --FROM [Method_Buy], VMI, adx_product
  --where Method_Buy.PRODUCT_ID = adx_product.PRODUCT_ID  
    --and adx_bom.PARENT_ID = adx_productlocation.PRODUCT_ID and adx_productlocation.location = VMI.Plant
  
  -- process.P_N  and process.process = process_location.process and process_location.location = VMI.Plant                    
  --FROM [Method_Buy], VMI, adx_product
  --where Method_Buy.PRODUCT_ID = adx_product.PRODUCT_ID  
    --and adx_bom.PARENT_ID = adx_productlocation.PRODUCT_ID and adx_productlocation.location = VMI.Plant
  
  -- process.P_N  and process.process = process_location.process and process_location.location = VMI.Plant                    
  --FROM [Method_Buy], VMI, adx_product
  --where Method_Buy.PRODUCT_ID = adx_product.PRODUCT_ID  
    --and adx_bom.PARENT_ID = adx_productlocation.PRODUCT_ID and adx_productlocation.location = VMI.Plant
  
  -- process.P_N  and process.process = process_location.process and process_location.location = VMI.Plant                    
  --FROM [Method_Buy], VMI, adx_product
  --where Method_Buy.PRODUCT_ID = adx_product.PRODUCT_ID  
    --and adx_bom.PARENT_ID = adx_productlocation.PRODUCT_ID and adx_productlocation.location = VMI.Plant
  
  -- process.P_N  and process.process = process_location.process and process_location.location = VMI.Plant                    
  --FROM [Method_Buy], VMI, adx_product
  --where Method_Buy.PRODUCT_ID = adx_product.PRODUCT_ID  
    --and adx_bom.PARENT_ID = adx_productlocation.PRODUCT_ID and adx_productlocation.location = VMI.Plant
  
  -- process.P_N  and process.process = process_location.process and process_location.location = VMI.Plant                    
  --FROM [Method_Buy], VMI, adx_product
  --where Method_Buy.PRODUCT_ID = adx_product.PRODUCT_ID  
    --and adx_bom.PARENT_ID = adx_productlocation.PRODUCT_ID and adx_productlocation.location = VMI.Plant
  
  -- process.P_N  and process.process = process_location.process and process_location.location = VMI.Plant                    
  --FROM [Method_Buy], VMI, adx_product
  --where Method_Buy.PRODUCT_ID = adx_product.PRODUCT_ID  
    --and adx_bom.PARENT_ID = adx_productlocation.PRODUCT_ID and adx_productlocation.location = VMI.Plant
  
  -- process.P_N  and process.process = process_location.process and process_location.location = VMI.Plant                    
  --FROM [Method_Buy], VMI, adx_product
  --where Method_Buy.PRODUCT_ID = adx_product.PRODUCT_ID  
    --and adx_bom.PARENT_ID = adx_productlocation.PRODUCT_ID and adx_productlocation.location = VMI.Plant
  
  -- process.P_N  and process.process = process_location.process and process_location.location = VMI.Plant                    
  --FROM [Method_Buy], VMI, adx_product
  --where Method_Buy.PRODUCT_ID = adx_product.PRODUCT_ID  
    --and adx_bom.PARENT_ID = adx_productlocation.PRODUCT_ID and adx_productlocation.location = VMI.Plant
  
  -- process.P_N  and process.process = process_location.process and process_location.location = VMI.Plant                    
  --FROM [Method_Buy], VMI, adx_product
  --where Method_Buy.PRODUCT_ID = adx_product.PRODUCT_ID  
    --and adx_bom.PARENT_ID = adx_productlocation.PRODUCT_ID and adx_productlocation.location = VMI.Plant
  
  -- process.P_N  and process.process = process_location.process and process_location.location = VMI.Plant                    
  --FROM [Method_Buy], VMI, adx_product
  --where Method_Buy.PRODUCT_ID = adx_product.PRODUCT_ID  
    --and adx_bom.PARENT_ID = adx_productlocation.PRODUCT_ID and adx_productlocation.location = VMI.Plant
  
  -- process.P_N  and process.process = process_location.process and process_location.location = VMI.Plant                    
  --FROM [Method_Buy], VMI, adx_product
  --where Method_Buy.PRODUCT_ID = adx_product.PRODUCT_ID  
    --and adx_bom.PARENT_ID = adx_productlocation.PRODUCT_ID and adx_productlocation.location = VMI.Plant
  
  -- process.P_N  and process.process = process_location.process and process_location.location = VMI.Plant                    
  --FROM [Method_Buy], VMI, adx_product
  --where Method_Buy.PRODUCT_ID = adx_product.PRODUCT_ID  
    --and adx_bom.PARENT_ID = adx_productlocation.PRODUCT_ID and adx_productlocation.location = VMI.Plant
  
  -- process.P_N  and process.process = process_location.process and process_location.location = VMI.Plant                    
  --FROM [Method_Buy], VMI, adx_product
  --where Method_Buy.PRODUCT_ID = adx_product.PRODUCT_ID  
    --and adx_bom.PARENT_ID = adx_productlocation.PRODUCT_ID and adx_productlocation.location = VMI.Plant
  
  -- process.P_N  and process.process = process_location.process and process_location.location = VMI.Plant                    
  --FROM [Method_Buy], VMI, adx_product
  --where Method_Buy.PRODUCT_ID = adx_product.PRODUCT_ID  
    --and adx_bom.PARENT_ID = adx_productlocation.PRODUCT_ID and adx_productlocation.location = VMI.Plant
  
  -- process.P_N  and process.process = process_location.process and process_location.location = VMI.Plant                    
  --FROM [Method_Buy], VMI, adx_product
  --where Method_Buy.PRODUCT_ID = adx_product.PRODUCT_ID  
    --and adx_bom.PARENT_ID = adx_productlocation.PRODUCT_ID and adx_productlocation.location = VMI.Plant
  
  -- process.P_N  and process.process = process_location.process and process_location.location = VMI.Plant                    
  --FROM [Method_Buy], VMI, adx_product
  --where Method_Buy.PRODUCT_ID = adx_product.PRODUCT_ID  
    --and adx_bom.PARENT_ID = adx_productlocation.PRODUCT_ID and adx_productlocation.location = VMI.Plant
  
  -- process.P_N  and process.process = process_location.process and process_location.location = VMI.Plant                    
  --FROM [Method_Buy], VMI, adx_product
  --where Method_Buy.PRODUCT_ID = adx_product.PRODUCT_ID  
    --and adx_bom.PARENT_ID = adx_productlocation.PRODUCT_ID and adx_productlocation.location = VMI.Plant
  
  -- process.P_N  and process.process = process_location.process and process_location.location = VMI.Plant                    
  --FROM [Method_Buy], VMI, adx_product
  --where Method_Buy.PRODUCT_ID = adx_product.PRODUCT_ID  
    --and adx_bom.PARENT_ID = adx_productlocation.PRODUCT_ID and adx_productlocation.location = VMI.Plant
  
  -- process.P_N  and process.process = process_location.process and process_location.location = VMI.Plant                    
  --FROM [Method_Buy], VMI, adx_product
  --where Method_Buy.PRODUCT_ID = adx_product.PRODUCT_ID  
    --and adx_bom.PARENT_ID = adx_productlocation.PRODUCT_ID and adx_productlocation.location = VMI.Plant
  
  -- process.P_N  and process.process = process_location.process and process_location.location = VMI.Plant                    
  --FROM [Method_Buy], VMI, adx_product
  --where Method_Buy.PRODUCT_ID = adx_product.PRODUCT_ID  
    --and adx_bom.PARENT_ID = adx_productlocation.PRODUCT_ID and adx_productlocation.location = VMI.Plant
  
  -- process.P_N  and process.process = process_location.process and process_location.location = VMI.Plant                    
  --FROM [Method_Buy], VMI, adx_product
  --where Method_Buy.PRODUCT_ID = adx_product.PRODUCT_ID  
    --and adx_bom.PARENT_ID = adx_productlocation.PRODUCT_ID and adx_productlocation.location = VMI.Plant
  
  -- process.P_N  and process.process = process_location.process and process_location.location = VMI.Plant                    
  --FROM [Method_Buy], VMI, adx_product
  --where Method_Buy.PRODUCT_ID = adx_product.PRODUCT_ID  
    --and adx_bom.PARENT_ID = adx_productlocation.PRODUCT_ID and adx_productlocation.location = VMI.Plant
  
  -- process.P_N  and process.process = process_location.process and process_location.location = VMI.Plant                    
  --FROM [Method_Buy], VMI, adx_product
  --where Method_Buy.PRODUCT_ID = adx_product.PRODUCT_ID  
    --and adx_bom.PARENT_ID = adx_productlocation.PRODUCT_ID and adx_productlocation.location = VMI.Plant
  
  -- process.P_N  and process.process = process_location.process and process_location.location = VMI.Plant                    
  --FROM [Method_Buy], VMI, adx_product
  --where Method_Buy.PRODUCT_ID = adx_product.PRODUCT_ID  
    --and adx_bom.PARENT_ID = adx_productlocation.PRODUCT_ID and adx_productlocation.location = VMI.Plant
  
  -- process.P_N  and process.process = process_location.process and process_location.location = VMI.Plant                    
  --FROM [Method_Buy], VMI, adx_product
  --where Method_Buy.PRODUCT_ID = adx_product.PRODUCT_ID  
    --and adx_bom.PARENT_ID = adx_productlocation.PRODUCT_ID and adx_productlocation.location = VMI.Plant
  
  -- process.P_N  and process.process = process_location.process and process_location.location = VMI.Plant                    
  --FROM [Method_Buy], VMI, adx_product
  --where Method_Buy.PRODUCT_ID = adx_product.PRODUCT_ID  
    --and adx_bom.PARENT_ID = adx_productlocation.PRODUCT_ID and adx_productlocation.location = VMI.Plant
  
  -- process.P_N  and process.process = process_location.process and process_location.location = VMI.Plant                    
  --FROM [Method_Buy], VMI, adx_product
  --where Method_Buy.PRODUCT_ID = adx_product.PRODUCT_ID  
    --and adx_bom.PARENT_ID = adx_productlocation.PRODUCT_ID and adx_productlocation.location = VMI.Plant
  
  -- process.P_N  and process.process = process_location.process and process_location.location = VMI.Plant                    
  --FROM [Method_Buy], VMI, adx_product
  --where Method_Buy.PRODUCT_ID = adx_product.PRODUCT_ID  
    --and adx_bom.PARENT_ID = adx_productlocation.PRODUCT_ID and adx_productlocation.location = VMI.Plant
  
  -- process.P_N  and process.process = process_location.process and process_location.location = VMI.Plant                    
  --FROM [Method_Buy], VMI, adx_product
  --where Method_Buy.PRODUCT_ID = adx_product.PRODUCT_ID  
    --and adx_bom.PARENT_ID = adx_productlocation.PRODUCT_ID and adx_productlocation.location = VMI.Plant
  
  -- process.P_N  and process.process = process_location.process and process_location.location = VMI.Plant                    
  --FROM [Method_Buy], VMI, adx_product
  --where Method_Buy.PRODUCT_ID = adx_product.PRODUCT_ID  
    --and adx_bom.PARENT_ID = adx_productlocation.PRODUCT_ID and adx_productlocation.location = VMI.Plant
  
  -- process.P_N  and process.process = process_location.process and process_location.location = VMI.Plant                    
  --FROM [Method_Buy], VMI, adx_product
  --where Method_Buy.PRODUCT_ID = adx_product.PRODUCT_ID  
    --and adx_bom.PARENT_ID = adx_productlocation.PRODUCT_ID and adx_productlocation.location = VMI.Plant
  
  -- process.P_N  and process.process = process_location.process and process_location.location = VMI.Plant                    
  --FROM [Method_Buy], VMI, adx_product
  --where Method_Buy.PRODUCT_ID = adx_product.PRODUCT_ID  
    --and adx_bom.PARENT_ID = adx_productlocation.PRODUCT_ID and adx_productlocation.location = VMI.Plant
  
  -- process.P_N  and process.process = process_location.process and process_location.location = VMI.Plant                    
  --FROM [Method_Buy], VMI, adx_product
  --where Method_Buy.PRODUCT_ID = adx_product.PRODUCT_ID  
    --and adx_bom.PARENT_ID = adx_productlocation.PRODUCT_ID and adx_productlocation.location = VMI.Plant
  
  -- process.P_N  and process.process = process_location.process and process_location.location = VMI.Plant                    
  --FROM [Method_Buy], VMI, adx_product
  --where Method_Buy.PRODUCT_ID = adx_product.PRODUCT_ID  
    --and adx_bom.PARENT_ID = adx_productlocation.PRODUCT_ID and adx_productlocation.location = VMI.Plant
  
  -- process.P_N  and process.process = process_location.process and process_location.location = VMI.Plant                    
  --FROM [Method_Buy], VMI, adx_product
  --where Method_Buy.PRODUCT_ID = adx_product.PRODUCT_ID  
    --and adx_bom.PARENT_ID = adx_productlocation.PRODUCT_ID and adx_productlocation.location = VMI.Plant
  
  -- process.P_N  and process.process = process_location.process and process_location.location = VMI.Plant                    
  --FROM [Method_Buy], VMI, adx_product
  --where Method_Buy.PRODUCT_ID = adx_product.PRODUCT_ID  
    --and adx_bom.PARENT_ID = adx_productlocation.PRODUCT_ID and adx_productlocation.location = VMI.Plant
  
  -- process.P_N  and process.process = process_location.process and process_location.location = VMI.Plant                    
  --FROM [Method_Buy], VMI, adx_product
  --where Method_Buy.PRODUCT_ID = adx_product.PRODUCT_ID  
    --and adx_bom.PARENT_ID = adx_productlocation.PRODUCT_ID and adx_productlocation.location = VMI.Plant
  
  -- process.P_N  and process.process = process_location.process and process_location.location = VMI.Plant                    
  --FROM [Method_Buy], VMI, adx_product
  --where Method_Buy.PRODUCT_ID = adx_product.PRODUCT_ID  
    --and adx_bom.PARENT_ID = adx_productlocation.PRODUCT_ID and adx_productlocation.location = VMI.Plant
  
  -- process.P_N  and process.process = process_location.process and process_location.location = VMI.Plant                    
  --FROM [Method_Buy], VMI, adx_product
  --where Method_Buy.PRODUCT_ID = adx_product.PRODUCT_ID  
    --and adx_bom.PARENT_ID = adx_productlocation.PRODUCT_ID and adx_productlocation.location = VMI.Plant
  
  -- process.P_N  and process.process = process_location.process and process_location.location = VMI.Plant                    
  --FROM [Method_Buy], VMI, adx_product
  --where Method_Buy.PRODUCT_ID = adx_product.PRODUCT_ID
GO

