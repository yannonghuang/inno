CREATE PROCEDURE [dbo].[write_route]
AS
insert into [dbo].[adx_route] (
       [PRODAREA]
      ,[ROUTE_ID]
      ,[SEGMENT_ID]
      ,[SEGMENT_IX]
      ,[STEP_IX]
      ,[OPERATION_ID]
)
SELECT 
       [PRODAREA]
      ,[ROUTE_ID]
      ,[SEGMENT_ID]
      ,[SEGMENT_IX]
      ,[STEP_IX]
      ,[OPERATION_ID]
 
  FROM [dbo].[new_route]
GO

