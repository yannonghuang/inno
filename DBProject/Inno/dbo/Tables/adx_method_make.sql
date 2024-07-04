CREATE TABLE [dbo].[adx_method_make] (
    [PRODUCT_ID]                          NVARCHAR (50)  NULL,
    [LOCATION]                            NVARCHAR (50)  NULL,
    [ROUTE_ID]                            NVARCHAR (50)  NULL,
    [PREFERENCE]                          NVARCHAR (MAX) NULL,
    [COST]                                TINYINT        NULL,
    [BOM_ID]                              NVARCHAR (100) NULL,
    [BOG_ID]                              NVARCHAR (50)  NULL,
    [EFFECTIVE_START]                     NVARCHAR (50)  NULL,
    [EFFECTIVE_END]                       NVARCHAR (50)  NULL,
    [HIER_LEVEL_1]                        NVARCHAR (50)  NULL,
    [HIER_LEVEL]                          NVARCHAR (50)  NULL,
    [HIER_LEVEL_3]                        NVARCHAR (50)  NULL,
    [process_unit_cost]                   TINYINT        NULL,
    [UDA_string_DMDSPEC]                  NVARCHAR (50)  NULL,
    [UDA_string_to_workorder_no_ASSY_LOC] NVARCHAR (50)  NULL,
    [UDA_string_to_workorder_no_FAB_LOC]  NVARCHAR (50)  NULL,
    [LOCATION_ID]                         NVARCHAR (50)  NULL
);
GO

