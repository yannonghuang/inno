CREATE PROCEDURE [dbo].[write_customer]
AS
insert into [dbo].[adx_customer] (
[CUSTOMER_ID]
      ,[CUSTOMER_DESCRIPTION]
      ,[CustomerPref]
      ,[CUSTOMER_HIER_LEVEL_1]
      ,[CUSTOMER_HIER_LEVEL_2]
      ,[CUSTOMER_HIER_LEVEL_3]
)
SELECT 
    [Sold_to_customer]
    ,[Name]
    ,'1'
    ,'HIER_LEVEL_1'
    ,'HIER_LEVEL_2'
    ,'HIER_LEVEL_3'
  FROM [Inno].[dbo].[customer]
/*
SELECT 
    [CustomerCode]
    ,[CustomerName]
    ,'1'
    ,'HIER_LEVEL_1'
    ,'HIER_LEVEL_2'
    ,'HIER_LEVEL_3' 
  FROM [dbo].[SO]
*/

insert into [dbo].[adx_customer] (
[CUSTOMER_ID]
      ,[CUSTOMER_DESCRIPTION]
      ,[CustomerPref]
      ,[CUSTOMER_HIER_LEVEL_1]
      ,[CUSTOMER_HIER_LEVEL_2]
      ,[CUSTOMER_HIER_LEVEL_3]
)
values( 
    'PSM01'
    ,'Innolight Technology USA Inc.'
    ,'1'
    ,'HIER_LEVEL_1'
    ,'HIER_LEVEL_2'
    ,'HIER_LEVEL_3'
)
GO

