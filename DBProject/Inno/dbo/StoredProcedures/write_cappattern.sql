CREATE PROCEDURE [dbo].[write_cappattern]
AS
insert into adx_cappattern
select * from cappattern
GO

