CREATE PROCEDURE [dbo].[write_operation]
AS
insert into [master].[dbo].[adx_operation] (
       [OPERATION_ID]
      ,[DESCRIPTION]
      ,[MIN_WAIT_TIME]
      ,[MAX_WAIT_TIME]
      ,[DEFAULT_SETUP_TIME]
      ,[FIRST_BATCH_TIME]
      ,[FIRST_UNIT_TIME]
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
VALUES(
       'OP_dummy'
      ,'-'
      ,'-'
      ,'-'
      ,'-'
      ,'-'
      ,'-'
      ,'-'
      ,'-'
      ,'-'
      ,'1'
      ,'-'
      ,'BORA_dummy'
      ,'-'
      ,'-'
      ,'-'
      ,'-' 
)

insert into [master].[dbo].[adx_operation] (
       [OPERATION_ID]
      ,[DESCRIPTION]
      ,[MIN_WAIT_TIME]
      ,[MAX_WAIT_TIME]
      ,[DEFAULT_SETUP_TIME]
      ,[FIRST_BATCH_TIME]
      ,[FIRST_UNIT_TIME]
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
       OPERATION_ID
      ,'-'
      ,'-'
      ,'-'
      ,'-'
      ,'-'
      ,'-'
      ,'-'
      ,'-'
      ,'-'
      ,'1'
      ,'-'
      ,REPLACE(OPERATION_ID, 'OP', 'BORA') --'BORA_dummy'
      ,'-'
      ,'-'
      ,'-'
      ,'-' 
  FROM [master].[dbo].[adx_route]
GO
