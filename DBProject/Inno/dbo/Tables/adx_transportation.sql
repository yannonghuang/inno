CREATE TABLE [dbo].[adx_transportation] (
    [PRODUCT]             NVARCHAR (50)  NULL,
    [FROM_LOCATION]       NVARCHAR (50)  NULL,
    [TO_LOCATION]         NVARCHAR (50)  NULL,
    [TRANS_RT]            NVARCHAR (50)  NULL,
    [MODE]                NVARCHAR (50)  NULL,
    [PREFERENCE]          NVARCHAR (MAX) NULL,
    [COST]                FLOAT (53)     NULL,
    [TRANSIT_TIME]        NVARCHAR (50)  NULL,
    [TRANSIT_TIME_UOM]    NVARCHAR (50)  NULL,
    [EFFECTIVE_START]     NVARCHAR (50)  NULL,
    [EFFECTIVE_END]       NVARCHAR (50)  NULL,
    [DEST_TYPE]           NVARCHAR (50)  NULL,
    [ASSY_LOC]            NVARCHAR (50)  NULL,
    [HIER_LEVEL_1]        NVARCHAR (50)  NULL,
    [HIER_LEVEL]          NVARCHAR (50)  NULL,
    [HIER_LEVEL_3]        NVARCHAR (50)  NULL,
    [process_unit_cost]   TINYINT        NULL,
    [PRODUCT_ID]          NVARCHAR (50)  NULL,
    [FROM_LOCATION_ID]    NVARCHAR (50)  NULL,
    [TO_LOCATION_ID]      NVARCHAR (50)  NULL,
    [TRANSPORTATION_MODE] NVARCHAR (50)  NULL
);
GO

