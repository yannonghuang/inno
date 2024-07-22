CREATE TABLE [dbo].[Shipments] (
    [Customer_ID]        NVARCHAR (50) NOT NULL,
    [CustomerName]       NVARCHAR (50) NOT NULL,
    [PRODUCT_ID]         NVARCHAR (50) NOT NULL,
    [IndustrialStandard] NVARCHAR (50) NOT NULL,
    [PO_Delivery_Date]   NVARCHAR (50) NOT NULL,
    [PO_Quantity]        FLOAT (53)    NOT NULL,
    [Quantity]           FLOAT (53)    NOT NULL,
    [DATE_ID_SHIPPED]    NVARCHAR (50) NOT NULL
);
GO

