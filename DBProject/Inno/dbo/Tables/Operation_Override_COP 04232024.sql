CREATE TABLE [dbo].[Operation_Override_COP 04232024] (
    [Pocess]         NVARCHAR (50) NOT NULL,
    [OPERATION_ID]   NVARCHAR (50) NOT NULL,
    [Labor_UPH]      NVARCHAR (50) NOT NULL,
    [Machine_UPH]    NVARCHAR (50) NULL,
    [UPH]            NVARCHAR (50) NOT NULL,
    [runtime]        NVARCHAR (50) NOT NULL,
    [preprocessing]  NVARCHAR (50) NULL,
    [postprocessing] NVARCHAR (50) NULL
);
GO

