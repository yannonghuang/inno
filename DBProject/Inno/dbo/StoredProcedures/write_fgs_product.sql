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
        
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
/*                
        'NA', -- 'MODULE',
        'NA', -- 'FACTORY',
        'NA', -- 'ALL',      
        'NA',
        'NA',
        'NA',
*/        
        --[work_order_model], -- FG_HIER_LEVEL_1 'NA', 'MODULE',
        --substring(MPS_model, CHARINDEX(' ', MPS_model) + 1, 3), -- FG_HIER_LEVEL_2 'NA', 'FACTORY',
        --'Saleable', -- FG_HIER_LEVEL_3 'NA', 'ALL',         
        --[work_order_model], -- FG_HIER_LEVEL_1 'NA',
        --substring(MPS_model, CHARINDEX(' ', MPS_model) + 1, 3), -- FG_HIER_LEVEL_2 'NA',
        --'Saleable', -- FG_HIER_LEVEL_3 'NA',

        '-',
        '-',
        '-',
        '-'  
FROM [FG_SUBSTITUTES] --, POCModel
--where POCModel.OLD_DP_model = FG_SUBSTITUTES.Model or POCModel.DP_model = FG_SUBSTITUTES.Model
GO

