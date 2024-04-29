CREATE PROCEDURE [dbo].[populate_fg_in_demand]
AS
truncate TABLE FG_In_Demand

insert into FG_In_Demand
SELECT distinct [PN]
  FROM [Inno].[dbo].[DP_Models], adx_demand
  where adx_demand.PRODUCT_ID like DP_Models.code + '%'
GO

