CREATE PROCEDURE [dbo].[dedup_product]
AS
DELETE T
FROM
(
SELECT *
, DupRank = ROW_NUMBER() OVER (
              PARTITION BY PRODUCT_ID 
                ,[HIER_LEVEL_1]
                ,[HIER_LEVEL_2]
                ,[HIER_LEVEL_3]
                ,[FG_HIER_LEVEL_1]
                ,[FG_HIER_LEVEL_2]
                ,[FG_HIER_LEVEL_3]
              ORDER BY (SELECT NULL)
            )
FROM [dbo].[adx_product]
) AS T
WHERE DupRank > 1 

truncate TABLE adx_product_mirror

insert into adx_product_mirror (
       [PRODUCT_ID]
      ,[DESCRIPTION]
      ,[PRODUCT_TYPE]
      ,[PRODAREA]
      ,[HIER_LEVEL_1]
      ,[HIER_LEVEL_2]
      ,[HIER_LEVEL_3]
      ,[FG_HIER_LEVEL_1]
      ,[FG_HIER_LEVEL_2]
      ,[FG_HIER_LEVEL_3]
      ,[END_ITEM]
      ,[A_MAT_STATUS]
      ,[LATE_FORECAST]
      ,[LATE_SALES]    
)
SELECT [PRODUCT_ID]
      ,[DESCRIPTION]
      ,[PRODUCT_TYPE]
      ,[PRODAREA]

      ,STRING_AGG(HIER_LEVEL_1, '_') WITHIN GROUP (ORDER BY HIER_LEVEL_1 ASC) --,[HIER_LEVEL_1]
      ,[HIER_LEVEL_2] --,STRING_AGG(HIER_LEVEL_2, '_') WITHIN GROUP (ORDER BY HIER_LEVEL_2 ASC) 
      ,[HIER_LEVEL_3] --,STRING_AGG(HIER_LEVEL_3, '_') WITHIN GROUP (ORDER BY HIER_LEVEL_3 ASC)
      
      ,[FG_HIER_LEVEL_1]
      ,[FG_HIER_LEVEL_2]
      ,[FG_HIER_LEVEL_3]
      ,[END_ITEM]
      ,[A_MAT_STATUS]
      ,[LATE_FORECAST]
      ,[LATE_SALES]
FROM [dbo].[adx_product]
group by 
       [PRODUCT_ID]
      ,[DESCRIPTION]
      ,[PRODUCT_TYPE]
      ,[PRODAREA]
      --,[HIER_LEVEL_1]
      ,[HIER_LEVEL_2]
      ,[HIER_LEVEL_3]
      ,[FG_HIER_LEVEL_1]
      ,[FG_HIER_LEVEL_2]
      ,[FG_HIER_LEVEL_3]
      ,[END_ITEM]
      ,[A_MAT_STATUS]
      ,[LATE_FORECAST]
      ,[LATE_SALES]


truncate table adx_product

insert into adx_product (
       [PRODUCT_ID]
      ,[DESCRIPTION]
      ,[PRODUCT_TYPE]
      ,[PRODAREA]
      ,[HIER_LEVEL_1]
      ,[HIER_LEVEL_2]
      ,[HIER_LEVEL_3]
      ,[FG_HIER_LEVEL_1]
      ,[FG_HIER_LEVEL_2]
      ,[FG_HIER_LEVEL_3]
      ,[END_ITEM]
      ,[A_MAT_STATUS]
      ,[LATE_FORECAST]
      ,[LATE_SALES]    
)
SELECT [PRODUCT_ID]
      ,[DESCRIPTION]
      ,[PRODUCT_TYPE]
      ,[PRODAREA]
      ,[HIER_LEVEL_1]
      ,[HIER_LEVEL_2]
      ,[HIER_LEVEL_3]      
      ,[FG_HIER_LEVEL_1]
      ,[FG_HIER_LEVEL_2]
      ,[FG_HIER_LEVEL_3]
      ,[END_ITEM]
      ,[A_MAT_STATUS]
      ,[LATE_FORECAST]
      ,[LATE_SALES]
  FROM [dbo].[adx_product_mirror]
GO

