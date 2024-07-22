CREATE PROCEDURE [dbo].[populate_preference_method_move]
AS

declare @FG_Inventory_Weight FLOAT
declare @FG_Scheduled_Delivery_Weight FLOAT
declare @FG_Shipment_History_Weight FLOAT
declare @FG_Firm_Sales_Weight FLOAT
declare @FG_Forecast_Weight FLOAT
declare @FG_Scheduled_Supply_Weight FLOAT
declare @FG_Planned_Purchase_Weight FLOAT
declare @FG_Purchase_History_Weight FLOAT

declare @Inventory_Weight FLOAT
declare @Scheduled_Delivery_Weight FLOAT
declare @Shipment_History_Weight FLOAT
declare @Firm_Sales_Weight FLOAT
declare @Forecast_Weight FLOAT
declare @Scheduled_Supply_Weight FLOAT
declare @Planned_Purchase_Weight FLOAT
declare @Purchase_History_Weight FLOAT
declare @Overhead_Weight FLOAT

declare @Buy_Planned_Purchase_Weight FLOAT

SELECT
    @Buy_Planned_Purchase_Weight = Planned_Purchase
FROM [preference_weight]
where [Area] = 'Buy'


SELECT
      @FG_Inventory_Weight = [Inventory],
      @FG_Scheduled_Delivery_Weight = [Scheduled_Delivery],
      @FG_Shipment_History_Weight = [Shipment_History],
      @FG_Firm_Sales_Weight = [Firm_Sales],
      @FG_Forecast_Weight = [Forecast],

      @FG_Scheduled_Supply_Weight = Scheduled_Supply,
      @FG_Planned_Purchase_Weight = Planned_Purchase,
      @FG_Purchase_History_Weight = Purchase_History 
FROM [preference_weight]
where [Area] = 'Make_FG'

SELECT
      @Inventory_Weight = [Inventory],
      @Scheduled_Delivery_Weight = [Scheduled_Delivery],
      @Shipment_History_Weight = [Shipment_History],
      @Firm_Sales_Weight = [Firm_Sales],
      @Forecast_Weight = [Forecast],

      @Scheduled_Supply_Weight = Scheduled_Supply,
      @Planned_Purchase_Weight = Planned_Purchase,
      @Purchase_History_Weight = Purchase_History
FROM [preference_weight]
where [Area] = 'Make_Raw'

SELECT
      @Overhead_Weight = [Overhead]    
FROM [preference_weight]
where [Area] = 'Move'

-------------
CREATE TABLE [dbo].[tmp_table0] (
	PRODUCT_ID [nvarchar](100) NOT NULL,
	[FROM_LOCATION] [nvarchar](50) NOT NULL,
	[TO_LOCATION] [nvarchar](50) NOT NULL,
    preference decimal  NULL,
) 

CREATE TABLE [dbo].[tmp_table] (
	PRODUCT_ID [nvarchar](100) NOT NULL,
	[FROM_LOCATION] [nvarchar](50) NOT NULL,
	[TO_LOCATION] [nvarchar](50) NOT NULL,
    preference decimal  NULL,
) 
------------
insert into [dbo].[tmp_table0] (
	PRODUCT_ID ,
	[FROM_LOCATION],
    TO_LOCATION,
    preference 
) 
select 
        adx_transportation.PRODUCT
        ,adx_transportation.FROM_LOCATION
        ,adx_transportation.TO_LOCATION

        ,preference = 

        -- inventory
        (CASE
        when exists (
         select *
         FROM  adx_supply 
         where adx_transportation.PRODUCT = adx_supply.product_id and adx_transportation.FROM_LOCATION = adx_supply.LOCATION_ID and adx_supply.status = 's'
        ) then (
         select SUM(TRY_CAST(adx_supply.qty as decimal))
         FROM  adx_supply 
         where adx_transportation.PRODUCT = adx_supply.product_id and adx_transportation.FROM_LOCATION = adx_supply.LOCATION_ID and adx_supply.status = 's'
         group by adx_supply.product_id, adx_supply.LOCATION_ID
         )  
        else 0
        end) *
        (case when exists (select * from DP_Models where PN = adx_transportation.PRODUCT) then @FG_Inventory_Weight else @Inventory_Weight end)
         
        +

        -- scheduled supply
        (CASE
        when exists (
         select *
         FROM  adx_supply 
         where adx_transportation.PRODUCT = adx_supply.product_id and (adx_transportation.FROM_LOCATION = adx_supply.LOCATION_ID) and adx_supply.status = 'f'
        ) then (
            select SUM(TRY_CAST(adx_supply.qty as decimal))
            FROM adx_supply 
            where adx_transportation.PRODUCT = adx_supply.product_id and (adx_transportation.FROM_LOCATION = adx_supply.LOCATION_ID) and adx_supply.status = 'f'
            group by adx_supply.product_id, adx_supply.LOCATION_ID
        ) 
        else 0
        end    
        ) * 
        (case when exists (select * from DP_Models where PN = adx_transportation.PRODUCT) then @FG_Scheduled_Supply_Weight else @Scheduled_Supply_Weight end)

        +

        -- scheduled delivery
        (CASE
        when exists (
         select *
         FROM POC_delivery 
         where adx_transportation.PRODUCT = POC_delivery.PN and (adx_transportation.FROM_LOCATION = POC_delivery.Plant)
        ) then (
            select SUM(POC_delivery.Quantity)
            FROM POC_delivery 
            where adx_transportation.PRODUCT = POC_delivery.PN and (adx_transportation.FROM_LOCATION = POC_delivery.Plant)
            group by POC_delivery.PN, POC_delivery.Plant
        ) 
        else 0
        end    
        ) * 
        (case when exists (select * from DP_Models where PN = adx_transportation.PRODUCT) then @FG_Scheduled_Delivery_Weight else @Scheduled_Delivery_Weight end)

        +

        -- firm sales
        (CASE
        when exists (
         select *
         FROM  [SO] 
         where adx_transportation.PRODUCT = [SO].PN --and (adx_transportation.FROM_LOCATION = [SO].CompanyCode)
        ) then (
            select SUM(TRY_CAST(SO.UnmetQuantity as decimal))
            FROM SO 
            where adx_transportation.PRODUCT = [SO].PN --and (adx_transportation.FROM_LOCATION = [SO].CompanyCode)
            group by [SO].PN--, [SO].CompanyCode
        ) 
        else 0
        end    
        ) * 
        (case when exists (select * from DP_Models where PN = adx_transportation.PRODUCT) then @FG_Firm_Sales_Weight else @Firm_Sales_Weight end)

        +

        -- shipment history
        (CASE
        when exists (
         select *
         FROM  shipments 
         where adx_transportation.PRODUCT = shipments.product_id --and (adx_transportation.FROM_LOCATION = shipments.location_id)           
        ) then (
            select SUM(quantity)
            FROM  shipments 
            where adx_transportation.PRODUCT = shipments.product_id --and (adx_transportation.FROM_LOCATION = shipments.location_id)      
            group by shipments.product_id--, shipments.location_id
        )        
        else 0     
        end
        ) *
        (case when exists (select * from DP_Models where PN = adx_transportation.PRODUCT) then @FG_Shipment_History_Weight else @Shipment_History_Weight end)

        +

        -- forecast
        (CASE
        when exists (
         select *
         FROM  Innolight_Forecast 
         where adx_transportation.PRODUCT = Innolight_Forecast.FG_PN and adx_transportation.[TO_LOCATION] = 'VIRTUAL'            
        ) then (
         select SUM(STAT_FCST * STAT_PROBABILITY)
         FROM  Innolight_Forecast 
         where adx_transportation.PRODUCT = Innolight_Forecast.FG_PN and adx_transportation.[TO_LOCATION] = 'VIRTUAL'     
         group by Innolight_Forecast.FG_PN)        
        else 0     
        end
        ) *
        (case when exists (select * from DP_Models where PN = adx_transportation.PRODUCT) then @FG_Forecast_Weight else @Forecast_Weight end) 

        +
        
        -- planned purchase
        (CASE
        when exists (
         select *
         FROM  opo 
         where adx_transportation.PRODUCT = opo.PN and adx_transportation.[FROM_LOCATION] = opo.Plant
        ) then
        (select SUM(TRY_CAST(opo.Quantity as decimal))
         FROM  opo 
         where adx_transportation.PRODUCT = opo.PN and adx_transportation.[FROM_LOCATION] = opo.Plant
         group by opo.PN, opo.Plant)  
        else 0
        end) *
        @Buy_Planned_Purchase_Weight

        +

        -- overhead
        (adx_transportation.COST * adx_transportation.TRANSIT_TIME) * @Overhead_Weight               
        --,[PREFERENCE]   
from adx_transportation 

---------------
/*
update tmp_table
set preference = round( 
    (select max(preference) from tmp_table internalR 
    where internalR.PRODUCT_ID = tmp_table.PRODUCT_ID and internalR.LOCATION_ID = tmp_table.LOCATION_ID
    ) / preference, 0)
*/    
---------------
insert into tmp_table(
	PRODUCT_ID ,
	[FROM_LOCATION],
    TO_LOCATION,
    preference 
)    
select 
	PRODUCT_ID ,
	[FROM_LOCATION],
    TO_LOCATION,
    -CAST(preference AS INT)
    --10 * ROW_NUMBER() over (partition by product_id, TO_LOCATION order by preference DESC)
from tmp_table0
---------------
update adx_transportation
set PREFERENCE = case 
when 
exists (
    SELECT *      
    FROM [tmp_table]
    where adx_transportation.PRODUCT = tmp_table.PRODUCT_ID 
    and adx_transportation.FROM_LOCATION = tmp_table.FROM_LOCATION and adx_transportation.TO_LOCATION = tmp_table.TO_LOCATION
)
then
(
    SELECT top 1 [tmp_table].preference      
    FROM [tmp_table]
    where adx_transportation.PRODUCT = tmp_table.PRODUCT_ID 
    and adx_transportation.FROM_LOCATION = tmp_table.FROM_LOCATION and adx_transportation.TO_LOCATION = tmp_table.TO_LOCATION
)
else '10000' --'5000'
--PREFERENCE
end

-------------
DROP TABLE [dbo].[tmp_table0]
DROP TABLE [dbo].[tmp_table]
GO

