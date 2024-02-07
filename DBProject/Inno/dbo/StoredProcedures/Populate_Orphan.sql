
CREATE PROCEDURE [dbo].[Populate_Orphan] 
AS
BEGIN
truncate table orphan

DECLARE @sSQL nvarchar(500)
   declare @count bigint;
   declare @table_name varchar(500)
   select @count = (select count(*) from BOM_Tables)
   declare MyCursor cursor for (select bom_table_name from BOM_Tables)
   open MyCursor 
   while @count > 0
      begin
        fetch MyCursor into @table_name
        print @table_name

        SET @sSQL = 'insert into orphan(PRODUCT_ID) ' +
            ' SELECT [partnumber] FROM ' + @table_name  +
            ' where not exists (select * from process where P_N = partnumber) and not exists (select * from method_buy where PRODUCT_ID = partnumber)'
        print @sSQL
        EXEC(@sSQL)
        set @count = @count - 1
      end
   close MyCursor 
   deallocate MyCursor 


DELETE T
FROM
(
SELECT *
, DupRank = ROW_NUMBER() OVER (
              PARTITION BY PRODUCT_ID
              ORDER BY (SELECT NULL)
            )
FROM [orphan]
) AS T
WHERE DupRank > 1 

END
GO

