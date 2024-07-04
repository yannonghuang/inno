
CREATE PROCEDURE [dbo].[Populate_Sanity_Subs_No_BOM] 
AS
BEGIN

Truncate Table Sanity_Subs_No_BOM


insert into Sanity_Subs_No_BOM (
    [substitution_group]
    ,[Priority]
    ,[Usage_percentage]
    ,[component]
    ,[Assemble_P_N]
)
SELECT 
    [substitution_group]
    ,[Priority]
    ,[Usage_percentage]
    ,[component]
    ,[Assemble_P_N]
FROM [Inno].[dbo].[RAW_SUBSTITUTES]
where not exists (
    select *
    from NATIVE_RAW_SUBSTITUTES
    where 
        NATIVE_RAW_SUBSTITUTES.[substitution_group] = RAW_SUBSTITUTES.[substitution_group] and
        NATIVE_RAW_SUBSTITUTES.[Priority] = RAW_SUBSTITUTES.[Priority] and
        NATIVE_RAW_SUBSTITUTES.[Usage_percentage] = RAW_SUBSTITUTES.[Usage_percentage] and
        NATIVE_RAW_SUBSTITUTES.[component] = RAW_SUBSTITUTES.[component] and
        NATIVE_RAW_SUBSTITUTES.[Assemble_P_N] = RAW_SUBSTITUTES.[Assemble_P_N]
) 

DELETE T
FROM
(
SELECT *
, DupRank = ROW_NUMBER() OVER (
              PARTITION BY 
                [substitution_group]
                ,[Priority]
                ,[Usage_percentage]
                ,[component]
                ,[Assemble_P_N]
              ORDER BY (SELECT NULL)
            )
FROM [Sanity_Subs_No_BOM]
) AS T
WHERE DupRank > 1 

END
GO

