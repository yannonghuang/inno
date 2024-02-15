CREATE PROCEDURE [dbo].[write_op_override]
AS
insert into [master].[dbo].[adx_op_override] (
       [OPERATION_ID]
      ,[PRODUCT_ID]
      ,[RESOURCE_ID]
      ,[START_DATE]
      ,[END_DATE]
      ,[MIN_WAIT_TIME]
      ,[MAX_WAIT_TIME]
      ,[DEFAULT_SETUP_TIME]
      ,[PROCESS_TIME_FIRST_BATCH]
      ,[PROCESS_TIME_FIRST_UNIT]
      ,[UPH]
      ,[POST_PROCESSING_TIME]
      ,[BATCH_SCALE_FACTOR]
      ,[YIELD_FACTOR]
      ,[YIELD_LOST_QTY]
      ,[BORA_ID]
      ,[SETUP_TYPE]
      ,[PROCESS_TYPE]
      ,[CAPABLE_TYPE]
      ,[TRANSFER_LOT_SIZE]
)
SELECT 
      adx_route.OPERATION_ID

      ,'-' -- [PRODUCT_ID]
      ,'-' --,[RESOURCE_ID]
      ,'-' -- [START_DATE]
      ,'-' -- [END_DATE]
      ,'-' -- [MIN_WAIT_TIME]
      ,'-' -- [MAX_WAIT_TIME]

      ,case 
      when preprocessing is not null then preprocessing
      else '-'
      end
      -- [DEFAULT_SETUP_TIME]
      
      ,'-' -- [PROCESS_TIME_FIRST_BATCH]
      ,'-' -- [PROCESS_TIME_FIRST_UNIT]

      ,[UPH]
      
      ,case 
      when postprocessing is not null then postprocessing
      else '-'
      end
      -- [POST_PROCESSING_TIME]


      ,'-' -- [BATCH_SCALE_FACTOR]
      ,'-' -- [YIELD_FACTOR]
      ,'-' -- [YIELD_LOST_QTY]
      ,'-' -- [BORA_ID]
      ,'-' -- [SETUP_TYPE]
      ,'-' -- [PROCESS_TYPE]
      ,'-' -- [CAPABLE_TYPE]
      ,'-' -- [TRANSFER_LOT_SIZE]

FROM [Operation_Override_COP], adx_route
where Operation_Override_COP.OPERATION_ID = adx_route.OPERATION_ID
GO

