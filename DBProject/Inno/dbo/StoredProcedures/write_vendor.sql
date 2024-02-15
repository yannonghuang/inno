CREATE PROCEDURE [dbo].[write_vendor]
AS
insert into [master].[dbo].[adx_vendor] (
[VENDOR_ID]
      ,[VENDOR_DESCRIPTION]
      ,[VENDOR_HIER_LEVEL_1]
      ,[VENDOR_HIER_LEVEL_2]
      ,[VENDOR_HIER_LEVEL_3]
      ,[VENDOR_TYPE]
)
SELECT 
    [VENDOR_ID]
    ,[VENDOR_ID]
    ,'HIER_LEVEL_1'
    ,'HIER_LEVEL_2'
    ,'HIER_LEVEL_3'
    ,'VENDOR_TYPE'
 
  FROM [Method_Buy]
GO

