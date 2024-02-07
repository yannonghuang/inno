
CREATE PROCEDURE [dbo].[Unset_Obsolete_Flag] 
AS
BEGIN

update [adx_bom]
set adx_bom.OBSOLETE = '-'
where exists (
    select * from adx_bom internalR where adx_bom.CHILD_ID = internalR.PARENT_ID
)

END
GO

