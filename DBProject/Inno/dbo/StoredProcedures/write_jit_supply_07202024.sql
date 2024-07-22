CREATE PROCEDURE [dbo].[write_jit_supply_07202024]
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
      [_20240317]
      ,[_20240324]
      ,[_20240331]
      ,[_20240407]
      ,[_20240414]
      ,[_20240421]
      ,[_20240428]
      ,[_20240505]
      ,[_20240512]
      ,[_20240519]
      ,[_20240526]
      ,[_20240602]
      ,[_20240707]
      ,[_20240804]
      ,[_20240901]
      ,[_20241006]
   FROM JIT_commit) p  
UNPIVOT  
   (Quantity FOR WK IN (
      [_20240317]
      ,[_20240324]
      ,[_20240331]
      ,[_20240407]
      ,[_20240414]
      ,[_20240421]
      ,[_20240428]
      ,[_20240505]
      ,[_20240512]
      ,[_20240519]
      ,[_20240526]
      ,[_20240602]
      ,[_20240707]
      ,[_20240804]
      ,[_20240901]
      ,[_20241006]
    )  
) AS unpvt
) TranposedDP
where TranposedDP.PN = adx_productlocation.PRODUCT_ID and TranposedDP.Plant = adx_productlocation.[LOCATION]
and TranposedDP.[Quantity] <> '0'
GO

