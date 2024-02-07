CREATE PROCEDURE [dbo].[dedup_vendor]
AS
DELETE T
FROM
(
SELECT *
, DupRank = ROW_NUMBER() OVER (
              PARTITION BY VENDOR_ID
              ORDER BY (SELECT NULL)
            )
FROM [master].[dbo].[adx_vendor]
) AS T
WHERE DupRank > 1
GO

