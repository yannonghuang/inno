CREATE TABLE [dbo].[old_Method_Buy] (
    [PRODUCT_ID]        NVARCHAR (50) NOT NULL,
    [Revesion_level]    NVARCHAR (50) NOT NULL,
    [VENDOR_ID]         INT           NOT NULL,
    [LOCATION]          SMALLINT      NOT NULL,
    [PREFERENCE_Quota]  TINYINT       NOT NULL,
    [EFFECTIVE_START]   DATE          NOT NULL,
    [EFFECTIVE_END]     DATE          NOT NULL,
    [LEAD_DAYS_SUPPLY]  SMALLINT      NOT NULL,
    [CYCLE_DAYS_SUPPLY] NVARCHAR (1)  NULL
);
GO

