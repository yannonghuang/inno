CREATE PROCEDURE [dbo].[write_rescapinter]
AS
insert into [master].[dbo].[adx_rescapinter] (
       [RESOURCE_ID]
      ,[START_TIME]
      ,[OFFSET]
      ,[CAP_FACTOR]
      ,[PATTERN_ID]
)
SELECT  
       [RESOURCE_ID]
      ,'-'
      ,'-'
      ,'1'
      ,'24x7'

FROM [master].[dbo].[adx_resource]
GO

