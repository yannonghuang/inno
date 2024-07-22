CREATE PROCEDURE [dbo].[write_dpm_cust_productlocation]
AS

------------------------


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
         [DPM] + '__' + Customer
        ,[DP_model] -- 'Virtual Product for Customer-Specific DP Model'

        ,'VIRTUAL'

        ,'1'
        ,'D'
        ,'1' -- min_lot
        ,'1000'
        ,'1000'
        ,'1' -- incr_lot
        ,'-'
        ,'-'
        ,'-'
        ,'cycle'
        ,'1'
        ,'-'
        ,'-'
        ,'1'
        ,'1'
    ,'MODULE'
    ,'MODULE'
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
  
FROM [dbo].[DPM_CustomerPN_Customer], [dbo].[POCModel]
where [DPM] = [work_order_model]
GO

