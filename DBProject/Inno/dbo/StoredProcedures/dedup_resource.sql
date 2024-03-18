CREATE PROCEDURE [dbo].[dedup_resource]
AS

DELETE T
FROM
(
SELECT *
, DupRank = ROW_NUMBER() OVER (
              PARTITION BY RESOURCE_ID, LOCATION
              ORDER BY (SELECT NULL)
            )
FROM [dbo].[adx_resource]
) AS T
WHERE DupRank > 1
GO

