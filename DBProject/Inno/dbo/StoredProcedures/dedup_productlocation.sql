CREATE PROCEDURE [dbo].[dedup_productlocation]
AS
DELETE T
FROM
(
SELECT *
, DupRank = ROW_NUMBER() OVER (
              PARTITION BY PRODUCT_ID, LOCATION, UDA_string_PACKAGE, UDA_string_TECHNOLOGY, PROD_AREA, HIER_LEVEL_1
              ORDER BY (SELECT NULL)
            )
FROM [dbo].[adx_productlocation]
) AS T
WHERE DupRank > 1


-------------------

truncate TABLE adx_productlocation_mirror

-------------------


insert into adx_productlocation_mirror (
	[PRODUCT_ID],
	[DESCRIPTION],
	[LOCATION],
	[PRODUCT_TYPE],
	[RESOLUTION],
	[MIN_LOT_SIZE],
	[MAX_LOT_SIZE],
	[STD_LOT_SIZE],
	[INCR_LOT_SIZE],
	[BUILD_PERIOD],
	[OBSOLETE],
	[TIME_FENCE],
	[CYCLE_TYPE],
	[CYCLE_FAMILY],
	[INVENTORY],
	[REVENUE],
	[SHARE_FLAG],
	[MIX],
	[PROD_AREA],
	[HIER_LEVEL_1],
	[HIER_LEVEL_2],
	[HIER_LEVEL_3],
	[Product_Unit_Cost],
	[UDA_string_LOC_ID],
	[UDA_float_HOLD_COST],
	[UDA_string_PRODUCT_FAMILY],
	[UDA_string_PRODUCT_GROUP],
	[UDA_string_TECHNOLOGY],
	[UDA_string_PACKAGE],
	[UDA_string_SHARED],
	[UDA_string_FAB_LOC],
	[UDA_string_MASK_LAYERS],
	[UDA_string_WAFER_SIZE],
	[UDA_string_BUMP_LOC],
	[UDA_string_BUMP_TYPE],
	[UDA_string_PROBE_LOC],
	[UDA_string_PACKAGE_FAMILY],
	[UDA_string_ASSY_LOC],
	[UDA_string_TEST_LOC],
	[UDA_string_A_MAT_STATUS],
	[c],
	[PROD_SKU_ID],
	[LOCATION_ID],
	[CYCLE_TIME_TYPE],
	[CYCLE_TIME_FAMILY],
	[TECHNOLOGY],
	[PACKAGE]      
)
SELECT 
	adx_productlocation.[PRODUCT_ID],
	adx_productlocation.[DESCRIPTION],
	adx_productlocation.[LOCATION],
	adx_productlocation.[PRODUCT_TYPE],
	adx_productlocation.[RESOLUTION],
	adx_productlocation.[MIN_LOT_SIZE],
	adx_productlocation.[MAX_LOT_SIZE],
	adx_productlocation.[STD_LOT_SIZE],
	adx_productlocation.[INCR_LOT_SIZE],
	adx_productlocation.[BUILD_PERIOD],
	adx_productlocation.[OBSOLETE],
	adx_productlocation.[TIME_FENCE],
	adx_productlocation.[CYCLE_TYPE],
	adx_productlocation.[CYCLE_FAMILY],
	adx_productlocation.[INVENTORY],
	adx_productlocation.[REVENUE],
	adx_productlocation.[SHARE_FLAG],
	adx_productlocation.[MIX],

	adx_productlocation.[PROD_AREA],
    --case
    --    when adx_productlocation.PROD_AREA = '-' or adx_productlocation.PROD_AREA is null then r2.PROD_AREA
    --    else adx_productlocation.PROD_AREA
    --end,

	adx_productlocation.[HIER_LEVEL_1],
    --case
    --    when r2.HIER_LEVEL_1 is not null then r2.HIER_LEVEL_1
    --    else adx_productlocation.HIER_LEVEL_1
    --end,

	adx_productlocation.[HIER_LEVEL_2],
	adx_productlocation.[HIER_LEVEL_3],
	adx_productlocation.[Product_Unit_Cost],
	adx_productlocation.[UDA_string_LOC_ID],
	adx_productlocation.[UDA_float_HOLD_COST],
	adx_productlocation.[UDA_string_PRODUCT_FAMILY],
	adx_productlocation.[UDA_string_PRODUCT_GROUP],
	
    --[UDA_string_TECHNOLOGY],
    case
        when r2.UDA_string_TECHNOLOGY is not null then r2.UDA_string_TECHNOLOGY
        else adx_productlocation.UDA_string_TECHNOLOGY
    end,
	
    adx_productlocation.[UDA_string_PACKAGE],
    --case
    --    when r2.UDA_string_PACKAGE is not null then r2.UDA_string_PACKAGE
    --    else adx_productlocation.UDA_string_PACKAGE
    --end,

	adx_productlocation.[UDA_string_SHARED],
	adx_productlocation.[UDA_string_FAB_LOC],
	adx_productlocation.[UDA_string_MASK_LAYERS],
	adx_productlocation.[UDA_string_WAFER_SIZE],
	adx_productlocation.[UDA_string_BUMP_LOC],
	adx_productlocation.[UDA_string_BUMP_TYPE],
	adx_productlocation.[UDA_string_PROBE_LOC],
	adx_productlocation.[UDA_string_PACKAGE_FAMILY],
	adx_productlocation.[UDA_string_ASSY_LOC],
	adx_productlocation.[UDA_string_TEST_LOC],
	adx_productlocation.[UDA_string_A_MAT_STATUS],
	adx_productlocation.[c],
	adx_productlocation.[PROD_SKU_ID],
	adx_productlocation.[LOCATION_ID],
	adx_productlocation.[CYCLE_TIME_TYPE],
	adx_productlocation.[CYCLE_TIME_FAMILY],
	adx_productlocation.[TECHNOLOGY],
	adx_productlocation.[PACKAGE]    
FROM [dbo].[adx_productlocation] left outer join adx_productlocation r2 on 
    adx_productlocation.PRODUCT_ID = r2.PRODUCT_ID and adx_productlocation.[LOCATION] = r2.[LOCATION]
--    and r2.UDA_string_PACKAGE <> '-'
    and r2.UDA_string_TECHNOLOGY <> '-'
--    and r2.HIER_LEVEL_1 <> '-'

-------------------

DELETE T
FROM
(
SELECT *
, DupRank = ROW_NUMBER() OVER (
              PARTITION BY PRODUCT_ID, LOCATION, UDA_string_PACKAGE, UDA_string_TECHNOLOGY, PROD_AREA, HIER_LEVEL_1
              ORDER BY (SELECT NULL)
            )
FROM [dbo].[adx_productlocation_mirror]
) AS T
WHERE DupRank > 1


-------------------
truncate table adx_productlocation
-------------------
insert into adx_productlocation (
	[PRODUCT_ID],
	[DESCRIPTION],
	[LOCATION],
	[PRODUCT_TYPE],
	[RESOLUTION],
	[MIN_LOT_SIZE],
	[MAX_LOT_SIZE],
	[STD_LOT_SIZE],
	[INCR_LOT_SIZE],
	[BUILD_PERIOD],
	[OBSOLETE],
	[TIME_FENCE],
	[CYCLE_TYPE],
	[CYCLE_FAMILY],
	[INVENTORY],
	[REVENUE],
	[SHARE_FLAG],
	[MIX],
	[PROD_AREA],
	[HIER_LEVEL_1],
	[HIER_LEVEL_2],
	[HIER_LEVEL_3],
	[Product_Unit_Cost],
	[UDA_string_LOC_ID],
	[UDA_float_HOLD_COST],
	[UDA_string_PRODUCT_FAMILY],
	[UDA_string_PRODUCT_GROUP],
	[UDA_string_TECHNOLOGY],
	[UDA_string_PACKAGE],
	[UDA_string_SHARED],
	[UDA_string_FAB_LOC],
	[UDA_string_MASK_LAYERS],
	[UDA_string_WAFER_SIZE],
	[UDA_string_BUMP_LOC],
	[UDA_string_BUMP_TYPE],
	[UDA_string_PROBE_LOC],
	[UDA_string_PACKAGE_FAMILY],
	[UDA_string_ASSY_LOC],
	[UDA_string_TEST_LOC],
	[UDA_string_A_MAT_STATUS],
	[c],
	[PROD_SKU_ID],
	[LOCATION_ID],
	[CYCLE_TIME_TYPE],
	[CYCLE_TIME_FAMILY],
	[TECHNOLOGY],
	[PACKAGE]      
)
SELECT 
	[PRODUCT_ID],
	[DESCRIPTION],
	[LOCATION],
	[PRODUCT_TYPE],
	[RESOLUTION],
	[MIN_LOT_SIZE],
	[MAX_LOT_SIZE],
	[STD_LOT_SIZE],
	[INCR_LOT_SIZE],
	[BUILD_PERIOD],
	[OBSOLETE],
	[TIME_FENCE],
	[CYCLE_TYPE],
	[CYCLE_FAMILY],
	[INVENTORY],
	[REVENUE],
	[SHARE_FLAG],
	[MIX],
	[PROD_AREA],
	[HIER_LEVEL_1],
	[HIER_LEVEL_2],
	[HIER_LEVEL_3],
	[Product_Unit_Cost],
	[UDA_string_LOC_ID],
	[UDA_float_HOLD_COST],
	[UDA_string_PRODUCT_FAMILY],
	[UDA_string_PRODUCT_GROUP],
	[UDA_string_TECHNOLOGY],
	STRING_AGG(UDA_string_PACKAGE, '_') WITHIN GROUP (ORDER BY UDA_string_PACKAGE ASC), --[UDA_string_PACKAGE],
	[UDA_string_SHARED],
	[UDA_string_FAB_LOC],
	[UDA_string_MASK_LAYERS],
	[UDA_string_WAFER_SIZE],
	[UDA_string_BUMP_LOC],
	[UDA_string_BUMP_TYPE],
	[UDA_string_PROBE_LOC],
	[UDA_string_PACKAGE_FAMILY],
	[UDA_string_ASSY_LOC],
	[UDA_string_TEST_LOC],
	[UDA_string_A_MAT_STATUS],
	[c],
	[PROD_SKU_ID],
	[LOCATION_ID],
	[CYCLE_TIME_TYPE],
	[CYCLE_TIME_FAMILY],
	[TECHNOLOGY],
	[PACKAGE]    
FROM [dbo].[adx_productlocation_mirror]
group by 
	[PRODUCT_ID],
	[DESCRIPTION],
	[LOCATION],
	[PRODUCT_TYPE],
	[RESOLUTION],
	[MIN_LOT_SIZE],
	[MAX_LOT_SIZE],
	[STD_LOT_SIZE],
	[INCR_LOT_SIZE],
	[BUILD_PERIOD],
	[OBSOLETE],
	[TIME_FENCE],
	[CYCLE_TYPE],
	[CYCLE_FAMILY],
	[INVENTORY],
	[REVENUE],
	[SHARE_FLAG],
	[MIX],
	[PROD_AREA],
	[HIER_LEVEL_1],
	[HIER_LEVEL_2],
	[HIER_LEVEL_3],
	[Product_Unit_Cost],
	[UDA_string_LOC_ID],
	[UDA_float_HOLD_COST],
	[UDA_string_PRODUCT_FAMILY],
	[UDA_string_PRODUCT_GROUP],
	[UDA_string_TECHNOLOGY],
--	[UDA_string_PACKAGE],
	[UDA_string_SHARED],
	[UDA_string_FAB_LOC],
	[UDA_string_MASK_LAYERS],
	[UDA_string_WAFER_SIZE],
	[UDA_string_BUMP_LOC],
	[UDA_string_BUMP_TYPE],
	[UDA_string_PROBE_LOC],
	[UDA_string_PACKAGE_FAMILY],
	[UDA_string_ASSY_LOC],
	[UDA_string_TEST_LOC],
	[UDA_string_A_MAT_STATUS],
	[c],
	[PROD_SKU_ID],
	[LOCATION_ID],
	[CYCLE_TIME_TYPE],
	[CYCLE_TIME_FAMILY],
	[TECHNOLOGY],
	[PACKAGE]    

-------------------
GO

