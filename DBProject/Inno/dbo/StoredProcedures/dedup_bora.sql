CREATE PROCEDURE [dbo].[dedup_bora]
AS

DELETE T
FROM
(
SELECT *
, DupRank = ROW_NUMBER() OVER (
              PARTITION BY BORA_ID
              ORDER BY (SELECT NULL)
            )
FROM [master].[dbo].[adx_bora]
) AS T
WHERE DupRank > 1
GO

