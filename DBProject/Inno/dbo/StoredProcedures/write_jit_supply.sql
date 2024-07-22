CREATE PROCEDURE [dbo].[write_jit_supply]
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
select 
    concat(TranposedDP.PN, '_', TranposedDP.Plant) + TranposedDP.WK -- [WO]
    , REPLACE([Description], ',', ';') -- [Description]        
    , '-'    
    ,TranposedDP.Plant
    ,TranposedDP.PN
    ,substring(TranposedDP.WK, 6, 2) + '/' + substring(TranposedDP.WK, 8, 2) + '/' + substring(TranposedDP.WK, 2, 4) -- TranposedDP.WK --REPLACE(Due_Date, '-', '/')
    ,TranposedDP.[Quantity]
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

from adx_productlocation, (
  SELECT Plant, PN, WK, Quantity  
FROM 
   (SELECT Plant, PN, 
      [_20240714]
      ,[_20240721]
      ,[_20240728]
      ,[_20240804]
      ,[_20240811]
      ,[_20240818]
      ,[_20240825]
      ,[_20240901]
      ,[_20240908]
      ,[_20240915]
      ,[_20240922]
      ,[_20240929]
      ,[_20241006]
      ,[_20241103]
      ,[_20241201]
      ,[_20250105]
      ,[_20250202]
      ,[_20250302]
      ,[_20250406]
      ,[_20250504]
      ,[_20250601]
   FROM JIT_commit) p  
UNPIVOT  
   (Quantity FOR WK IN (
      [_20240714]
      ,[_20240721]
      ,[_20240728]
      ,[_20240804]
      ,[_20240811]
      ,[_20240818]
      ,[_20240825]
      ,[_20240901]
      ,[_20240908]
      ,[_20240915]
      ,[_20240922]
      ,[_20240929]
      ,[_20241006]
      ,[_20241103]
      ,[_20241201]
      ,[_20250105]
      ,[_20250202]
      ,[_20250302]
      ,[_20250406]
      ,[_20250504]
      ,[_20250601]
    )  
) AS unpvt
) TranposedDP
where TranposedDP.PN = adx_productlocation.PRODUCT_ID and TranposedDP.Plant = adx_productlocation.[LOCATION]
and TranposedDP.[Quantity] is not null and TranposedDP.[Quantity] > 0
GO

