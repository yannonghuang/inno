CREATE PROCEDURE [dbo].[write_period_manager]
AS
insert into adx_period_manager
select * from period_manager
GO

