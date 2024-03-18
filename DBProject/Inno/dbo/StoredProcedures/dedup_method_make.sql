CREATE PROCEDURE [dbo].[dedup_method_make]
AS
DELETE T
FROM
(
SELECT *
, DupRank = ROW_NUMBER() OVER (
              PARTITION BY BOM_ID, ROUTE_ID, LOCATION
              ORDER BY (SELECT NULL)
            )
FROM [dbo].[adx_method_make]
) AS T
WHERE DupRank > 1
GO

