CREATE procedure [dbo].[Promote_to_Staging]
as
begin
   DECLARE @sSQL nvarchar(max)

   declare @count bigint;
   declare @table_name varchar(500)
   select @count = (select count(*) from INFORMATION_SCHEMA.TABLES where TABLE_NAME like 'adx%')
   declare MyCursor cursor for (select TABLE_NAME from INFORMATION_SCHEMA.TABLES where TABLE_NAME like 'adx%')
   open MyCursor 
   while @count > 0
      begin
        fetch MyCursor into @table_name
        print @table_name
        if @table_name <> 'adx_graybox' and @table_name <> 'adx_product_mirror' 
            and @table_name <> 'adx_productlocation_mirror'
            and @table_name <> 'adx_cfi_family' and @table_name <> 'ADX_CUSTOMER'
        begin

            declare @remote_table_name varchar(500)
            set @remote_table_name = @table_name
            if @table_name = 'adx_op_override'
            BEGIN
                set @remote_table_name = 'ADX_OPERATION_OVERRIDE'
            END

		    declare @column_list varchar(max)
		    set @column_list = ''

		    declare @column_name varchar(500)
		    declare @columnSql as nvarchar(max)

            --- build column list shared by both remote and local ----
		    DECLARE ColumnCursor CURSOR GLOBAL FOR 
            --select column_name FROM INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = @table_name
            select local.COLUMN_NAME 
            FROM adx_staging.INFORMATION_SCHEMA.COLUMNS remote, INFORMATION_SCHEMA.COLUMNS local
            where remote.TABLE_NAME = @remote_table_name 
            and local.TABLE_NAME = @table_name
            and remote.COLUMN_NAME = local.COLUMN_NAME
            and remote.COLUMN_NAME <> 'MODEL_ID'

		    open ColumnCursor 

		    FETCH next FROM ColumnCursor INTO @column_name
		    WHILE @@FETCH_STATUS = 0
		    BEGIN
			    PRINT '@column_name=' + @column_name
			    set @column_list = @column_list + @column_name + ','

                -- change '-' to null in original tables
                SET @sSQL = 'update ' + @table_name + 
                    ' set ' + @column_name + ' = null ' +
                    ' where ' + @column_name + ' = ''-'' '
                print  @sSQL
                EXEC(@sSQL)

			    FETCH NEXT FROM ColumnCursor INTO @column_name
		    END

		    set @column_list = SUBSTRING(@column_list, 1, LEN(@column_list) - 1)


            -- copy to STAGING
            SET @sSQL = 'truncate table [ADX_STAGING].[dbo].' + @remote_table_name
            print @sSQL
            EXEC(@sSQL)

            SET @sSQL = 'insert into [ADX_STAGING].[dbo].' + @remote_table_name + '(MODEL_ID, ' + @column_list + ')'
            + ' select ''Innolight'', ' + @column_list + ' from ' + @table_name
		    print @sSQL
            EXEC(@sSQL)

		    close ColumnCursor 
		    deallocate ColumnCursor 

        end
        set @count = @count - 1
      end
   close MyCursor 
   deallocate MyCursor 

    --- adx_cfi_family
    truncate table [ADX_STAGING].[dbo].[ADX_CFI]
    insert into [ADX_STAGING].[dbo].[ADX_CFI] (
       MODEL_ID 
      ,[CYCLE_TIME_FAMILY]
      ,[CYCLE_TIME_TYPE]
      ,[MINIMUM]
      ,[IDEAL]
      ,[TOLERATED]
    )
    SELECT 
      'Innolight'
      ,[FAMILY]
      ,[TYPE]
      ,[MIN]
      ,[IDEAL]
      ,[MAX]
    FROM [adx_cfi_family]

    --- ADX_CUSTOMER
    truncate table [ADX_STAGING].[dbo].[ADX_CUSTOMER]
    insert into [ADX_STAGING].[dbo].[ADX_CUSTOMER] (
        MODEL_ID
      ,[SOLD_TO_ID]
      ,[DESCRIPTION]
      ,[CUSTOMER_PREF]
      ,[HIER_LEVEL_1]
      ,[HIER_LEVEL_2]
      ,[HIER_LEVEL_3]
    )
    SELECT 
      'Innolight'
      ,[CUSTOMER_ID]
      ,[CUSTOMER_DESCRIPTION]
      ,[CustomerPref]
      ,[CUSTOMER_HIER_LEVEL_1]
      ,[CUSTOMER_HIER_LEVEL_2]
      ,[CUSTOMER_HIER_LEVEL_3]
    FROM [Inno].[dbo].[adx_customer]

    -- change data type from 'Cost' to 'REAL NUMBER' in UDA
    update [ADX_STAGING].[dbo].[ADX_UDA]
    set [USER_TYPE] = 'REAL NUMBER'
    where [USER_TYPE] = 'Cost'

end
GO

