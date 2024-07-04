USE [master]
GO
/****** Object:  Database [ADX_STAGING]    Script Date: 5/2/2024 11:27:40 PM ******/
CREATE DATABASE [ADX_STAGING]

GO

ALTER DATABASE [ADX_STAGING] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ADX_STAGING].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ADX_STAGING] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ADX_STAGING] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ADX_STAGING] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ADX_STAGING] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ADX_STAGING] SET ARITHABORT OFF 
GO
ALTER DATABASE [ADX_STAGING] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [ADX_STAGING] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ADX_STAGING] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ADX_STAGING] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ADX_STAGING] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ADX_STAGING] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ADX_STAGING] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ADX_STAGING] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ADX_STAGING] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ADX_STAGING] SET  DISABLE_BROKER 
GO
ALTER DATABASE [ADX_STAGING] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ADX_STAGING] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ADX_STAGING] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ADX_STAGING] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ADX_STAGING] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ADX_STAGING] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ADX_STAGING] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ADX_STAGING] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [ADX_STAGING] SET  MULTI_USER 
GO
ALTER DATABASE [ADX_STAGING] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ADX_STAGING] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ADX_STAGING] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ADX_STAGING] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [ADX_STAGING] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [ADX_STAGING] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [ADX_STAGING] SET QUERY_STORE = OFF
GO
USE [ADX_STAGING]
GO

/****** Object:  Sequence [dbo].[PseudoIds]    Script Date: 5/2/2024 11:27:40 PM ******/
/****** Object:  Synonym [dbo].[ERROR_LOG]    Script Date: 5/2/2024 11:27:40 PM ******/
/****** Object:  Synonym [dbo].[GET_MODEL_ID]    Script Date: 5/2/2024 11:27:40 PM ******/
/****** Object:  Synonym [dbo].[PROCESS_HISTORY]    Script Date: 5/2/2024 11:27:40 PM ******/
/****** Object:  Synonym [dbo].[PUBLISH_DEMAND_OVERRIDES]    Script Date: 5/2/2024 11:27:40 PM ******/
/****** Object:  Synonym [dbo].[PUBLISH_PLANNED_PURCHASES]    Script Date: 5/2/2024 11:27:40 PM ******/
/****** Object:  Synonym [dbo].[PUBLISH_PLANNED_WORKORDERS]    Script Date: 5/2/2024 11:27:40 PM ******/
/****** Object:  Table [dbo].[SOURCE_DATA_TRANSFER_AUDIT]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  View [dbo].[ADX_BOOMI_API_ISSUES]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






/****** Object:  Table [dbo].[DL_ADX_PRODUCTLOCATION]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  View [dbo].[DL_ADX_WO_VIEW_TEST]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ADX_DATA_ERROR_LOG]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ADX_DATA_ERROR_CODE]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  View [dbo].[ADX_MODEL_ERRORS]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





--AND  mbp.PARAM_NAME = 'MODEL_ID'
--AND  mbp.MODEL_ID = 'ALL'
--AND  mbp.PLAN_ID = 'ALL'

GO
/****** Object:  View [dbo].[ADX_DATA_ERRORS]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






/****** Object:  Table [dbo].[DSM_LOCATION]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  View [dbo].[DSM_PLANNED_PURCHASES_VIEW]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


  /****** Object:  View [dbo].[DSM_PLANNED_WORKORDERS_VIEW]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




  /****** Object:  Table [dbo].[DL_ADX_ROUTE]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  View [dbo].[VW_DSM_ROUTE_OPERATION]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/****** Object:  Table [dbo].[ADX_OPERATION]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ADX_OPERATION_OVERRIDE]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ADX_RESALT]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ADX_ROUTE]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ADX_BOR]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ADX_BORA]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  View [dbo].[DSM_OP_ROUTE_BOR_RESOURCE_VIEW]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






/****** Object:  Table [dbo].[VISTA_ACTIVITY_LOG]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[DSM_TABLES_LOG]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  View [dbo].[DSM_TABLES_LOG_VIEW]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Object:  Table [dbo].[ADX_AOP]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ADX_ASP]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ADX_ATT_STG_CLASS_CATALOG]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ADX_ATT_STG_CORE]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ADX_ATT_UDS_CLASS_CATALOG]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ADX_ATT_UDS_CORE]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ADX_ATT_UDS_CORE_AOS]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ADX_ATT_UDS_CORE_BKUP]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ADX_ATT_USER_CLASS_CATALOG]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ADX_ATT_USER_EDIT]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ADX_ATT_USER_TYPE_CATALOG]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ADX_BOG]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ADX_BOM]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ADX_BOR_MRP]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ADX_CAPPATTERN]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ADX_CDP_Forecast]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ADX_CFI]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ADX_CHANNEL]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ADX_COMMODITYGRADES]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ADX_CUSTOMER]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ADX_CUSTOMER_FCST]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ADX_DAILY_PROCESS_CONTROL]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ADX_DEMAND]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ADX_DEMAND_UNC]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ADX_DIM_DATE]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ADX_ERROR_CONTROL]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ADX_EVENTS]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ADX_EXPORT_PLANNED_PURCHASES]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ADX_EXPORT_PLANNED_STOCK_TRANSFER]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ADX_EXPORT_PLANNED_WORKORDERS]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ADX_GREYBOX_ACTION]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ADX_GREYBOX_ACTION_UNC]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ADX_GREYBOX_CONS2]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ADX_GREYBOX_HEADER]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ADX_GREYBOX_TARGET]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ADX_HOLIDAY]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ADX_HORIZON]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ADX_INVENTORY]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ADX_LOCATION]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ADX_LOOKUP]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ADX_LOOKUP_TEMPLATE]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ADX_MEIO_Demand]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ADX_MEIO_Planning_Group]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ADX_MEIO_Product_Location]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ADX_MEIO_Scenario]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ADX_MEIO_Service_Targets]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ADX_METHOD_BUY]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ADX_METHOD_MAKE]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ADX_METHOD_VEHICLE]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ADX_MODEL_BUILD_PARAMETERS]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ADX_OPEN_SALES_ORDERS]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ADX_OPERATION_OVERRIDE_TEST]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ADX_OUTBOUND_FCST_TO_ERP]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ADX_OUTBOUND_SAFETY_STOCK]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ADX_PARAMETERS_DEFAULTS]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ADX_PERIOD_MANAGER]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ADX_PLAN_INFO]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ADX_PROCESS_CONTROL]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ADX_PROCESS_HISTORY]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ADX_PROD_EOL]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ADX_PROD_REPLACEMENTS]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ADX_PRODAREA]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ADX_PRODUCT]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ADX_PRODUCT_SUBSTITUTE]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ADX_PRODUCTLOCATION]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ADX_QUOTES]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ADX_RESCAPEXC]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ADX_RESCAPINTER]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ADX_RESOURCE]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ADX_RPT_ADR_DEMAND_ATTR]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ADX_RPT_ADR_DEMAND_SUPPLY]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ADX_RPT_ADR_SUPPLY_ATTR]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ADX_RPT_ADR_SUPPLY_DEMAND]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ADX_RPT_ADR_WORKORDER_ATTR]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ADX_RPT_CONNECTIONS]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ADX_RPT_DEMANDS]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ADX_RPT_WORKORDER_CYCLES]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ADX_SAFETY_STOCK]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ADX_SALES_OPPORTUNITIES]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ADX_SEQ_RESOURCE]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ADX_SETUP_MATRIX]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ADX_SETUPS]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ADX_SHIPMENTS]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ADX_SHIPMENTS_DISTI]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ADX_SOURCING]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ADX_SOURCING_PRODUCT_CUST]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ADX_STAGING_TABLES]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ADX_SUPPLY]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ADX_TABLE_COUNT]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ADX_TRANSPORTATION]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ADX_UDA]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ADX_UNIT_CONVERSION]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ADX_UNIT_COST]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ADX_VENDOR]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ADX_WIP]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ADX_WORKORDERS]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ADX_XERATES]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ADX_ZONE_NAME]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[DEMAND]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[DL_ADX_AOP]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[DL_ADX_ASP]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[DL_ADX_BOG]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[DL_ADX_BOM]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[DL_ADX_BOM_TEMP]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[DL_ADX_BOR]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[DL_ADX_BOR_MRP]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[DL_ADX_BORA]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[DL_ADX_CAPPATTERN]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[DL_ADX_CDP_Forecast]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[DL_ADX_CFI]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[DL_ADX_CFI_FAMILY]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[DL_ADX_CHANNEL]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[DL_ADX_COMMODITYGRADES]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[DL_ADX_CUSTOMER]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[DL_ADX_CUSTOMER_FCST]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[DL_ADX_CUSTOMER_TEMP]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[DL_ADX_DEMAND]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[DL_ADX_DEMAND_TEMP]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[DL_ADX_DEMAND_UNC]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[DL_ADX_EVENTS]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[DL_ADX_EXPORT_PLANNED_PURCHASES]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[DL_ADX_EXPORT_PLANNED_STOCK_TRANSFER]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[DL_ADX_EXPORT_PLANNED_WORKORDERS]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[DL_ADX_GREYBOX_ACTION]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[DL_ADX_GREYBOX_ACTION_UNC]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[DL_ADX_GREYBOX_CONS2]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[DL_ADX_GREYBOX_HEADER]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[DL_ADX_GREYBOX_TARGET]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[DL_ADX_HOLIDAY]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[DL_ADX_INVENTORY]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[DL_ADX_LOCATION]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[DL_ADX_MEIO_Demand]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[DL_ADX_MEIO_Planning_Group]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[DL_ADX_MEIO_Product_Location]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[DL_ADX_MEIO_Scenario]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[DL_ADX_MEIO_Service_Targets]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[DL_ADX_METHOD_BUY]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[DL_ADX_METHOD_BUY_TEMP]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[DL_ADX_METHOD_BUY_UNC]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[DL_ADX_METHOD_MAKE]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[DL_ADX_METHOD_MAKE_TEMP]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[DL_ADX_METHOD_VEHICLE]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[DL_ADX_MODEL_BUILD_PARAMETERS]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[DL_ADX_NCR_GUID]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[DL_ADX_OP_LIMS]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[DL_ADX_OP_LIMS_TEST]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[DL_ADX_OPEN_SALES_ORDERS]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[DL_ADX_OPERATION]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[DL_ADX_OPERATION_OVERRIDE]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[DL_ADX_OPERATION_TEMP]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[DL_ADX_OUTBOUND_FCST_TO_ERP]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[DL_ADX_OUTBOUND_SAFETY_STOCK]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[DL_ADX_PERIOD_MANAGER]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[DL_ADX_PLAN_INFO]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[DL_ADX_PROD_EOL]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[DL_ADX_PROD_REPLACEMENTS]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[DL_ADX_PRODAREA]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[DL_ADX_PRODUCT]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[DL_ADX_PRODUCT_FAMILY]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[DL_ADX_PRODUCT_FAMILY_BKP_20240410]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[DL_ADX_PRODUCT_SUBSTITUTE]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[DL_ADX_PRODUCT_TEMP]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[DL_ADX_PRODUCTLOCATION_TEMP]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[DL_ADX_QUOTES]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[DL_ADX_RESALT]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[DL_ADX_RESCAPEXC]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[DL_ADX_RESCAPINTER]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[DL_ADX_RESOURCE]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[DL_ADX_ROUTE_TEMP]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[DL_ADX_RPT_ADR_DEMAND_ATTR]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[DL_ADX_RPT_ADR_DEMAND_SUPPLY]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[DL_ADX_RPT_ADR_SUPPLY_ATTR]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[DL_ADX_RPT_ADR_SUPPLY_DEMAND]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[DL_ADX_RPT_ADR_WORKORDER_ATTR]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[DL_ADX_RPT_CONNECTIONS]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[DL_ADX_RPT_DEMANDS]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[DL_ADX_RPT_WORKORDER_CYCLES]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[DL_ADX_SAFETY_STOCK]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[DL_ADX_SAFETY_STOCK_TEMP]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[DL_ADX_SALES_OPPORTUNITIES]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[DL_ADX_SEQ_RESOURCE]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[DL_ADX_SETUP_MATRIX]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[DL_ADX_SETUPS]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[DL_ADX_SHIPMENTS]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[DL_ADX_SHIPMENTS_DISTI]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[DL_ADX_SHIPMENTS_TEMP]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[DL_ADX_SOURCING]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[DL_ADX_SOURCING_PRODUCT_CUST]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[DL_ADX_SUPPLY]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[DL_ADX_SUPPLY_PR]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[DL_ADX_SUPPLY_PR_BKP_20240410]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[DL_ADX_SUPPLY_TEMP]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[DL_ADX_TRANSPORTATION]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[DL_ADX_UDA]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[DL_ADX_UNIT_CONVERSION]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[DL_ADX_UNIT_COST]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[DL_ADX_VENDOR]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[DL_ADX_VENDOR_TEMP]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[DL_ADX_WIP]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[DL_ADX_WIP_TEMP]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[DL_ADX_WO_NCR]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[DL_ADX_WO_NCR_BKP_20240410]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[DL_ADX_WORKORDERS]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[DL_ADX_WORKORDERS_TEMP]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[DL_ADX_XERATES]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[DL_CUSTOMER_SIGNIFICANCE]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[DL_CUSTOMER_SIGNIFICANCE_BKP_20240410]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[DL_CUSTOMER_SIGNIFICANCE_EXCEL_DATA]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[DL_WO_CONSUMPTION]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[DSM_EXP_BUFFER]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[DSM_EXPDATE]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[DSM_HOLIDAY]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[DSM_OPERATION_OVERRIDE]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[DSM_OPERATION_OVERRIDE_TEST]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[DSM_PLANNED_MAINTENANCE]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[DSM_PRIORITY_PARAMETER]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[DSM_PRODUCT_TEMP]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[DSM_REGION_PRIORITY_CLASS]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[DSM_RESALT]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[DSM_RESALT_BKP_20240425]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[DSM_RESOURCE]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[DSM_ROUTE_OP_BOR]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[err_FlatFile_ErrorRows]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[PUBLISH_PLANNED_PURCHASE_ACK]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[PUBLISH_PLANNED_WORKORDER_ACK]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[SOURCE_BUILD_PARAMETERS]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[SOURCE_DATA_TABLE]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[wrk_adx_Table_Structure]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[wrk_pseudo_id_tables]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[wrk_pseudo_id_xref]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ZZ_OPERATION_DUPLICATE_TEMP]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER TABLE [dbo].[ADX_ATT_USER_CLASS_CATALOG] CHECK CONSTRAINT [FK_ATT_UDS_CLS_ATT_CLS_CAT]
GO
ALTER TABLE [dbo].[ADX_ATT_USER_EDIT] CHECK CONSTRAINT [FK_MDM_ATT_USER_EDIT_ATT_USR_C]
GO
ALTER TABLE [dbo].[ADX_ATT_USER_EDIT] CHECK CONSTRAINT [FK_MDM_ATT_USER_EDIT_ATT_USR_T]
GO
ALTER TABLE [dbo].[ADX_LOOKUP] CHECK CONSTRAINT [FK_ADX_LOOKUP_LOOKUP_TEMPLATE]
GO
ALTER TABLE [dbo].[ADX_HORIZON] CHECK CONSTRAINT [GOOD_MDM_HORIZON]
GO
ALTER TABLE [dbo].[DSM_EXPDATE] CHECK CONSTRAINT [CHK_EXPDATE_STAGE]
GO
ALTER TABLE [dbo].[DSM_PLANNED_MAINTENANCE] CHECK CONSTRAINT [CHK_DSM_PLANNED_MAINTENANCE_DURATION]
GO
/****** Object:  StoredProcedure [dbo].[Check_DSM_DL_Table_Dup]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




/****** Object:  StoredProcedure [dbo].[PR_ADD_ADX_UDA]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  StoredProcedure [dbo].[PR_ADD_DL_ADX_UDA]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/****** Object:  StoredProcedure [dbo].[PR_BACKUP_STATIC_DATA]    Script Date: 5/2/2024 11:27:40 PM ******/
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
/****** Object:  StoredProcedure [dbo].[PR_CHK_FOR_DUPS]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Debbie Burgess
-- Create date: 01-May-2020
-- Description:	This procedure checks for duplicates in staging tables
-- =============================================
/****** Object:  StoredProcedure [dbo].[PR_CREATE_ADX_TABLES]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Object:  StoredProcedure [dbo].[PR_DATA_ERRORS]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Object:  StoredProcedure [dbo].[PR_DELETE_DATA]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Debbie Burgess
-- Create date: 01-May-2020
-- Description:	Delete data from tables depending on the model_id
-- =============================================
/****** Object:  StoredProcedure [dbo].[PR_DROP_ADX_UDA]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  StoredProcedure [dbo].[PR_FORECAST_SPLIT]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/****** Object:  StoredProcedure [dbo].[PR_FORECAST_SPLIT_BKP_20230228]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/****** Object:  StoredProcedure [dbo].[PR_POP_DIM_DATE_WEEKS_ISO]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  StoredProcedure [dbo].[PR_POP_DIM_DATE_WEEKS_NA1]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  StoredProcedure [dbo].[PR_POP_DIM_DATE_WEEKS_NA2]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  StoredProcedure [dbo].[PR_POPULATE_ADX_TABLES]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




/****** Object:  StoredProcedure [dbo].[PR_POPULATE_ADX_TABLES_FROM_DSM]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/****** Object:  StoredProcedure [dbo].[PR_POPULATE_DL_ADX_WO_NCR]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/****** Object:  StoredProcedure [dbo].[PR_PSEUDO_ID_POPULATE]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  StoredProcedure [dbo].[PR_PSEUDO_ID_REVERT]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  StoredProcedure [dbo].[PR_RESTORE_STATIC_DATA]    Script Date: 5/2/2024 11:27:40 PM ******/
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
/****** Object:  StoredProcedure [dbo].[PR_TEST_CURSOR]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  StoredProcedure [dbo].[PR_UPDATE_ADX_DATA]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Debbie Burgess
-- Create date: 01-May-2020
-- Description:	This procedure inserts data from DL tables to ADX tables
-- =============================================
/****** Object:  StoredProcedure [dbo].[PR_UPDATE_ADX_DYNAMIC_DATA]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Debbie Burgess
-- Create date: 01-May-2020
-- Description:	This procedure inserts data from DL tables to ADX tables
-- =============================================
/****** Object:  StoredProcedure [dbo].[PR_UPDATE_STAGING_DATA]    Script Date: 5/2/2024 11:27:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Debbie Burgess
-- Create date: 01-May-2020
-- Description:	This procedure determines the data loaded into DL tables
-- and updates the ADX tables with the updated data
-- =============================================
USE [master]
GO
ALTER DATABASE [ADX_STAGING] SET  READ_WRITE 
GO
