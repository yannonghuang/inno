CREATE PROCEDURE [dbo].[write_resalt]
AS

insert into [dbo].[adx_resalt] (
       [OPERATION_ID]
      ,[RESALT_ID]
      ,[PREFERENCE]
      ,[RES_ID]
      ,[ELEM_IX]
)
values (
       '-' 
      ,'RESALT_dummy'
      ,'1'
      ,'RESOURCE_dummy'
      ,'1'
)

insert into [dbo].[adx_resalt] (
       [OPERATION_ID]
      ,[RESALT_ID]
      ,[PREFERENCE]
      ,[RES_ID]
      ,[ELEM_IX]
)
SELECT  
       '-' --replace(BOR_ID, 'BOR' , 'OP')
      ,[RESALT_ID]
      ,'1'

--      ,case
--      when COP_resource.RESOURCE_ID is not null 
--      then
        ,replace(RESALT_ID, 'RESALT' , 'RESOURCE')
--      else
--        'RESOURCE_dummy'
--      END

      ,'1'
FROM [dbo].[adx_bor] 
--    left OUTER join COP_resource
--    on 'RESOURCE_' + COP_resource.RESOURCE_ID + '_Machine' = replace(RESALT_ID, 'RESALT' , 'RESOURCE')
--FROM [dbo].[adx_bor]     
where not RESALT_ID like '%dummy%'



insert into [dbo].[adx_resalt] (
       [OPERATION_ID]
      ,[RESALT_ID]
      ,[PREFERENCE]
      ,[RES_ID]
      ,[ELEM_IX]
)
SELECT  
       '-' --replace(BOR_ID, 'BOR' , 'OP')
      ,[RESALT_ID]
      ,'1'
      ,replace(replace(RESALT_ID, 'RESALT' , 'RESOURCE'), '_Machine', '_s_Machine')
      ,'2'
FROM [dbo].[adx_bor], COP_resource
where RESALT_ID like '%_Machine' and not RESALT_ID like '%dummy%'
    and 'RESOURCE_' + COP_resource.RESOURCE_ID + '_Machine' = 
    replace(replace(RESALT_ID, 'RESALT' , 'RESOURCE'), '_Machine', '_s_Machine')
GO

