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
FROM [dbo].[adx_bora], [Operation_Override_COP]
where not BOR_ID like '%dummy%' 
and replace(BOR_ID, 'BOR' , 'OP') = Operation_Override_COP.OPERATION_ID and Operation_Override_COP.Machine_UPH <> '0'

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

      ,case
      when Machine_UPH = '0' then '1'
      else TRY_CAST(Machine_UPH AS decimal(5, 2)) / TRY_CAST(Labor_UPH AS decimal(5, 2))
      end
      --,'1' rate
FROM [dbo].[adx_bora], [Operation_Override_COP]
where not BOR_ID like '%dummy%'
and replace(BOR_ID, 'BOR' , 'OP') = Operation_Override_COP.OPERATION_ID
GO

