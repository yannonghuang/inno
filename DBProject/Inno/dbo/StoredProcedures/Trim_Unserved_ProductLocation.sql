
CREATE PROCEDURE [dbo].[Trim_Unserved_ProductLocation] 
AS
BEGIN

    delete from adx_productlocation
    where not exists (
    select * from adx_method_make where adx_method_make.PRODUCT_ID = adx_productlocation.PRODUCT_ID and adx_method_make.[LOCATION] = adx_productlocation.[LOCATION]
    ) and not exists (
    select * from adx_method_buy where adx_method_buy.PRODUCT_ID = adx_productlocation.PRODUCT_ID and adx_method_buy.[LOCATION] = adx_productlocation.LOCATION
    ) 
    and not exists (
    select * from adx_transportation where adx_transportation.PRODUCT = adx_productlocation.PRODUCT_ID and adx_transportation.TO_LOCATION = adx_productlocation.LOCATION
    ) 

    declare @productlocation_count int = 1;
    while @productlocation_count > 0
    BEGIN
        delete from adx_productlocation    
        where exists (
        select * from adx_method_make, adx_bom where adx_bom.PARENT_ID = adx_method_make.PRODUCT_ID and adx_method_make.PRODUCT_ID = adx_productlocation.PRODUCT_ID  and adx_method_make.[LOCATION] = adx_productlocation.[LOCATION]
            and not exists (select * from adx_productlocation internalR where adx_bom.CHILD_ID = internalR.PRODUCT_ID and adx_method_make.[LOCATION] = internalR.[LOCATION])
        )
        set @productlocation_count = @@rowcount;
    END

END
GO

