
CREATE PROCEDURE [dbo].[Populate_CFI 07202024] 
AS
BEGIN
update adx_productlocation
set
    [CYCLE_TYPE] = 
    case
    when exists (
        SELECT *
        FROM Production_LeadTime, Process
        where Process.P_N = adx_productlocation.PRODUCT_ID
        and Production_LeadTime.process = process.Process
        and process.Process <> 'Module'
    ) or exists (
        SELECT *
        FROM [Inno].[dbo].[POCModel], POCFG, Production_LeadTime, Process
        where Process.P_N = adx_productlocation.PRODUCT_ID
        and work_order_model = work_order_code 
        and MPS_model = Production_LeadTime.model
        and Production_LeadTime.process = 'Module'
        and POCFG.FG_PN = Process.P_N and process.Process = 'Module'
    ) 
    then
    'cycle'
    else
    CYCLE_TYPE
    end
    --CYCLE_TYPE
    
    ,[CYCLE_FAMILY] = '' + dbo.GET_CFI_BY_PN(adx_productlocation.PRODUCT_ID)
/**
    case 
    when exists (
        SELECT *
        FROM Production_LeadTime, Process
        where Process.P_N = adx_productlocation.PRODUCT_ID
        and Production_LeadTime.process = process.Process
        and process.Process <> 'Module'
    ) then (
        SELECT top 1 CFI_FAMILY --lead_time
        FROM Production_LeadTime, Process
        where Process.P_N = adx_productlocation.PRODUCT_ID
        and Production_LeadTime.process = process.Process
        and process.Process <> 'Module'
    )
    else
    case
    when exists (
        SELECT *
        FROM [Inno].[dbo].[POCModel], POCFG, Production_LeadTime, Process
        where Process.P_N = adx_productlocation.PRODUCT_ID
        and work_order_model = work_order_code 
        and MPS_model = Production_LeadTime.model
        and Production_LeadTime.process = 'Module'
        and POCFG.FG_PN = Process.P_N and process.Process = 'Module'
    ) then (
        SELECT top 1 CFI_FAMILY --lead_time
        FROM [Inno].[dbo].[POCModel], POCFG, Production_LeadTime, Process
        where Process.P_N = adx_productlocation.PRODUCT_ID
        and work_order_model = work_order_code 
        and MPS_model = Production_LeadTime.model
        and OLD_DP_model = Production_LeadTime.model2
        and Production_LeadTime.process = 'Module'
        and POCFG.FG_PN = Process.P_N and process.Process = 'Module'
    )
    else
    CYCLE_FAMILY
    end

    end
**/
---------------------------

END
GO

