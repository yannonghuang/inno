CREATE PROCEDURE [dbo].[write_dpm_bom]
AS


insert into [adx_bom]  (
        [BOM_ID]
        ,[LOCATION_ID]
        ,[PARENT_ID]
        ,[ALT_GROUP]
        ,[PREFERENCE]
        ,[ELEM_IX]
        ,[CHILD_ID]
        ,[NEW_SUPPLY]
        ,[GRADE]
        ,[RATE]
        ,[BATCH_SIZE]
        ,[EFFECTIVE_START]
        ,[EFFECTIVE_END]
        ,[OBSOLETE]        
)

SELECT
        -- 'BOM_' + work_order_model
        'BOM_' + work_order_model + '_' + FG_PN -- DB load

        ,'-'
        , work_order_model           
        , FG_PN
        ,'1'
        ,'1'        
        , FG_PN
        ,'-'
        ,'-'   
        ,'1'   
        ,'-'
        ,'-'
        ,'-'  
        ,'-'
  FROM [POCModel], [POCFG], adx_product, Process
  where Work_order_code = work_order_model and FG_PN = adx_product.PRODUCT_ID
  and FG_PN = Process.P_N and Process.Process = 'Module'
GO

