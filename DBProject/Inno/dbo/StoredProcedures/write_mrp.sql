CREATE PROCEDURE [dbo].[write_mrp]
AS

truncate table adx_route
truncate table adx_operation
truncate table adx_bora
truncate table adx_bor
truncate table adx_resalt
truncate table adx_resource
truncate table adx_rescapinter
truncate table adx_op_override

EXEC write_route
EXEC write_operation
EXEC write_bora
EXEC write_bor
EXEC write_resalt
EXEC write_resource
EXEC write_rescapinter
EXEC write_op_override

EXEC dedup_route
EXEC dedup_operation
EXEC dedup_bora
EXEC dedup_bor
EXEC dedup_resalt
EXEC dedup_resource
EXEC dedup_rescapinter
EXEC dedup_op_override
GO

