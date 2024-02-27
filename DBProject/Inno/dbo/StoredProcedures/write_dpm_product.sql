CREATE PROCEDURE [dbo].[write_dpm_product]
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
    [work_order_model],   
    'Virtual Product for DP Model ',  
    'M',  
    'MODULE',
        'DP Model', -- 'MODULE',
        '-', -- 'FACTORY',
        '-', -- 'ALL',        
        'DP Model',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-'  
FROM [POCModel]
GO

