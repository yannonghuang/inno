CREATE TABLE [dbo].[production_order] (
    [Creation_Date]            DATE          NULL,
    [WO]                       NVARCHAR (50) NULL,
    [Type]                     NVARCHAR (50) NULL,
    [PN]                       NVARCHAR (50) NULL,
    [Description]              NVARCHAR (50) NULL,
    [Plant]                    NVARCHAR (50) NULL,
    [Quantity_GMEIN]           NVARCHAR (50) NULL,
    [Delivered_Quantity_GMEIN] FLOAT (53)    NULL,
    [UOM_GMEIN]                NVARCHAR (50) NULL,
    [Start_Date]               DATE          NULL,
    [Due_Date]                 DATE          NULL,
    [Status]                   NVARCHAR (50) NULL,
    [输入者]                      NVARCHAR (50) NULL,
    [Reserved_Number]          INT           NULL,
    [Group]                    NVARCHAR (50) NULL,
    [Process]                  NVARCHAR (50) NULL,
    [Storage]                  NVARCHAR (50) NULL,
    [Actual_Assigned_Date]     DATE          NULL,
    [Actual_Finished_Date]     DATE          NULL,
    [Scrap_GMEIN]              FLOAT (53)    NULL,
    [Actual_Start_Date]        DATE          NULL
);
GO

