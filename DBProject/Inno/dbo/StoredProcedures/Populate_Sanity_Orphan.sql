
CREATE PROCEDURE [dbo].[Populate_Sanity_Orphan] 
AS
BEGIN
truncate table Sanity_Orphan

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

        set @table_name = '_' + @table_name

        SET @sSQL = 'insert into Sanity_Orphan(Component, FG, [File]) ' +
            ' SELECT ParentPart, FG, ''' + @table_name  + ''' FROM ' + @table_name  +
            ' where ParentPart is not null and ParentPart <> FG '

            + ' and exists (' +
            ' select * ' +
            ' from [POCFG]' +
            ' where [POCFG].[FG_PN] = ' + @table_name + '.[FG]) '

            + ' and not exists (' +
            ' select * ' +
            ' from ' + @table_name + ' internalTable ' + 
            ' where internalTable.[partnumber] = ' + @table_name + '.[ParentPart] and ' + 'internalTable.[ParentPart] is not null' +
            ')'

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
              PARTITION BY Component, FG, [File]
              ORDER BY (SELECT NULL)
            )
FROM [Sanity_Orphan]
) AS T
WHERE DupRank > 1 

END
GO

