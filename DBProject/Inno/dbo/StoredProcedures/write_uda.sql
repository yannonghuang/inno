CREATE PROCEDURE [dbo].[write_uda]
AS
insert into adx_uda
select * from uda
GO

