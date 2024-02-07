CREATE PROCEDURE [dbo].[write_dpm_method_make]
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
        work_order_model   

        ,CASE
         WHEN (process_location.location is not null) and (process_location.manufacture = 'M') THEN process_location.location         
         ELSE '1000' 
         END
       
        ,'ROUTE_dummy'  

        ,'1'
        ,'0'
        ,'BOM_' + work_order_model
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
FROM [POCModel], [POCFG], Process, Process_Location
where Work_order_code = work_order_model
and Process.P_N = work_order_model and Process.process = Process_Location.process
GO

