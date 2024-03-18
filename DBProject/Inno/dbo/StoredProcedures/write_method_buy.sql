CREATE PROCEDURE [dbo].[write_method_buy]
AS
insert into [dbo].[adx_method_buy] (
        [PRODUCT_ID]
      ,[LOCATION]
      ,[PREFERENCE]
      ,[COST]
      ,[MIN_SUPPLY]
      ,[MAX_SUPPLY]
      ,[LEAD_DAYS_SUPPLY]
      ,[CYCLE_DAYS_SUPPLY]
      ,[VENDOR_ID]
      ,[EFFECTIVE_START]
      ,[EFFECTIVE_END]
      ,[HIER_LEVEL_1]
      ,[HIER_LEVEL]
      ,[HIER_LEVEL_3]
      ,[process_unit_cost]
)
SELECT 

    Method_Buy.[PRODUCT_ID]
    ,Method_Buy.[LOCATION]
    ,100
    ,10
    ,100
    ,1000
    ,1 -- [LEAD_DAYS_SUPPLY]
    ,10
    ,[VENDOR_ID]
    ,'-'
    ,'-'

    ,'HIER_LEVEL_1'
    ,'HIER_LEVEL_2'
    ,'HIER_LEVEL_3'
    ,1
 
  FROM [Method_Buy], adx_product
  where Method_Buy.PRODUCT_ID = adx_product.PRODUCT_ID
  order by [PRODUCT_ID], [VENDOR_ID]

------------------------------------------------------
  update [adx_method_buy] 
  SET [LEAD_DAYS_SUPPLY] = (
    case 
    when exists (SELECT * 
        FROM old_Method_buy
        where adx_method_buy.PRODUCT_ID = old_Method_Buy.PRODUCT_ID) 
    then (
        SELECT top 1  LEAD_DAYS_SUPPLY 
        FROM old_Method_buy
        where adx_method_buy.PRODUCT_ID = old_Method_Buy.PRODUCT_ID
    )
    else '100'
    end
  )
GO

