CREATE PROCEDURE [dbo].[write_sourcing]
AS
insert into adx_sourcing
select * from sourcing
GO

