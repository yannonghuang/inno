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
      ,'0.1'
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
FROM [dbo].[Process], adx_product, transportation, adx_productlocation -- , [Process] p2
where Process.[P_N] = adx_product.PRODUCT_ID -- and p2.[P_N] = Process.[P_N]
    and [Process].process = transportation.process 
    and Process.plant = transportation.[from] -- and p2.plant = transportation.[to]
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
    --,'VMI'
    --,VMI.Plant
    --,process_location.location
    -- ,adx_productlocation.location
    
      ,process.Plant      
      ,'-'
      ,'ROAD'
      ,'1'
      ,'0.1'
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
FROM [Method_Buy], adx_product, [VMI], [process], [process_location] -- adx_productlocation, 
where Method_Buy.PRODUCT_ID = adx_product.PRODUCT_ID and (
    exists (select * from [adx_bom] where Method_Buy.PRODUCT_ID = adx_bom.CHILD_ID and adx_bom.PARENT_ID = process.P_N)
    or exists (select * from [RAW_SUBSTITUTES] where Method_Buy.PRODUCT_ID = RAW_SUBSTITUTES.component and RAW_SUBSTITUTES.Assemble_P_N = process.P_N)
) and (process.Plant = 'SUB_PCBA' 
    or (process.Plant <> 'SUB_PCBA' and not exists (select * from Method_Buy internalR where internalR.[LOCATION] = process.Plant and internalR.PRODUCT_ID = Method_Buy.PRODUCT_ID))
)
and process.Plant = VMI.Plant 
and process.Process = process_location.process and process.Plant = process_location.location and process_location.Manufacture = 'M'  
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

