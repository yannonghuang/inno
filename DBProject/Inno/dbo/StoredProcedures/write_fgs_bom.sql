CREATE PROCEDURE [dbo].[write_fgs_bom]
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
        'BOM_' + concat( [PN_for_customer], '@', [Customer_abbreviate]) 
        ,'-'
        , concat( [PN_for_customer], '@', [Customer_abbreviate])           
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
  FROM [master].[dbo].[FG_SUBSTITUTES], adx_product, Process
  where FG_PN = adx_product.PRODUCT_ID and FG_PN = Process.P_N and Process.Process = 'Module'
GO

