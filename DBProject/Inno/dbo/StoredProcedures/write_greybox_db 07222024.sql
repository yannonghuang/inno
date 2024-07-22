CREATE PROCEDURE [dbo].[write_greybox_db 07222024]
AS

insert into [dbo].[ADX_GREYBOX_HEADER] (
       [CONSTRAINT_ID]
      ,[BUILD_POLICY]
      ,[DEFAULT_BUILD_AHEAD]
      ,[BUILD_AHEAD_NAME]
      ,[WEIGHT_FACTOR_NAME]
      ,[HIER_LEVEL_1]
      ,[HIER_LEVEL_2]
      ,[HIER_LEVEL_3]
      ,[GROUP1]
      ,[GROUP2]
      --,[DATA_LAST_UPDATED]
)
SELECT 
    [LOCATION] + '_' + [COMLOCATION_UDA_PROD_AREA] + '_' + [COMLOCATION_UDA_TECHNOLOGY] + '_' + [COMLOCATION_UDA_PACKAGE]
    ,[BUILDPOLICY]
    ,[BUILDEARLYLIMIT]
    ,[BUILD_AHEAD]
    ,'-'
    ,[HIER_LEVEL_1]
    ,[HIER_LEVEL_2]
    ,[HIER_LEVEL_3]
    ,'-'
    ,'-'
FROM [Inno].[dbo].[adx_graybox]

DELETE T
FROM
(
SELECT *
, DupRank = ROW_NUMBER() OVER (
              PARTITION BY CONSTRAINT_ID
              ORDER BY (SELECT NULL)
            )
FROM [dbo].[ADX_GREYBOX_HEADER]
) AS T
WHERE DupRank > 1
----------------------------------------------------------------------------
----------------------------------------------------------------------------
insert into [dbo].[ADX_GREYBOX_TARGET] (
       [CONSTRAINT_ID]
      ,[CSTR_OBJECT_NAME]
      --,[UDA_NAME]
      ,[CONSTRAINT_TYPE]
      ,[RESTRICTION_VALUE]
      ,[CONSTRAINT_ORDER]
      --,[DATA_LAST_UPDATED]
)
SELECT
    [LOCATION] + '_' + [COMLOCATION_UDA_PROD_AREA] + '_' + [COMLOCATION_UDA_TECHNOLOGY] + '_' + [COMLOCATION_UDA_PACKAGE]
    ,'LOCATION'
    ,'RESTRICTION'
    ,[LOCATION]
    ,'0'
FROM [Inno].[dbo].[adx_graybox]

-----------------------------------
insert into [dbo].[ADX_GREYBOX_TARGET] (
       [CONSTRAINT_ID]
      ,[CSTR_OBJECT_NAME]
      ,[UDA_NAME]
      ,[CONSTRAINT_TYPE]
      ,[RESTRICTION_VALUE]
      ,[CONSTRAINT_ORDER]
      --,[DATA_LAST_UPDATED]
)
SELECT
    [LOCATION] + '_' + [COMLOCATION_UDA_PROD_AREA] + '_' + [COMLOCATION_UDA_TECHNOLOGY] + '_' + [COMLOCATION_UDA_PACKAGE]
    ,'COMLOCATION'
    ,'PROD_AREA'
    ,'RESTRICTION'
    ,[COMLOCATION_UDA_PROD_AREA]
    ,'1'
FROM [Inno].[dbo].[adx_graybox]
-----------------------------------
insert into [dbo].[ADX_GREYBOX_TARGET] (
       [CONSTRAINT_ID]
      ,[CSTR_OBJECT_NAME]
      ,[UDA_NAME]
      ,[CONSTRAINT_TYPE]
      ,[RESTRICTION_VALUE]
      ,[CONSTRAINT_ORDER]
      --,[DATA_LAST_UPDATED]
)
SELECT
    [LOCATION] + '_' + [COMLOCATION_UDA_PROD_AREA] + '_' + [COMLOCATION_UDA_TECHNOLOGY] + '_' + [COMLOCATION_UDA_PACKAGE]
    ,'COMLOCATION'
    ,'TECHNOLOGY'
    ,'RESTRICTION'
    ,[COMLOCATION_UDA_TECHNOLOGY]
    ,'2'
FROM [Inno].[dbo].[adx_graybox]
-----------------------------------
insert into [dbo].[ADX_GREYBOX_TARGET] (
       [CONSTRAINT_ID]
      ,[CSTR_OBJECT_NAME]
      ,[UDA_NAME]
      ,[CONSTRAINT_TYPE]
      ,[RESTRICTION_VALUE]
      ,[CONSTRAINT_ORDER]
      --,[DATA_LAST_UPDATED]
)
SELECT
    [LOCATION] + '_' + [COMLOCATION_UDA_PROD_AREA] + '_' + [COMLOCATION_UDA_TECHNOLOGY] + '_' + [COMLOCATION_UDA_PACKAGE]
    ,'COMLOCATION'
    ,'PACKAGE'
    ,'RESTRICTION'
    ,[COMLOCATION_UDA_PACKAGE]
    ,'3'
FROM [Inno].[dbo].[adx_graybox]

DELETE T
FROM
(
SELECT *
, DupRank = ROW_NUMBER() OVER (
              PARTITION BY        
                [CONSTRAINT_ID]
                ,[CSTR_OBJECT_NAME]
                ,[UDA_NAME]
              ORDER BY (SELECT NULL)
            )
FROM [dbo].[ADX_GREYBOX_TARGET]
) AS T
WHERE DupRank > 1
----------------------------------------------------------------------------
----------------------------------------------------------------------------
insert into ADX_GREYBOX_ACTION (
       [CONSTRAINT_ID]
      ,[CAPACITY]
      ,[UOM]
      ,[START_DATE]
      ,[END_DATE]
      --,[DATA_LAST_UPDATED]
)
SELECT 
    [LOCATION] + '_' + [COMLOCATION_UDA_PROD_AREA] + '_' + [COMLOCATION_UDA_TECHNOLOGY] + '_' + [COMLOCATION_UDA_PACKAGE]
    ,[CAPACITY]
    ,[UOM]
    ,[START] -- convert(datetime, [START], 1)
    ,[END]   -- convert(datetime, [END], 1)
FROM [Inno].[dbo].[adx_graybox]

DELETE T
FROM
(
SELECT *
, DupRank = ROW_NUMBER() OVER (
              PARTITION BY        
                [CONSTRAINT_ID]
                ,[START_DATE]
                ,[END_DATE]
              ORDER BY (SELECT NULL)
            )
FROM [dbo].[ADX_GREYBOX_ACTION]
) AS T
WHERE DupRank > 1
GO

