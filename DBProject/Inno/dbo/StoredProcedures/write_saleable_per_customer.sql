CREATE PROCEDURE [dbo].[write_saleable_per_customer]
AS
BEGIN

EXEC Populate_DPM_CustomerPN_Customer

EXEC write_dpm_cust_bom
EXEC write_dpm_cust_method_make
EXEC write_dpm_cust_product
EXEC write_dpm_cust_productlocation


END
GO

