CREATE PROCEDURE [dbo].[write_so_demand]
AS
BEGIN

insert into [dbo].[adx_demand] (
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
      ,PACKAGE
)
SELECT
      --concat([SONumber], '_', [ItemId])
      concat([SONumber], '_', 
        10 * ROW_NUMBER() over (partition by SONumber ORDER BY (SELECT NULL))
      )
      
      ,[Description]

      , case 
        when customer.Sold_to_customer is not null then customer.Sold_to_customer 
        else [CustomerCode] 
      end
      --,customer.Sold_to_customer -- [CustomerCode]

      ,'1'
      ,'100'
      ,DeliveryDate -- substring(CONVERT(VARCHAR, DeliveryDate), 1, 4) + '/' + substring(CONVERT(VARCHAR, DeliveryDate), 6, 2) + '/' + substring(CONVERT(VARCHAR, DeliveryDate), 9, 2)      
      ,DeliveryDate --substring(CONVERT(VARCHAR, DeliveryDate), 1, 4) + '/' + substring(CONVERT(VARCHAR, DeliveryDate), 6, 2) + '/' + substring(CONVERT(VARCHAR, DeliveryDate), 9, 2)    

      , case 
        when abbreviate_customer_code is not null then IndustrialStandard + '__' + abbreviate_customer_code
        -- else IndustrialStandard + '__domestic_others' -- ???   
        else [PN]           
      end

      ,'VIRTUAL'
      ,UnmetQuantity -- replace(UnmetQuantity, ',', '') -- [Quantity]
      ,'-'
      ,'-'

      ,'-'    
      -- [REVENUE]

      ,'-'
      ,'-'   
      ,'-'
      ,'-'   
      ,'-'
      ,'-'               
      ,POCFG.Work_order_code -- PACKAGE

  FROM POCFG, [dbo].[SO] left OUTER JOIN customer on
   [CustomerCode] = customer.Sold_to_customer or ('0000' + [CustomerCode] = customer.Sold_to_customer)
    -- left OUTER JOIN customer on [CustomerCode] = customer.Sold_to_customer
    --left OUTER JOIN customer on '0000' + [CustomerCode] = customer.Sold_to_customer
  where UnmetQuantity <> 0 and [POCFG].FG_PN = SO.PN
END
GO

