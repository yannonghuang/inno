CREATE PROCEDURE [dbo].[segregate_whitebox_greybox]
AS

----------------
update adx_method_make
set ROUTE_ID = ROUTE_ID + '_dummy'
where exists (
SELECT  *
  FROM [DP_Models]
  where adx_method_make.PRODUCT_ID = PN and [MPS_Model] <> 'COP'
)
----------------
update adx_productlocation
set UDA_string_TECHNOLOGY = UDA_string_TECHNOLOGY + '_COP'
where UDA_string_TECHNOLOGY <> '-' and exists (
SELECT *
  FROM [DP_Models]
  where PRODUCT_ID = PN and MPS_Model = 'COP'
)
GO

