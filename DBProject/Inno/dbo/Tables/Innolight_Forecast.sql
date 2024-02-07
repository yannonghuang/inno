CREATE TABLE [dbo].[Innolight_Forecast] (
    [DATE_ID]          NVARCHAR (50) NULL,
    [FG_PN]            NVARCHAR (50) NULL,
    [DP_PN_Desc]       NVARCHAR (50) NULL,
    [WO_Model]         NVARCHAR (50) NULL,
    [MPS_Model]        NVARCHAR (50) NULL,
    [Sold_to_customer] NVARCHAR (50) NULL,
    [Country]          NVARCHAR (50) NULL,
    [STAT_FCST]        FLOAT (53)    NULL,
    [STAT_PROBABILITY] FLOAT (53)    NULL
);
GO

