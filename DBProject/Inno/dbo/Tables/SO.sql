CREATE TABLE [dbo].[SO] (
    [Creation_Date]      NVARCHAR (50) NOT NULL,
    [SONumber]           NVARCHAR (50) NOT NULL,
    [Customer_PO]        NVARCHAR (50) NOT NULL,
    [CustomerCode]       NVARCHAR (50) NOT NULL,
    [CustomerName]       NVARCHAR (50) NOT NULL,
    [PN]                 NVARCHAR (50) NOT NULL,
    [IndustrialStandard] NVARCHAR (50) NOT NULL,
    [Description]        NVARCHAR (50) NOT NULL,
    [客户物料编号]             NVARCHAR (50) NOT NULL,
    [Description2]       NVARCHAR (50) NOT NULL,
    [DeliveryDate]       NVARCHAR (50) NOT NULL,
    [销售员姓名]              NVARCHAR (50) NOT NULL,
    [UnmetQuantity]      FLOAT (53)    NOT NULL
);
GO

