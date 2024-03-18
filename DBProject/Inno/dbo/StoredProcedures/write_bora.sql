CREATE PROCEDURE [dbo].[write_bora]
AS
insert into [dbo].[adx_bora] (
[BORA_ID]
      ,[BOR_ID]
      ,[PREFERENCE]
)
values ('T_BORALT_MOVE', 'BOR_dummy', '1')

insert into [dbo].[adx_bora] (
[BORA_ID]
      ,[BOR_ID]
      ,[PREFERENCE]
)
SELECT  
       [BORA_ID]
      ,replace(BORA_ID, 'BORA' , 'BOR') --[BOR_ID]
      ,'1'
  FROM [dbo].[adx_operation]
GO

