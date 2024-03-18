CREATE PROCEDURE [dbo].[populate_transportation_preference]
AS

CREATE TABLE [dbo].[tmp_table] (
	PRODUCT_ID [nvarchar](100) NOT NULL,
	[FROM_LOCATION] [nvarchar](50) NOT NULL,
	[TO_LOCATION] [nvarchar](50) NOT NULL,    
    preference decimal not NULL

) 

------------
insert into [dbo].[tmp_table] (
	PRODUCT_ID ,
	[FROM_LOCATION],
    TO_LOCATION,
    preference 
) 
select 
        adx_transportation.PRODUCT
        ,adx_transportation.FROM_LOCATION
        ,adx_transportation.TO_LOCATION

        ,PREFERENCE = 
        CASE
        when exists (
         select *
         FROM  adx_supply 
         where adx_transportation.PRODUCT = adx_supply.product_id and adx_transportation.FROM_LOCATION = adx_supply.LOCATION_ID and adx_supply.status = 's'
        ) then
        (
         select SUM(TRY_CAST(adx_supply.qty as decimal))
         FROM  adx_supply 
         where adx_transportation.PRODUCT = adx_supply.product_id and adx_transportation.FROM_LOCATION = adx_supply.LOCATION_ID and adx_supply.status = 's'
         group by adx_supply.product_id, adx_supply.LOCATION_ID  
        )
        else 0
        end 
        +
        CASE
        when exists (
         select *
         FROM  adx_supply 
         where adx_transportation.PRODUCT = adx_supply.product_id and adx_transportation.FROM_LOCATION = adx_supply.LOCATION_ID and adx_supply.status = 'f'
        ) then
        (
         select SUM(TRY_CAST(adx_supply.qty as decimal))
         FROM  adx_supply 
         where adx_transportation.PRODUCT = adx_supply.product_id and adx_transportation.FROM_LOCATION = adx_supply.LOCATION_ID and adx_supply.status = 'f'
         group by adx_supply.product_id, adx_supply.LOCATION_ID  
        )
        else 0
        end    
        +
        CASE
        when exists (
         select *
         FROM  Innolight_Forecast 
         where adx_transportation.PRODUCT = Innolight_Forecast.FG_PN and adx_transportation.TO_LOCATION = 'VIRTUAL'            
        ) then
        (
         select SUM([STAT_FCST])
         FROM  Innolight_Forecast 
         where adx_transportation.PRODUCT = Innolight_Forecast.FG_PN and adx_transportation.TO_LOCATION = 'VIRTUAL'     
         group by Innolight_Forecast.FG_PN            
        )       
        else 0     
        end
        --,[PREFERENCE]   
from adx_transportation


---------------
update adx_transportation
set PREFERENCE = case 
when 
exists (
    SELECT *      
    FROM [tmp_table]
    where adx_transportation.PRODUCT = tmp_table.PRODUCT_ID and adx_transportation.FROM_LOCATION = tmp_table.FROM_LOCATION 
    and adx_transportation.TO_LOCATION = tmp_table.TO_LOCATION
)
then
(
    SELECT top 1 tmp_table.preference     
    FROM [tmp_table]
    where adx_transportation.PRODUCT = tmp_table.PRODUCT_ID and adx_transportation.FROM_LOCATION = tmp_table.FROM_LOCATION 
    and adx_transportation.TO_LOCATION = tmp_table.TO_LOCATION
)
else 0
end

-------------
DROP TABLE [dbo].[tmp_table]
GO

