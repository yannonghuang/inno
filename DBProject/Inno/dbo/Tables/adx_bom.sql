CREATE TABLE [dbo].[adx_bom] (
    [BOM_ID]          NVARCHAR (100) NOT NULL,
    [LOCATION_ID]     NVARCHAR (50)  NOT NULL,
    [PARENT_ID]       NVARCHAR (50)  NOT NULL,
    [ALT_GROUP]       NVARCHAR (50)  NOT NULL,
    [PREFERENCE]      TINYINT        NOT NULL,
    [ELEM_IX]         TINYINT        NOT NULL,
    [CHILD_ID]        NVARCHAR (50)  NOT NULL,
    [NEW_SUPPLY]      NVARCHAR (50)  NOT NULL,
    [GRADE]           NVARCHAR (50)  NOT NULL,
    [RATE]            NVARCHAR (50)  NOT NULL,
    [BATCH_SIZE]      NVARCHAR (50)  NOT NULL,
    [EFFECTIVE_START] NVARCHAR (50)  NOT NULL,
    [EFFECTIVE_END]   NVARCHAR (50)  NOT NULL,
    [OBSOLETE]        NVARCHAR (50)  NULL
);
GO

