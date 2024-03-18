CREATE PROCEDURE [dbo].[dedup_resalt]
AS

DELETE T
FROM
(
SELECT *
, DupRank = ROW_NUMBER() OVER (
              PARTITION BY RESALT_ID, RES_ID
              ORDER BY (SELECT NULL)
            )
FROM [dbo].[adx_resalt]
) AS T
WHERE DupRank > 1
GO

