CREATE PROCEDURE [dbo].[write_subs_product]
AS

begin
    DECLARE @sSQL nvarchar(2000)
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

        ',''-'' ' +
        ',''-'' ' +
        ',''-'' ' +        
        ',''-'' ' +
        ',''-'' ' +        
        ',''-'' ' +         
/*
        ',CASE   ' +
        ' WHEN Process.Process is not null THEN Process.Process ' +          
        ' ELSE ''NA'' ' +
        ' END ' +

        ',CASE   ' +
            ' WHEN adx_product.HIER_LEVEL_1 is not null THEN adx_product.HIER_LEVEL_1 ' +         
            ' ELSE ''-'' ' +
        ' END ' +     
*/              
--        ',''Virtual'' ' +
        -- HIER_LEVEL_1 --   

/*
        ',CASE   ' +
            ' WHEN adx_product.HIER_LEVEL_2 is not null THEN adx_product.HIER_LEVEL_2 ' +         
            ' ELSE ''NA'' ' +
        ' END ' +   
*/        
--        ',''Make'' ' +
        -- ',adx_product.HIER_LEVEL_2 ' +
        -- HIER_LEVEL_2 --   
        -- ',''FACTORY'' ' +

/*        
        ',CASE   ' +
            ' WHEN adx_product.HIER_LEVEL_3 is not null THEN adx_product.HIER_LEVEL_3 ' +         
            ' ELSE ''NA'' ' +
        ' END ' +     
*/
--        ',''Optical'' ' +
        --',adx_product.HIER_LEVEL_3 ' +
        -- HIER_LEVEL_3 --         
        -- ',''ALL'' ' +

/*        
        ',CASE   ' +
        ' WHEN Process.Process is not null THEN Process.Process ' +          
        ' ELSE ''Raw'' ' +
        ' END ' +
               
        ',CASE   ' +
            ' WHEN adx_product.FG_HIER_LEVEL_1 is not null THEN adx_product.FG_HIER_LEVEL_1 ' +         
            ' ELSE ''-'' ' +
        ' END ' +     
*/                 
--        ',''NA'' ' +
        -- FG_HIER_LEVEL_1 --  

--        ',''NA'' ' +
        -- FG_HIER_LEVEL_2 --         

--        ',''NA'' ' +
        -- FG_HIER_LEVEL_3 -- 

        ',''-'' ' +
        ',''-'' ' +
        ',''-'' ' +        
        ',''-'' ' + 

        'FROM ' + @table_name + ', Process, adx_product ' +       
        'where component = adx_product.PRODUCT_ID and ' + @table_name + '.Assemble_P_N = Process.P_N ' +
            ' and exists (select * from adx_product internalR where Assemble_P_N = internalR.PRODUCT_ID) '
--        'FROM ' + @table_name + ' left outer JOIN Process on ' + @table_name + '.Assemble_P_N = Process.P_N ' 
--            + ' left outer JOIN adx_product on ' + @table_name + '.Assemble_P_N = adx_product.PRODUCT_ID '
--            + ', adx_product ' +
--        'where component = adx_product.PRODUCT_ID'

        print @sSQL
        EXEC(@sSQL)

        set @count = @count - 1
      end
   close MyCursor 
   deallocate MyCursor 
end
GO

