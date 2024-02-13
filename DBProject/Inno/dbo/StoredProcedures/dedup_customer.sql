CREATE PROCEDURE [dbo].[dedup_customer]
AS
DELETE T
FROM
(
SELECT *
, DupRank = ROW_NUMBER() OVER (
              PARTITION BY [CUSTOMER_ID]
              ORDER BY (SELECT NULL)
            )
FROM [master].[dbo].[adx_customer]
) AS T
WHERE DupRank > 1
GO

