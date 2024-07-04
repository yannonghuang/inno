CREATE TABLE [dbo].[adx_method_buy] (
    [PRODUCT_ID]        NVARCHAR (50)  NULL,
    [LOCATION]          NVARCHAR (50)  NULL,
    [PREFERENCE]        NVARCHAR (MAX) NULL,
    [COST]              INT            NULL,
    [MIN_SUPPLY]        INT            NULL,
    [MAX_SUPPLY]        INT            NULL,
    [LEAD_DAYS_SUPPLY]  INT            NULL,
    [CYCLE_DAYS_SUPPLY] INT            NULL,
    [VENDOR_ID]         NVARCHAR (50)  NULL,
    [EFFECTIVE_START]   NVARCHAR (50)  NULL,
    [EFFECTIVE_END]     NVARCHAR (50)  NULL,
    [HIER_LEVEL_1]      NVARCHAR (50)  NULL,
    [HIER_LEVEL]        NVARCHAR (50)  NULL,
    [HIER_LEVEL_3]      NVARCHAR (50)  NULL,
    [process_unit_cost] INT            NULL,
    [LOCATION_ID]       NVARCHAR (50)  NULL
);
GO

