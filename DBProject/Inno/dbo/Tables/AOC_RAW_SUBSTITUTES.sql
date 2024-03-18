CREATE TABLE [dbo].[AOC_RAW_SUBSTITUTES] (
    [substitution_group] NVARCHAR (50) NOT NULL,
    [Priority]           TINYINT       NOT NULL,
    [Usage_percentage]   TINYINT       NOT NULL,
    [component]          NVARCHAR (50) NOT NULL,
    [Assemble_P_N]       NVARCHAR (50) NOT NULL
);
GO

