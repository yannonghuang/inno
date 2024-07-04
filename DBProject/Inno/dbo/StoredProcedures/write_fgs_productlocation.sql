CREATE PROCEDURE [dbo].[write_fgs_productlocation]
AS

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
        concat([PN_for_customer], '__', [Customer_abbreviate])

        ,REPLACE(FG_description, ',', ';')    
        --,FG_description

        ,CASE
         WHEN process_location.location is not null THEN process_location.location         
         ELSE '1000'
         END

        ,'1'
        ,'D'
        ,'1' --  min_lot
        ,'1000'
        ,'1000'
        ,'1' --  incr_lot
        ,'-'
        ,'-'
        ,'-'
        ,'factor'
        ,'2'
        ,'-'
        ,'-'
        ,'1'
        ,'1'
    ,'MODULE'
    ,'-' --,'MODULE'
    ,'-' --,'FACTORY'
    ,'-' --,'ALL'
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
  
FROM FG_SUBSTITUTES, Process, Process_Location
where Process.P_N = concat([PN_for_customer], '__', [Customer_abbreviate]) and Process.process = Process_Location.process
and exists (select * from adx_product where FG_PN = adx_product.PRODUCT_ID)
---------------------
/*
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
        FG_PN        
        --concat([PN_for_customer], '__', [Customer_abbreviate])

        ,REPLACE(FG_description, ',', ';')    
        --,FG_description

        ,CASE
         WHEN process_location.location is not null THEN process_location.location         
         ELSE '1000'
         END

        ,'1'
        ,'D'
        ,'1'
        ,'1000'
        ,'1000'
        ,'1'
        ,'-'
        ,'-'
        ,'-'
        ,'factor'
        ,'2'
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
  
FROM FG_SUBSTITUTES, Process, Process_Location
where Process.P_N = concat([PN_for_customer], '__', [Customer_abbreviate]) and Process.process = Process_Location.process
and exists (select * from adx_product where FG_PN = adx_product.PRODUCT_ID)
*/
---------------------
/*
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
        FG_PN        
        --concat([PN_for_customer], '__', [Customer_abbreviate])

        ,REPLACE(FG_description, ',', ';')    
        --,FG_description

        ,CASE
         WHEN process_location.location is not null THEN process_location.location         
         ELSE '1000'
         END

        ,'1'
        ,'D'
        ,'1'
        ,'1000'
        ,'1000'
        ,'1'
        ,'-'
        ,'-'
        ,'-'
        ,'factor'
        ,'2'
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
  
FROM FG_SUBSTITUTES, Process, Process_Location
where Process.P_N = concat([PN_for_customer], '__', [Customer_abbreviate]) and Process.process = Process_Location.process
and exists (select * from adx_product where FG_PN = adx_product.PRODUCT_ID)
*/
---------------------
/*
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
        FG_PN        
        --concat([PN_for_customer], '__', [Customer_abbreviate])

        ,REPLACE(FG_description, ',', ';')    
        --,FG_description

        ,CASE
         WHEN process_location.location is not null THEN process_location.location         
         ELSE '1000'
         END

        ,'1'
        ,'D'
        ,'1'
        ,'1000'
        ,'1000'
        ,'1'
        ,'-'
        ,'-'
        ,'-'
        ,'factor'
        ,'2'
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
  
FROM FG_SUBSTITUTES, Process, Process_Location
where Process.P_N = concat([PN_for_customer], '__', [Customer_abbreviate]) and Process.process = Process_Location.process
and exists (select * from adx_product where FG_PN = adx_product.PRODUCT_ID)
*/
---------------------
/*
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
        FG_PN        
        --concat([PN_for_customer], '__', [Customer_abbreviate])

        ,REPLACE(FG_description, ',', ';')    
        --,FG_description

        ,CASE
         WHEN process_location.location is not null THEN process_location.location         
         ELSE '1000'
         END

        ,'1'
        ,'D'
        ,'1'
        ,'1000'
        ,'1000'
        ,'1'
        ,'-'
        ,'-'
        ,'-'
        ,'factor'
        ,'2'
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
  
FROM FG_SUBSTITUTES, Process, Process_Location
where Process.P_N = concat([PN_for_customer], '__', [Customer_abbreviate]) and Process.process = Process_Location.process
and exists (select * from adx_product where FG_PN = adx_product.PRODUCT_ID)
*/
---------------------
/*
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
        FG_PN        
        --concat([PN_for_customer], '__', [Customer_abbreviate])

        ,REPLACE(FG_description, ',', ';')    
        --,FG_description

        ,CASE
         WHEN process_location.location is not null THEN process_location.location         
         ELSE '1000'
         END

        ,'1'
        ,'D'
        ,'1'
        ,'1000'
        ,'1000'
        ,'1'
        ,'-'
        ,'-'
        ,'-'
        ,'factor'
        ,'2'
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
  
FROM FG_SUBSTITUTES, Process, Process_Location
where Process.P_N = concat([PN_for_customer], '__', [Customer_abbreviate]) and Process.process = Process_Location.process
and exists (select * from adx_product where FG_PN = adx_product.PRODUCT_ID)
*/
---------------------
/*
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
        FG_PN        
        --concat([PN_for_customer], '@', [Customer_abbreviate])

        ,REPLACE(FG_description, ',', ';')    
        --,FG_description

        ,CASE
         WHEN process_location.location is not null THEN process_location.location         
         ELSE '1000'
         END

        ,'1'
        ,'D'
        ,'1'
        ,'1000'
        ,'1000'
        ,'1'
        ,'-'
        ,'-'
        ,'-'
        ,'factor'
        ,'2'
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
  
FROM FG_SUBSTITUTES, Process, Process_Location
where Process.P_N = concat([PN_for_customer], '@', [Customer_abbreviate]) and Process.process = Process_Location.process
and exists (select * from adx_product where FG_PN = adx_product.PRODUCT_ID)
*/
GO

