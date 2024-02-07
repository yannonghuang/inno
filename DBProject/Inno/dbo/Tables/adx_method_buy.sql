CREATE TABLE [dbo].[adx_method_buy] (
    [PRODUCT_ID]        NVARCHAR (50) NOT NULL,
    [LOCATION]          NVARCHAR (50) NOT NULL,
    [PREFERENCE]        TINYINT       NOT NULL,
    [COST]              INT           NOT NULL,
    [MIN_SUPPLY]        INT           NOT NULL,
    [MAX_SUPPLY]        INT           NOT NULL,
    [LEAD_DAYS_SUPPLY]  INT           NULL,
    [CYCLE_DAYS_SUPPLY] INT           NULL,
    [VENDOR_ID]         NVARCHAR (50) NOT NULL,
    [EFFECTIVE_START]   NVARCHAR (50) NOT NULL,
    [EFFECTIVE_END]     NVARCHAR (50) NOT NULL,
    [HIER_LEVEL_1]      NVARCHAR (50) NOT NULL,
    [HIER_LEVEL]        NVARCHAR (50) NOT NULL,
    [HIER_LEVEL_3]      NVARCHAR (50) NOT NULL,
    [process_unit_cost] INT           NOT NULL
);
GO

