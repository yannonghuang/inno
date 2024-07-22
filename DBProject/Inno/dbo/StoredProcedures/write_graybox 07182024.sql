CREATE PROCEDURE [dbo].[write_graybox 07182024]
AS

delete FROM [dbo].[AOCSR4 Rough capacity] 
where [AOCSR4 Rough capacity].capacity is null or [AOCSR4 Rough capacity].capacity = 0

DELETE T
FROM
(
SELECT *
, DupRank = ROW_NUMBER() OVER (
              PARTITION BY 
                [model]
                ,[process]
                ,[start]
                ,[end]
              ORDER BY (SELECT NULL)
            )
FROM [AOCSR4 Rough capacity]
) AS T
WHERE DupRank > 1


insert into [dbo].[adx_graybox] (
       [CASE]
      ,[CONS_ID]
      ,[LOCATION]
      ,[COMLOCATION]
      ,[COMLOCATION_UDA_PROD_AREA]
      ,[COMLOCATION_UDA_TECHNOLOGY]
      ,[COMLOCATION_UDA_SHARED]
      ,[COMLOCATION_UDA_PACKAGE]
      ,[CAPACITY]
      ,[UOM]
      ,[BUILDPOLICY]
      ,[BUILDEARLYLIMIT]
      ,[BUILD_AHEAD]
      ,[START]
      ,[END]
      ,[HIER_LEVEL_1]
      ,[HIER_LEVEL_2]
      ,[HIER_LEVEL_3]
      ,[COMMODITY]
      ,[VENDOR]
      ,[CATEGORY]
      ,[RELATION]
      ,[PLANNER]
      ,[TIME_LEVEL]
      ,[CORRESPONDS]
)
SELECT 
       '-' -- [CASE]
      ,concat(
            process.plant, '_'
            ,[AOCSR4 Rough capacity].process, '_'
            ,POCModel.work_order_model, '_'
            ,[START], '_'
            ,[END]         
      ) 
      ,process.plant --[LOCATION]      
      ,'-' --[COMLOCATION]

        ,CASE
         WHEN process.Process is not null THEN 
            CASE
            WHEN process.Process = 'Module' THEN 'MODULE'
            ELSE 'OPTICAL'
            END            
        ELSE 'OPTICAL'
        END
        --[COMLOCATION_UDA_PROD_AREA]
    
      ,[AOCSR4 Rough capacity].process -- [COMLOCATION_UDA_TECHNOLOGY]

      ,'-' --[COMLOCATION_UDA_SHARED]

      ,POCModel.work_order_model --[COMLOCATION_UDA_PACKAGE]

      ,[AOCSR4 Rough capacity].CAPACITY -- [CAPACITY]   

      ,[UOM] --'WEEK' --[UOM]
      ,'-' -- [BUILDPOLICY]
      ,'-' -- [BUILDEARLYLIMIT]
      ,'-' -- [BUILD_AHEAD]

      ,[AOCSR4 Rough capacity].[START]
      ,[AOCSR4 Rough capacity].[END]

      ,'NA' -- 'HIER_LEVEL_1'
      ,'NA' -- 'HIER_LEVEL_2'
      ,'NA' -- 'HIER_LEVEL_3'

      ,'-' -- [COMMODITY]
      ,'-' -- [VENDOR]
      ,'-' -- [CATEGORY]
      ,'-' -- [RELATION]
      ,'-' -- [PLANNER]
      ,'-' -- [TIME_LEVEL]
      ,'-' -- [CORRESPONDS]

FROM [dbo].[AOCSR4 Rough capacity], process, POCModel
where [AOCSR4 Rough capacity].capacity <> 0
    and process.Process = [AOCSR4 Rough capacity].process
    and process.plant = [AOCSR4 Rough capacity].plant
    and POCModel.[OLD_DP_model] = [AOCSR4 Rough capacity].model
GO

