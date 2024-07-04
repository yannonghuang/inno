CREATE TABLE [dbo].[adx_op_override] (
    [OPERATION_ID]             NVARCHAR (50) NULL,
    [PRODUCT_ID]               NVARCHAR (50) NULL,
    [RESOURCE_ID]              NVARCHAR (50) NULL,
    [START_DATE]               NVARCHAR (50) NULL,
    [END_DATE]                 NVARCHAR (50) NULL,
    [MIN_WAIT_TIME]            NVARCHAR (50) NULL,
    [MAX_WAIT_TIME]            NVARCHAR (50) NULL,
    [DEFAULT_SETUP_TIME]       NVARCHAR (50) NULL,
    [PROCESS_TIME_FIRST_BATCH] NVARCHAR (50) NULL,
    [PROCESS_TIME_FIRST_UNIT]  NVARCHAR (50) NULL,
    [UPH]                      NVARCHAR (50) NULL,
    [POST_PROCESSING_TIME]     NVARCHAR (50) NULL,
    [BATCH_SCALE_FACTOR]       NVARCHAR (50) NULL,
    [YIELD_FACTOR]             NVARCHAR (50) NULL,
    [YIELD_LOST_QTY]           NVARCHAR (50) NULL,
    [BORA_ID]                  NVARCHAR (50) NULL,
    [SETUP_TYPE]               NVARCHAR (50) NULL,
    [PROCESS_TYPE]             NVARCHAR (50) NULL,
    [CAPABLE_TYPE]             NVARCHAR (50) NULL,
    [TRANSFER_LOT_SIZE]        NVARCHAR (50) NULL
);
GO

