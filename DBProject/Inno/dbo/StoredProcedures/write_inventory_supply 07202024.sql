CREATE PROCEDURE [dbo].[write_inventory_supply 07202024]
AS
insert into [dbo].[adx_supply] (
      [SUPPLY_ID]
      ,[DESCRIPTION]
      ,[VENDOR_ID]
      ,[LOCATION_ID]
      ,[PRODUCT_ID]
      ,[SUPPLY_DATE]
      ,[QTY]
      ,[STATUS]
      ,[METHOD]
      ,[COST]
      ,[FAB_LOC]
      ,[FAB_PART_ID]
      ,[LOT_ID]
      ,[TECHNOLOGY]
      ,[MASK_LAYERS]
      ,[WAFER_SIZE]
      ,[MAT_TYPE]
      ,[PASSIVATION]
      ,[BUMP_LOC]
      ,[PROBE_LOC]
      ,[DB_LOC]
      ,[PACKAGE_FAMILY]
      ,[PACKAGE]
      ,[ASSY_LOC]
      ,[TEST_LOC]
      ,[DM_SPEC]
      ,[DEMAND_ID]
      ,[WIRE_COLOR]
      ,[PROD_AREA]
      ,[ALLOCATION]
)
SELECT
    --concat(PN, '_', Plant, '_', UnconstrainedQuantity)
    concat(PN, '_', Plant, '_', Storage, '_', UnconstrainedQuantity)
    , REPLACE(Stock_all.Description, ',', ';') -- [Description]         
    
    , '-'
    ,[Plant]
    ,[PN]
    ,'-'
    ,[UnconstrainedQuantity]
    ,'s'

    ,'-'
    ,'-'
    ,'-'
    ,'-'
    ,'-'
    ,'-'
    ,'-'
    ,'-'
    ,'-'
    ,'-'
    ,'-'
    ,'-'
    ,'-'
    ,'-'
    ,'-'
    ,'-'
    ,'-'
    ,'-'
    ,'-'
    ,'-'
    ,'-'
    ,'-'               
  FROM [dbo].[Stock_all], adx_productlocation
  where -- SN is not NULL and
     PN = adx_productlocation.PRODUCT_ID and plant = adx_productlocation.[LOCATION]
GO

