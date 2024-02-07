
CREATE PROCEDURE [dbo].[Trim_Unserved_ProductLocation] 
AS
BEGIN

delete from adx_productlocation
where not exists (
    select * from adx_method_make where adx_method_make.PRODUCT_ID = adx_productlocation.PRODUCT_ID -- and adx_method_make.[LOCATION] = adx_productlocation.[LOCATION]
) and not exists (
    select * from adx_method_buy where adx_method_buy.PRODUCT_ID = adx_productlocation.PRODUCT_ID -- and adx_method_buy.[LOCATION] = adx_productlocation.LOCATION
) 

--and not exists (
--    select * from adx_transportation where adx_transportation.PRODUCT = adx_productlocation.PRODUCT_ID and adx_transportation.TO_LOCATION = adx_productlocation.LOCATION
--) 

END
GO

