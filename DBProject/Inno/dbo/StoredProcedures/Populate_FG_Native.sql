
CREATE PROCEDURE [dbo].[Populate_FG_Native] 
AS
BEGIN

Truncate Table FG_Native;

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
        SET @sSQL = 'insert into FG_Native (PN) ' + 
            ' select FG from ' + @table_name
                     
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
              PARTITION BY PN
              ORDER BY (SELECT NULL)
            )
FROM [FG_Native]
) AS T
WHERE DupRank > 1 

END
GO

