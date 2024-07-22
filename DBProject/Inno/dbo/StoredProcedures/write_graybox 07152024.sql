CREATE PROCEDURE [dbo].[write_graybox 07152024]
AS

delete FROM [dbo].[SR4AOC rough capacity] 
where [SR4AOC rough capacity].capacity is null or [SR4AOC rough capacity].capacity = 0

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
FROM [SR4AOC rough capacity]
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
            ,[SR4AOC rough capacity].process, '_'
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
    
      ,[SR4AOC rough capacity].process -- [COMLOCATION_UDA_TECHNOLOGY]

      ,'-' --[COMLOCATION_UDA_SHARED]

      ,POCModel.work_order_model --[COMLOCATION_UDA_PACKAGE]

      ,[SR4AOC rough capacity].CAPACITY -- [CAPACITY]   

      ,[UOM] --'WEEK' --[UOM]
      ,'-' -- [BUILDPOLICY]
      ,'-' -- [BUILDEARLYLIMIT]
      ,'-' -- [BUILD_AHEAD]

      ,[SR4AOC rough capacity].[START]
      ,[SR4AOC rough capacity].[END]

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

FROM [dbo].[SR4AOC rough capacity] left outer join process on process.Process = [SR4AOC rough capacity].process
    left outer join POCModel on POCModel.[DP_model] = [SR4AOC rough capacity].model
where [SR4AOC rough capacity].capacity <> 0
GO

