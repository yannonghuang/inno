CREATE PROCEDURE [dbo].[write_so_demand]
AS
insert into [master].[dbo].[adx_demand] (
       [DEMAND_ID]
      ,[DESCRIPTION]
      ,[CUSTOMER_ID]
      ,[STATUS]
      ,[PRIORITY]
      ,[REQ_DUE_DATE]
      ,[COMMITTED_DUE_TIME]
      ,[PRODUCT_ID]
      ,[LOCATION_ID]
      ,[QUANTITY]
      ,[LATE_DEMAND_PENALTY]
      ,[SHORT_DEMAND_PENALTY]
      ,[REVENUE]
      ,[ALLOCATION_S]
      ,[DM_SPEC_S]
      ,[ASSY_LOC_S]
      ,[FAB_LOC_S]
      ,[DEMAND_ID_S]
      ,[WIRE_COLOR_S]
)
SELECT
      [SONumber]
      ,[Description]
      ,[CustomerCode]
      ,'1'
      ,'100'
      ,[DeliveryDate]
      ,[DeliveryDate]
      ,[IndustrialStandard] + '@' + customer.abbreviate_customer_code -- ???
      ,'VIRTUAL'
      ,[Quantity]
      ,'-'
      ,'-'      
      ,[REVENUE]

      ,'-'
      ,'-'   
      ,'-'
      ,'-'   
      ,'-'
      ,'-'               

  FROM [master].[dbo].[SO], customer
  where '0000' + [CustomerCode] = customer.Sold_to_customer
GO

