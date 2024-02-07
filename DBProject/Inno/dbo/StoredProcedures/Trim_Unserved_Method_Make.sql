
CREATE PROCEDURE [dbo].[Trim_Unserved_Method_Make] 
AS
BEGIN

delete from [adx_method_make]
where not exists (
    select * from adx_bom where adx_method_make.PRODUCT_ID = adx_bom.PARENT_ID
)

END
GO

