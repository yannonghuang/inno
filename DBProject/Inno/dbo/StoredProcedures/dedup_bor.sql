CREATE PROCEDURE [dbo].[dedup_bor]
AS

DELETE T
FROM
(
SELECT *
, DupRank = ROW_NUMBER() OVER (
              PARTITION BY BOR_ID, RESALT_ID
              ORDER BY (SELECT NULL)
            )
FROM [dbo].[adx_bor]
) AS T
WHERE DupRank > 1
GO

