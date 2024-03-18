CREATE PROCEDURE [dbo].[dedup_op_override]
AS

DELETE T
FROM
(
SELECT *
, DupRank = ROW_NUMBER() OVER (
              PARTITION BY OPERATION_ID
              ORDER BY (SELECT NULL)
            )
FROM [dbo].[adx_op_override]
) AS T
WHERE DupRank > 1
GO

