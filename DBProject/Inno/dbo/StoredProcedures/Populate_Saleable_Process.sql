
CREATE PROCEDURE [dbo].[Populate_Saleable_Process] 
AS
truncate table Saleable_Process

insert into Saleable_Process (P_N, Plant, Process) 
            SELECT [work_order_model], process_location.location, 'saleable'
            FROM [POCModel], [process_location]
            where process_location.process = 'saleable'

insert into Saleable_Process (P_N, Plant, Process) 
            SELECT concat([PN_for_customer], '@', [Customer_abbreviate]), process_location.location, 'saleable'
            FROM [FG_SUBSTITUTES], [process_location]
            where process_location.process = 'saleable'
GO

