CREATE TABLE [dbo].[ADX_PRODAREA] (
    [MODEL_ID]          NVARCHAR (100) NULL,
    [PRODAREA]          NVARCHAR (255) NULL,
    [RESOLUTION]        INT            NULL,
    [BUILD_PERIOD]      INT            NULL,
    [TIME_FENCE]        INT            NULL,
    [CYCLE_TIME_TYPE]   NVARCHAR (255) NULL,
    [CYCLE_TIME_FAMILY] INT            NULL,
    [SHARE_FLAG]        INT            NULL,
    [MIX]               INT            NULL,
    [DATA_LAST_UPDATED] NVARCHAR (50)  NULL
);
GO

