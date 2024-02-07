CREATE PROCEDURE [dbo].[dedup_RAW_MATERIAL_SCRAP]
AS
DELETE T
FROM
(
SELECT *
, DupRank = ROW_NUMBER() OVER (
              PARTITION BY PN, Plant
              ORDER BY (SELECT NULL)
            )
FROM [master].[dbo].[RAW_MATERIAL_SCRAP]
) AS T
WHERE DupRank > 1
GO

