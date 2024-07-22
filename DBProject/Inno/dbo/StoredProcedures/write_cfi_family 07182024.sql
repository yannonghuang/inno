CREATE PROCEDURE [dbo].[write_cfi_family 07182024]
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
FROM [Inno].[dbo].[SR4AOC_Production_LeadTime]
GO

