CREATE TABLE [dbo].[customer] (
    [Sold_to_customer]         NVARCHAR (50) NOT NULL,
    [Ship_to_customer]         NVARCHAR (50) NOT NULL,
    [Name]                     NVARCHAR (50) NOT NULL,
    [Country]                  NVARCHAR (50) NOT NULL,
    [abbreviate_customer_code] NVARCHAR (50) NOT NULL
);
GO

