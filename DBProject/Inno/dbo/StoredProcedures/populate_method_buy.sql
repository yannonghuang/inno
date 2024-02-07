CREATE PROCEDURE [dbo].[populate_method_buy]
AS

truncate table method_buy

insert into [method_buy] (
        [PRODUCT_ID]
      ,[LOCATION]
      ,[VENDOR_ID]
)
SELECT  [PN]
      ,[Plant]
      ,[Vendor]
  FROM [master].[dbo].[RAW_Material_Method_Buy]


DELETE T
FROM
(
SELECT *
, DupRank = ROW_NUMBER() OVER (
              PARTITION BY [PRODUCT_ID], [LOCATION], [VENDOR_ID] 
              ORDER BY (SELECT NULL)
            )
FROM [method_buy]
) AS T
WHERE DupRank > 1
GO

