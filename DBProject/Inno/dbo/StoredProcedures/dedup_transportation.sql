CREATE PROCEDURE [dbo].[dedup_transportation]
AS
DELETE T
FROM
(
SELECT *
, DupRank = ROW_NUMBER() OVER (
              PARTITION BY Product, FROM_LOCATION, TO_LOCATION, Mode 
              ORDER BY (SELECT NULL)
            )
FROM [master].[dbo].[adx_transportation]
) AS T
WHERE DupRank > 1
GO

