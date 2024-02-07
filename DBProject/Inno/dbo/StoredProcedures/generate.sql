CREATE PROCEDURE [dbo].[generate]
AS
BEGIN

EXEC Truncate_ADX_Tables
EXEC populate_process

EXEC write_bom_bom
EXEC write_bom_method_make
EXEC write_bom_product
EXEC write_bom_productlocation

EXEC dedup_bom
EXEC dedup_method_make
EXEC dedup_product
EXEC dedup_productlocation

EXEC write_subs_bom
EXEC write_subs_method_make
EXEC write_subs_product
EXEC write_subs_productlocation

EXEC write_dpm_bom
EXEC write_dpm_method_make
EXEC write_dpm_product
EXEC write_dpm_productlocation

EXEC write_fgs_bom
EXEC write_fgs_method_make
EXEC write_fgs_product
EXEC write_fgs_productlocation

EXEC dedup_bom
EXEC dedup_method_make
EXEC dedup_product
EXEC dedup_productlocation

EXEC write_method_Buy
EXEC write_vendor
EXEC write_raw_productlocation
EXEC write_transportation

EXEC dedup_method_Buy
EXEC dedup_vendor
EXEC dedup_productlocation
EXEC dedup_transportation

EXEC Trim_Unserved_Method_Make
EXEC Trim_Unserved_ProductLocation

EXEC Unset_Obsolete_Flag
END
GO

