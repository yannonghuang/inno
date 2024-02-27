
CREATE PROCEDURE [dbo].[Populate_Finished_Goods] 
AS
BEGIN

Truncate Table Finished_Goods

DECLARE @sSQL nvarchar(1500)
   declare @count bigint;
   declare @table_name varchar(500)
   select @count = (select count(*) from BOM_Tables)
   declare MyCursor cursor for (select bom_table_name from BOM_Tables)
   open MyCursor 
   while @count > 0
      begin
        fetch MyCursor into @table_name
        print @table_name
        SET @sSQL = 'insert into Finished_Goods (PRODUCT_ID, TYPE) ' + 
            ' select FG, ''Part'' from ' + @table_name
                     
        print @sSQL
        EXEC(@sSQL)
        set @count = @count - 1
      end
   close MyCursor 
   deallocate MyCursor 

insert into Finished_Goods (PRODUCT_ID, TYPE)
SELECT
    [work_order_model],
    'DP Model' 
FROM [POCModel]  

insert into Finished_Goods (PRODUCT_ID, TYPE)
SELECT
    concat([PN_for_customer], '@', [Customer_abbreviate]),   
    'Customer FG Substitution'
FROM [FG_SUBSTITUTES]  

/*
insert into Finished_Goods (PRODUCT_ID, TYPE)
SELECT
    concat([DPM], '@', [Customer]),   
    'Customer-Specific DP Model'
FROM [DPM_CustomerPN_Customer]  
*/

DELETE T
FROM
(
SELECT *
, DupRank = ROW_NUMBER() OVER (
              PARTITION BY PRODUCT_ID
              ORDER BY (SELECT NULL)
            )
FROM [Finished_Goods]
) AS T
WHERE DupRank > 1 

END
GO

