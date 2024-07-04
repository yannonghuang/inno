USE [master]
GO
/****** Object:  Database [ADX_SCP_UDS]    Script Date: 5/2/2024 11:26:05 PM ******/
CREATE DATABASE [ADX_SCP_UDS]
GO

ALTER DATABASE [ADX_SCP_UDS] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ADX_SCP_UDS].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ADX_SCP_UDS] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ADX_SCP_UDS] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ADX_SCP_UDS] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ADX_SCP_UDS] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ADX_SCP_UDS] SET ARITHABORT OFF 
GO
ALTER DATABASE [ADX_SCP_UDS] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [ADX_SCP_UDS] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ADX_SCP_UDS] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ADX_SCP_UDS] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ADX_SCP_UDS] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ADX_SCP_UDS] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ADX_SCP_UDS] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ADX_SCP_UDS] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ADX_SCP_UDS] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ADX_SCP_UDS] SET  DISABLE_BROKER 
GO
ALTER DATABASE [ADX_SCP_UDS] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ADX_SCP_UDS] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ADX_SCP_UDS] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ADX_SCP_UDS] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ADX_SCP_UDS] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ADX_SCP_UDS] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ADX_SCP_UDS] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ADX_SCP_UDS] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [ADX_SCP_UDS] SET  MULTI_USER 
GO
ALTER DATABASE [ADX_SCP_UDS] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ADX_SCP_UDS] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ADX_SCP_UDS] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ADX_SCP_UDS] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [ADX_SCP_UDS] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [ADX_SCP_UDS] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [ADX_SCP_UDS] SET QUERY_STORE = OFF
GO
USE [ADX_SCP_UDS]
GO

/****** Object:  Synonym [dbo].[ADX_ATT_STG_CLASS_CATALOG]    Script Date: 5/2/2024 11:26:05 PM ******/
--CREATE SYNONYM [dbo].[ADX_ATT_STG_CLASS_CATALOG] FOR [Inno].[dbo].[ADX_ATT_STG_CLASS_CATALOG]
--GO
/****** Object:  Synonym [dbo].[ADX_ATT_STG_CORE]    Script Date: 5/2/2024 11:26:05 PM ******/
--CREATE SYNONYM [dbo].[ADX_ATT_STG_CORE] FOR [Inno].[dbo].[ADX_ATT_STG_CORE]
--GO
/****** Object:  Synonym [dbo].[ADX_ATT_UDS_CLASS_CATALOG]    Script Date: 5/2/2024 11:26:05 PM ******/
--CREATE SYNONYM [dbo].[ADX_ATT_UDS_CLASS_CATALOG] FOR [Inno].[dbo].[ADX_ATT_UDS_CLASS_CATALOG]
--GO
/****** Object:  Synonym [dbo].[ADX_ATT_UDS_CORE]    Script Date: 5/2/2024 11:26:05 PM ******/
--CREATE SYNONYM [dbo].[ADX_ATT_UDS_CORE] FOR [Inno].[dbo].[ADX_ATT_UDS_CORE]
--GO
/****** Object:  Synonym [dbo].[ADX_ATT_USER_CLASS_CATALOG]    Script Date: 5/2/2024 11:26:05 PM ******/
--CREATE SYNONYM [dbo].[ADX_ATT_USER_CLASS_CATALOG] FOR [Inno].[dbo].[ADX_ATT_USER_CLASS_CATALOG]
--GO
/****** Object:  Synonym [dbo].[ADX_ATT_USER_EDIT]    Script Date: 5/2/2024 11:26:05 PM ******/
--CREATE SYNONYM [dbo].[ADX_ATT_USER_EDIT] FOR [Inno].[dbo].[ADX_ATT_USER_EDIT]
--GO
/****** Object:  Synonym [dbo].[ADX_ATT_USER_TYPE_CATALOG]    Script Date: 5/2/2024 11:26:05 PM ******/
--CREATE SYNONYM [dbo].[ADX_ATT_USER_TYPE_CATALOG] FOR [Inno].[dbo].[ADX_ATT_USER_TYPE_CATALOG]
--GO
/****** Object:  Synonym [dbo].[ADX_BOM]    Script Date: 5/2/2024 11:26:05 PM ******/
/****** Object:  Synonym [dbo].[ADX_BOR]    Script Date: 5/2/2024 11:26:05 PM ******/
/****** Object:  Synonym [dbo].[ADX_BORA]    Script Date: 5/2/2024 11:26:05 PM ******/
/****** Object:  Synonym [dbo].[ADX_CAPPATTERN]    Script Date: 5/2/2024 11:26:05 PM ******/
/****** Object:  Synonym [dbo].[ADX_CFI]    Script Date: 5/2/2024 11:26:05 PM ******/
/****** Object:  Synonym [dbo].[ADX_CUSTOMER]    Script Date: 5/2/2024 11:26:05 PM ******/
/****** Object:  Synonym [dbo].[ADX_DATA_ERROR_CODE]    Script Date: 5/2/2024 11:26:05 PM ******/
--CREATE SYNONYM [dbo].[ADX_DATA_ERROR_CODE] FOR [Inno].[dbo].[ADX_DATA_ERROR_CODE]
--GO
/****** Object:  Synonym [dbo].[ADX_DATA_ERROR_LOG]    Script Date: 5/2/2024 11:26:05 PM ******/
--CREATE SYNONYM [dbo].[ADX_DATA_ERROR_LOG] FOR [Inno].[dbo].[ADX_DATA_ERROR_LOG]
--GO
/****** Object:  Synonym [dbo].[ADX_DEMAND]    Script Date: 5/2/2024 11:26:05 PM ******/
/****** Object:  Synonym [dbo].[ADX_DEMAND_UNC]    Script Date: 5/2/2024 11:26:05 PM ******/
--CREATE SYNONYM [dbo].[ADX_DEMAND_UNC] FOR [Inno].[dbo].[ADX_DEMAND_UNC]
--GO
/****** Object:  Synonym [dbo].[ADX_ERROR_CONTROL]    Script Date: 5/2/2024 11:26:05 PM ******/
--CREATE SYNONYM [dbo].[ADX_ERROR_CONTROL] FOR [Inno].[dbo].[ADX_ERROR_CONTROL]
--GO
/****** Object:  Synonym [dbo].[ADX_HOLIDAY]    Script Date: 5/2/2024 11:26:05 PM ******/
--CREATE SYNONYM [dbo].[ADX_HOLIDAY] FOR [Inno].[dbo].[ADX_HOLIDAY]
--GO
/****** Object:  Synonym [dbo].[ADX_LOCATION]    Script Date: 5/2/2024 11:26:05 PM ******/
/****** Object:  Synonym [dbo].[ADX_METHOD_BUY]    Script Date: 5/2/2024 11:26:05 PM ******/
/****** Object:  Synonym [dbo].[ADX_METHOD_MAKE]    Script Date: 5/2/2024 11:26:05 PM ******/
/****** Object:  Synonym [dbo].[ADX_MODEL_BUILD_PARAMETERS]    Script Date: 5/2/2024 11:26:05 PM ******/
--CREATE SYNONYM [dbo].[ADX_MODEL_BUILD_PARAMETERS] FOR [Inno].[dbo].[ADX_MODEL_BUILD_PARAMETERS]
--GO
/****** Object:  Synonym [dbo].[ADX_OPEN_SALES_ORDERS]    Script Date: 5/2/2024 11:26:05 PM ******/
--CREATE SYNONYM [dbo].[ADX_OPEN_SALES_ORDERS] FOR [Inno].[dbo].[ADX_OPEN_SALES_ORDERS]
--GO
/****** Object:  Synonym [dbo].[ADX_OPERATION]    Script Date: 5/2/2024 11:26:05 PM ******/
/****** Object:  Synonym [dbo].[ADX_OPERATION_OVERRIDE]    Script Date: 5/2/2024 11:26:05 PM ******/
/****** Object:  Synonym [dbo].[ADX_OPERATION_OVERRIDE_TEST]    Script Date: 5/2/2024 11:26:05 PM ******/
--CREATE SYNONYM [dbo].[ADX_OPERATION_OVERRIDE_TEST] FOR [Inno].[dbo].[ADX_OPERATION_OVERRIDE_TEST]
--GO
/****** Object:  Synonym [dbo].[ADX_PERIOD_MANAGER]    Script Date: 5/2/2024 11:26:05 PM ******/
/****** Object:  Synonym [dbo].[ADX_PROCESS_CONTROL]    Script Date: 5/2/2024 11:26:05 PM ******/
--CREATE SYNONYM [dbo].[ADX_PROCESS_CONTROL] FOR [Inno].[dbo].[ADX_PROCESS_CONTROL]
--GO
/****** Object:  Synonym [dbo].[ADX_PROCESS_HISTORY]    Script Date: 5/2/2024 11:26:05 PM ******/
--CREATE SYNONYM [dbo].[ADX_PROCESS_HISTORY] FOR [Inno].[dbo].[ADX_PROCESS_HISTORY]
--GO
/****** Object:  Synonym [dbo].[ADX_PRODUCT]    Script Date: 5/2/2024 11:26:05 PM ******/
/****** Object:  Synonym [dbo].[ADX_PRODUCTLOCATION]    Script Date: 5/2/2024 11:26:05 PM ******/
/****** Object:  Synonym [dbo].[ADX_RESALT]    Script Date: 5/2/2024 11:26:05 PM ******/
/****** Object:  Synonym [dbo].[ADX_RESCAPEXC]    Script Date: 5/2/2024 11:26:05 PM ******/
/****** Object:  Synonym [dbo].[ADX_RESCAPINTER]    Script Date: 5/2/2024 11:26:05 PM ******/
/****** Object:  Synonym [dbo].[ADX_RESOURCE]    Script Date: 5/2/2024 11:26:05 PM ******/
/****** Object:  Synonym [dbo].[ADX_ROUTE]    Script Date: 5/2/2024 11:26:05 PM ******/
/****** Object:  Synonym [dbo].[ADX_SAFETY_STOCK]    Script Date: 5/2/2024 11:26:05 PM ******/
/****** Object:  Synonym [dbo].[ADX_SHIPMENTS]    Script Date: 5/2/2024 11:26:05 PM ******/
--CREATE SYNONYM [dbo].[ADX_SHIPMENTS] FOR [Inno].[dbo].[ADX_SHIPMENTS]
--GO
/****** Object:  Synonym [dbo].[ADX_SUPPLY]    Script Date: 5/2/2024 11:26:05 PM ******/
/****** Object:  Synonym [dbo].[ADX_TABLE_COUNT]    Script Date: 5/2/2024 11:26:05 PM ******/
--CREATE SYNONYM [dbo].[ADX_TABLE_COUNT] FOR [Inno].[dbo].[ADX_TABLE_COUNT]
--GO
/****** Object:  Synonym [dbo].[ADX_TRANS_METHODS]    Script Date: 5/2/2024 11:26:05 PM ******/
--CREATE SYNONYM [dbo].[ADX_TRANS_METHODS] FOR [Inno].[dbo].[ADX_TRANS_METHODS]
--GO
/****** Object:  Synonym [dbo].[ADX_TRANSPORTATION]    Script Date: 5/2/2024 11:26:05 PM ******/
/****** Object:  Synonym [dbo].[ADX_UDA]    Script Date: 5/2/2024 11:26:05 PM ******/
/****** Object:  Synonym [dbo].[ADX_VENDOR]    Script Date: 5/2/2024 11:26:05 PM ******/
/****** Object:  Synonym [dbo].[ADX_WIP]    Script Date: 5/2/2024 11:26:05 PM ******/
--CREATE SYNONYM [dbo].[ADX_WIP] FOR [Inno].[dbo].[ADX_WIP]
--GO
/****** Object:  Synonym [dbo].[ADX_WORKORDERS]    Script Date: 5/2/2024 11:26:05 PM ******/
--CREATE SYNONYM [dbo].[ADX_WORKORDERS] FOR [Inno].[dbo].[ADX_WORKORDERS]
--GO

/****** Object:  UserDefinedFunction [dbo].[CHARINDEXn]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  UserDefinedFunction [dbo].[GET_BUSINESS_MODEL]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  UserDefinedFunction [dbo].[GET_HORIZONBEYOND]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  UserDefinedFunction [dbo].[GET_HORIZONEND]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  UserDefinedFunction [dbo].[GET_HORIZONSTART]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



/****** Object:  UserDefinedFunction [dbo].[GET_INCRLOTSIZE]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  UserDefinedFunction [dbo].[GET_MAXLOTSIZE]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  UserDefinedFunction [dbo].[GET_MINLOTSIZE]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Object:  UserDefinedFunction [dbo].[GET_MODEL_ID]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  UserDefinedFunction [dbo].[GET_PERIODMANAGER]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  UserDefinedFunction [dbo].[GET_PLAN_ID]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Object:  UserDefinedFunction [dbo].[GET_PRODLOCSEPARATOR]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  UserDefinedFunction [dbo].[GET_STDLOTSIZE]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Object:  UserDefinedFunction [dbo].[GREATEST_DATE]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  UserDefinedFunction [dbo].[GREATEST_VALUE]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Object:  UserDefinedFunction [dbo].[IS_VALID_DATE_FORMAT]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Object:  UserDefinedFunction [dbo].[IS_VALID_NUMBER]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Object:  UserDefinedFunction [dbo].[LEAST_DATE]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  UserDefinedFunction [dbo].[LEAST_VALUE]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/****** Object:  UserDefinedFunction [dbo].[NEXT_DAY]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  UserDefinedFunction [dbo].[PREV_DATE_OF_DAY]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  View [dbo].[SCP_PRODUCT]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/****** Object:  View [dbo].[SCP_PRODUCTLOCATION]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/****** Object:  Table [dbo].[ActLots_CONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ActLots_DSM]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ActLots_DSM_PUBLISH]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ActLots_DSM2]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ActLots_M2U]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ActLots_UNCONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ADX_TEMP_FCST_NETTING_NETTED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ADX_TEMP_FORECAST_NETTING]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ADX_TEMP_FORECAST_NETTING_SUD]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[BatchId_CONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[BatchId_DSM]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[BatchId_DSM_PUBLISH]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[BatchId_DSM2]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[BatchId_M2U]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[BatchId_UNCONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[BatchIdElem_CONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[BatchIdElem_DSM]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[BatchIdElem_DSM_PUBLISH]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[BatchIdElem_DSM2]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[BatchIdElem_M2U]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[BatchIdElem_UNCONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[BoC_CONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[BoC_DSM]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[BoC_DSM_PUBLISH]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[BoC_DSM2]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[BoC_M2U]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[BoC_UNCONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[BoCElem_CONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[BoCElem_DSM]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[BoCElem_DSM_PUBLISH]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[BoCElem_DSM2]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[BoCElem_M2U]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[BoCElem_UNCONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[BoG_CONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[BoG_DSM]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[BoG_DSM_PUBLISH]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[BoG_DSM2]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[BoG_M2U]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[BoG_UNCONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[BoGElem_CONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[BoGElem_DSM]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[BoGElem_DSM_PUBLISH]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[BoGElem_DSM2]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[BoGElem_M2U]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[BoGElem_UNCONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[BoM_CONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[BoM_DSM]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[BoM_DSM_PUBLISH]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[BoM_DSM2]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[BoM_M2U]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[BoM_UNCONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[BoMElem_CONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[BoMElem_DSM]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[BoMElem_DSM_PUBLISH]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[BoMElem_DSM2]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[BoMElem_M2U]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[BoMElem_UNCONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[BoMElemProperty_CONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[BoMElemProperty_DSM]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[BoMElemProperty_DSM_PUBLISH]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[BoMElemProperty_DSM2]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[BoMElemProperty_M2U]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[BoMElemProperty_UNCONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[BoR_CONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[BoR_DSM]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[BoR_DSM_PUBLISH]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[BoR_DSM2]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[BoR_M2U]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[BoR_UNCONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[BoRAlt_CONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[BoRAlt_DSM]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[BoRAlt_DSM_PUBLISH]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[BoRAlt_DSM2]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[BoRAlt_M2U]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[BoRAlt_UNCONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[BoRAltElem_CONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[BoRAltElem_DSM]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[BoRAltElem_DSM_PUBLISH]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[BoRAltElem_DSM2]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[BoRAltElem_M2U]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[BoRAltElem_UNCONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[BoRElem_CONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[BoRElem_DSM]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[BoRElem_DSM_PUBLISH]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[BoRElem_DSM2]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[BoRElem_M2U]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[BoRElem_UNCONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[BorPerCap_CONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[BorPerCap_DSM]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[BorPerCap_DSM_PUBLISH]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[BorPerCap_UNCONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[BorPerCapElem_CONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[BorPerCapElem_DSM]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[BorPerCapElem_DSM_PUBLISH]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[BorPerCapElem_UNCONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[BusinessRule_CONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[BusinessRule_DSM]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[BusinessRule_DSM_PUBLISH]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[BusinessRule_DSM2]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[BusinessRule_M2U]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[BusinessRule_UNCONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[Cal_CONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[Cal_DSM]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[Cal_DSM_PUBLISH]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[Cal_DSM2]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[Cal_M2U]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[Cal_UNCONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[CapPattern_CONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[CapPattern_DSM]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[CapPattern_DSM_PUBLISH]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[CapPattern_DSM2]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[CapPattern_M2U]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[CapPattern_UNCONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[CapPatternElem_CONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[CapPatternElem_DSM]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[CapPatternElem_DSM_PUBLISH]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[CapPatternElem_DSM2]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[CapPatternElem_M2U]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[CapPatternElem_UNCONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[CfiCycle_CONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[CfiCycle_DSM]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[CfiCycle_DSM_PUBLISH]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[CfiCycle_DSM2]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[CfiCycle_M2U]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[CfiCycle_UNCONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[CfiFactor_CONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[CfiFactor_DSM]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[CfiFactor_DSM_PUBLISH]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[CfiFactor_DSM2]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[CfiFactor_M2U]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[CfiFactor_UNCONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[CfiOverride_CONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[CfiOverride_DSM]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[CfiOverride_DSM_PUBLISH]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[CfiOverride_DSM2]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[CfiOverride_M2U]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[CfiOverride_UNCONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[CfiOverrideElem_CONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[CfiOverrideElem_DSM]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[CfiOverrideElem_DSM_PUBLISH]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[CfiOverrideElem_DSM2]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[CfiOverrideElem_M2U]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[CfiOverrideElem_UNCONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[CfiWait_CONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[CfiWait_DSM]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[CfiWait_DSM_PUBLISH]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[CfiWait_DSM2]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[CfiWait_M2U]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[CfiWait_UNCONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ComGrpElem_DSM]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ComGrpElem_M2U]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[Commodity_CONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[Commodity_DSM]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[Commodity_DSM_PUBLISH]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[Commodity_DSM2]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[Commodity_M2U]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[Commodity_UNCONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[CommodityGrades_CONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[CommodityGrades_DSM]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[CommodityGrades_DSM_PUBLISH]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[CommodityGrades_DSM2]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[CommodityGrades_M2U]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[CommodityGrades_UNCONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[Connections_CONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[Connections_DSM]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[Connections_DSM_PUBLISH]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[Connections_DSM2]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[Connections_M2U]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[Connections_UNCONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[Constraint_CONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[Constraint_DSM]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[Constraint_DSM_PUBLISH]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[Constraint_DSM2]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[Constraint_M2U]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[Constraint_UNCONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ConstraintActElem_CONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ConstraintActElem_DSM]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ConstraintActElem_DSM_PUBLISH]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ConstraintActElem_DSM2]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ConstraintActElem_M2U]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ConstraintActElem_UNCONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ConstraintElem_CONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ConstraintElem_DSM]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ConstraintElem_DSM_PUBLISH]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ConstraintElem_DSM2]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ConstraintElem_M2U]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ConstraintElem_UNCONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ConstraintOverrideEl_CONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ConstraintOverrideEl_DSM]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ConstraintOverrideEl_DSM_PUBLISH]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ConstraintOverrideEl_DSM2]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ConstraintOverrideEl_M2U]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ConstraintOverrideEl_UNCONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ConstraintTarget_CONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ConstraintTarget_DSM]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ConstraintTarget_DSM_PUBLISH]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ConstraintTarget_DSM2]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ConstraintTarget_M2U]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ConstraintTarget_UNCONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ConstraintTargetElem_CONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ConstraintTargetElem_DSM]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ConstraintTargetElem_DSM_PUBLISH]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ConstraintTargetElem_DSM2]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ConstraintTargetElem_M2U]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ConstraintTargetElem_UNCONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[CustGrpElem_DSM]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[CustGrpElem_M2U]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[Customer_CONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[Customer_DSM]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[Customer_DSM_PUBLISH]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[Customer_DSM2]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[Customer_M2U]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[Customer_UNCONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[Demand_CONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[Demand_DSM]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[Demand_DSM_PUBLISH]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[Demand_DSM2]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[Demand_M2U]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[Demand_UNCONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[DemandElem_CONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[DemandElem_DSM]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[DemandElem_DSM_PUBLISH]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[DemandElem_DSM2]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[DemandElem_M2U]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[DemandElem_UNCONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[DemandMasterElem_DSM]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[DemandMasterElem_M2U]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[DemandProperty_CONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[DemandProperty_DSM]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[DemandProperty_DSM_PUBLISH]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[DemandProperty_DSM2]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[DemandProperty_M2U]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[DemandProperty_UNCONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[DL_ADX_WIP_BKP_20240409]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[EMSCriterion_CONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[EMSCriterion_DSM]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[EMSCriterion_DSM_PUBLISH]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[EMSCriterion_DSM2]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[EMSCriterion_M2U]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[EMSCriterion_UNCONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[EMSThresCriterRankElem_CONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[EMSThresCriterRankElem_DSM]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[EMSThresCriterRankElem_DSM_PUBLISH]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[EMSThresCriterRankElem_DSM2]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[EMSThresCriterRankElem_M2U]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[EMSThresCriterRankElem_UNCONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[EMSThresholds_CONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[EMSThresholds_DSM]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[EMSThresholds_DSM_PUBLISH]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[EMSThresholds_DSM2]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[EMSThresholds_M2U]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[EMSThresholds_UNCONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[FilterRule_CONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[FilterRule_DSM]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[FilterRule_DSM_PUBLISH]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[FilterRule_DSM2]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[FilterRule_M2U]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[FilterRule_UNCONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[FilterRuleCriteria_CONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[FilterRuleCriteria_DSM]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[FilterRuleCriteria_DSM_PUBLISH]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[FilterRuleCriteria_DSM2]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[FilterRuleCriteria_M2U]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[FilterRuleCriteria_UNCONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[FutureHoldLots_CONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[FutureHoldLots_DSM]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[FutureHoldLots_DSM_PUBLISH]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[FutureHoldLots_DSM2]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[FutureHoldLots_M2U]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[FutureHoldLots_UNCONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[Holiday_CONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[Holiday_DSM]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[Holiday_DSM_PUBLISH]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[Holiday_DSM2]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[Holiday_M2U]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[Holiday_UNCONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[HolidayElem_CONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[HolidayElem_DSM]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[HolidayElem_DSM_PUBLISH]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[HolidayElem_DSM2]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[HolidayElem_M2U]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[HolidayElem_UNCONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[Inventory_CONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[Inventory_DSM]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[Inventory_DSM_PUBLISH]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[Inventory_DSM2]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[Inventory_M2U]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[Inventory_UNCONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[KeepBatch_CONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[KeepBatch_DSM]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[KeepBatch_DSM_PUBLISH]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[KeepBatch_DSM2]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[KeepBatch_M2U]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[KeepBatch_UNCONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[KeepBatchElem_CONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[KeepBatchElem_DSM]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[KeepBatchElem_DSM_PUBLISH]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[KeepBatchElem_DSM2]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[KeepBatchElem_M2U]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[KeepBatchElem_UNCONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[Location_CONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[Location_DSM]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[Location_DSM_PUBLISH]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[Location_DSM2]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[Location_M2U]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[Location_UNCONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[LotBoMSubst_CONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[LotBoMSubst_DSM]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[LotBoMSubst_DSM_PUBLISH]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[LotBoMSubst_DSM2]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[LotBoMSubst_M2U]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[LotBoMSubst_UNCONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[Method_CONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[Method_DSM]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[Method_DSM_PUBLISH]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[Method_DSM2]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[Method_M2U]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[Method_UNCONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[MethodAlt_CONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[MethodAlt_DSM]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[MethodAlt_DSM_PUBLISH]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[MethodAlt_DSM2]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[MethodAlt_M2U]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[MethodAlt_UNCONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[MethodAltElem_CONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[MethodAltElem_DSM]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[MethodAltElem_DSM_PUBLISH]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[MethodAltElem_DSM2]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[MethodAltElem_M2U]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[MethodAltElem_UNCONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ObjectCharacteristic_CONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ObjectCharacteristic_DSM]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ObjectCharacteristic_DSM_PUBLISH]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ObjectCharacteristic_DSM2]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ObjectCharacteristic_M2U]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ObjectCharacteristic_UNCONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[Op_CONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[Op_DSM]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[Op_DSM_PUBLISH]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[Op_DSM2]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[Op_M2U]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[Op_UNCONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[OpOverridesCom_CONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[OpOverridesCom_DSM]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[OpOverridesCom_DSM_PUBLISH]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[OpOverridesCom_DSM2]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[OpOverridesCom_M2U]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[OpOverridesCom_UNCONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[OpOverridesRes_CONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[OpOverridesRes_DSM]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[OpOverridesRes_DSM_PUBLISH]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[OpOverridesRes_DSM2]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[OpOverridesRes_M2U]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[OpOverridesRes_M2U_TEST]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[OpOverridesRes_UNCONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[OpOverridesString_CONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[OpOverridesString_DSM]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[OpOverridesString_DSM_PUBLISH]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[OpOverridesString_DSM2]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[OpOverridesString_M2U]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[OpOverridesString_UNCONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[OpOverridesTime_CONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[OpOverridesTime_DSM]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[OpOverridesTime_DSM_PUBLISH]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[OpOverridesTime_DSM2]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[OpOverridesTime_M2U]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[OpOverridesTime_UNCONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[OpPriorityMatrix_CONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[OpPriorityMatrix_DSM]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[OpPriorityMatrix_DSM_PUBLISH]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[OpPriorityMatrix_DSM2]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[OpPriorityMatrix_M2U]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[OpPriorityMatrix_UNCONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[Penalty_CONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[Penalty_DSM]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[Penalty_DSM_PUBLISH]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[Penalty_DSM2]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[Penalty_M2U]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[Penalty_UNCONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[PenaltyElem_CONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[PenaltyElem_DSM]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[PenaltyElem_DSM_PUBLISH]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[PenaltyElem_DSM2]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[PenaltyElem_M2U]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[PenaltyElem_UNCONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[PenaltyFunction_CONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[PenaltyFunction_DSM]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[PenaltyFunction_DSM_PUBLISH]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[PenaltyFunction_DSM2]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[PenaltyFunction_M2U]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[PenaltyFunction_UNCONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[PenaltyFunctionElem_CONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[PenaltyFunctionElem_DSM]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[PenaltyFunctionElem_DSM_PUBLISH]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[PenaltyFunctionElem_DSM2]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[PenaltyFunctionElem_M2U]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[PenaltyFunctionElem_UNCONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[PeriodMgr_CONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[PeriodMgr_DSM]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[PeriodMgr_DSM_PUBLISH]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[PeriodMgr_DSM2]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[PeriodMgr_M2U]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[PeriodMgr_UNCONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[PeriodMgrElem_CONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[PeriodMgrElem_DSM]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[PeriodMgrElem_DSM_PUBLISH]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[PeriodMgrElem_DSM2]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[PeriodMgrElem_M2U]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[PeriodMgrElem_UNCONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[PeriodOfCoverProfile_CONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[PeriodOfCoverProfile_DSM]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[PeriodOfCoverProfile_DSM_PUBLISH]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[PeriodOfCoverProfile_DSM2]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[PeriodOfCoverProfile_M2U]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[PeriodOfCoverProfile_UNCONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[PgnCaseMaster]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[PrevMain_CONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[PrevMain_DSM]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[PrevMain_DSM_PUBLISH]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[PrevMain_DSM2]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[PrevMain_M2U]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[PrevMain_UNCONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[PriorityMatrix_CONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[PriorityMatrix_DSM]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[PriorityMatrix_DSM_PUBLISH]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[PriorityMatrix_DSM2]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[PriorityMatrix_M2U]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[PriorityMatrix_UNCONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[PriorityMatrixElem_CONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[PriorityMatrixElem_DSM]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[PriorityMatrixElem_DSM_PUBLISH]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[PriorityMatrixElem_DSM2]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[PriorityMatrixElem_M2U]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[PriorityMatrixElem_UNCONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[PUBLISH_DEMAND_OVERRIDES]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[PUBLISH_PLANNED_PURCHASES]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[PUBLISH_PLANNED_PURCHASES_HISTORY]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[PUBLISH_PLANNED_WORKORDERS]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[PUBLISH_PLANNED_WORKORDERS_HISTORY]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ResAlt_CONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ResAlt_DSM]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ResAlt_DSM_PUBLISH]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ResAlt_DSM2]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ResAlt_M2U]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ResAlt_UNCONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ResAltElem_CONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ResAltElem_DSM]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ResAltElem_DSM_PUBLISH]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ResAltElem_DSM2]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ResAltElem_M2U]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ResAltElem_UNCONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ResCapExc_CONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ResCapExc_DSM]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ResCapExc_DSM_PUBLISH]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ResCapExc_DSM2]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ResCapExc_M2U]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ResCapExc_UNCONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ResCapInter_CONS_SOLVED]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ResCapInter_DSM]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ResCapInter_DSM_PUBLISH]    Script Date: 5/2/2024 11:26:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ResCapInter_DSM2]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ResCapInter_M2U]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ResCapInter_UNCONS_SOLVED]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[Resource_CONS_SOLVED]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[Resource_DSM]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[Resource_DSM_PUBLISH]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[Resource_DSM2]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[Resource_M2U]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[Resource_UNCONS_SOLVED]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ResPrevPrgrm_CONS_SOLVED]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ResPrevPrgrm_DSM]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ResPrevPrgrm_DSM_PUBLISH]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ResPrevPrgrm_DSM2]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ResPrevPrgrm_M2U]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ResPrevPrgrm_UNCONS_SOLVED]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ResTransferTime_CONS_SOLVED]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ResTransferTime_DSM]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ResTransferTime_DSM_PUBLISH]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ResTransferTime_DSM2]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ResTransferTime_M2U]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ResTransferTime_UNCONS_SOLVED]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[Route_CONS_SOLVED]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[Route_DSM]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[Route_DSM_PUBLISH]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[Route_DSM2]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[Route_M2U]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[Route_UNCONS_SOLVED]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[RouteRouteSegm_CONS_SOLVED]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[RouteRouteSegm_DSM]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[RouteRouteSegm_DSM_PUBLISH]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[RouteRouteSegm_DSM2]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[RouteRouteSegm_M2U]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[RouteRouteSegm_UNCONS_SOLVED]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[RouteSegment_CONS_SOLVED]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[RouteSegment_DSM]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[RouteSegment_DSM_PUBLISH]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[RouteSegment_DSM2]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[RouteSegment_M2U]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[RouteSegment_UNCONS_SOLVED]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[RouteSegStepSeq_CONS_SOLVED]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[RouteSegStepSeq_DSM]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[RouteSegStepSeq_DSM_PUBLISH]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[RouteSegStepSeq_DSM2]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[RouteSegStepSeq_M2U]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[RouteSegStepSeq_UNCONS_SOLVED]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[SafetyStock_CONS_SOLVED]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[SafetyStock_DSM]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[SafetyStock_DSM_PUBLISH]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[SafetyStock_DSM2]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[SafetyStock_M2U]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[SafetyStock_UNCONS_SOLVED]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[Setup_CONS_SOLVED]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[Setup_DSM]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[Setup_DSM_PUBLISH]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[Setup_DSM2]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[Setup_M2U]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[Setup_UNCONS_SOLVED]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[SetupBoRs_CONS_SOLVED]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[SetupBoRs_DSM]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[SetupBoRs_DSM_PUBLISH]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[SetupBoRs_DSM2]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[SetupBoRs_M2U]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[SetupBoRs_UNCONS_SOLVED]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[SetupMatRelation_CONS_SOLVED]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[SetupMatRelation_DSM]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[SetupMatRelation_DSM_PUBLISH]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[SetupMatRelation_DSM2]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[SetupMatRelation_M2U]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[SetupMatRelation_UNCONS_SOLVED]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[SetupMatrix_CONS_SOLVED]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[SetupMatrix_DSM]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[SetupMatrix_DSM_PUBLISH]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[SetupMatrix_DSM2]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[SetupMatrix_M2U]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[SetupMatrix_UNCONS_SOLVED]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[SetupMatrixGrpModif_CONS_SOLVED]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[SetupMatrixGrpModif_DSM]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[SetupMatrixGrpModif_DSM_PUBLISH]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[SetupMatrixGrpModif_DSM2]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[SetupMatrixGrpModif_M2U]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[SetupMatrixGrpModif_UNCONS_SOLVED]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[SetupMatrixModif_CONS_SOLVED]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[SetupMatrixModif_DSM]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[SetupMatrixModif_DSM_PUBLISH]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[SetupMatrixModif_DSM2]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[SetupMatrixModif_M2U]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[SetupMatrixModif_UNCONS_SOLVED]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[SFSActPortion_CONS_SOLVED]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[SFSActPortion_DSM]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[SFSActPortion_DSM_PUBLISH]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[SFSActPortion_DSM2]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[SFSActPortion_M2U]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[SFSActPortion_UNCONS_SOLVED]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[SFSConnections_CONS_SOLVED]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[SFSConnections_DSM]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[SFSConnections_DSM_PUBLISH]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[SFSConnections_DSM2]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[SFSConnections_M2U]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[SFSConnections_UNCONS_SOLVED]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[SFSLotAct_CONS_SOLVED]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[SFSLotAct_DSM]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[SFSLotAct_DSM_PUBLISH]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[SFSLotAct_DSM2]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[SFSLotAct_M2U]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[SFSLotAct_UNCONS_SOLVED]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[SFSResAct_CONS_SOLVED]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[SFSResAct_DSM]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[SFSResAct_DSM_PUBLISH]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[SFSResAct_DSM2]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[SFSResAct_M2U]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[SFSResAct_UNCONS_SOLVED]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[SFSResPortion_CONS_SOLVED]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[SFSResPortion_DSM]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[SFSResPortion_DSM_PUBLISH]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[SFSResPortion_DSM2]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[SFSResPortion_M2U]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[SFSResPortion_UNCONS_SOLVED]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[SFSResSched_CONS_SOLVED]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[SFSResSched_DSM]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[SFSResSched_DSM_PUBLISH]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[SFSResSched_DSM2]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[SFSResSched_M2U]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[SFSResSched_UNCONS_SOLVED]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[SFSSchedule_CONS_SOLVED]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[SFSSchedule_DSM]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[SFSSchedule_DSM_PUBLISH]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[SFSSchedule_DSM2]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[SFSSchedule_M2U]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[SFSSchedule_UNCONS_SOLVED]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[SFSUpLots_DSM]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[SFSUpLots_M2U]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[SortRule_CONS_SOLVED]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[SortRule_DSM]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[SortRule_DSM_PUBLISH]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[SortRule_DSM2]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[SortRule_M2U]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[SortRule_UNCONS_SOLVED]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[SortRuleCriteria_CONS_SOLVED]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[SortRuleCriteria_DSM]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[SortRuleCriteria_DSM_PUBLISH]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[SortRuleCriteria_DSM2]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[SortRuleCriteria_M2U]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[SortRuleCriteria_UNCONS_SOLVED]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[StartingInv_CONS_SOLVED]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[StartingInv_DSM]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[StartingInv_DSM_PUBLISH]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[StartingInv_DSM2]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[StartingInv_M2U]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[StartingInv_UNCONS_SOLVED]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[Step_CONS_SOLVED]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[Step_DSM]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[Step_DSM_PUBLISH]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[Step_DSM2]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[Step_M2U]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[Step_UNCONS_SOLVED]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[StepSeq_CONS_SOLVED]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[StepSeq_DSM]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[StepSeq_DSM_PUBLISH]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[StepSeq_DSM2]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[StepSeq_M2U]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[StepSeq_UNCONS_SOLVED]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[Storage_CONS_SOLVED]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[Storage_DSM]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[Storage_DSM_PUBLISH]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[Storage_DSM2]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[Storage_M2U]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[Storage_UNCONS_SOLVED]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[StorageAlt_CONS_SOLVED]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[StorageAlt_DSM]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[StorageAlt_DSM_PUBLISH]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[StorageAlt_DSM2]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[StorageAlt_M2U]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[StorageAlt_UNCONS_SOLVED]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[StorageAltElem_CONS_SOLVED]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[StorageAltElem_DSM]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[StorageAltElem_DSM_PUBLISH]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[StorageAltElem_DSM2]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[StorageAltElem_M2U]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[StorageAltElem_UNCONS_SOLVED]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[StorageCapExc_CONS_SOLVED]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[StorageCapExc_DSM]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[StorageCapExc_DSM_PUBLISH]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[StorageCapExc_DSM2]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[StorageCapExc_M2U]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[StorageCapExc_UNCONS_SOLVED]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[StorageCapInter_CONS_SOLVED]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[StorageCapInter_DSM]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[StorageCapInter_DSM_PUBLISH]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[StorageCapInter_DSM2]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[StorageCapInter_M2U]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[StorageCapInter_UNCONS_SOLVED]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[Supply_CONS_SOLVED]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[Supply_DSM]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[Supply_DSM_PUBLISH]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[Supply_DSM2]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[Supply_M2U]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[Supply_UNCONS_SOLVED]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[temp_missing_WorkOrders]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[TimeOverrideLots_CONS_SOLVED]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[TimeOverrideLots_DSM]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[TimeOverrideLots_DSM_PUBLISH]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[TimeOverrideLots_DSM2]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[TimeOverrideLots_M2U]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[TimeOverrideLots_UNCONS_SOLVED]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[VAttr_CONS_SOLVED]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[VAttr_DSM]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[VAttr_DSM_PUBLISH]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[VAttr_DSM2]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[VAttr_M2U]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[VAttr_UNCONS_SOLVED]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[VAttrValueBag_CONS_SOLVED]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[VAttrValueBag_DSM]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[VAttrValueBag_DSM_PUBLISH]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[VAttrValueBag_DSM2]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[VAttrValueBag_M2U]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[VAttrValueBag_UNCONS_SOLVED]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[VAttrValueDouble_CONS_SOLVED]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[VAttrValueDouble_DSM]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[VAttrValueDouble_DSM_PUBLISH]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[VAttrValueDouble_DSM2]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[VAttrValueDouble_M2U]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[VAttrValueDouble_UNCONS_SOLVED]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[VAttrValueInt_CONS_SOLVED]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[VAttrValueInt_DSM]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[VAttrValueInt_DSM_PUBLISH]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[VAttrValueInt_DSM2]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[VAttrValueInt_M2U]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[VAttrValueInt_UNCONS_SOLVED]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[VAttrValueString_CONS_SOLVED]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[VAttrValueString_DSM]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[VAttrValueString_DSM_PUBLISH]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[VAttrValueString_DSM2]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[VAttrValueString_M2U]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[VAttrValueString_UNCONS_SOLVED]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[VAttrValueTime_CONS_SOLVED]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[VAttrValueTime_DSM]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[VAttrValueTime_DSM_PUBLISH]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[VAttrValueTime_DSM2]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[VAttrValueTime_M2U]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[VAttrValueTime_UNCONS_SOLVED]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[Vendor_CONS_SOLVED]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[Vendor_DSM]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[Vendor_DSM_PUBLISH]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[Vendor_DSM2]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[Vendor_M2U]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[Vendor_UNCONS_SOLVED]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[WipBuffer_CONS_SOLVED]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[WipBuffer_DSM]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[WipBuffer_DSM_PUBLISH]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[WipBuffer_DSM2]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[WipBuffer_M2U]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[WipBuffer_UNCONS_SOLVED]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[WipResLots_CONS_SOLVED]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[WipResLots_DSM]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[WipResLots_DSM_PUBLISH]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[WipResLots_DSM2]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[WipResLots_M2U]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[WipResLots_UNCONS_SOLVED]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[WipStepLots_CONS_SOLVED]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[WipStepLots_DSM]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[WipStepLots_DSM_PUBLISH]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[WipStepLots_DSM2]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[WipStepLots_M2U]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[WipStepLots_M2U_bkp_20240422]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[WipStepLots_UNCONS_SOLVED]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[WorkOrders_CONS_SOLVED]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[WorkOrders_DSM]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[WorkOrders_DSM_PUBLISH]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[WorkOrders_DSM2]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[WorkOrders_M2U]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[WorkOrders_UNCONS_SOLVED]    Script Date: 5/2/2024 11:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  StoredProcedure [dbo].[ERROR_LOG]    Script Date: 5/2/2024 11:26:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/****** Object:  StoredProcedure [dbo].[PR_ADD_UDS_UDA]    Script Date: 5/2/2024 11:26:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




/****** Object:  StoredProcedure [dbo].[PR_BOM]    Script Date: 5/2/2024 11:26:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





/****** Object:  StoredProcedure [dbo].[PR_BOR]    Script Date: 5/2/2024 11:26:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO








/****** Object:  StoredProcedure [dbo].[PR_CALENDAR]    Script Date: 5/2/2024 11:26:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





/****** Object:  StoredProcedure [dbo].[PR_CAPPATTERN]    Script Date: 5/2/2024 11:26:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





/****** Object:  StoredProcedure [dbo].[PR_CFI]    Script Date: 5/2/2024 11:26:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




/****** Object:  StoredProcedure [dbo].[PR_CLEANUP]    Script Date: 5/2/2024 11:26:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






/****** Object:  StoredProcedure [dbo].[PR_COPY_MODEL_DATA]    Script Date: 5/2/2024 11:26:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Debbie Burgess
-- Create date: 8 May 2020
-- Description:	This procedure will create tables and copy the data for the 
--              model
-- =============================================
/****** Object:  StoredProcedure [dbo].[PR_COPY_RES_CAPACITY_DATA]    Script Date: 5/2/2024 11:26:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Object:  StoredProcedure [dbo].[PR_CREATE_CONSTRAINTS]    Script Date: 5/2/2024 11:26:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




-- =============================================
-- Author:		Debbie Burgess
-- Create date: 02 April 2020
-- Description:	Create constraint data
-- =============================================
/****** Object:  StoredProcedure [dbo].[PR_CREATE_SYNONYM]    Script Date: 5/2/2024 11:26:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/****** Object:  StoredProcedure [dbo].[PR_CREATE_SYNONYM_2]    Script Date: 5/2/2024 11:26:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
/****** Object:  StoredProcedure [dbo].[PR_CUSTOMER]    Script Date: 5/2/2024 11:26:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




/****** Object:  StoredProcedure [dbo].[PR_DELETE_PLANNED_PURCHASES]    Script Date: 5/2/2024 11:26:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



/****** Object:  StoredProcedure [dbo].[PR_DELETE_PLANNED_WORKORDERS]    Script Date: 5/2/2024 11:26:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



/****** Object:  StoredProcedure [dbo].[PR_DEMAND_PRIORITY]    Script Date: 5/2/2024 11:26:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  StoredProcedure [dbo].[PR_DEMANDS]    Script Date: 5/2/2024 11:26:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Object:  StoredProcedure [dbo].[PR_DROP_UDS_UDA]    Script Date: 5/2/2024 11:26:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Object:  StoredProcedure [dbo].[PR_DSM_OUTPUT]    Script Date: 5/2/2024 11:26:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/****** Object:  StoredProcedure [dbo].[PR_DUMMY_CAPACITY]    Script Date: 5/2/2024 11:26:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





/****** Object:  StoredProcedure [dbo].[PR_FORECAST_NETTING]    Script Date: 5/2/2024 11:26:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




/****** Object:  StoredProcedure [dbo].[PR_GET_COLUMS]    Script Date: 5/2/2024 11:26:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Debbie Burgess
-- Create date: 02 April 2020
-- Description:	This function will return the columns to be returned by the target constraint
-- =============================================
/****** Object:  StoredProcedure [dbo].[PR_HIERARCHY]    Script Date: 5/2/2024 11:26:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





/****** Object:  StoredProcedure [dbo].[PR_LOCATION]    Script Date: 5/2/2024 11:26:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





/****** Object:  StoredProcedure [dbo].[PR_LOG_DATA_ERROR]    Script Date: 5/2/2024 11:26:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

----- EXEC [dbo].[PR_LOG_DATA_ERROR]  'PR_POPULATE_UDS'

/****** Object:  StoredProcedure [dbo].[PR_MFG_METHODS]    Script Date: 5/2/2024 11:26:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Object:  StoredProcedure [dbo].[PR_OPERATION]    Script Date: 5/2/2024 11:26:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Object:  StoredProcedure [dbo].[PR_OPERATION_OVERRIDE]    Script Date: 5/2/2024 11:26:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Object:  StoredProcedure [dbo].[PR_PERIOD_MANAGER]    Script Date: 5/2/2024 11:26:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/****** Object:  StoredProcedure [dbo].[PR_POPULATE_UDS]    Script Date: 5/2/2024 11:26:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/******************************************************************************
   NAME:     PR_POPULATE_UDS
   PURPOSE:  This is the control procedure which calls all the procedures
             required to populate the SAT tables with data

******************************************************************************/
/****** Object:  StoredProcedure [dbo].[PR_PRE_POPULATE]    Script Date: 5/2/2024 11:26:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  StoredProcedure [dbo].[PR_PRODUCT_LOCATION]    Script Date: 5/2/2024 11:26:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/****** Object:  StoredProcedure [dbo].[PR_PRODUCT_SUBSTITUTE]    Script Date: 5/2/2024 11:26:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



/****** Object:  StoredProcedure [dbo].[PR_PUBLISH_DEMAND_OVERRIDES]    Script Date: 5/2/2024 11:26:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Object:  StoredProcedure [dbo].[PR_PUBLISH_PLANNED_PURCHASES]    Script Date: 5/2/2024 11:26:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/****** Object:  StoredProcedure [dbo].[PR_PUBLISH_PLANNED_WORKORDERS]    Script Date: 5/2/2024 11:26:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/****** Object:  StoredProcedure [dbo].[PR_PURCHASE_METHODS]    Script Date: 5/2/2024 11:26:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Object:  StoredProcedure [dbo].[PR_REBUILD_UDS]    Script Date: 5/2/2024 11:26:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





/****** Object:  StoredProcedure [dbo].[PR_REPLACE_SPECIAL_CHARS]    Script Date: 5/2/2024 11:26:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  StoredProcedure [dbo].[PR_RESALT]    Script Date: 5/2/2024 11:26:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




/****** Object:  StoredProcedure [dbo].[PR_RESOURCE]    Script Date: 5/2/2024 11:26:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






/****** Object:  StoredProcedure [dbo].[PR_ROUTE_STEP]    Script Date: 5/2/2024 11:26:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







/****** Object:  StoredProcedure [dbo].[PR_SAFETY_STOCK]    Script Date: 5/2/2024 11:26:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







/****** Object:  StoredProcedure [dbo].[PR_SETUP]    Script Date: 5/2/2024 11:26:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



 

/****** Object:  StoredProcedure [dbo].[PR_SOURCING_CONSTRAINT]    Script Date: 5/2/2024 11:26:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







/****** Object:  StoredProcedure [dbo].[PR_SUPPLY]    Script Date: 5/2/2024 11:26:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Object:  StoredProcedure [dbo].[PR_TRANSPORTATION_METHODS]    Script Date: 5/2/2024 11:26:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






/****** Object:  StoredProcedure [dbo].[PR_TRUNCATE_UDS]    Script Date: 5/2/2024 11:26:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




/****** Object:  StoredProcedure [dbo].[PR_UPDATE_SUPPLY_RELEASE]    Script Date: 5/2/2024 11:26:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Object:  StoredProcedure [dbo].[PR_UPDATE_UDS_UDA]    Script Date: 5/2/2024 11:26:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/****** Object:  StoredProcedure [dbo].[PR_UPDATE_WORKORDERS_RELEASE]    Script Date: 5/2/2024 11:26:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Object:  StoredProcedure [dbo].[PR_WIP]    Script Date: 5/2/2024 11:26:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Object:  StoredProcedure [dbo].[PR_WO_MATERIAL_CONSUMPTION]    Script Date: 5/2/2024 11:26:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/****** Object:  StoredProcedure [dbo].[PROCESS_HISTORY]    Script Date: 5/2/2024 11:26:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  StoredProcedure [dbo].[UPDATE_PROCESS_CONTROL]    Script Date: 5/2/2024 11:26:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/****** Object:  StoredProcedure [dbo].[util_BCPFormatFile]    Script Date: 5/2/2024 11:26:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

USE [master]
GO
ALTER DATABASE [ADX_SCP_UDS] SET  READ_WRITE 
GO
