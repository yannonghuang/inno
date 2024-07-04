CREATE PROCEDURE [dbo].[write_fgs_method_make]
AS
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
        concat([PN_for_customer], '__', [Customer_abbreviate])    

        ,CASE
         WHEN (process_location.location is not null) and (process_location.manufacture = 'M') THEN process_location.location         
         ELSE '1000' 
         END
       
        ,'ROUTE_dummy'  

        ,'1'
        ,'0'
        ,'BOM_' + concat([PN_for_customer], '__', [Customer_abbreviate]) + '_' + FG_PN -- DB load
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
FROM FG_SUBSTITUTES, Process, Process_Location, adx_product
where Process.P_N = concat([PN_for_customer], '__', [Customer_abbreviate]) and Process.process = Process_Location.process
and FG_PN = adx_product.PRODUCT_ID
GO

