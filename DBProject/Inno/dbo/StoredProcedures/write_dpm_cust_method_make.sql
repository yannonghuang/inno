CREATE PROCEDURE [dbo].[write_dpm_cust_method_make]
AS
    
----------------

    insert into [adx_method_make]  (
        [PRODUCT_ID]
        ,[LOCATION]
        ,[ROUTE_ID]
        ,[PREFERENCE]
        ,[COST]
        ,[BOM_ID]
        ,[BOG_ID]
        ,[EFFECTIVE_START]
        ,[EFFECTIVE_END]
        ,[HIER_LEVEL_1]
        ,[HIER_LEVEL]
        ,[HIER_LEVEL_3]
        ,[process_unit_cost]
        ,[UDA_string_DMDSPEC]
        ,[UDA_string_to_workorder_no_ASSY_LOC]
        ,[UDA_string_to_workorder_no_FAB_LOC]
    )

    SELECT
        [DPM] + '__' + [Customer]

        ,'VIRTUAL'
       
        ,'ROUTE_dummy'  

        ,'1'
        ,'0'

        --,'BOM_' + [DPM] + '__' + [Customer]
        ,'BOM_' + [DPM] + '__' + Customer + '_' + adx_bom.CHILD_ID -- DB load

        ,'-'
        ,'-'
        ,'-'   
        ,'HIER_LEVEL_1'
        ,'HIER_LEVEL_2'
        ,'HIER_LEVEL_3'
        ,'1'
        ,'-'
        ,'-'
        ,'-'   
  FROM [dbo].[DPM_CustomerPN_Customer], adx_bom --, adx_product
  where DPM_CustomerPN_Customer.[DPM] + '__' + DPM_CustomerPN_Customer.[Customer] = adx_bom.PARENT_ID
  --and DP_Models.PN = adx_product.PRODUCT_ID
GO

