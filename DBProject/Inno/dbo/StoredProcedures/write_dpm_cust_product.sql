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
    [DPM] + '__' + Customer,   
    [DP_model], -- 'Virtual Product for Customer-Specific DP Model ',  
    'M',  
    'MODULE',

        '-',
        '-',
        '-',
        '-',
        '-',
        '-',            
/**        
        DPM, -- FG_HIER_LEVEL_1 'NA', 'MODULE',
        DPM_CustomerPN_Customer.MPS_Model, -- FG_HIER_LEVEL_2 'NA', 'FACTORY',
        'Forecast', -- FG_HIER_LEVEL_3 'NA', 'ALL', 

        DPM, -- FG_HIER_LEVEL_1 'NA',
        DPM_CustomerPN_Customer.MPS_Model, -- FG_HIER_LEVEL_2 'NA',
        'Forecast', -- FG_HIER_LEVEL_3 'NA',
**/
        '-',
        '-',
        '-',
        '-'  
FROM [DPM_CustomerPN_Customer], [dbo].[POCModel]
where [DPM] = [work_order_model]
GO

