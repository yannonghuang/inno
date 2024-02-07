CREATE PROCEDURE [dbo].[dedup_operation]
AS

DELETE T
FROM
(
SELECT *
, DupRank = ROW_NUMBER() OVER (
              PARTITION BY OPERATION_ID
              ORDER BY (SELECT NULL)
            )
FROM [master].[dbo].[adx_operation]
) AS T
WHERE DupRank > 1
GO

