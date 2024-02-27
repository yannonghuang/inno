CREATE PROCEDURE [dbo].[write_dpm_cust_product]
AS

-------------------------
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
    [DPM] + '@' + Customer,   
    'Virtual Product for Customer-Specific DP Model ',  
    'M',  
    'MODULE',
        'Customer-Specific DP Model', -- 'MODULE',
        '-', -- 'FACTORY',
        '-', -- 'ALL',        
        'Customer-Specific DP Model',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-'  
  FROM [DPM_CustomerPN_Customer]
GO

