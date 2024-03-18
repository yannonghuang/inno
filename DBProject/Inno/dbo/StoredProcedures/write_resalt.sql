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
      ,replace(RESALT_ID, 'RESALT' , 'RESOURCE')
      ,'1'
FROM [dbo].[adx_bor] 
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
FROM [dbo].[adx_bor]
where RESALT_ID like '%_Machine' and not RESALT_ID like '%dummy%'
GO

