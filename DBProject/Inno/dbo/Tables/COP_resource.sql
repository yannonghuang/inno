CREATE TABLE [dbo].[COP_resource] (
    [RESOURCE_ID]       NVARCHAR (50) NOT NULL,
    [LOCATION_ID]       SMALLINT      NOT NULL,
    [RES_TYPE]          NVARCHAR (50) NOT NULL,
    [CARE]              NVARCHAR (1)  NULL,
    [PERIOD_MGR_ID]     NVARCHAR (1)  NULL,
    [DESCRIPTION]       NVARCHAR (1)  NULL,
    [Month_Capacity_H]  FLOAT (53)    NOT NULL,
    [Number_of_station] FLOAT (53)    NOT NULL,
    [column9]           NVARCHAR (1)  NULL
);
GO

