
CREATE PROCEDURE [dbo].[Populate_Sanity_No_Buy] 
AS
BEGIN

truncate table Sanity_No_Buy;

DECLARE @sSQL nvarchar(1500)
   declare @count int;
   declare @countAffected int;   
   declare @table_name varchar(500)
   select @count = (select count(*) from BOM_Tables)
   declare MyCursor cursor for (select bom_table_name from BOM_Tables)
   open MyCursor 
   while @count > 0
      begin
        fetch MyCursor into @table_name
        print @table_name

        set @table_name = '_' + @table_name
        
        SET @sSQL = 'insert into Sanity_No_Buy(Component, FG, [File]) ' +
            ' SELECT partnumber, FG, ''' + @table_name  + ''' FROM ' + @table_name  +
            ' where ( ' +
                ' not exists ( ' +
                    ' select * from ' + @table_name  + ' internalR where ' + @table_name + '.partnumber = internalR.ParentPart ' +
                ' ) AND ' +
                ' not exists ( ' +
                    ' select * from [Method_Buy] where ' + @table_name + '.partnumber = Method_Buy.PRODUCT_ID ' +
                ' ) ' +

            ' and exists (' +
            ' select * ' +
            ' from [POCFG]' +
            ' where [POCFG].[FG_PN] = ' + @table_name + '.[FG]) ' +
                            
            ' ) '
                       
        print @sSQL
        --set @countAffected = 1
        --while @countAffected > 0
        --BEGIN
            EXEC(@sSQL)
        --    set @countAffected = @@rowcount;
        --END
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
FROM [Sanity_No_Buy]
) AS T
WHERE DupRank > 1 

END
GO

