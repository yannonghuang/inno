CREATE TABLE [dbo].[adx_resource] (
    [RESOURCE_ID]      NVARCHAR (50) NULL,
    [DESCRIPTION]      NVARCHAR (50) NULL,
    [LOCATION]         NVARCHAR (50) NULL,
    [RES_TYPE]         NVARCHAR (50) NULL,
    [BATCH_PERIOD]     NVARCHAR (50) NULL,
    [BATCH_TYPE]       NVARCHAR (50) NULL,
    [AVG_BATCH_VOLUME] NVARCHAR (50) NULL,
    [MIN_BATCH_VOLUME] NVARCHAR (50) NULL,
    [MAX_BATCH_VOLUME] NVARCHAR (50) NULL,
    [SPEED_FACTOR]     NVARCHAR (50) NULL,
    [MULTI_RES_FACTOR] TINYINT       NULL,
    [CARE]             TINYINT       NULL,
    [DELAY_ALLOWED]    NVARCHAR (50) NULL,
    [PERIOD_MGR_ID]    NVARCHAR (50) NULL,
    [SETUP_MATRIX_ID]  NVARCHAR (50) NULL,
    [CAPABLE_TYPE]     NVARCHAR (50) NULL,
    [MIX_TYPE]         NVARCHAR (50) NULL,
    [HIER_LEVEL_1]     NVARCHAR (50) NULL,
    [HIER_LEVEL_2]     NVARCHAR (50) NULL,
    [HIER_LEVEL_3]     NVARCHAR (50) NULL,
    [OpOverrideType]   NVARCHAR (50) NULL,
    [HIER_LEVEL_3_bak] NVARCHAR (50) NULL,
    [HIER_LEVEL_1_bak] NVARCHAR (50) NULL
);
GO
