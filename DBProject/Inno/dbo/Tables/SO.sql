CREATE TABLE [dbo].[SO] (
    [Creation_Date]      NVARCHAR (50)  NOT NULL,
    [Sales_Channel]      NVARCHAR (50)  NOT NULL,
    [订单类型描述]             NVARCHAR (50)  NOT NULL,
    [CustomerCode]       NVARCHAR (50)  NOT NULL,
    [CustomerName]       NVARCHAR (50)  NOT NULL,
    [注释]                 NVARCHAR (50)  NULL,
    [Series]             NVARCHAR (50)  NOT NULL,
    [PN]                 NVARCHAR (50)  NOT NULL,
    [Model]              NVARCHAR (100) NOT NULL,
    [Description]        NVARCHAR (50)  NOT NULL,
    [物料组2描述]             NVARCHAR (50)  NOT NULL,
    [物料组3描述]             NVARCHAR (1)   NULL,
    [物料短描述]              NVARCHAR (50)  NOT NULL,
    [DeliveryDate0]      NVARCHAR (50)  NULL,
    [DeliveryQuantity]   NVARCHAR (50)  NOT NULL,
    [Revenue]            NVARCHAR (1)   NULL,
    [UnmetQuantity]      NVARCHAR (50)  NOT NULL,
    [SONumber]           NVARCHAR (50)  NOT NULL,
    [CompanyCode]        NVARCHAR (50)  NOT NULL,
    [SystemSONumber]     NVARCHAR (50)  NOT NULL,
    [ItemId]             NVARCHAR (50)  NOT NULL,
    [CompanyName]        NVARCHAR (50)  NOT NULL,
    [IndustrialStandard] NVARCHAR (50)  NOT NULL,
    [CustomerPN]         NVARCHAR (50)  NOT NULL,
    [Quantity]           NVARCHAR (50)  NOT NULL,
    [Currency]           NVARCHAR (50)  NOT NULL,
    [DeliveryDate]       NVARCHAR (50)  NOT NULL,
    [销售员姓名]              NVARCHAR (50)  NOT NULL,
    [拒绝原因描述]             NVARCHAR (50)  NULL,
    [创建人]                NVARCHAR (50)  NOT NULL
);
GO

