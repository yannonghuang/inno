
CREATE PROCEDURE [dbo].[Populate_CFI] 
AS
BEGIN
update adx_productlocation
set
    [CYCLE_TYPE] = 
    case
    when exists (
        SELECT *
        FROM SR4AOC_Production_LeadTime, Process
        where Process.P_N = adx_productlocation.PRODUCT_ID
        and SR4AOC_Production_LeadTime.process = process.Process
        and process.Process <> 'Module'
    ) or exists (
        SELECT *
        FROM [Inno].[dbo].[POCModel], POCFG, SR4AOC_Production_LeadTime, Process
        where Process.P_N = adx_productlocation.PRODUCT_ID
        and work_order_model = work_order_code 
        and MPS_model = SR4AOC_Production_LeadTime.model
        and SR4AOC_Production_LeadTime.process = 'Model'
        and POCFG.FG_PN = Process.P_N and process.Process = 'Module'
    ) 
    then
    'cycle'
    else
    CYCLE_TYPE
    end
    --CYCLE_TYPE
    
    ,[CYCLE_FAMILY] = 
    case 
    when exists (
        SELECT *
        FROM SR4AOC_Production_LeadTime, Process
        where Process.P_N = adx_productlocation.PRODUCT_ID
        and SR4AOC_Production_LeadTime.process = process.Process
        and process.Process <> 'Module'
    ) then (
        SELECT top 1 CFI_FAMILY --lead_time
        FROM SR4AOC_Production_LeadTime, Process
        where Process.P_N = adx_productlocation.PRODUCT_ID
        and SR4AOC_Production_LeadTime.process = process.Process
        and process.Process <> 'Module'
    )
    else
    case
    when exists (
        SELECT *
        FROM [Inno].[dbo].[POCModel], POCFG, SR4AOC_Production_LeadTime, Process
        where Process.P_N = adx_productlocation.PRODUCT_ID
        and work_order_model = work_order_code 
        and MPS_model = SR4AOC_Production_LeadTime.model
        and SR4AOC_Production_LeadTime.process = 'Model'
        and POCFG.FG_PN = Process.P_N and process.Process = 'Module'
    ) then (
        SELECT top 1 CFI_FAMILY --lead_time
        FROM [Inno].[dbo].[POCModel], POCFG, SR4AOC_Production_LeadTime, Process
        where Process.P_N = adx_productlocation.PRODUCT_ID
        and work_order_model = work_order_code 
        and MPS_model = SR4AOC_Production_LeadTime.model
        and OLD_DP_model = SR4AOC_Production_LeadTime.model2
        and SR4AOC_Production_LeadTime.process = 'Model'
        and POCFG.FG_PN = Process.P_N and process.Process = 'Module'
    )
    else
    CYCLE_FAMILY
    end
    end

---------------------------

--update adx_productlocation
--set CYCLE_FAMILY = '-'
--where CYCLE_TYPE = '-'

END
GO

