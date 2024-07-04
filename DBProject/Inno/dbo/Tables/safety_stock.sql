CREATE TABLE [dbo].[safety_stock] (
    [PRODUCT_ID]   NVARCHAR (50) NOT NULL,
    [LOCATION_ID]  NVARCHAR (50) NOT NULL,
    [START_DATE]   NVARCHAR (50) NOT NULL,
    [END_DATE]     NVARCHAR (50) NOT NULL,
    [SAFETY_LEVEL] NVARCHAR (50) NOT NULL,
    [SAFETY_POC]   NVARCHAR (50) NOT NULL,
    [PENALTY_100]  NVARCHAR (50) NOT NULL,
    [PENALTY_80]   NVARCHAR (50) NOT NULL,
    [PENALTY_50]   NVARCHAR (50) NOT NULL
);
GO
