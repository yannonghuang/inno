CREATE PROCEDURE [dbo].[write_customer]
AS
insert into [master].[dbo].[adx_customer] (
[CUSTOMER_ID]
      ,[CUSTOMER_DESCRIPTION]
      ,[CustomerPref]
      ,[CUSTOMER_HIER_LEVEL_1]
      ,[CUSTOMER_HIER_LEVEL_2]
      ,[CUSTOMER_HIER_LEVEL_3]
)
SELECT 
    [CustomerCode]
    ,[CustomerName]
    ,'1'
    ,'HIER_LEVEL_1'
    ,'HIER_LEVEL_2'
    ,'HIER_LEVEL_3'
 
  FROM [master].[dbo].[SO]
GO

