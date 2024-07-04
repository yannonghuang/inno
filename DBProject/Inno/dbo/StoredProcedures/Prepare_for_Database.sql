CREATE PROCEDURE [dbo].[Prepare_for_Database]
AS
BEGIN
---------
update adx_product
set PROD_SKU_ID = PRODUCT_ID,
PROD_SKU_DESCRIPTION = DESCRIPTION
---------
update adx_productlocation
set PROD_SKU_ID = PRODUCT_ID,
LOCATION_ID = LOCATION,
CYCLE_TIME_FAMILY=CYCLE_FAMILY,
CYCLE_TIME_TYPE=CYCLE_TYPE,
TECHNOLOGY=UDA_string_TECHNOLOGY
---------
update adx_resource
set LOCATION_ID = LOCATION
---------
update adx_method_make
set LOCATION_ID = LOCATION
---------
update adx_transportation
set FROM_LOCATION_ID = FROM_LOCATION,
TO_LOCATION_ID = TO_LOCATION,
PRODUCT_ID = PRODUCT,
TRANSPORTATION_MODE=MODE
---------
update adx_method_buy
set LOCATION_ID = LOCATION
---------
update adx_demand
set REQUEST_DUE_TIME = REQ_DUE_DATE,
ID = DEMAND_ID
---------
EXEC write_greybox_db

END
GO

