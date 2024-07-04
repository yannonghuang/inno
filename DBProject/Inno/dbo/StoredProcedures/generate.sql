CREATE PROCEDURE [dbo].[generate]
AS
BEGIN

------------ pre-processing
EXEC Truncate_ADX_Tables;
EXEC populate_process;
EXEC populate_method_buy;
EXEC Populate_Raw_Substitutes;
EXEC Populate_Native_Raw_Substitutes;
EXEC Populate_DP_Models;
EXEC Populate_Material_DP_Model;
EXEC Populate_Finished_Goods;

------------ MSIC. --- write_cfi_family
EXEC write_cfi_family;
EXEC write_cappattern;
EXEC write_location;
EXEC write_period_manager;
EXEC write_safety_stock;
EXEC write_sourcing;
EXEC write_uda;

------------ BEGIN: static
EXEC write_bom_bom;
EXEC write_bom_method_make;
EXEC write_bom_product;
EXEC write_bom_productlocation;

EXEC dedup_bom;
EXEC dedup_method_make;
EXEC dedup_product;
EXEC dedup_productlocation;

EXEC write_subs_bom;
EXEC write_subs_method_make;
EXEC write_subs_product;
EXEC write_subs_productlocation;

EXEC write_dpm_bom;
EXEC write_dpm_method_make;
EXEC write_dpm_product;
EXEC write_dpm_productlocation;


EXEC write_fgs_bom
EXEC write_fgs_method_make
EXEC write_fgs_product
EXEC write_fgs_productlocation


EXEC dedup_bom;
EXEC dedup_method_make;
EXEC dedup_product;
EXEC dedup_productlocation;

EXEC write_method_Buy;
EXEC write_vendor;
EXEC write_raw_productlocation;
EXEC write_transportation;

EXEC dedup_method_Buy;
EXEC dedup_vendor;
EXEC dedup_productlocation;
EXEC dedup_transportation;
------------ END: static


------------ BEGIN: static post-processing
EXEC Trim_Unserved_Method_Make;
--EXEC Trim_Unserved_ProductLocation
--EXEC Trim_Unused_ProductLocation;
EXEC Unset_Obsolete_Flag;
------------ END: static post-processing


------------ BEGIN: write_saleable_per_customer
EXEC write_saleable_per_customer;
EXEC dedup_bom;
EXEC dedup_method_make;
EXEC dedup_product;
EXEC dedup_productlocation;
------------ END: write_saleable_per_customer

------------ BEGIN: demand
EXEC write_customer;
EXEC dedup_customer;
EXEC write_so_demand;
EXEC write_dp_demand;
EXEC dedup_demand;
EXEC Trim_Demand;
------------ END: demand

------------ BEGIN: supply
EXEC write_inventory_supply;
EXEC write_workorder_supply;
EXEC write_jit_supply;
EXEC write_opr_supply;
EXEC dedup_supply;
------------ END: supply

------------ BEGIN: populate preference
EXEC populate_preference_method_make;
EXEC populate_preference_method_move;
EXEC populate_preference_method_buy;
EXEC populate_preference_demand;
------------ END: populate preference

------------ BEGIN: mrp
EXEC write_mrp;
------------ END: mrp

------------ BEGIN: graybox
EXEC write_graybox;
EXEC dedup_graybox;
EXEC segregate_whitebox_greybox;
------------ END: graybox



EXEC Populate_CFI

------------- Prepare_for_Database
EXEC Prepare_for_Database

END
GO

