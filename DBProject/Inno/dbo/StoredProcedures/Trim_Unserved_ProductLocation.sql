
CREATE PROCEDURE [dbo].[Trim_Unserved_ProductLocation] 
AS
BEGIN

    declare @productlocation_served_count int = 1;
    declare @productlocation_completed_count int = 1;    
    declare @productlocation_sound_count int = 1;        
    declare @transportation_count int = 1;    
    while @productlocation_served_count > 0 and @transportation_count > 0 and @productlocation_completed_count > 0 -- and @productlocation_sound_count > 0
    BEGIN

        delete from adx_productlocation
        where 
        not exists (select * from adx_bom where adx_bom.CHILD_ID = adx_productlocation.PRODUCT_ID and adx_bom.ALT_GROUP <> '-')

        and not exists (
        select * from adx_method_make where adx_method_make.PRODUCT_ID = adx_productlocation.PRODUCT_ID and adx_method_make.[LOCATION] = adx_productlocation.[LOCATION]
        ) and not exists (
        select * from adx_method_buy where adx_method_buy.PRODUCT_ID = adx_productlocation.PRODUCT_ID and adx_method_buy.[LOCATION] = adx_productlocation.LOCATION
        ) 
        and not exists (
        select * from adx_transportation where adx_transportation.PRODUCT = adx_productlocation.PRODUCT_ID and adx_transportation.TO_LOCATION = adx_productlocation.LOCATION
        ) 
        set @productlocation_served_count = @@rowcount;
-----------------------------------------------
        delete from adx_productlocation    
        where  
        not exists (select * from adx_bom where adx_bom.CHILD_ID = adx_productlocation.PRODUCT_ID and adx_bom.ALT_GROUP <> '-')
        
        and exists (
        select * from adx_method_make, adx_bom where 
            adx_bom.ALT_GROUP = '-'
            and adx_bom.PARENT_ID = adx_method_make.PRODUCT_ID and adx_method_make.PRODUCT_ID = adx_productlocation.PRODUCT_ID 
            and adx_method_make.[LOCATION] = adx_productlocation.[LOCATION]
            and not exists (select * from adx_productlocation internalR where adx_bom.CHILD_ID = internalR.PRODUCT_ID and adx_method_make.[LOCATION] = internalR.[LOCATION])            
        )
        set @productlocation_completed_count = @@rowcount;
-----------------------------------------------
/*
        delete from adx_productlocation    
        where 
        exists (
        select * from adx_method_make, adx_bom where 
            adx_bom.ALT_GROUP <> '-'

            and adx_bom.PARENT_ID = adx_method_make.PRODUCT_ID and adx_method_make.PRODUCT_ID = adx_productlocation.PRODUCT_ID 
            and adx_method_make.[LOCATION] = adx_productlocation.[LOCATION] and

            (select count(distinct child_id) from adx_bom adx_bom_internalR1 where adx_bom_internalR1.PARENT_ID = adx_bom.PARENT_ID)
            =
            (select count(distinct child_id) from adx_bom adx_bom_internalR2 where adx_bom_internalR2.PARENT_ID = adx_bom.PARENT_ID
            and not exists (select * from adx_productlocation internalR where adx_bom_internalR2.CHILD_ID = internalR.PRODUCT_ID 
            and adx_method_make.[LOCATION] = internalR.[LOCATION]) 
            )          
        )
        set @productlocation_sound_count = @@rowcount;
*/
-----------------------------------------------
        delete from adx_transportation
        where not exists (
            select * from adx_productlocation
            where adx_transportation.FROM_LOCATION = adx_productlocation.[LOCATION] and adx_transportation.PRODUCT = adx_productlocation.[PRODUCT_ID] 
        )
        set @transportation_count = @@rowcount;
    END

END
GO

