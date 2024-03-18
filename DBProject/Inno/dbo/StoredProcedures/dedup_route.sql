CREATE PROCEDURE [dbo].[dedup_route]
AS

DELETE T
FROM
(
SELECT *
, DupRank = ROW_NUMBER() OVER (
              PARTITION BY ROUTE_ID, OPERATION_ID
              ORDER BY (SELECT NULL)
            )
FROM [dbo].[adx_route]
) AS T
WHERE DupRank > 1
GO

