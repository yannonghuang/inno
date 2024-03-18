CREATE PROCEDURE [dbo].[populate_method_make_preference]
AS

declare @Inventory_Weight INTEGER
declare @Planned_Delivery_Weight INTEGER
declare @Shipment_History_Weight INTEGER
declare @Firm_Sales_Weight INTEGER
declare @Forecast_Weight INTEGER
declare @Overhead_Weight INTEGER
declare @Total INTEGER

SELECT
      @Inventory_Weight = [Inventory],
      @Planned_Delivery_Weight = [Planned_Delivery],
      @Shipment_History_Weight = [Shipment_History],
      @Firm_Sales_Weight = [Firm_Sales],
      @Forecast_Weight = [Forecast],
      @Overhead_Weight = [Overhead]    
  FROM [preference_weight]
  where [Area] = 'Material'

set @Total = 
 @Inventory_Weight +
 @Planned_Delivery_Weight +
 @Shipment_History_Weight +
 @Firm_Sales_Weight +
 @Forecast_Weight +
 @Overhead_Weight

-------------
CREATE TABLE [dbo].[tmp_table] (
	PRODUCT_ID [nvarchar](100) NOT NULL,
	[LOCATION_ID] [nvarchar](50) NOT NULL,
	[CHILD_ID] [nvarchar](50) NOT NULL,
    preference decimal not NULL
) 

------------
insert into [dbo].[tmp_table] (
	PRODUCT_ID ,
	[LOCATION_ID],
	[CHILD_ID],
    preference 
) 
select 
        adx_method_make.PRODUCT_ID
        ,adx_method_make.[LOCATION]
        ,adx_bom.CHILD_ID

        ,PREFERENCE = 
        CASE
        when exists (
         select *
         FROM  adx_supply 
         where adx_bom.CHILD_ID = adx_supply.product_id and adx_method_make.[LOCATION] = adx_supply.LOCATION_ID and adx_supply.status = 's'
        ) then
        (select SUM(TRY_CAST(adx_supply.qty as decimal))
         FROM  adx_supply 
         where adx_bom.CHILD_ID = adx_supply.product_id and adx_method_make.[LOCATION] = adx_supply.LOCATION_ID and adx_supply.status = 's'
         group by adx_supply.product_id, adx_supply.LOCATION_ID) * (@Inventory_Weight / @Total)
        else 1
        end 

        +
        
        CASE
        when exists (
         select *
         FROM  adx_supply 
         where adx_bom.CHILD_ID = adx_supply.product_id and adx_method_make.[LOCATION] = adx_supply.LOCATION_ID and adx_supply.status = 'f'
        ) then
        (select SUM(TRY_CAST(adx_supply.qty as decimal))
         FROM  adx_supply 
         where adx_bom.CHILD_ID = adx_supply.product_id and adx_method_make.[LOCATION] = adx_supply.LOCATION_ID and adx_supply.status = 'f'
         group by adx_supply.product_id, adx_supply.LOCATION_ID) * (@Planned_Delivery_Weight / @Total)
        else 1
        end    
        +
        CASE
        when exists (
         select *
         FROM  Innolight_Forecast 
         where adx_bom.CHILD_ID = Innolight_Forecast.FG_PN and adx_method_make.[LOCATION] = 'VIRTUAL'            
        ) then (
         select SUM([STAT_FCST])
         FROM  Innolight_Forecast 
         where adx_bom.CHILD_ID = Innolight_Forecast.FG_PN and adx_method_make.[LOCATION] = 'VIRTUAL'     
         group by Innolight_Forecast.FG_PN) * (@Forecast_Weight / @Total)       
        else 1     
        end
        --,[PREFERENCE]   
from adx_method_make, adx_bom
where adx_method_make.PRODUCT_ID = adx_bom.PARENT_ID and adx_bom.ALT_GROUP <> '-' 

---------------
update tmp_table
set preference = round( 
    (select max(preference) from tmp_table internalR 
    where internalR.PRODUCT_ID = tmp_table.PRODUCT_ID and internalR.LOCATION_ID = tmp_table.LOCATION_ID
    ) / preference, 0)

---------------
update adx_method_make
set PREFERENCE = case 
when 
exists (
    SELECT *      
    FROM [tmp_table]
    where adx_method_make.PRODUCT_ID = tmp_table.PRODUCT_ID and adx_method_make.PRODUCT_ID = tmp_table.PRODUCT_ID
)
then
(
    SELECT top 1 STRING_AGG(
        [tmp_table].preference,
        '|') WITHIN GROUP (ORDER BY [tmp_table].CHILD_ID)      
    FROM [tmp_table]
    where adx_method_make.PRODUCT_ID = tmp_table.PRODUCT_ID and adx_method_make.LOCATION = tmp_table.LOCATION_ID
    group by [tmp_table].[PRODUCT_ID], [tmp_table].[LOCATION_ID]
)
else '1000000'
end

-------------
DROP TABLE [dbo].[tmp_table]
GO

