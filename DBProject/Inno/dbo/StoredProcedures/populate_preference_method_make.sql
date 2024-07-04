CREATE PROCEDURE [dbo].[populate_preference_method_make]
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

SELECT
      @FG_Inventory_Weight = [Inventory],
      @FG_Scheduled_Delivery_Weight = [Scheduled_Delivery],
      @FG_Shipment_History_Weight = [Shipment_History],
      @FG_Firm_Sales_Weight = [Firm_Sales],
      @FG_Forecast_Weight = [Forecast],

      @FG_Scheduled_Supply_Weight = Scheduled_Supply,
      @FG_Planned_Purchase_Weight = Planned_Purchase,
      @FG_Purchase_History_Weight = Purchase_History,

      @Overhead_Weight = [Overhead]    
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
      @Purchase_History_Weight = Purchase_History,

      @Overhead_Weight = [Overhead]    
  FROM [preference_weight]
  where [Area] = 'Make_Raw'

-------------
CREATE TABLE [dbo].[tmp_table0] (
	BOM_ID [nvarchar](100) NOT NULL,  -- DB load
	PRODUCT_ID [nvarchar](100) NOT NULL,
	[LOCATION_ID] [nvarchar](50) NOT NULL,
	[CHILD_ID] [nvarchar](50) NOT NULL,
    preference decimal  NULL,
) 

CREATE TABLE [dbo].[tmp_table] (
	BOM_ID [nvarchar](100) NOT NULL,  -- DB load      
	PRODUCT_ID [nvarchar](100) NOT NULL,
	[LOCATION_ID] [nvarchar](50) NOT NULL,
	[CHILD_ID] [nvarchar](50) NOT NULL,
    preference decimal  NULL,
) 
------------
insert into [dbo].[tmp_table0] (
    BOM_ID, -- DB load
	PRODUCT_ID ,
	[LOCATION_ID],
	[CHILD_ID],
    preference 
) 
select 
        adx_method_make.BOM_ID -- DB load

        ,adx_method_make.PRODUCT_ID
        ,adx_method_make.[LOCATION]
        ,adx_bom.CHILD_ID

        ,preference = 

        -- inventory
        (CASE
        when exists (
         select *
         FROM  adx_supply 
         where adx_bom.CHILD_ID = adx_supply.product_id and (adx_method_make.[LOCATION] = 'VIRTUAL' or adx_method_make.[LOCATION] = adx_supply.LOCATION_ID) and adx_supply.status = 's'
        ) then (
            case
            when adx_method_make.[LOCATION] = 'VIRTUAL'
            then (
                select SUM(TRY_CAST(adx_supply.qty as decimal))
                FROM  adx_supply 
                where adx_bom.CHILD_ID = adx_supply.product_id and (adx_method_make.[LOCATION] = 'VIRTUAL' or adx_method_make.[LOCATION] = adx_supply.LOCATION_ID) and adx_supply.status = 's'
                group by adx_supply.product_id
            ) else (
                select SUM(TRY_CAST(adx_supply.qty as decimal))
                FROM  adx_supply 
                where adx_bom.CHILD_ID = adx_supply.product_id and (adx_method_make.[LOCATION] = 'VIRTUAL' or adx_method_make.[LOCATION] = adx_supply.LOCATION_ID) and adx_supply.status = 's'
                group by adx_supply.product_id, adx_supply.LOCATION_ID
            )
            end
         )  
        else 0
        end) *
        (case when exists (select * from DP_Models where PN = adx_bom.CHILD_ID) then @FG_Inventory_Weight else @Inventory_Weight end)
         
        +

        -- scheduled supply
        (CASE
        when exists (
         select *
         FROM  adx_supply 
         where adx_bom.CHILD_ID = adx_supply.product_id and (adx_method_make.[LOCATION] = 'VIRTUAL' or adx_method_make.[LOCATION] = adx_supply.LOCATION_ID) and adx_supply.status = 'f'
        ) then (
            case
            when adx_method_make.[LOCATION] = 'VIRTUAL' then (
                select SUM(TRY_CAST(adx_supply.qty as decimal))
                FROM adx_supply 
                where adx_bom.CHILD_ID = adx_supply.product_id and (adx_method_make.[LOCATION] = 'VIRTUAL' or adx_method_make.[LOCATION] = adx_supply.LOCATION_ID) and adx_supply.status = 'f'
                group by adx_supply.product_id
            ) else (
                select SUM(TRY_CAST(adx_supply.qty as decimal))
                FROM adx_supply 
                where adx_bom.CHILD_ID = adx_supply.product_id and (adx_method_make.[LOCATION] = 'VIRTUAL' or adx_method_make.[LOCATION] = adx_supply.LOCATION_ID) and adx_supply.status = 'f'
                group by adx_supply.product_id, adx_supply.LOCATION_ID
            )
            end
        ) 
        else 0
        end    
        ) * 
        (case when exists (select * from DP_Models where PN = adx_bom.CHILD_ID) then @FG_Scheduled_Supply_Weight else @Scheduled_Supply_Weight end)

        +

        -- scheduled delivery
        (CASE
        when exists (
         select *
         FROM POC_delivery 
         where adx_bom.CHILD_ID = POC_delivery.PN and (adx_method_make.[LOCATION] = 'VIRTUAL' or adx_method_make.[LOCATION] = POC_delivery.Plant)
        ) then (
            case
            when adx_method_make.[LOCATION] = 'VIRTUAL' then (
                select SUM(POC_delivery.Quantity)
                FROM POC_delivery 
                where adx_bom.CHILD_ID = POC_delivery.PN and (adx_method_make.[LOCATION] = 'VIRTUAL' or adx_method_make.[LOCATION] = POC_delivery.Plant)
                group by POC_delivery.PN
            ) else (
                select SUM(POC_delivery.Quantity)
                FROM POC_delivery 
                where adx_bom.CHILD_ID = POC_delivery.PN and (adx_method_make.[LOCATION] = 'VIRTUAL' or adx_method_make.[LOCATION] = POC_delivery.Plant)
                group by POC_delivery.PN, POC_delivery.Plant
            )
            end
        ) 
        else 0
        end    
        ) * 
        (case when exists (select * from DP_Models where PN = adx_bom.CHILD_ID) then @FG_Scheduled_Delivery_Weight else @Scheduled_Delivery_Weight end)

        +

        -- firm sales
        (CASE
        when exists (
         select *
         FROM  [SO] 
         where adx_bom.CHILD_ID = [SO].PN and (adx_method_make.[LOCATION] = 'VIRTUAL' or adx_method_make.[LOCATION] = [SO].CompanyCode)
        ) then (
            case
            when adx_method_make.[LOCATION] = 'VIRTUAL' then (
                select SUM(TRY_CAST(SO.Quantity as decimal))
                FROM SO 
                where adx_bom.CHILD_ID = [SO].PN and (adx_method_make.[LOCATION] = 'VIRTUAL' or adx_method_make.[LOCATION] = [SO].CompanyCode)
                group by [SO].PN
            ) else (
                select SUM(TRY_CAST(SO.Quantity as decimal))
                FROM SO 
                where adx_bom.CHILD_ID = [SO].PN and (adx_method_make.[LOCATION] = 'VIRTUAL' or adx_method_make.[LOCATION] = [SO].CompanyCode)
                group by [SO].PN, [SO].CompanyCode
            )
            end
        ) 
        else 0
        end    
        ) * 
        (case when exists (select * from DP_Models where PN = adx_bom.CHILD_ID) then @FG_Firm_Sales_Weight else @Firm_Sales_Weight end)

        +

        -- shipment history
        (CASE
        when exists (
         select *
         FROM  shipments 
         where adx_bom.CHILD_ID = shipments.product_id and (adx_method_make.[LOCATION] = 'VIRTUAL' or adx_method_make.[LOCATION] = shipments.location_id)           
        ) then (
            case
            when adx_method_make.[LOCATION] = 'VIRTUAL' then (
                select SUM(quantity)
                FROM  shipments 
                where adx_bom.CHILD_ID = shipments.product_id and (adx_method_make.[LOCATION] = 'VIRTUAL' or adx_method_make.[LOCATION] = shipments.location_id)      
                group by shipments.product_id
            ) else (
                select SUM(quantity)
                FROM  shipments 
                where adx_bom.CHILD_ID = shipments.product_id and (adx_method_make.[LOCATION] = 'VIRTUAL' or adx_method_make.[LOCATION] = shipments.location_id)      
                group by shipments.product_id, shipments.location_id
            )
            end
        )        
        else 0     
        end
        ) *
        (case when exists (select * from DP_Models where PN = adx_bom.CHILD_ID) then @FG_Shipment_History_Weight else @Shipment_History_Weight end)

        +

        -- forecast
        (CASE
        when exists (
         select *
         FROM  Innolight_Forecast 
         where adx_bom.CHILD_ID = Innolight_Forecast.FG_PN and adx_method_make.[LOCATION] = 'VIRTUAL'            
        ) then (
         select SUM(STAT_FCST * STAT_PROBABILITY)
         FROM  Innolight_Forecast 
         where adx_bom.CHILD_ID = Innolight_Forecast.FG_PN and adx_method_make.[LOCATION] = 'VIRTUAL'     
         group by Innolight_Forecast.FG_PN)        
        else 0     
        end
        ) *
        (case when exists (select * from DP_Models where PN = adx_bom.CHILD_ID) then @FG_Forecast_Weight else @Forecast_Weight end)        
        --,[PREFERENCE]   
from adx_method_make, adx_bom
where adx_method_make.PRODUCT_ID = adx_bom.PARENT_ID and adx_bom.ALT_GROUP <> '-' 
and adx_method_make.BOM_ID = adx_bom.BOM_ID -- DB load

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
    BOM_ID, -- DB load
	PRODUCT_ID ,
	[LOCATION_ID],
	[CHILD_ID] ,
    preference
)    
select 
    BOM_ID, -- DB load
	PRODUCT_ID ,
	[LOCATION_ID],
	[CHILD_ID],
    -CAST(preference AS INT)
    --10 * ROW_NUMBER() over (partition by product_id, location_id order by preference DESC)
from tmp_table0
---------------
update adx_method_make
set PREFERENCE = case 
when 
exists (
    SELECT *      
    FROM [tmp_table]
    where adx_method_make.PRODUCT_ID = tmp_table.PRODUCT_ID and adx_method_make.LOCATION = tmp_table.LOCATION_ID
    and adx_method_make.BOM_ID = tmp_table.BOM_ID -- DB load
)
then
(
    SELECT top 1 STRING_AGG(
        [tmp_table].preference,
        '|') WITHIN GROUP (ORDER BY [tmp_table].CHILD_ID)      
    FROM [tmp_table]
    where adx_method_make.PRODUCT_ID = tmp_table.PRODUCT_ID and adx_method_make.LOCATION = tmp_table.LOCATION_ID
    and adx_method_make.BOM_ID = tmp_table.BOM_ID -- DB load
    group by [tmp_table].[PRODUCT_ID], [tmp_table].[LOCATION_ID], tmp_table.BOM_ID
)
else '10000' --'10000'
end
--PREFERENCE

/*-------------
update adx_method_make
set PREFERENCE = 0
where not exists (
    select * from adx_productlocation
    where adx_method_make.PRODUCT_ID = adx_productlocation.PRODUCT_ID and adx_method_make.[LOCATION] = adx_productlocation.[LOCATION] 
    -- and adx_productlocation.c = 0
)
-------------*/
DROP TABLE [dbo].[tmp_table0]
DROP TABLE [dbo].[tmp_table]
GO

