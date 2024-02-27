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
        'BOM_' + [DPM] + '@' + Customer
        ,'-'
        , [DPM] + '@' + Customer
        , [CustomerPN] + '@' + Customer
        ,'1'
        ,'1'        
        , [CustomerPN] + '@' + Customer
        ,'-'
        ,'-'   
        ,'1'   
        ,'-'
        ,'-'
        ,'-'  
        ,'-'
  FROM [master].[dbo].[DPM_CustomerPN_Customer]
GO

