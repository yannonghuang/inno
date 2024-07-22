CREATE TABLE [dbo].[production_order] (
    [Creation_Date]            NVARCHAR (50) NOT NULL,
    [WO]                       NVARCHAR (50) NOT NULL,
    [Type]                     NVARCHAR (50) NOT NULL,
    [PN]                       NVARCHAR (50) NOT NULL,
    [Description]              NVARCHAR (50) NOT NULL,
    [Plant]                    NVARCHAR (50) NOT NULL,
    [Quantity_GMEIN]           FLOAT (53)    NOT NULL,
    [Delivered_Quantity_GMEIN] FLOAT (53)    NOT NULL,
    [UOM_GMEIN]                NVARCHAR (50) NOT NULL,
    [Start_Date]               NVARCHAR (50) NOT NULL,
    [Due_Date]                 NVARCHAR (50) NOT NULL,
    [Status]                   NVARCHAR (50) NOT NULL,
    [输入者]                      NVARCHAR (50) NOT NULL,
    [Reserved_Number]          NVARCHAR (50) NOT NULL,
    [Group]                    NVARCHAR (50) NOT NULL,
    [Process]                  NVARCHAR (50) NOT NULL,
    [Storage]                  NVARCHAR (50) NULL,
    [Actual_Assigned_Date]     NVARCHAR (50) NOT NULL,
    [Actual_Finished_Date]     NVARCHAR (50) NULL,
    [Scrap_GMEIN]              FLOAT (53)    NOT NULL,
    [Actual_Start_Date]        NVARCHAR (50) NULL
);
GO

