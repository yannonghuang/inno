CREATE PROCEDURE [dbo].[populate_preference_demand]
AS

declare @Firm_Sales_Weight FLOAT
declare @Forecast_Weight FLOAT
declare @Customer_Importance FLOAT

SELECT
    @Firm_Sales_Weight = [Firm_Sales],
    @Forecast_Weight = [Forecast],
    @Customer_Importance = [Customer_Importance]         
FROM [preference_weight]
where [Area] = 'Demand'

-------------
CREATE TABLE [dbo].[tmp_table0] (
	DEMAND_ID [nvarchar](100) NOT NULL,
    preference decimal  NULL,
) 

CREATE TABLE [dbo].[tmp_table] (
	DEMAND_ID [nvarchar](100) NOT NULL,
    preference decimal  NULL,
) 
------------
insert into [dbo].[tmp_table0] (
    DEMAND_ID,
    preference 
) 
select 
        adx_demand.DEMAND_ID

        ,preference = 

        -- QUANTITY
        (case
        when DATEDIFF(DAY, GETDATE(), convert(DATETIME, REQ_DUE_DATE, 1)) > 0
        then
            TRY_CAST(Quantity as decimal) / DATEDIFF(MONTH, GETDATE(), convert(DATETIME, REQ_DUE_DATE, 1))
        else
            TRY_CAST(Quantity as decimal)
        end) *
        @Forecast_Weight

        +

        -- customer importance
        (100 / 
            (select top 1 CustomerPref from adx_customer where adx_customer.CUSTOMER_ID = adx_demand.CUSTOMER_ID)) *
        @Customer_Importance

from adx_demand
where status = '2'


---------------

insert into tmp_table(
    DEMAND_ID,
    preference 
)    
select 
    DEMAND_ID,
    
    10 * ROW_NUMBER() over (partition by NULL order by preference DESC)
from tmp_table0
---------------
update adx_demand
set PRIORITY = case 
when 
exists (
    SELECT *      
    FROM [tmp_table]
    where adx_demand.DEMAND_ID = tmp_table.DEMAND_ID
)
then
(
    SELECT top 1 [tmp_table].preference      
    FROM [tmp_table]
    where adx_demand.DEMAND_ID = tmp_table.DEMAND_ID
)
else '10000'
--PREFERENCE
end

-------------
DROP TABLE [dbo].[tmp_table0]
DROP TABLE [dbo].[tmp_table]
GO

