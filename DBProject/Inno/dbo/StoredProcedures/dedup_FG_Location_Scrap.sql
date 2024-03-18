CREATE PROCEDURE [dbo].[dedup_FG_Location_Scrap]
AS
DELETE T
FROM
(
SELECT *
, DupRank = ROW_NUMBER() OVER (
              PARTITION BY PN, Plant
              ORDER BY (SELECT NULL)
            )
FROM [dbo].[FG_Location_Scrap]
) AS T
WHERE DupRank > 1
GO

