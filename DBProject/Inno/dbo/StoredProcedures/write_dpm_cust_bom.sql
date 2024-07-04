CREATE PROCEDURE [dbo].[write_dpm_cust_bom]
AS

---------------------

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
        --'BOM_' + [DPM] + '__' + Customer
        'BOM_' + [DPM] + '__' + Customer + '_' + FG_SUBSTITUTES.FG_PN -- DB load

        ,'-'
        , [DPM] + '__' + Customer
        , FG_SUBSTITUTES.FG_PN -- [CustomerPN] + '__' + Customer
        ,'1'
        ,'1'        
        , FG_SUBSTITUTES.FG_PN -- [CustomerPN] + '__' + Customer
        ,'-'
        ,'-'   
        ,'1'   
        ,'-'
        ,'-'
        ,'-'  
        ,'-'
  FROM [dbo].[DPM_CustomerPN_Customer]
  ,[FG_SUBSTITUTES]
  ,[DP_Models]
  ,adx_product
  where DPM_CustomerPN_Customer.Customer = FG_SUBSTITUTES.Customer_abbreviate and DPM_CustomerPN_Customer.CustomerPN = FG_SUBSTITUTES.PN_for_customer
  and DP_Models.Code = DPM_CustomerPN_Customer.DPM
  and DP_Models.PN = FG_SUBSTITUTES.FG_PN
  and DP_Models.PN = adx_product.PRODUCT_ID
GO

