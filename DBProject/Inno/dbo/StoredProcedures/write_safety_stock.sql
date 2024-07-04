CREATE PROCEDURE [dbo].[write_safety_stock]
AS
insert into adx_safety_stock
select * from safety_stock
GO

