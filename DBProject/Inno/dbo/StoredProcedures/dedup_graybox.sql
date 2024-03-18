CREATE PROCEDURE [dbo].[dedup_graybox]
AS
DELETE T
FROM
(
SELECT *
, DupRank = ROW_NUMBER() OVER (
              PARTITION BY 
                [LOCATION]
                ,[COMLOCATION_UDA_PROD_AREA]
                ,[COMLOCATION_UDA_TECHNOLOGY]
                ,[COMLOCATION_UDA_PACKAGE]
                ,[START]
                ,[END]                
              ORDER BY (SELECT NULL)
            )
FROM [dbo].[adx_graybox]
) AS T
WHERE DupRank > 1
GO

