CREATE TABLE [dbo].[Production_Leadtime] (
    [Model]      NVARCHAR (50) NOT NULL,
    [Model2]     NVARCHAR (50) NOT NULL,
    [Process]    NVARCHAR (50) NOT NULL,
    [Lead_time]  FLOAT (53)    NOT NULL,
    [CFI_FAMILY] TINYINT       NOT NULL
);
GO

