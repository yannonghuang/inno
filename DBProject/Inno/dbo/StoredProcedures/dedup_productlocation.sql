CREATE PROCEDURE [dbo].[dedup_productlocation]
AS
DELETE T
FROM
(
SELECT *
, DupRank = ROW_NUMBER() OVER (
              PARTITION BY PRODUCT_ID, LOCATION, UDA_string_TECHNOLOGY, UDA_string_PACKAGE
              ORDER BY (SELECT NULL)
            )
FROM [master].[dbo].[adx_productlocation]
) AS T
WHERE DupRank > 1
GO

