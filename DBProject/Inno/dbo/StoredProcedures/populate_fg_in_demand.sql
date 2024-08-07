CREATE PROCEDURE [dbo].[populate_fg_in_demand]
AS

truncate table adx_demand

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
)
SELECT
      concat(Customer, '_', New_Model.Code, Month)
      ,Model
      ,customer.Sold_to_customer -- SUBSTRING(customer.Sold_to_customer, 5, 6) --Customer
      ,'2'
      ,'100'
      ,substring(Month, 7, 2) + '/01/' + substring(Month, 4, 2)
      ,substring(Month, 7, 2) + '/01/' + substring(Month, 4, 2)
      ,New_Model.Code + '@' + Customer --New_Model.Code
      ,'VIRTUAL'
      ,replace(Forecast, ',', '')

      ,'-'
      ,'-'      
      ,'-'

      ,'-'
      ,'-'   
      ,'-'
      ,'-'   
      ,'-'
      ,'-'               

from New_Model, adx_productlocation, customer, (
SELECT Customer, Model, Month, Forecast  
FROM 
   (SELECT Customer, Model, 
      [_2024_01]
      ,[_2024_02]
      ,[_2024_03]
      ,[_2024_04]
      ,[_2024_05]
      ,[_2024_06]
      ,[_2024_07]
      ,[_2024_08]
      ,[_2024_09]
      ,[_2024_10]
      ,[_2024_11]
      ,[_2024_12]
      ,[_2025_01]
      ,[_2025_02]
      ,[_2025_03]
      ,[_2025_04]      
   FROM DP
   where Category = 'forecast') p  
UNPIVOT  
   (Forecast FOR Month IN (
       [_2024_01]
      ,[_2024_02]
      ,[_2024_03]
      ,[_2024_04]
      ,[_2024_05]
      ,[_2024_06]
      ,[_2024_07]
      ,[_2024_08]
      ,[_2024_09]
      ,[_2024_10]
      ,[_2024_11]
      ,[_2024_12]  
      ,[_2025_01]
      ,[_2025_02]
      ,[_2025_03]
      ,[_2025_04]        
    )  
) AS unpvt
) TranposedDP
where TranposedDP.Model = New_Model.DPModel
    and New_Model.Code = adx_productlocation.PRODUCT_ID and 'VIRTUAL' = adx_productlocation.[LOCATION]
    and Customer = customer.abbreviate_customer_code

DELETE T
FROM
(
SELECT *
, DupRank = ROW_NUMBER() OVER (
              PARTITION BY DEMAND_ID
              ORDER BY (SELECT NULL)
            )
FROM [dbo].[adx_demand]
) AS T
WHERE DupRank > 1

truncate TABLE FG_In_Demand

insert into FG_In_Demand
SELECT distinct [PN]
  FROM [Inno].[dbo].[DP_Models], adx_demand
  where adx_demand.PRODUCT_ID like DP_Models.code + '%'
GO

