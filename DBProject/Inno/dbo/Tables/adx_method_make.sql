CREATE TABLE [dbo].[adx_method_make] (
    [PRODUCT_ID]                          NVARCHAR (50)  NOT NULL,
    [LOCATION]                            NVARCHAR (50)  NULL,
    [ROUTE_ID]                            NVARCHAR (50)  NOT NULL,
    [PREFERENCE]                          NVARCHAR (MAX) NOT NULL,
    [COST]                                TINYINT        NOT NULL,
    [BOM_ID]                              NVARCHAR (100) NOT NULL,
    [BOG_ID]                              NVARCHAR (50)  NOT NULL,
    [EFFECTIVE_START]                     NVARCHAR (50)  NOT NULL,
    [EFFECTIVE_END]                       NVARCHAR (50)  NOT NULL,
    [HIER_LEVEL_1]                        NVARCHAR (50)  NOT NULL,
    [HIER_LEVEL]                          NVARCHAR (50)  NOT NULL,
    [HIER_LEVEL_3]                        NVARCHAR (50)  NOT NULL,
    [process_unit_cost]                   TINYINT        NOT NULL,
    [UDA_string_DMDSPEC]                  NVARCHAR (50)  NOT NULL,
    [UDA_string_to_workorder_no_ASSY_LOC] NVARCHAR (50)  NOT NULL,
    [UDA_string_to_workorder_no_FAB_LOC]  NVARCHAR (50)  NOT NULL
);
GO

