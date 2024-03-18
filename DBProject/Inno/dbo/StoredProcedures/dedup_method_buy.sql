CREATE PROCEDURE [dbo].[dedup_method_buy]
AS
DELETE T
FROM
(
SELECT *
, DupRank = ROW_NUMBER() OVER (
              PARTITION BY PRODUCT_ID, LOCATION, VENDOR_ID
              ORDER BY (SELECT NULL)
            )
FROM [dbo].[adx_method_buy]
) AS T
WHERE DupRank > 1
GO

