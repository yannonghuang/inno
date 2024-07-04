
CREATE PROCEDURE [dbo].[Populate_Sanity_DPM_FG_No_BOM] 
AS
BEGIN

Truncate Table Sanity_DPM_FG_No_BOM


insert into Sanity_DPM_FG_No_BOM (Code, PN)
SELECT
    Work_order_code,
    FG_PN 
FROM POCFG
where not exists (
    select *
    from FG_Native
    where POCFG.FG_PN = FG_Native.PN
) 

DELETE T
FROM
(
SELECT *
, DupRank = ROW_NUMBER() OVER (
              PARTITION BY Code, PN
              ORDER BY (SELECT NULL)
            )
FROM [Sanity_DPM_FG_No_BOM]
) AS T
WHERE DupRank > 1 

END
GO

