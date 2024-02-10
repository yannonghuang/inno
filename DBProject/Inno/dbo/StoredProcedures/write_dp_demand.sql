CREATE PROCEDURE [dbo].[write_dp_demand]
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
      concat(Customer, '_', New_Model.Code, '_', Month)
      ,Model
      ,Customer
      ,'2'
      ,'100'
      ,Month
      ,Month
      ,New_Model.Code
      ,'VIRTUAL'
      ,Forecast

      ,'-'
      ,'-'      
      ,'-'

      ,'-'
      ,'-'   
      ,'-'
      ,'-'   
      ,'-'
      ,'-'               

from New_Model, (
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

   FROM DP) p  
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
    )  
) AS unpvt
) TranposedDP
where TranposedDP.Model = New_Model.DPModel
GO

