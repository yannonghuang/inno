CREATE TABLE [dbo].[Innolight_Forecast] (
    [DATE_ID]          NVARCHAR (50) NOT NULL,
    [FG_PN]            NVARCHAR (50) NOT NULL,
    [DP_PN_Desc]       NVARCHAR (50) NOT NULL,
    [WO_Model]         NVARCHAR (50) NOT NULL,
    [MPS_Model]        NVARCHAR (50) NOT NULL,
    [Sold_to_customer] NVARCHAR (50) NOT NULL,
    [Country]          NVARCHAR (50) NOT NULL,
    [STAT_FCST]        FLOAT (53)    NOT NULL,
    [STAT_PROBABILITY] FLOAT (53)    NOT NULL
);
GO

