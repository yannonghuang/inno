CREATE TABLE [dbo].[OPO] (
    [Plant]       SMALLINT      NULL,
    [删除标识]        NVARCHAR (1)  NULL,
    [凭证日期]        NVARCHAR (50) NULL,
    [采购凭证]        NVARCHAR (50) NULL,
    [项目]          SMALLINT      NULL,
    [PN]          NVARCHAR (50) NULL,
    [库存地点]        NVARCHAR (50) NULL,
    [Quantity]    INT           NULL,
    [仍要交货_数量]     INT           NULL,
    [短文本]         NVARCHAR (50) NULL,
    [订单单位]        NVARCHAR (50) NULL,
    [采购组]         NVARCHAR (50) NULL,
    [项目类别]        TINYINT       NULL,
    [物料组]         NVARCHAR (50) NULL,
    [Vendor]      NVARCHAR (50) NULL,
    [Vendor_Name] NVARCHAR (50) NULL
);
GO

