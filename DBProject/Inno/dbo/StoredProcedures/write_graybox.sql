CREATE PROCEDURE [dbo].[write_graybox]
AS

delete FROM [dbo].[Capacity] 
where [Capacity].capacity is null or [Capacity].capacity = 0

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
FROM [Capacity]
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
            ,[Capacity].process, '_'
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
    
      ,[Capacity].process -- [COMLOCATION_UDA_TECHNOLOGY]

      ,'-' --[COMLOCATION_UDA_SHARED]

      ,POCModel.work_order_model --[COMLOCATION_UDA_PACKAGE]

      ,[Capacity].CAPACITY -- [CAPACITY]   

      ,[UOM] --'WEEK' --[UOM]
      ,'-' -- [BUILDPOLICY]
      ,'-' -- [BUILDEARLYLIMIT]
      ,'-' -- [BUILD_AHEAD]

      ,[Capacity].[START]
      ,[Capacity].[END]

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

FROM [dbo].[Capacity], process, POCModel
where [Capacity].capacity <> 0
    and process.Process = [Capacity].process
    and process.plant = [Capacity].plant
    and POCModel.[OLD_DP_model] = [Capacity].model
GO

