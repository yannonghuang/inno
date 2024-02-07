CREATE PROCEDURE dedup_productlocation
AS
DELETE T
FROM
(
SELECT *
, DupRank = ROW_NUMBER() OVER (
              PARTITION BY PRODUCT_ID, LOCATION
              ORDER BY (SELECT NULL)
            )
FROM [master].[dbo].[adx_productlocation]
) AS T
WHERE DupRank > 1
GO

