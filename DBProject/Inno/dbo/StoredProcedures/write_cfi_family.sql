CREATE PROCEDURE [dbo].[write_cfi_family]
AS
insert into adx_cfi_family
select * from cfi_family
GO

