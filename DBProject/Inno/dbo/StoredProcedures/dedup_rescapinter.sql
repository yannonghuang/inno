CREATE PROCEDURE [dbo].[dedup_rescapinter]
AS

DELETE T
FROM
(
SELECT *
, DupRank = ROW_NUMBER() OVER (
              PARTITION BY RESOURCE_ID
              ORDER BY (SELECT NULL)
            )
FROM [master].[dbo].[adx_rescapinter]
) AS T
WHERE DupRank > 1
GO

