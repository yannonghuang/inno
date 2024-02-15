CREATE PROCEDURE [dbo].[write_resource]
AS
insert into [master].[dbo].[adx_resource] (
       [RESOURCE_ID]
      ,[DESCRIPTION]
      ,[LOCATION]
      ,[RES_TYPE]
      ,[BATCH_PERIOD]
      ,[BATCH_TYPE]
      ,[AVG_BATCH_VOLUME]
      ,[MIN_BATCH_VOLUME]
      ,[MAX_BATCH_VOLUME]
      ,[SPEED_FACTOR]
      ,[MULTI_RES_FACTOR]
      ,[CARE]
      ,[DELAY_ALLOWED]
      ,[PERIOD_MGR_ID]
      ,[SETUP_MATRIX_ID]
      ,[CAPABLE_TYPE]
      ,[MIX_TYPE]
      ,[HIER_LEVEL_1]
      ,[HIER_LEVEL_2]
      ,[HIER_LEVEL_3]
      ,[OpOverrideType]
      ,[HIER_LEVEL_3_bak]
      ,[HIER_LEVEL_1_bak]
)
SELECT  
      [RES_ID]
      ,'-'
      ,'2000'-- [LOCATION]

      ,case
      when RES_ID like '%_Crew' then 'C'
      else 'M'
      end
      --,[RES_TYPE]

      ,'-' -- [BATCH_PERIOD]
      ,'-' -- [BATCH_TYPE]
      ,'-' -- [AVG_BATCH_VOLUME]
      ,'-' -- [MIN_BATCH_VOLUME]
      ,'-' -- [MAX_BATCH_VOLUME]
      ,'-' -- [SPEED_FACTOR]

/*
      ,case
      when RES_ID like '%_Crew' then '1000' -- number of line workers at 2000      
      else 
        case 
            when COP_resource.Number_of_station is not null and COP_resource.Number_of_station <> 0 then COP_resource.Number_of_station
            else '1' -- number of machines 
        END
      end
*/
      ,COP_resource.Number_of_station -- [MULTI_RES_FACTOR]
      
      ,'2' --[CARE]

      ,'-' -- [DELAY_ALLOWED]
      ,'SCP' -- [PERIOD_MGR_ID]
      ,'-' -- [SETUP_MATRIX_ID]
      ,'-' -- [CAPABLE_TYPE]
      ,'-' -- [MIX_TYPE]
      ,'HIER_LEVEL_1' -- [HIER_LEVEL_1]
      ,'HIER_LEVEL_2' -- [HIER_LEVEL_2]
      ,'HIER_LEVEL_3' -- [HIER_LEVEL_3]
      ,'-' -- [OpOverrideType]
      ,'-' -- [HIER_LEVEL_3_bak]
      ,'-' -- [HIER_LEVEL_1_bak]

FROM [master].[dbo].[adx_resalt], COP_resource
where RES_ID = 'RESOURCE_' + COP_resource.RESOURCE_ID + '_Machine' and COP_resource.Number_of_station <> 0


insert into [master].[dbo].[adx_resource] (
       [RESOURCE_ID]
      ,[DESCRIPTION]
      ,[LOCATION]
      ,[RES_TYPE]
      ,[BATCH_PERIOD]
      ,[BATCH_TYPE]
      ,[AVG_BATCH_VOLUME]
      ,[MIN_BATCH_VOLUME]
      ,[MAX_BATCH_VOLUME]
      ,[SPEED_FACTOR]
      ,[MULTI_RES_FACTOR]
      ,[CARE]
      ,[DELAY_ALLOWED]
      ,[PERIOD_MGR_ID]
      ,[SETUP_MATRIX_ID]
      ,[CAPABLE_TYPE]
      ,[MIX_TYPE]
      ,[HIER_LEVEL_1]
      ,[HIER_LEVEL_2]
      ,[HIER_LEVEL_3]
      ,[OpOverrideType]
      ,[HIER_LEVEL_3_bak]
      ,[HIER_LEVEL_1_bak]
)
values (  
      'RESOURCE_Crew'
      ,'-'
      ,'2000'-- [LOCATION]

      ,'C'

      ,'-' -- [BATCH_PERIOD]
      ,'-' -- [BATCH_TYPE]
      ,'-' -- [AVG_BATCH_VOLUME]
      ,'-' -- [MIN_BATCH_VOLUME]
      ,'-' -- [MAX_BATCH_VOLUME]
      ,'-' -- [SPEED_FACTOR]

/*
      ,case
      when RES_ID like '%_Crew' then '1000' -- number of line workers at 2000      
      else 
        case 
            when COP_resource.Number_of_station is not null and COP_resource.Number_of_station <> 0 then COP_resource.Number_of_station
            else '1' -- number of machines 
        END
      end
*/
      ,'1000' -- [MULTI_RES_FACTOR]
      
      ,'2' --[CARE]

      ,'-' -- [DELAY_ALLOWED]
      ,'SCP' -- [PERIOD_MGR_ID]
      ,'-' -- [SETUP_MATRIX_ID]
      ,'-' -- [CAPABLE_TYPE]
      ,'-' -- [MIX_TYPE]
      ,'HIER_LEVEL_1' -- [HIER_LEVEL_1]
      ,'HIER_LEVEL_2' -- [HIER_LEVEL_2]
      ,'HIER_LEVEL_3' -- [HIER_LEVEL_3]
      ,'-' -- [OpOverrideType]
      ,'-' -- [HIER_LEVEL_3_bak]
      ,'-' -- [HIER_LEVEL_1_bak]
)
GO

