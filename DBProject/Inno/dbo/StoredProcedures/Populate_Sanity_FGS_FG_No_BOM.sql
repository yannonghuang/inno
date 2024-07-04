
CREATE PROCEDURE [dbo].[Populate_Sanity_FGS_FG_No_BOM] 
AS
BEGIN

Truncate Table Sanity_FGS_FG_No_BOM


insert into Sanity_FGS_FG_No_BOM (
	[PN],
	[Customer],
	[Code_Customer]
)
SELECT [FG_PN]
      ,[Customer_abbreviate]
      ,[PN_for_customer]
FROM [FG_SUBSTITUTES]
where not exists (
    select *
    from FG_Native
    where FG_SUBSTITUTES.FG_PN = FG_Native.PN
) 

DELETE T
FROM
(
SELECT *
, DupRank = ROW_NUMBER() OVER (
              PARTITION BY 
	            [PN],
	            [Customer],
	            [Code_Customer]
              ORDER BY (SELECT NULL)
            )
FROM [Sanity_FGS_FG_No_BOM]
) AS T
WHERE DupRank > 1 

END
GO

