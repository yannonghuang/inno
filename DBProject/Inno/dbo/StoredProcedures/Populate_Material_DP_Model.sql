CREATE PROCEDURE [dbo].[Populate_Material_DP_Model]
AS

begin

truncate table Material_DP_Model

    DECLARE @sSQL nvarchar(2000)
    --declare @table_name varchar(500)
    --set @table_name = 'BOM_1000_part1'

   declare @count bigint;
   declare @table_name varchar(500)
   select @count = (select count(*) from BOM_Tables)
   declare MyCursor cursor for (select bom_table_name from BOM_Tables)
   open MyCursor 
   while @count > 0
      begin
        fetch MyCursor into @table_name
        print @table_name                

        SET @sSQL = 
        'insert into [Material_DP_Model]  (' +
        '[PN] ' +
        ',[DESCRIPTION] ' +
        ',[OLD_DESCRIPTION] ' +        
        ',[CODE] ' +
        ',[MPS_MODEL] ' +
        ') ' +

        'SELECT ' +
         @table_name + '.partnumber ' +

        ', CASE   ' +
            ' WHEN DP_Models.DESCRIPTION is not null THEN DP_Models.DESCRIPTION ' +
            ' ELSE ''-'' ' +
        ' END ' +     

        ', CASE   ' +
            ' WHEN DP_Models.OLD_DESCRIPTION is not null THEN DP_Models.OLD_DESCRIPTION ' +
            ' ELSE ''-'' ' +
        ' END ' +   

        ', CASE   ' +
            ' WHEN DP_Models.Code is not null THEN DP_Models.Code ' +
            ' ELSE ''-'' ' +
        ' END ' +             

        ', CASE   ' +
            ' WHEN MPS_Model is not null THEN MPS_Model ' +         
            ' ELSE ''-'' ' +
        ' END ' +     


        'FROM ' + @table_name + 
            ' left outer JOIN DP_Models on ' + @table_name + '.FG = DP_Models.PN ' 
            -- + 'where componenttype is not null  ' 
  
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
              PARTITION BY PN, CODE, DESCRIPTION, MPS_MODEL
              ORDER BY (SELECT NULL)
            )
FROM [Material_DP_Model]
) AS T
WHERE DupRank > 1

end
GO

