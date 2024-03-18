CREATE TABLE [dbo].[original_BOM_5000_bom] (
    [Plant]            NVARCHAR (50) NOT NULL,
    [FG]               NVARCHAR (50) NOT NULL,
    [旧的物料编号]           NVARCHAR (1)  NULL,
    [FGDescription]    NVARCHAR (50) NOT NULL,
    [FGDescription2]   NVARCHAR (1)  NULL,
    [成品尺寸]             NVARCHAR (1)  NULL,
    [BOMLevel]         FLOAT (53)    NOT NULL,
    [BOMVersion]       TINYINT       NOT NULL,
    [可选文本]             NVARCHAR (1)  NULL,
    [基本数量]             FLOAT (53)    NOT NULL,
    [项目编号]             TINYINT       NOT NULL,
    [SubstituteGroup]  NVARCHAR (50) NULL,
    [Priority]         TINYINT       NOT NULL,
    [Usage]            TINYINT       NOT NULL,
    [partnumber]       NVARCHAR (50) NOT NULL,
    [BOM物料单]           INT           NULL,
    [组]                INT           NULL,
    [生产版本]             NVARCHAR (1)  NULL,
    [特定工厂物料状态]         NVARCHAR (1)  NULL,
    [成本收集器订单号]         NVARCHAR (1)  NULL,
    [初始估算成功日期]         NVARCHAR (1)  NULL,
    [是否仍需初始估算]         NVARCHAR (1)  NULL,
    [是否已成本估算]          NVARCHAR (50) NULL,
    [组件旧物料号]           NVARCHAR (1)  NULL,
    [PartDescription]  NVARCHAR (50) NOT NULL,
    [PartDescription2] NVARCHAR (1)  NULL,
    [组件尺寸]             NVARCHAR (1)  NULL,
    [projecttype]      NVARCHAR (50) NULL,
    [组件数量]             FLOAT (53)    NOT NULL,
    [Scrap]            NVARCHAR (50) NOT NULL,
    [UOM]              NVARCHAR (50) NOT NULL,
    [中止指示符]            NVARCHAR (1)  NULL,
    [中断日期]             NVARCHAR (1)  NULL,
    [后续物料]             NVARCHAR (1)  NULL,
    [项目文本行1]           NVARCHAR (1)  NULL,
    [项目文本行_2]          NVARCHAR (1)  NULL,
    [项目长文本]            NVARCHAR (1)  NULL,
    [ParentPart]       NVARCHAR (50) NULL,
    [成本核算标识相关]         NVARCHAR (50) NULL,
    [错误]               NVARCHAR (1)  NULL,
    [组件采购组]            NVARCHAR (50) NULL,
    [组件采购类型]           NVARCHAR (50) NOT NULL,
    [组件特殊采购类型]         TINYINT       NULL,
    [调拨工厂]             SMALLINT      NULL,
    [标准采购信息记录]         NVARCHAR (50) NULL,
    [外协采购信息记录]         NVARCHAR (1)  NULL,
    [组2]               NVARCHAR (1)  NULL,
    [操作_活动]            NVARCHAR (1)  NULL,
    [长描述]              NVARCHAR (1)  NULL,
    [插件]               NVARCHAR (1)  NULL,
    [反冲]               NVARCHAR (1)  NULL,
    [供应商]              NVARCHAR (1)  NULL,
    [供应商名称]            NVARCHAR (1)  NULL,
    [组件库存]             FLOAT (53)    NOT NULL,
    [未清采购订单数量]         TINYINT       NOT NULL,
    [图号]               NVARCHAR (1)  NULL,
    [生产商_制造商]          NVARCHAR (1)  NULL,
    [产地]               NVARCHAR (1)  NULL,
    [componenttype]    NVARCHAR (50) NULL,
    [创建日期]             NVARCHAR (1)  NULL,
    [计划交货日期]           TINYINT       NOT NULL,
    [专用_通用]            NVARCHAR (1)  NULL
);
GO

