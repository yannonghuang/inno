CREATE TABLE [dbo].[period_manager] (
    [PERIOD_MGR_ID]  NVARCHAR (50) NOT NULL,
    [HORIZON_START]  NVARCHAR (50) NOT NULL,
    [IDX]            NVARCHAR (50) NOT NULL,
    [BUCKET_TYPE]    NVARCHAR (50) NOT NULL,
    [NUMBER_BUCKETS] NVARCHAR (50) NOT NULL,
    [LATE_RANGE]     NVARCHAR (50) NOT NULL
);
GO
