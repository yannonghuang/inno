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
    [DP_model], -- 'Virtual Product for DP Model ',  
    'F',  
    'MODULE',
        'Model', -- DP_Models.MPS_Model, -- 'DP Model', -- 'MODULE',
        'Model', -- DP_Models.MPS_Model, -- '-', -- 'FACTORY',
        'Model', -- 'ALL',        
        DP_Models.MPS_Model, --'DP Model',
        DP_Models.MPS_Model, --'-',
        DP_Models.MPS_Model, --'-',

        '-',
        '-',
        '-',
        '-'  
FROM [POCModel], DP_Models, adx_product
where POCModel.work_order_model = DP_Models.Code and DP_Models.PN = adx_product.PRODUCT_ID
--FROM [POCModel], DP_Models
--where POCModel.work_order_model = DP_Models.Code
GO

