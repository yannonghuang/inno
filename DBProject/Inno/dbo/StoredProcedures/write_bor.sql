CREATE PROCEDURE [dbo].[write_bor]
AS
insert into [dbo].[adx_bor] (
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

insert into [dbo].[adx_bor] (
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
FROM [dbo].[adx_bora]
where not BOR_ID like '%dummy%'

insert into [dbo].[adx_bor] (
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
FROM [dbo].[adx_bora]
where not BOR_ID like '%dummy%'
GO

