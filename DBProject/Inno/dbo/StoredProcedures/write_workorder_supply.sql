CREATE PROCEDURE [dbo].[write_workorder_supply]
AS
insert into [master].[dbo].[adx_supply] (
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
    [WO]
    , REPLACE(production_order.[Description], ',', ';') -- [Description]        
    , '-'    
    ,[Plant]
    ,[PN]
    ,Due_Date --REPLACE(Due_Date, '-', '/')
    ,[Quantity_GMEIN]
    ,'f'
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
  FROM [master].[dbo].[production_order], adx_productlocation
  where WO is not NULL
  and PN = adx_productlocation.PRODUCT_ID and Plant = adx_productlocation.[LOCATION]
GO

