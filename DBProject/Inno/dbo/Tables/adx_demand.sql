CREATE TABLE [dbo].[adx_demand] (
    [DEMAND_ID]            NVARCHAR (50)  NULL,
    [DESCRIPTION]          NVARCHAR (150) NULL,
    [CUSTOMER_ID]          NVARCHAR (50)  NULL,
    [STATUS]               NVARCHAR (50)  NULL,
    [PRIORITY]             NVARCHAR (50)  NULL,
    [REQ_DUE_DATE]         NVARCHAR (50)  NULL,
    [COMMITTED_DUE_TIME]   NVARCHAR (50)  NULL,
    [PRODUCT_ID]           NVARCHAR (50)  NULL,
    [LOCATION_ID]          NVARCHAR (50)  NULL,
    [QUANTITY]             NVARCHAR (50)  NULL,
    [LATE_DEMAND_PENALTY]  NVARCHAR (50)  NULL,
    [SHORT_DEMAND_PENALTY] NVARCHAR (50)  NULL,
    [REVENUE]              NVARCHAR (50)  NULL,
    [ALLOCATION_S]         NVARCHAR (50)  NULL,
    [DM_SPEC_S]            NVARCHAR (50)  NULL,
    [ASSY_LOC_S]           NVARCHAR (50)  NULL,
    [FAB_LOC_S]            NVARCHAR (50)  NULL,
    [DEMAND_ID_S]          NVARCHAR (50)  NULL,
    [WIRE_COLOR_S]         NVARCHAR (50)  NULL,
    [REQUEST_DUE_TIME]     NVARCHAR (50)  NULL,
    [ID]                   NVARCHAR (50)  NULL,
    [PACKAGE]              NVARCHAR (50)  NULL
);
GO

