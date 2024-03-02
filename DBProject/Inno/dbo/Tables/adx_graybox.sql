CREATE TABLE [dbo].[adx_graybox] (
    [CASE]                       NVARCHAR (50)  NULL,
    [CONS_ID]                    NVARCHAR (150) NULL,
    [LOCATION]                   NVARCHAR (50)  NULL,
    [COMLOCATION]                NVARCHAR (50)  NULL,
    [COMLOCATION_UDA_PROD_AREA]  NVARCHAR (50)  NULL,
    [COMLOCATION_UDA_TECHNOLOGY] NVARCHAR (50)  NULL,
    [COMLOCATION_UDA_SHARED]     NVARCHAR (50)  NULL,
    [COMLOCATION_UDA_PACKAGE]    NVARCHAR (50)  NULL,
    [CAPACITY]                   INT            NULL,
    [UOM]                        NVARCHAR (50)  NULL,
    [BUILDPOLICY]                NVARCHAR (50)  NULL,
    [BUILDEARLYLIMIT]            NVARCHAR (50)  NULL,
    [BUILD_AHEAD]                NVARCHAR (50)  NULL,
    [START]                      NVARCHAR (50)  NULL,
    [END]                        NVARCHAR (50)  NULL,
    [HIER_LEVEL_1]               NVARCHAR (50)  NULL,
    [HIER_LEVEL_2]               NVARCHAR (50)  NULL,
    [HIER_LEVEL_3]               NVARCHAR (50)  NULL,
    [COMMODITY]                  NVARCHAR (50)  NULL,
    [VENDOR]                     NVARCHAR (50)  NULL,
    [CATEGORY]                   NVARCHAR (50)  NULL,
    [RELATION]                   NVARCHAR (50)  NULL,
    [PLANNER]                    NVARCHAR (50)  NULL,
    [TIME_LEVEL]                 NVARCHAR (50)  NULL,
    [CORRESPONDS]                NVARCHAR (50)  NULL
);
GO

