CREATE PROCEDURE [dbo].[write_fgs_product]
AS

insert into [adx_product] (
    [PRODUCT_ID],
    [DESCRIPTION],
    [PRODUCT_TYPE],
    [PRODAREA],
    [HIER_LEVEL_1],
    [HIER_LEVEL_2],
    [HIER_LEVEL_3],
    [FG_HIER_LEVEL_1],
    [FG_HIER_LEVEL_2],
    [FG_HIER_LEVEL_3],
    [END_ITEM],
    [A_MAT_STATUS],
    [LATE_FORECAST],
    [LATE_SALES]
)

SELECT
    concat([PN_for_customer], '__', [Customer_abbreviate]),   
    'Virtual Product for FG Substitute ',  
    'M',  
    'MODULE',
        '-', --'NA', -- 'MODULE',
        '-', --'NA', -- 'FACTORY',
        '-', --'NA', -- 'ALL',        
        '-', --'NA',
        '-', --'NA',
        '-', --'NA',
        '-',
        '-',
        '-',
        '-'  
FROM [FG_SUBSTITUTES]
GO

