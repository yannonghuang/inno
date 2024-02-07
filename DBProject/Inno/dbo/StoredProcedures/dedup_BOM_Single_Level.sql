CREATE PROCEDURE [dbo].[dedup_BOM_Single_Level]
AS
DELETE T
FROM
(
SELECT *
, DupRank = ROW_NUMBER() OVER (
              PARTITION BY component, FG
              ORDER BY (SELECT NULL)
            )
FROM [master].[dbo].[BOM_Single_Level]
) AS T
WHERE DupRank > 1
GO

