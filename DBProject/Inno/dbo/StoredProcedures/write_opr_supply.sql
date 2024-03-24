CREATE PROCEDURE [dbo].[write_opr_supply]
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
    concat(OPR.[PN], '_', OPR.[Plant], '_', OPR.Supply_Date) --[WO]
    , REPLACE(OPR.[Description], ',', ';') -- [Description]        
    , '-'    
    ,OPR.[Plant]
    ,OPR.[PN]
    ,substring(OPR.Supply_Date, 5, 2) + '/' + substring(OPR.Supply_Date, 7, 2) + '/' + substring(OPR.Supply_Date, 1, 4)
    ,REPLACE(OPR.[Quantity], ',', '') -- OPR.[Quantity]
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
  FROM [dbo].[OPR], adx_productlocation
  where PN = adx_productlocation.PRODUCT_ID and Plant = adx_productlocation.[LOCATION]
GO

