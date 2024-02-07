
CREATE PROCEDURE [dbo].[Populate_Raw_Substitutes] 
AS
BEGIN
truncate table Raw_Substitutes

insert into Raw_Substitutes (
      [substitution_group]
      ,[Priority]
      ,[Usage_percentage]
      ,[component]
      ,[Assemble_P_N]
)
SELECT [substitution_group]
      ,[Priority]
      ,[Usage_percentage]
      ,[component]
      ,[Assemble_P_N]
FROM [COP_RAW_SUBSTITUTES]


insert into Raw_Substitutes (
      [substitution_group]
      ,[Priority]
      ,[Usage_percentage]
      ,[component]
      ,[Assemble_P_N]
)
SELECT [substitution_group]
      ,[Priority]
      ,[Usage_percentage]
      ,[component]
      ,[Assemble_P_N]
FROM [AOC_RAW_SUBSTITUTES]

insert into Raw_Substitutes (
      [substitution_group]
      ,[Priority]
      ,[Usage_percentage]
      ,[component]
      ,[Assemble_P_N]
)
SELECT [substitution_group]
      ,[Priority]
      ,[Usage_percentage]
      ,[component]
      ,[Assemble_P_N]
FROM [SR4_RAW_SUBSTITUTES]

DELETE T
FROM
(
SELECT *
, DupRank = ROW_NUMBER() OVER (
              PARTITION BY [substitution_group], [component], [Assemble_P_N]
              ORDER BY (SELECT NULL)
            )
FROM [Raw_Substitutes]
) AS T
WHERE DupRank > 1 

END
GO

