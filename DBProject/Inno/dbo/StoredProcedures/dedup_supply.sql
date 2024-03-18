CREATE PROCEDURE [dbo].[dedup_supply]
AS
DELETE T
FROM
(
SELECT *
, DupRank = ROW_NUMBER() OVER (
              PARTITION BY SUPPLY_ID
              ORDER BY (SELECT NULL)
            )
FROM [dbo].[adx_supply]
) AS T
WHERE DupRank > 1
GO

