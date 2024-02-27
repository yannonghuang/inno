
CREATE PROCEDURE [dbo].[Populate_DPM_CustomerPN_Customer] 
AS
BEGIN

Truncate Table DPM_CustomerPN_Customer

insert into DPM_CustomerPN_Customer (DPM, CustomerPN, Customer)
SELECT 
        Work_order_code 
        ,[PN_for_customer]
        ,[Customer_abbreviate]    
FROM [FG_SUBSTITUTES], [POCFG], adx_productlocation
where FG_SUBSTITUTES.FG_PN = POCFG.FG_PN 
and FG_SUBSTITUTES.FG_PN = adx_productlocation.PRODUCT_ID and adx_productlocation.[LOCATION] = 'VIRTUAL'

DELETE T
FROM
(
SELECT *
, DupRank = ROW_NUMBER() OVER (
              PARTITION BY DPM, CustomerPN, Customer
              ORDER BY (SELECT NULL)
            )
FROM [DPM_CustomerPN_Customer]
) AS T
WHERE DupRank > 1 

END
GO

