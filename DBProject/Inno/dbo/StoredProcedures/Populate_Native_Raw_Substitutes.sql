CREATE PROCEDURE [dbo].[Populate_Native_Raw_Substitutes]
AS

begin
    truncate TABLE Native_Raw_Substitutes;

    DECLARE @sSQL nvarchar(1000)
    --declare @table_name varchar(1000)
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
        'insert into [NATIVE_RAW_SUBSTITUTES]  (' +
	        '[substitution_group] ' +
	        ', [Priority] ' +
	        ', [Usage_percentage]  ' +
	        ', [component]  ' +
	        ', [Assemble_P_N]  ' +
        ') ' +

        'SELECT ' +

        'SubstituteGroup ' +
        ', Priority' +
        ', Usage' +
        ', partnumber' +
        ', ParentPart' +

        ' FROM ' + @table_name + 
     
        ' where ParentPart is not null '
            + ' and SubstituteGroup is not null ' 

  
        print @sSQL
        EXEC(@sSQL)

        set @count = @count - 1
      end
   close MyCursor 
   deallocate MyCursor;

   DELETE T
    FROM
    (
    SELECT *
    , DupRank = ROW_NUMBER() OVER (
              PARTITION BY 	
                [substitution_group]
	            , [Priority]
	            , [Usage_percentage]
	            , [component]
	            , [Assemble_P_N]
              ORDER BY (SELECT NULL)
            )
    FROM [dbo].[Native_Raw_Substitutes]
    ) AS T
    WHERE DupRank > 1

end
GO

