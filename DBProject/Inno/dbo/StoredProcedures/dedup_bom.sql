CREATE PROCEDURE [dbo].[dedup_bom]
AS
DELETE T
FROM
(
SELECT *
, DupRank = ROW_NUMBER() OVER (
              PARTITION BY BOM_ID, PARENT_ID, CHILD_ID --, LOCATION_ID
              ORDER BY (SELECT NULL)
            )
FROM [dbo].[adx_bom]
) AS T
WHERE DupRank > 1
GO

