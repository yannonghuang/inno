CREATE TABLE [dbo].[RAW_SUBSTITUTES] (
    [substitution_group] NVARCHAR (50) NULL,
    [Priority]           TINYINT       NULL,
    [Usage_percentage]   TINYINT       NULL,
    [component]          NVARCHAR (50) NULL,
    [Assemble_P_N]       NVARCHAR (50) NULL
);
GO


CREATE NONCLUSTERED INDEX [Index_RAW_SUBSTITUTES_1]
    ON [dbo].[RAW_SUBSTITUTES]([component] DESC);
GO

