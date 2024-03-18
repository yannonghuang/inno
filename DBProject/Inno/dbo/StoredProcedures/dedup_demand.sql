CREATE PROCEDURE [dbo].[dedup_demand]
AS
DELETE T
FROM
(
SELECT *
, DupRank = ROW_NUMBER() OVER (
              PARTITION BY DEMAND_ID
              ORDER BY (SELECT NULL)
            )
FROM [dbo].[adx_demand]
) AS T
WHERE DupRank > 1
GO

