CREATE PROCEDURE [dbo].[populate_preference_method_buy]
AS

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
  where [Area] = 'Buy'

-------------
CREATE TABLE [dbo].[tmp_table0] (
	PRODUCT_ID [nvarchar](100) NOT NULL,
	[LOCATION_ID] [nvarchar](50) NOT NULL,
	[Vendor_ID] [nvarchar](50) NOT NULL,
    preference decimal  NULL,
) 

CREATE TABLE [dbo].[tmp_table] (
	PRODUCT_ID [nvarchar](100) NOT NULL,
	[LOCATION_ID] [nvarchar](50) NOT NULL,
	[Vendor_ID] [nvarchar](50) NOT NULL,
    preference decimal  NULL,
) 
------------
insert into [dbo].[tmp_table0] (
	PRODUCT_ID ,
	[LOCATION_ID],
	[Vendor_ID],
    preference 
) 
select 
        adx_method_buy.PRODUCT_ID
        ,adx_method_buy.[LOCATION]
        ,adx_method_buy.VENDOR_ID

        ,preference = 

        -- planned purchase
        (CASE
        when exists (
         select *
         FROM  opo 
         where adx_method_buy.PRODUCT_ID = opo.PN and adx_method_buy.[LOCATION] = opo.Plant and adx_method_buy.[VENDOR_ID] like ('%' + opo.Vendor)
        ) then
        (select SUM(TRY_CAST(opo.Quantity as decimal))
         FROM  opo 
         where adx_method_buy.PRODUCT_ID = opo.PN and adx_method_buy.[LOCATION] = opo.Plant and adx_method_buy.[VENDOR_ID] like ('%' + opo.Vendor)
         group by opo.PN, opo.Plant, opo.Vendor)  
        else 0
        end) *
        @Planned_Purchase_Weight
           
from adx_method_buy


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
	[LOCATION_ID],
	[Vendor_ID] ,
    preference
)    
select 
	PRODUCT_ID ,
	[LOCATION_ID],
	[Vendor_ID] ,
    10 * ROW_NUMBER() over (partition by product_id, location_id order by preference DESC)
from tmp_table0
---------------
update adx_method_buy
set PREFERENCE = case 
when 
exists (
    SELECT *      
    FROM [tmp_table]
    where adx_method_buy.PRODUCT_ID = tmp_table.PRODUCT_ID and adx_method_buy.LOCATION = tmp_table.LOCATION_ID and adx_method_buy.[VENDOR_ID] = tmp_table.Vendor_ID
)
then
(
    SELECT top 1 [tmp_table].preference      
    FROM [tmp_table]
    where adx_method_buy.PRODUCT_ID = tmp_table.PRODUCT_ID and adx_method_buy.LOCATION = tmp_table.LOCATION_ID and adx_method_buy.[VENDOR_ID] = tmp_table.Vendor_ID
)
else '5000'
--PREFERENCE
end

-------------
DROP TABLE [dbo].[tmp_table0]
DROP TABLE [dbo].[tmp_table]
GO

