CREATE PROCEDURE [dbo].[write_bom_bom]
AS

begin
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
        'insert into [adx_bom]  (' +
        '[BOM_ID] ' +
        ',[LOCATION_ID] ' +
        ',[PARENT_ID] ' +
        ',[ALT_GROUP] ' +
        ',[PREFERENCE] ' +
        ',[ELEM_IX] ' +
        ',[CHILD_ID] ' +
        ',[NEW_SUPPLY] ' +
        ',[GRADE] ' +
        ',[RATE] ' +
        ',[BATCH_SIZE] ' +
        ',[EFFECTIVE_START] ' +
        ',[EFFECTIVE_END] ' +
        ',[OBSOLETE] ' +
        ') ' +

        'SELECT ' +

        '''BOM_'' + ParentPart ' +

        ',''-'' ' +
        --',CASE   ' +
        --' WHEN process_location.location is not null THEN process_location.location ' +                   
        --' ELSE ''1000'' ' + 
        ----' ELSE ''dummy'' ' +                
        --' END ' +
        --', process_location.location ' +
        
        ', ParentPart ' +

        ',''-'' ' +
        --', SubstituteGroup ' +

        ',''1'' ' +

        ', SUBSTRING(BOMLevel, LEN(BOMLevel) - CHARINDEX(''.'', REVERSE(BOMLevel))+2, 100)' +


        ',CASE   ' +
        ' WHEN SubstituteGroup is null THEN partnumber' +          
        ' ELSE ''VirtualProduct_'' + ParentPart + ''_'' + SubstituteGroup ' +
        ' END ' +
        
        --', partnumber ' +
        
        ',''-'' ' +
        ',''-'' ' +  

        ',CASE   ' +
        ' WHEN BOM_Single_Level.quantity is not null THEN BOM_Single_Level.quantity/1000' +          
        ' ELSE ''1'' ' +
        ' END ' +
        --',''1000'' ' +   
        
        ',''-'' ' +
        ',''-'' ' +
        ',''-'' ' +   
        ',''-'' ' +   
        --'FROM ' + @table_name + ', Process, process_location ' +
        ' FROM ' + @table_name + 
            ' left outer JOIN BOM_Single_Level on ' + @table_name + '.ParentPart = BOM_Single_Level.FG ' + 
            ' and ' + @table_name + '.partnumber = BOM_Single_Level.component ' + 

            --' left outer JOIN BOM_Single_Level on ' + @table_name + '.ParentPart = BOM_Single_Level.component ' + 

            --' left outer JOIN Process on ' + @table_name + '.partnumber = Process.P_N ' + 
            --'left outer JOIN process_location on Process.process = process_location.process ' +        
        ' where ParentPart is not null ' -- + @table_name + '.SubstituteGroup is NULL and '
        -- ' where componenttype is not null and ParentPart is not null ' -- + @table_name + '.SubstituteGroup is NULL and '
        -- + @table_name + '.ParentPart = Process.P_N and Process.process = process_location.process '
  
        print @sSQL
        EXEC(@sSQL)

        set @count = @count - 1
      end
   close MyCursor 
   deallocate MyCursor 

end
GO

