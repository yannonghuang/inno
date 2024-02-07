CREATE PROCEDURE [dbo].[write_subs_product]
AS

begin
    DECLARE @sSQL nvarchar(1000)
    --declare @table_name varchar(500)
    --set @table_name = 'BOM_1000_part1'


   declare @count bigint;
   declare @table_name varchar(500)
   select @count = (select count(*) from RawSubs_Tables)
   declare MyCursor cursor for (select raw_subs_table_name from RawSubs_Tables)
   open MyCursor 
   while @count > 0
      begin
        fetch MyCursor into @table_name
        print @table_name                

        SET @sSQL = 
        'insert into [adx_product]  (' +
        '[PRODUCT_ID] ' +
        ',[DESCRIPTION] ' +
        ',[PRODUCT_TYPE] ' +
        ',[PRODAREA] ' +
        ',[HIER_LEVEL_1] ' +
        ',[HIER_LEVEL_2] ' +
        ',[HIER_LEVEL_3] ' +
        ',[FG_HIER_LEVEL_1] ' +
        ',[FG_HIER_LEVEL_2] ' +
        ',[FG_HIER_LEVEL_3] ' +
        ',[END_ITEM] ' +
        ',[A_MAT_STATUS] ' +
        ',[LATE_FORECAST] ' +
        ',[LATE_SALES] ' +
        ') ' +

        'SELECT ' +
        ' ''VirtualProduct_'' + Assemble_P_N + ''_'' + substitution_group ' +   
        ',''Virtual Product for Raw Material Substitutions'' ' +  
        ',''M'' ' +  

        ',CASE   ' +
        ' WHEN Process.Process is not null THEN ' +
            ' CASE   ' +
            ' WHEN Process.Process = ''Module'' THEN ''MODULE'' ' +
            ' ELSE ''OPTICAL'' ' +
            ' END ' +             
        ' ELSE ''OPTICAL'' ' +
        ' END ' +

        ',CASE   ' +
        ' WHEN Process.Process is not null THEN ' +
            ' CASE   ' +
            ' WHEN Process.Process = ''Module'' THEN ''MODULE'' ' +
            ' ELSE ''OPTICAL'' ' +
            ' END ' +             
        ' ELSE ''OPTICAL'' ' +
        ' END ' +

        ',''FACTORY'' ' +
        ',''ALL'' ' +
        
        ',''-'' ' +
        ',''-'' ' +
        ',''-'' ' +
        ',''-'' ' +
        ',''-'' ' +
        ',''-'' ' +
        ',''-'' ' + 
  
        'FROM ' + @table_name + ' left outer JOIN Process on ' + @table_name + '.Assemble_P_N = Process.P_N ' 
  
        print @sSQL
        EXEC(@sSQL)

        set @count = @count - 1
      end
   close MyCursor 
   deallocate MyCursor 
end
GO

