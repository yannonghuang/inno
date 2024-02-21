CREATE PROCEDURE [dbo].[populate_process]
AS

--pre-processing
EXEC Populate_Subcon_Process
EXEC Populate_Virtual_Parent_Process
EXEC Populate_Saleable_Process

truncate table Process

insert into [Process] (
    [P_N]
    ,[Process]
    ,[Plant]    
)
SELECT  FG_Location_Scrap.PN
        , CASE
          WHEN FG_Location_Scrap.Process is not null THEN FG_Location_Scrap.Process        
          ELSE  -- [parent_process] 
            CASE
            when [parent_process] = 'Module' THEN 'dummy'
            ELSE FG_Location_Scrap.Process
            END
          END          
        ,FG_Location_Scrap.[Plant]
FROM FG_Location_Scrap  left outer join [virtual_parent_process] on part_number = FG_Location_Scrap.PN

/*
insert into [Process] (
    [P_N]
    ,[Plant]
    ,[Process]
)
SELECT  [PN]
      ,[Plant]
      ,[Process]
FROM [master].[dbo].[FG_Location_Scrap]
*/
/*
insert into [Process] (
    [P_N]
    ,[Plant]
    ,[Process]
)
SELECT 
     [P_N]
      ,[Plant]
      ,[Process]
FROM [SR4_FGsfg_Process]

insert into [Process] (
    [P_N]
    ,[Plant]
    ,[Process]
)
SELECT 
    [P_N]
      ,[PLANT]
      ,[Process]
  FROM [COP_FGsfg_Process]


insert into [Process] (
    [P_N]
    ,[Plant]
    ,[Process]
)
SELECT 
    [P_N]
      ,[Plant]
      ,[Process]
  FROM [AOC_FGsfg_Process]
*/

insert into [Process] (
    [P_N]
    ,[Plant]
    ,[Process]
)
SELECT 
    [P_N]
      ,[Plant]
      ,[Process]
  FROM [Subcon_Process]


/*
insert into [Process] (
    [P_N]
    ,[Plant]
    ,[Process]
)
SELECT 
    [part_number]
    ,location
    ,[parent_process]
  FROM [virtual_parent_process]
*/

insert into [Process] (
    [P_N]
    ,[Plant]
    ,[Process]
)
SELECT 
    [P_N]
      ,[Plant]
      ,[Process]
FROM [Saleable_Process]

delete from Process
where Process is null

DELETE T
FROM
(
SELECT *
, DupRank = ROW_NUMBER() OVER (
              PARTITION BY P_N, Plant
              ORDER BY (SELECT NULL)
            )
FROM [process]
) AS T
WHERE DupRank > 1
GO

