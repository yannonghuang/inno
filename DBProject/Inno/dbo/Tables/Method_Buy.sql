CREATE TABLE [dbo].[Method_Buy] (
    [PRODUCT_ID]        NVARCHAR (50) NULL,
    [Revesion_level]    NVARCHAR (50) NULL,
    [VENDOR_ID]         NVARCHAR (50) NULL,
    [LOCATION]          NVARCHAR (50) NULL,
    [PREFERENCE_Quota]  TINYINT       NULL,
    [EFFECTIVE_START]   DATE          NULL,
    [EFFECTIVE_END]     DATE          NULL,
    [LEAD_DAYS_SUPPLY]  SMALLINT      NULL,
    [CYCLE_DAYS_SUPPLY] NVARCHAR (1)  NULL
);
GO

