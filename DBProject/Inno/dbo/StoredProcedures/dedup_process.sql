CREATE PROCEDURE [dbo].[dedup_process]
AS
DELETE T
FROM
(
SELECT *
, DupRank = ROW_NUMBER() OVER (
              PARTITION BY P_N
              ORDER BY (SELECT NULL)
            )
FROM [dbo].[process]
) AS T
WHERE DupRank > 1
GO

