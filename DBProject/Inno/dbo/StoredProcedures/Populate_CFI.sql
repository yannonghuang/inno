
CREATE PROCEDURE [dbo].[Populate_CFI] 
AS
BEGIN

CREATE TABLE [dbo].[adx_productlocation_tmp](
	[PRODUCT_ID] [nvarchar](50) NULL,
	[DESCRIPTION] [nvarchar](200) NULL,
	[LOCATION] [nvarchar](50) NULL,
	[PRODUCT_TYPE] [tinyint] NULL,
	[RESOLUTION] [nvarchar](50) NULL,
	[MIN_LOT_SIZE] [tinyint] NULL,
	[MAX_LOT_SIZE] [smallint] NULL,
	[STD_LOT_SIZE] [smallint] NULL,
	[INCR_LOT_SIZE] [tinyint] NULL,
	[BUILD_PERIOD] [nvarchar](50) NULL,
	[OBSOLETE] [nvarchar](50) NULL,
	[TIME_FENCE] [nvarchar](50) NULL,
	[CYCLE_TYPE] [nvarchar](50) NULL,
	[CYCLE_FAMILY] [nvarchar](50) NULL,
	[INVENTORY] [nvarchar](50) NULL,
	[REVENUE] [nvarchar](50) NULL,
	[SHARE_FLAG] [tinyint] NULL,
	[MIX] [tinyint] NULL,
	[PROD_AREA] [nvarchar](50) NULL,
	[HIER_LEVEL_1] [nvarchar](50) NULL,
	[HIER_LEVEL_2] [nvarchar](50) NULL,
	[HIER_LEVEL_3] [nvarchar](50) NULL,
	[Product_Unit_Cost] [nvarchar](50) NULL,
	[UDA_string_LOC_ID] [nvarchar](50) NULL,
	[UDA_float_HOLD_COST] [nvarchar](50) NULL,
	[UDA_string_PRODUCT_FAMILY] [nvarchar](50) NULL,
	[UDA_string_PRODUCT_GROUP] [nvarchar](50) NULL,
	[UDA_string_TECHNOLOGY] [nvarchar](50) NULL,
	[UDA_string_PACKAGE] [nvarchar](500) NULL,
	[UDA_string_SHARED] [nvarchar](50) NULL,
	[UDA_string_FAB_LOC] [nvarchar](50) NULL,
	[UDA_string_MASK_LAYERS] [nvarchar](50) NULL,
	[UDA_string_WAFER_SIZE] [nvarchar](50) NULL,
	[UDA_string_BUMP_LOC] [nvarchar](50) NULL,
	[UDA_string_BUMP_TYPE] [nvarchar](50) NULL,
	[UDA_string_PROBE_LOC] [nvarchar](50) NULL,
	[UDA_string_PACKAGE_FAMILY] [nvarchar](50) NULL,
	[UDA_string_ASSY_LOC] [nvarchar](50) NULL,
	[UDA_string_TEST_LOC] [nvarchar](50) NULL,
	[UDA_string_A_MAT_STATUS] [nvarchar](50) NULL,
	[c] [int] NULL,
	[PROD_SKU_ID] [nvarchar](50) NULL,
	[LOCATION_ID] [nvarchar](50) NULL,
	[CYCLE_TIME_TYPE] [nvarchar](50) NULL,
	[CYCLE_TIME_FAMILY] [tinyint] NULL,
	[TECHNOLOGY] [nvarchar](50) NULL,
	[PACKAGE] [nvarchar](50) NULL
)

-----------------------------

insert into adx_productlocation_tmp(
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
	adx_productlocation.[DESCRIPTION],
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

	ISNULL(Production_LeadTime.cfi_family, [CYCLE_FAMILY]),
	
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
FROM 
    adx_productlocation left outer JOIN 
    Material_DP_Model ON
        Material_DP_Model.PN = adx_productlocation.[PRODUCT_ID] left outer JOIN 
    Production_LeadTime ON
        (Material_DP_Model.OLD_Description = Production_LeadTime.model2 
        or Material_DP_Model.Description = Production_LeadTime.model2) left outer JOIN Process ON
    Process.P_N = adx_productlocation.[PRODUCT_ID]
        and process.Process = Production_LeadTime.process

-----------------------------
truncate TABLE adx_productlocation

-----------------------------
INSERT into adx_productlocation
select * from adx_productlocation_tmp

---------------------------
DROP TABLE [adx_productlocation_tmp]

END
GO

