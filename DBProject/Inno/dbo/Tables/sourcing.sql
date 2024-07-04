CREATE TABLE [dbo].[sourcing] (
    [CASE]                     NVARCHAR (50) NOT NULL,
    [ROLE]                     NVARCHAR (50) NOT NULL,
    [COMLOCATION_UDA_LOCATION] NVARCHAR (50) NOT NULL,
    [COMLOCATION_UDA_SUFFIX]   NVARCHAR (50) NOT NULL,
    [METHOD_UDA_SRC_CON]       NVARCHAR (50) NOT NULL,
    [RULE_1]                   NVARCHAR (50) NOT NULL,
    [RULE_2]                   NVARCHAR (50) NOT NULL,
    [UOM]                      NVARCHAR (50) NOT NULL,
    [START]                    NVARCHAR (50) NOT NULL,
    [END]                      NVARCHAR (50) NOT NULL,
    [COP_PENALTY_COST]         NVARCHAR (50) NOT NULL
);
GO

