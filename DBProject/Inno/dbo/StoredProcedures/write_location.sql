CREATE PROCEDURE [dbo].[write_location]
AS
insert into adx_location
select * from location
GO

