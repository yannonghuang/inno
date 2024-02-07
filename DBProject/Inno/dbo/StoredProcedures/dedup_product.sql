CREATE PROCEDURE dedup_product
AS
DELETE T
FROM
(
SELECT *
, DupRank = ROW_NUMBER() OVER (
              PARTITION BY PRODUCT_ID
              ORDER BY (SELECT NULL)
            )
FROM [master].[dbo].[adx_product]
) AS T
WHERE DupRank > 1
GO

