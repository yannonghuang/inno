CREATE TABLE [dbo].[BOM_Single_Level] (
    [FG]        NVARCHAR (50) NULL,
    [版次]        NVARCHAR (50) NULL,
    [物料描述]      NVARCHAR (50) NULL,
    [工厂]        SMALLINT      NULL,
    [BOM用途]     TINYINT       NULL,
    [创建日期]      DATE          NULL,
    [修改日期]      DATE          NULL,
    [component] NVARCHAR (50) NULL,
    [版次2]       NVARCHAR (50) NULL,
    [组件描述]      NVARCHAR (50) NULL,
    [quantity]  FLOAT (53)    NULL,
    [超领率]       FLOAT (53)    NULL,
    [UOM]       NVARCHAR (50) NULL,
    [采购类型]      NVARCHAR (50) NULL,
    [优先级]       TINYINT       NULL,
    [替代组]       NVARCHAR (50) NULL,
    [使用可能性]     TINYINT       NULL,
    [ICT项目类别]   NVARCHAR (50) NULL,
    [排序字符串]     NVARCHAR (50) NULL,
    [项目文本行_2]   NVARCHAR (50) NULL,
    [策略]        TINYINT       NULL,
    [与核算成本相关标识] NVARCHAR (50) NULL,
    [项目文本行1]    NVARCHAR (50) NULL,
    [生产仓储地点]    SMALLINT      NULL
);
GO

