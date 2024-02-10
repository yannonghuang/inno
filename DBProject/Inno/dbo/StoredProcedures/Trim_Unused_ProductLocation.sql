
CREATE PROCEDURE [dbo].[Trim_Unused_ProductLocation] 
AS
BEGIN

declare @productlocation_count int = 1;
declare @method_make_count int = 1;
declare @method_buy_count int = 1;
declare @transportation_count int = 1;

while @productlocation_count > 0 or @method_make_count > 0 or @method_buy_count > 0 or @transportation_count > 0
begin
    delete from adx_productlocation
    where 
    not exists (
        select * from Finished_Goods
        where adx_productlocation.PRODUCT_ID = Finished_Goods.PRODUCT_ID
    ) and 
    not exists (
        select * from adx_bom, adx_productlocation internalR, adx_method_make 
        where adx_bom.child_id = adx_productlocation.PRODUCT_ID and
            adx_bom.parent_id = internalR.PRODUCT_ID and
            internalR.[LOCATION] = adx_productlocation.[LOCATION] AND
            adx_method_make.BOM_ID = adx_bom.BOM_ID and adx_method_make.[LOCATION] = adx_productlocation.[LOCATION]
    ) and 
    not exists (
        select * from adx_transportation where adx_transportation.PRODUCT = adx_productlocation.PRODUCT_ID and adx_transportation.FROM_LOCATION = adx_productlocation.LOCATION
    )
    set @productlocation_count = @@rowcount;

    delete from [adx_method_make]
    where not exists (
        select * from adx_productlocation where adx_method_make.PRODUCT_ID = adx_productlocation.PRODUCT_ID and adx_method_make.[LOCATION] = adx_productlocation.[LOCATION]
    )
    set @method_make_count = @@rowcount;

    delete from [adx_method_buy]
    where not exists (
        select * from adx_productlocation where adx_method_buy.PRODUCT_ID = adx_productlocation.PRODUCT_ID and adx_method_buy.[LOCATION] = adx_productlocation.[LOCATION]
    )
    set @method_buy_count = @@rowcount;

    delete from [adx_transportation]
    where not exists (
        select * from adx_productlocation where adx_transportation.PRODUCT = adx_productlocation.PRODUCT_ID and adx_transportation.[TO_LOCATION] = adx_productlocation.[LOCATION]
    )
    set @transportation_count = @@rowcount;
END

END
GO

