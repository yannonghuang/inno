CREATE FUNCTION [dbo].[GET_CFI_BY_PN] (
    @Product_Id NVARCHAR(100)
)
RETURNS NVARCHAR(50)

AS

begin
    declare @ret int

    --,@Product_Id NVARCHAR(100)
    --@Package NVARCHAR(50)
    --set @Package = 'F29'
    --set @Product_Id = '500-3264-007'

    set @ret = (
        SELECT top 1 Production_LeadTime.cfi_family
        FROM Production_LeadTime, Material_DP_Model, Process
        where Material_DP_Model.PN = @Product_Id and Process.P_N = @Product_Id
            and process.Process = Production_LeadTime.process
            and (Material_DP_Model.OLD_Description = Production_LeadTime.model2 or Material_DP_Model.Description = Production_LeadTime.model2)
        )
    --print @ret

    RETURN(@ret)

end
GO
