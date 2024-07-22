CREATE PROCEDURE [dbo].[write_cfi_family]
AS
insert into adx_cfi_family
select * from cfi_family;

insert into adx_cfi_family (
    [FAMILY]
    ,[TYPE]
    ,[MIN]
    ,[IDEAL]
    ,[MAX]
)
SELECT 
      [CFI_FAMILY]
      ,'CYCLE'
      ,[Lead_time] * 86400
      ,[Lead_time] * 86400
      ,[Lead_time] * 86400     
FROM [Inno].[dbo].[Production_LeadTime]
GO

