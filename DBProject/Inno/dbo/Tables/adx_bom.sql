CREATE TABLE [dbo].[adx_bom] (
    [BOM_ID]          NVARCHAR (100) NULL,
    [LOCATION_ID]     NVARCHAR (50)  NULL,
    [PARENT_ID]       NVARCHAR (50)  NULL,
    [ALT_GROUP]       NVARCHAR (50)  NULL,
    [PREFERENCE]      TINYINT        NULL,
    [ELEM_IX]         TINYINT        NULL,
    [CHILD_ID]        NVARCHAR (50)  NULL,
    [NEW_SUPPLY]      NVARCHAR (50)  NULL,
    [GRADE]           NVARCHAR (50)  NULL,
    [RATE]            NVARCHAR (50)  NULL,
    [BATCH_SIZE]      NVARCHAR (50)  NULL,
    [EFFECTIVE_START] NVARCHAR (50)  NULL,
    [EFFECTIVE_END]   NVARCHAR (50)  NULL,
    [OBSOLETE]        NVARCHAR (50)  NULL
);
GO

