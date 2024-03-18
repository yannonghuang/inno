CREATE PROCEDURE [dbo].[Trim_Demand]
AS
BEGIN

delete from [dbo].[adx_demand]
where not exists (
    select * from adx_productlocation
    where adx_demand.PRODUCT_ID = adx_productlocation.PRODUCT_ID and adx_demand.LOCATION_ID = adx_productlocation.[LOCATION] 
) or not exists (
    select * from adx_customer
    where adx_demand.CUSTOMER_ID = adx_customer.CUSTOMER_ID 
)


END
GO

