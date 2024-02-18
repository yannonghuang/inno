CREATE PROCEDURE [dbo].[write_bor]
AS
insert into [master].[dbo].[adx_bor] (
       [BOR_ID]
      ,[IDX]
      ,[RESALT_ID]
      ,[RATE]
)
values(  
      'BOR_dummy'
      ,'1'
      ,'RESALT_dummy'
      ,'1'
)

insert into [master].[dbo].[adx_bor] (
       [BOR_ID]
      ,[IDX]
      ,[RESALT_ID]
      ,[RATE]
)
SELECT  
      [BOR_ID]
      ,'1'
      ,case
      when BOR_ID like '%Preform%' and (not BOR_ID like '%LASER') then 'RESALT_Preform_Assembly_Machine'
      else replace(BOR_ID, 'BOR' , 'RESALT') + '_Machine'
      end
      ,'1'
FROM [master].[dbo].[adx_bora]
where not BOR_ID like '%dummy%'

insert into [master].[dbo].[adx_bor] (
       [BOR_ID]
      ,[IDX]
      ,[RESALT_ID]
      ,[RATE]
)
SELECT  
      [BOR_ID]
      ,'2'
      ,'RESALT_Crew'
      ,'1'
FROM [master].[dbo].[adx_bora]
where not BOR_ID like '%dummy%'
GO

