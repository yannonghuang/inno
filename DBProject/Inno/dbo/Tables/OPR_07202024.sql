CREATE TABLE [dbo].[OPR_07202024] (
    [Plant]       NVARCHAR (50) NOT NULL,
    [Storage]     SMALLINT      NOT NULL,
    [申请人]         NVARCHAR (50) NOT NULL,
    [请求日期]        NVARCHAR (50) NOT NULL,
    [更改日期]        NVARCHAR (50) NOT NULL,
    [采购申请]        BIGINT        NOT NULL,
    [项目]          SMALLINT      NOT NULL,
    [PN]          NVARCHAR (50) NOT NULL,
    [版次]          NVARCHAR (50) NOT NULL,
    [Description] NVARCHAR (50) NOT NULL,
    [Quantity]    NVARCHAR (50) NOT NULL,
    [UOM]         NVARCHAR (50) NOT NULL,
    [Supply_Date] NVARCHAR (50) NOT NULL
);
GO

