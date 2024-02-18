
CREATE PROCEDURE [dbo].[Populate_DP_Models] 
AS
BEGIN

Truncate Table DP_Models


insert into DP_Models (Code, DESCRIPTION, PN, MPS_Model)
SELECT
    work_order_model,
    DP_model,
    FG_PN,
    SUBSTRING(MPS_Model, CHARINDEX(' ', MPS_Model) + 1, 1000) 
FROM [POCModel], POCFG
where work_order_model = Work_order_code

DELETE T
FROM
(
SELECT *
, DupRank = ROW_NUMBER() OVER (
              PARTITION BY Code, DESCRIPTION, PN
              ORDER BY (SELECT NULL)
            )
FROM [DP_Models]
) AS T
WHERE DupRank > 1 

END
GO

