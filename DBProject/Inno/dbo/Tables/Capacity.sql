CREATE TABLE [dbo].[Capacity] (
    [model]    NVARCHAR (50) NOT NULL,
    [process]  NVARCHAR (50) NOT NULL,
    [start]    NVARCHAR (50) NOT NULL,
    [end]      NVARCHAR (50) NOT NULL,
    [capacity] BIGINT        NOT NULL,
    [uom]      NVARCHAR (50) NOT NULL,
    [plant]    NVARCHAR (50) NOT NULL
);
GO

