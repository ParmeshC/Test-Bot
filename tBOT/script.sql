USE [master]
GO
/****** Object:  Database [tbot]    Script Date: 1/11/2017 4:35:05 PM ******/
CREATE DATABASE [tbot]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'tbot', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\tbot.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'tbot_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\tbot_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [tbot] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [tbot].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [tbot] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [tbot] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [tbot] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [tbot] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [tbot] SET ARITHABORT OFF 
GO
ALTER DATABASE [tbot] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [tbot] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [tbot] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [tbot] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [tbot] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [tbot] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [tbot] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [tbot] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [tbot] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [tbot] SET  DISABLE_BROKER 
GO
ALTER DATABASE [tbot] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [tbot] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [tbot] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [tbot] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [tbot] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [tbot] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [tbot] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [tbot] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [tbot] SET  MULTI_USER 
GO
ALTER DATABASE [tbot] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [tbot] SET DB_CHAINING OFF 
GO
ALTER DATABASE [tbot] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [tbot] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [tbot] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [tbot] SET QUERY_STORE = OFF
GO
USE [tbot]
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO
USE [tbot]
GO
/****** Object:  Table [dbo].[EndPointObject]    Script Date: 1/11/2017 4:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EndPointObject](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[EndPointId] [int] NOT NULL,
 CONSTRAINT [PK_EndPointObject] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Instance]    Script Date: 1/11/2017 4:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Instance](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[InstanceName] [nvarchar](200) NOT NULL,
 CONSTRAINT [PK_Instance] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EndPoint]    Script Date: 1/11/2017 4:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EndPoint](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[InstanceId] [int] NOT NULL,
	[Name] [nvarchar](1000) NULL,
 CONSTRAINT [PK_EndPoint] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EndPointObjectGroup]    Script Date: 1/11/2017 4:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EndPointObjectGroup](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[EndPointObjectId] [int] NOT NULL,
	[Section] [nvarchar](200) NOT NULL,
 CONSTRAINT [PK_EndPointObjectGroup] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EndPointObjectComponent]    Script Date: 1/11/2017 4:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EndPointObjectComponent](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](200) NOT NULL,
	[Value] [nvarchar](max) NULL,
	[EndPointObjectId] [int] NOT NULL,
 CONSTRAINT [PK_EndPointObjectComponent] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[View_EndPointObjectComponent_By_EndPointObjectIdWise]    Script Date: 1/11/2017 4:35:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[View_EndPointObjectComponent_By_EndPointObjectIdWise]
AS
SELECT        TOP (100) PERCENT dbo.EndPointObject.Id AS EndPointObjectId, dbo.EndPoint.InstanceId, dbo.Instance.InstanceName AS Instance, dbo.EndPointObject.EndPointId, dbo.EndPoint.Name AS EndPoint, 
                         dbo.EndPointObjectComponent.Id AS EndPointObjectComponentId, dbo.EndPointObjectComponent.Name AS EndPointObjectComponentName, dbo.EndPointObjectComponent.Value AS EndPointObjectComponentValue, 
                         COUNT(dbo.EndPointObjectGroup.Id) AS EndPointObjectGroupCount
FROM            dbo.Instance INNER JOIN
                         dbo.EndPoint ON dbo.Instance.Id = dbo.EndPoint.InstanceId INNER JOIN
                         dbo.EndPointObject ON dbo.EndPoint.Id = dbo.EndPointObject.EndPointId LEFT OUTER JOIN
                         dbo.EndPointObjectGroup ON dbo.EndPointObject.Id = dbo.EndPointObjectGroup.EndPointObjectId LEFT OUTER JOIN
                         dbo.EndPointObjectComponent ON dbo.EndPointObject.Id = dbo.EndPointObjectComponent.EndPointObjectId
GROUP BY dbo.EndPointObject.Id, dbo.EndPoint.InstanceId, dbo.Instance.InstanceName, dbo.EndPointObject.EndPointId, dbo.EndPoint.Name, dbo.EndPointObjectComponent.Id, dbo.EndPointObjectComponent.Name, 
                         dbo.EndPointObjectComponent.Value
GO
/****** Object:  UserDefinedFunction [dbo].[Get_EndPointObjectComponent_For_EndPointObjectComponentId]    Script Date: 1/11/2017 4:35:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[Get_EndPointObjectComponent_For_EndPointObjectComponentId]
(	
		@EndPointObjectComponentId int
)
RETURNS TABLE 
AS
RETURN 
(
SELECT        EndPointObjectComponentId, EndPointObjectComponentName AS ComponentName, EndPointObjectComponentValue AS ComponentValue
FROM            View_EndPointObjectComponent_By_EndPointObjectIdWise
WHERE        (EndPointObjectComponentId = @EndPointObjectComponentId)
)
GO
/****** Object:  Table [dbo].[EndPointComponent]    Script Date: 1/11/2017 4:35:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EndPointComponent](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[InstanceId] [int] NOT NULL,
	[EndPointComponentName] [nvarchar](200) NULL,
	[Value] [nvarchar](max) NULL,
 CONSTRAINT [PK_EndPointComponent] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[Get_EndPointComponent_For_EndPointComponentId]    Script Date: 1/11/2017 4:35:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[Get_EndPointComponent_For_EndPointComponentId]
(	
		@EndPointComponentId int
)
RETURNS TABLE 
AS
RETURN 
(
SELECT        Id AS EndPointComponentId, EndPointComponentName AS ComponentName, Value AS ComponentValue
FROM            EndPointComponent
WHERE        (Id = @EndPointComponentId)
)
GO
/****** Object:  UserDefinedFunction [dbo].[Get_EndPoints_For_InstanceId]    Script Date: 1/11/2017 4:35:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[Get_EndPoints_For_InstanceId]
(	
	@InstanceId int
)
RETURNS TABLE 
AS
RETURN 
(
SELECT        Id AS EndPointId, Name AS EndPoint
FROM            EndPoint
WHERE        (InstanceId = InstanceId)
)
GO
/****** Object:  View [dbo].[View_EndPointObjectComponent_By_EndPointObjectGroupIdWise]    Script Date: 1/11/2017 4:35:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[View_EndPointObjectComponent_By_EndPointObjectGroupIdWise]
AS
SELECT        TOP (100) PERCENT dbo.EndPointObjectGroup.Id AS EndPointObjectGroupId, dbo.EndPointObjectGroup.Section AS EndPointObjectGroupSection, dbo.Instance.Id AS InstanceId, dbo.EndPointObject.Id AS EndPointObjectId, 
                         dbo.EndPoint.Id AS EndPointId, dbo.Instance.InstanceName AS Instance, dbo.EndPoint.Name AS EndPoint, dbo.EndPointObjectComponent.Id AS EndPointObjectComponentId, 
                         dbo.EndPointObjectComponent.Name AS EndPointObjectComponentName, dbo.EndPointObjectComponent.Value AS EndPointObjectComponentValue
FROM            dbo.EndPointObjectGroup LEFT OUTER JOIN
                         dbo.Instance INNER JOIN
                         dbo.EndPoint ON dbo.Instance.Id = dbo.EndPoint.InstanceId INNER JOIN
                         dbo.EndPointObject ON dbo.EndPoint.Id = dbo.EndPointObject.EndPointId LEFT OUTER JOIN
                         dbo.EndPointObjectComponent ON dbo.EndPointObject.Id = dbo.EndPointObjectComponent.EndPointObjectId ON dbo.EndPointObjectGroup.EndPointObjectId = dbo.EndPointObject.Id
GO
/****** Object:  UserDefinedFunction [dbo].[Get_EndPointObjectComponents_For_EndPointObjectGroupSection]    Script Date: 1/11/2017 4:35:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[Get_EndPointObjectComponents_For_EndPointObjectGroupSection]
(	
	@EndPointObjectGroupSection  nvarchar(200)
)
RETURNS TABLE 
AS
RETURN 
(
	
SELECT        EndPoint, EndPointObjectId, EndPointObjectComponentId, EndPointObjectComponentName AS ComponentName, EndPointObjectComponentValue AS ComponentValue
FROM            View_EndPointObjectComponent_By_EndPointObjectGroupIdWise
WHERE        (EndPointObjectGroupSection = @EndPointObjectGroupSection)
)
GO
/****** Object:  View [dbo].[View_EndPointObject_By_Count]    Script Date: 1/11/2017 4:35:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[View_EndPointObject_By_Count]
AS
SELECT        dbo.EndPoint.InstanceId, dbo.EndPoint.Id AS EndPointId, dbo.Instance.InstanceName AS Instance, dbo.EndPoint.Name AS EndPoint, COUNT(dbo.EndPointObject.Id) AS Object
FROM            dbo.EndPoint INNER JOIN
                         dbo.Instance ON dbo.EndPoint.InstanceId = dbo.Instance.Id LEFT OUTER JOIN
                         dbo.EndPointObject ON dbo.EndPoint.Id = dbo.EndPointObject.EndPointId
GROUP BY dbo.EndPoint.Name, dbo.Instance.InstanceName, dbo.EndPoint.InstanceId, dbo.EndPoint.Id
GO
/****** Object:  UserDefinedFunction [dbo].[Get_EndPointObjectComponentCount_GroupedInCount_By_EndPointObject_For_EndPointId]    Script Date: 1/11/2017 4:35:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Rekha Parmesh
-- Create date: Oct 2nd 2017
-- Description:	Get the Count of EndpointObjectComponents in EndPointObjects for the given EndPoint
-- =============================================
CREATE FUNCTION [dbo].[Get_EndPointObjectComponentCount_GroupedInCount_By_EndPointObject_For_EndPointId] 
(	
	@EndPointId int
)
RETURNS TABLE 
AS
RETURN 
(
SELECT        EndPointId, EndPoint, EndPointObjectId, COUNT(EndPointObjectComponentId) AS ComponentCount, EndPointObjectGroupCount
FROM            View_EndPointObjectComponent_By_EndPointObjectIdWise
GROUP BY EndPointObjectId, EndPointId, EndPoint, EndPointObjectGroupCount
HAVING        (EndPointId = @EndPointId)
)
GO
/****** Object:  UserDefinedFunction [dbo].[Get_EndPointObjectComponents_For_EndPointObjectId]    Script Date: 1/11/2017 4:35:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Rekha Parmesh
-- Create date: Oct 2nd 2017
-- Description:	Get the EndpointObjectComponents for the specific EndPointObjectId
-- =============================================
CREATE FUNCTION [dbo].[Get_EndPointObjectComponents_For_EndPointObjectId] 
(	
	@EndPointObjectId int
)
RETURNS TABLE 
AS
RETURN 
(
SELECT        EndPoint, EndPointObjectId, EndPointObjectComponentId, EndPointObjectComponentName AS ComponentName, EndPointObjectComponentValue AS ComponentValue
FROM            View_EndPointObjectComponent_By_EndPointObjectIdWise
WHERE        (EndPointObjectId = @EndPointObjectId)
)
GO
/****** Object:  UserDefinedFunction [dbo].[Get_EndPointObjectGroups_For_EndPointObjectId]    Script Date: 1/11/2017 4:35:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[Get_EndPointObjectGroups_For_EndPointObjectId]
(	
	@EndPointObjectId int
)
RETURNS TABLE 
AS
RETURN 
(
SELECT DISTINCT  EndPointObjectGroupId, EndPointObjectGroupSection, EndPointObjectId, EndPointId, EndPoint
FROM            View_EndPointObjectComponent_By_EndPointObjectGroupIdWise
WHERE        (EndPointObjectId = @EndPointObjectId)
)
GO
/****** Object:  View [dbo].[View_EndPointObjectGroup_By_Count]    Script Date: 1/11/2017 4:35:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[View_EndPointObjectGroup_By_Count]
AS
SELECT        Section AS EndPointObjectGroupSection, COUNT(Id) AS EndPointObjectGroupSectionCount
FROM            dbo.EndPointObjectGroup
GROUP BY Section
GO
/****** Object:  UserDefinedFunction [dbo].[Get_EndPointObject_EndPoint_For_EndPointObjectGroupSection]    Script Date: 1/11/2017 4:35:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[Get_EndPointObject_EndPoint_For_EndPointObjectGroupSection]
(	
	@EndPointObjectGroupSection nvarchar(200)
)
RETURNS TABLE 
AS
RETURN 
(
SELECT        EndPointObjectGroup.Section AS EndPointObjectGroupSection, EndPoint.Name AS EndPoint, EndPointObject.Id AS EndPointObjectId, EndPoint.Id AS EndPointId, EndPointObjectGroup.Id AS EndPointObjectGroupId
FROM            EndPointObject INNER JOIN
                         EndPointObjectGroup ON EndPointObject.Id = EndPointObjectGroup.EndPointObjectId INNER JOIN
                         EndPoint ON EndPointObject.EndPointId = EndPoint.Id
WHERE        (EndPointObjectGroup.Section = @EndPointObjectGroupSection)
)
GO
/****** Object:  View [dbo].[View_EndPointObjectGroup_Distinct]    Script Date: 1/11/2017 4:35:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[View_EndPointObjectGroup_Distinct]
AS
SELECT DISTINCT Section
FROM            dbo.EndPointObjectGroup
GO
/****** Object:  View [dbo].[View_EndPointComponent]    Script Date: 1/11/2017 4:35:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[View_EndPointComponent]
AS
SELECT        Id AS EndPointComponentId, EndPointComponentName AS ComponentName, Value AS ComponentValue
FROM            dbo.EndPointComponent
GO
/****** Object:  Table [dbo].[Authorization]    Script Date: 1/11/2017 4:35:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Authorization](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [nvarchar](50) NULL,
	[Password] [nvarchar](50) NULL,
	[Type] [nvarchar](50) NULL,
 CONSTRAINT [PK_Authorization] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Environment]    Script Date: 1/11/2017 4:35:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Environment](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AppServer] [nvarchar](100) NULL,
	[AppPort] [int] NULL,
	[DBHostName] [nvarchar](100) NULL,
	[DBPortNumber] [int] NULL,
	[DBServiceName] [nvarchar](100) NULL,
	[DBUserId] [nvarchar](100) NULL,
	[DBPassword] [nvarchar](100) NULL,
 CONSTRAINT [PK_Environment] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TestCase]    Script Date: 1/11/2017 4:35:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TestCase](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NULL,
	[Template] [nvarchar](100) NULL,
	[Condition] [nvarchar](max) NULL,
 CONSTRAINT [PK_TestCases] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TestSuite]    Script Date: 1/11/2017 4:35:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TestSuite](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NULL,
	[TestCaseId] [int] NULL,
 CONSTRAINT [PK_TestSuite] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Authorization] ON 

INSERT [dbo].[Authorization] ([Id], [UserName], [Password], [Type]) VALUES (1, N'grails_user', N'u_pick_it', N'Basic')
INSERT [dbo].[Authorization] ([Id], [UserName], [Password], [Type]) VALUES (2, N'saisusr', N'u_pick_it', N'Basic')
SET IDENTITY_INSERT [dbo].[Authorization] OFF
SET IDENTITY_INSERT [dbo].[EndPoint] ON 

INSERT [dbo].[EndPoint] ([Id], [InstanceId], [Name]) VALUES (1, 1, N'academic-catalogs')
INSERT [dbo].[EndPoint] ([Id], [InstanceId], [Name]) VALUES (3, 1, N'account-funds-available-transactions')
INSERT [dbo].[EndPoint] ([Id], [InstanceId], [Name]) VALUES (4, 1, N'account-receivable-types')
INSERT [dbo].[EndPoint] ([Id], [InstanceId], [Name]) VALUES (5, 1, N'accounts-payable-invoices')
INSERT [dbo].[EndPoint] ([Id], [InstanceId], [Name]) VALUES (6, 1, N'admission-populations')
INSERT [dbo].[EndPoint] ([Id], [InstanceId], [Name]) VALUES (7, 1, N'admission-residency-types')
INSERT [dbo].[EndPoint] ([Id], [InstanceId], [Name]) VALUES (8, 1, N'advisor-types')
INSERT [dbo].[EndPoint] ([Id], [InstanceId], [Name]) VALUES (9, 1, N'aptitude-assessments')
INSERT [dbo].[EndPoint] ([Id], [InstanceId], [Name]) VALUES (10, 1, N'aptitude-assessment-types')
INSERT [dbo].[EndPoint] ([Id], [InstanceId], [Name]) VALUES (11, 1, N'assessment-calculation-methods')
INSERT [dbo].[EndPoint] ([Id], [InstanceId], [Name]) VALUES (12, 1, N'assessment-special-circumstances')
INSERT [dbo].[EndPoint] ([Id], [InstanceId], [Name]) VALUES (13, 1, N'billing-override-reasons')
INSERT [dbo].[EndPoint] ([Id], [InstanceId], [Name]) VALUES (14, 1, N'building-wings')
INSERT [dbo].[EndPoint] ([Id], [InstanceId], [Name]) VALUES (15, 1, N'buyers')
INSERT [dbo].[EndPoint] ([Id], [InstanceId], [Name]) VALUES (16, 1, N'course-levels')
INSERT [dbo].[EndPoint] ([Id], [InstanceId], [Name]) VALUES (17, 1, N'employment-performance-review-ratings')
INSERT [dbo].[EndPoint] ([Id], [InstanceId], [Name]) VALUES (18, 1, N'employment-performance-reviews')
INSERT [dbo].[EndPoint] ([Id], [InstanceId], [Name]) VALUES (19, 1, N'employment-performance-review-types')
INSERT [dbo].[EndPoint] ([Id], [InstanceId], [Name]) VALUES (20, 1, N'employment-proficiencies')
INSERT [dbo].[EndPoint] ([Id], [InstanceId], [Name]) VALUES (21, 1, N'employment-proficiency-levels')
INSERT [dbo].[EndPoint] ([Id], [InstanceId], [Name]) VALUES (22, 1, N'employment-vocations')
INSERT [dbo].[EndPoint] ([Id], [InstanceId], [Name]) VALUES (23, 1, N'external-employment-positions')
INSERT [dbo].[EndPoint] ([Id], [InstanceId], [Name]) VALUES (24, 1, N'external-employments')
INSERT [dbo].[EndPoint] ([Id], [InstanceId], [Name]) VALUES (25, 1, N'external-employment-statuses')
INSERT [dbo].[EndPoint] ([Id], [InstanceId], [Name]) VALUES (26, 1, N'floor-characteristics')
INSERT [dbo].[EndPoint] ([Id], [InstanceId], [Name]) VALUES (27, 1, N'free-on-board-types')
INSERT [dbo].[EndPoint] ([Id], [InstanceId], [Name]) VALUES (28, 1, N'housing-resident-types')
INSERT [dbo].[EndPoint] ([Id], [InstanceId], [Name]) VALUES (29, 1, N'identity-document-types')
INSERT [dbo].[EndPoint] ([Id], [InstanceId], [Name]) VALUES (30, 1, N'interest-areas')
INSERT [dbo].[EndPoint] ([Id], [InstanceId], [Name]) VALUES (31, 1, N'job-applications')
INSERT [dbo].[EndPoint] ([Id], [InstanceId], [Name]) VALUES (32, 1, N'job-application-sources')
INSERT [dbo].[EndPoint] ([Id], [InstanceId], [Name]) VALUES (33, 1, N'job-application-statuses')
INSERT [dbo].[EndPoint] ([Id], [InstanceId], [Name]) VALUES (34, 1, N'meal-plan-rates')
INSERT [dbo].[EndPoint] ([Id], [InstanceId], [Name]) VALUES (35, 1, N'meal-plans')
INSERT [dbo].[EndPoint] ([Id], [InstanceId], [Name]) VALUES (36, 1, N'meal-types')
INSERT [dbo].[EndPoint] ([Id], [InstanceId], [Name]) VALUES (37, 1, N'person-achievements')
INSERT [dbo].[EndPoint] ([Id], [InstanceId], [Name]) VALUES (38, 1, N'personal-relationship-statuses')
INSERT [dbo].[EndPoint] ([Id], [InstanceId], [Name]) VALUES (39, 1, N'person-employment-proficiencies')
INSERT [dbo].[EndPoint] ([Id], [InstanceId], [Name]) VALUES (40, 1, N'person-employment-references')
INSERT [dbo].[EndPoint] ([Id], [InstanceId], [Name]) VALUES (41, 1, N'person-holds')
INSERT [dbo].[EndPoint] ([Id], [InstanceId], [Name]) VALUES (42, 1, N'person-publications')
INSERT [dbo].[EndPoint] ([Id], [InstanceId], [Name]) VALUES (43, 1, N'privacy-statuses')
INSERT [dbo].[EndPoint] ([Id], [InstanceId], [Name]) VALUES (44, 1, N'proficiency-licensing-authorities')
INSERT [dbo].[EndPoint] ([Id], [InstanceId], [Name]) VALUES (45, 1, N'publication-types')
INSERT [dbo].[EndPoint] ([Id], [InstanceId], [Name]) VALUES (46, 1, N'purchase-classifications')
INSERT [dbo].[EndPoint] ([Id], [InstanceId], [Name]) VALUES (47, 1, N'purchase-orders')
INSERT [dbo].[EndPoint] ([Id], [InstanceId], [Name]) VALUES (48, 1, N'rehire-types')
INSERT [dbo].[EndPoint] ([Id], [InstanceId], [Name]) VALUES (49, 1, N'roommate-characteristics')
INSERT [dbo].[EndPoint] ([Id], [InstanceId], [Name]) VALUES (50, 1, N'rooms')
INSERT [dbo].[EndPoint] ([Id], [InstanceId], [Name]) VALUES (51, 1, N'rooms_room-availability')
INSERT [dbo].[EndPoint] ([Id], [InstanceId], [Name]) VALUES (52, 1, N'room-types')
INSERT [dbo].[EndPoint] ([Id], [InstanceId], [Name]) VALUES (53, 1, N'section-instructors')
INSERT [dbo].[EndPoint] ([Id], [InstanceId], [Name]) VALUES (54, 1, N'ship-to-destinations')
INSERT [dbo].[EndPoint] ([Id], [InstanceId], [Name]) VALUES (55, 1, N'social-media-types')
INSERT [dbo].[EndPoint] ([Id], [InstanceId], [Name]) VALUES (56, 1, N'source-context')
INSERT [dbo].[EndPoint] ([Id], [InstanceId], [Name]) VALUES (57, 1, N'student-advisor-relationships')
INSERT [dbo].[EndPoint] ([Id], [InstanceId], [Name]) VALUES (58, 1, N'student-aptitude-assessments')
INSERT [dbo].[EndPoint] ([Id], [InstanceId], [Name]) VALUES (59, 1, N'student-attendances')
INSERT [dbo].[EndPoint] ([Id], [InstanceId], [Name]) VALUES (60, 1, N'student-course-transfers')
INSERT [dbo].[EndPoint] ([Id], [InstanceId], [Name]) VALUES (61, 1, N'student-residential-categories')
INSERT [dbo].[EndPoint] ([Id], [InstanceId], [Name]) VALUES (62, 1, N'student-section-waitlists')
INSERT [dbo].[EndPoint] ([Id], [InstanceId], [Name]) VALUES (63, 1, N'vendors')
INSERT [dbo].[EndPoint] ([Id], [InstanceId], [Name]) VALUES (64, 1, N'veteran-statuses')
INSERT [dbo].[EndPoint] ([Id], [InstanceId], [Name]) VALUES (66, 1, N'requisitions')
INSERT [dbo].[EndPoint] ([Id], [InstanceId], [Name]) VALUES (67, 1, N'ledger-activities')
INSERT [dbo].[EndPoint] ([Id], [InstanceId], [Name]) VALUES (68, 1, N'financial-document-types')
INSERT [dbo].[EndPoint] ([Id], [InstanceId], [Name]) VALUES (69, 1, N'grants')
INSERT [dbo].[EndPoint] ([Id], [InstanceId], [Name]) VALUES (71, 1, N'accounting-string-component-values')
INSERT [dbo].[EndPoint] ([Id], [InstanceId], [Name]) VALUES (72, 1, N'fiscal-years')
INSERT [dbo].[EndPoint] ([Id], [InstanceId], [Name]) VALUES (73, 1, N'fiscal-periods')
INSERT [dbo].[EndPoint] ([Id], [InstanceId], [Name]) VALUES (74, 1, N'institution-jobs')
INSERT [dbo].[EndPoint] ([Id], [InstanceId], [Name]) VALUES (75, 1, N'institution-employers')
INSERT [dbo].[EndPoint] ([Id], [InstanceId], [Name]) VALUES (76, 1, N'institution-job-supervisors')
INSERT [dbo].[EndPoint] ([Id], [InstanceId], [Name]) VALUES (77, 1, N'employees')
INSERT [dbo].[EndPoint] ([Id], [InstanceId], [Name]) VALUES (78, 1, N'pay-classifications')
INSERT [dbo].[EndPoint] ([Id], [InstanceId], [Name]) VALUES (79, 1, N'pay-scales')
INSERT [dbo].[EndPoint] ([Id], [InstanceId], [Name]) VALUES (80, 1, N'leave-plans')
INSERT [dbo].[EndPoint] ([Id], [InstanceId], [Name]) VALUES (81, 1, N'leave-categories')
INSERT [dbo].[EndPoint] ([Id], [InstanceId], [Name]) VALUES (82, 1, N'employee-leave-transactions')
INSERT [dbo].[EndPoint] ([Id], [InstanceId], [Name]) VALUES (83, 1, N'leave-types')
INSERT [dbo].[EndPoint] ([Id], [InstanceId], [Name]) VALUES (84, 1, N'employee-leave-plans')
INSERT [dbo].[EndPoint] ([Id], [InstanceId], [Name]) VALUES (85, 1, N'institution-positions')
INSERT [dbo].[EndPoint] ([Id], [InstanceId], [Name]) VALUES (86, 1, N'housing-assignments')
INSERT [dbo].[EndPoint] ([Id], [InstanceId], [Name]) VALUES (88, 1, N'restricted-student-financial-aid-awards')
INSERT [dbo].[EndPoint] ([Id], [InstanceId], [Name]) VALUES (89, 1, N'student-financial-aid-awards')
INSERT [dbo].[EndPoint] ([Id], [InstanceId], [Name]) VALUES (90, 1, N'accounting-codes')
INSERT [dbo].[EndPoint] ([Id], [InstanceId], [Name]) VALUES (91, 1, N'accounting-code-categories')
INSERT [dbo].[EndPoint] ([Id], [InstanceId], [Name]) VALUES (92, 1, N'student-charges')
INSERT [dbo].[EndPoint] ([Id], [InstanceId], [Name]) VALUES (93, 1, N'student-payments')
INSERT [dbo].[EndPoint] ([Id], [InstanceId], [Name]) VALUES (94, 1, N'section-statuses')
INSERT [dbo].[EndPoint] ([Id], [InstanceId], [Name]) VALUES (95, 1, N'instructional-deliVery-method')
INSERT [dbo].[EndPoint] ([Id], [InstanceId], [Name]) VALUES (96, 1, N'meal-plan-requests')
INSERT [dbo].[EndPoint] ([Id], [InstanceId], [Name]) VALUES (97, 1, N'meal-plan-assignments')
INSERT [dbo].[EndPoint] ([Id], [InstanceId], [Name]) VALUES (98, 1, N'deduction-types')
INSERT [dbo].[EndPoint] ([Id], [InstanceId], [Name]) VALUES (99, 1, N'person-benefit-dependents')
INSERT [dbo].[EndPoint] ([Id], [InstanceId], [Name]) VALUES (100, 1, N'person-beneficiaries')
INSERT [dbo].[EndPoint] ([Id], [InstanceId], [Name]) VALUES (101, 1, N'deduction-categories')
INSERT [dbo].[EndPoint] ([Id], [InstanceId], [Name]) VALUES (102, 1, N'cost-calculation-methods')
INSERT [dbo].[EndPoint] ([Id], [InstanceId], [Name]) VALUES (103, 1, N'beneficiary-preference-types')
GO
INSERT [dbo].[EndPoint] ([Id], [InstanceId], [Name]) VALUES (104, 1, N'payroll-deductions')
INSERT [dbo].[EndPoint] ([Id], [InstanceId], [Name]) VALUES (105, 1, N'financial-aid-application-outcomes')
INSERT [dbo].[EndPoint] ([Id], [InstanceId], [Name]) VALUES (106, 1, N'financial-aid-applications')
INSERT [dbo].[EndPoint] ([Id], [InstanceId], [Name]) VALUES (107, 1, N'student-financial-aid-need-summaries')
INSERT [dbo].[EndPoint] ([Id], [InstanceId], [Name]) VALUES (108, 1, N'student-financial-aid-award-payments')
INSERT [dbo].[EndPoint] ([Id], [InstanceId], [Name]) VALUES (109, 1, N'restricted-student-financial-aid-award-payments')
INSERT [dbo].[EndPoint] ([Id], [InstanceId], [Name]) VALUES (111, 1, N'room-rates')
INSERT [dbo].[EndPoint] ([Id], [InstanceId], [Name]) VALUES (126, 1, N'housing-requests')
SET IDENTITY_INSERT [dbo].[EndPoint] OFF
SET IDENTITY_INSERT [dbo].[EndPointComponent] ON 

INSERT [dbo].[EndPointComponent] ([Id], [InstanceId], [EndPointComponentName], [Value]) VALUES (1, 1, N'AuthType', N'''Basic'';')
INSERT [dbo].[EndPointComponent] ([Id], [InstanceId], [EndPointComponentName], [Value]) VALUES (2, 1, N'UserName', N'DropDown=[
  "grails_user",
  "saisuser"
];')
INSERT [dbo].[EndPointComponent] ([Id], [InstanceId], [EndPointComponentName], [Value]) VALUES (3, 1, N'Password', N'switch (Component.UserName) {
    case ''grails_user'':
        DropDown=[
          "u_pick_it",
          "i_pick_it",
          "all_pick_it"
        ];
        //"u_pick_it";
        break;
    case ''saisuser'':
                /*DropDown=[
          "good",
          "great",
          "best"
        ];*/
        ''sai123'';
        break;
    
    default:
        //''good'';
        break;
}')
INSERT [dbo].[EndPointComponent] ([Id], [InstanceId], [EndPointComponentName], [Value]) VALUES (4, 1, N'Accept', N'''application/json'';')
INSERT [dbo].[EndPointComponent] ([Id], [InstanceId], [EndPointComponentName], [Value]) VALUES (5, 1, N'ContentType', N'''application/json'';')
INSERT [dbo].[EndPointComponent] ([Id], [InstanceId], [EndPointComponentName], [Value]) VALUES (6, 1, N'LanguageCode', N'''en-in'';')
INSERT [dbo].[EndPointComponent] ([Id], [InstanceId], [EndPointComponentName], [Value]) VALUES (7, 1, N'RequestMethod', N'''GET'';')
INSERT [dbo].[EndPointComponent] ([Id], [InstanceId], [EndPointComponentName], [Value]) VALUES (8, 1, N'RequestUrl', N'url=''http://''
+Component.Server
+'':''
+Component.Port
+''/''
+Component.App
+''/''
+Component.Connector
+''/''+Component.EndPoint;')
INSERT [dbo].[EndPointComponent] ([Id], [InstanceId], [EndPointComponentName], [Value]) VALUES (9, 1, N'RequestBody', N'''nice body'';')
INSERT [dbo].[EndPointComponent] ([Id], [InstanceId], [EndPointComponentName], [Value]) VALUES (10, 1, N'App', N'''StudentApi'';')
INSERT [dbo].[EndPointComponent] ([Id], [InstanceId], [EndPointComponentName], [Value]) VALUES (11, 1, N'Connector', N'''api'';')
INSERT [dbo].[EndPointComponent] ([Id], [InstanceId], [EndPointComponentName], [Value]) VALUES (12, 1, N'Version', N'''ver2'';')
INSERT [dbo].[EndPointComponent] ([Id], [InstanceId], [EndPointComponentName], [Value]) VALUES (13, 1, N'RawSchemaURL', N'SchemaUrl="https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/"
 + Component.EndPoint+
 ".json?at=refs%2Fheads%2F"
 + Component.Version
+".0";')
INSERT [dbo].[EndPointComponent] ([Id], [InstanceId], [EndPointComponentName], [Value]) VALUES (20, 1, N'Server', N'DropDown=[
  "m040145.ellucian.com",
  "149.24.38.75",
  "34.193.79.158",
  "52.201.103.2",
  "149.24.12.180",
  "52.202.27.120",
  "good go"
];')
INSERT [dbo].[EndPointComponent] ([Id], [InstanceId], [EndPointComponentName], [Value]) VALUES (21, 1, N'Port', N'switch (Component.Server) {
    case ''m040145.ellucian.com'':
        ''8088'';
        break;
    case ''149.24.38.75'':
        if(Component.App==''IntegrationApi'')
        ''7004'';
        else if(Component.App==''StudentApi'')
        ''7005'';
        break;
    case ''34.193.79.158'':
        ''7005'';
        break;
    case ''52.201.103.2'':
        ''7005'';
        break;
    case ''149.24.12.180'':
        ''8080'';
        break;
    case ''52.202.27.120'':
        ''7006'';
        break;
    
    default:
        // code
}')
INSERT [dbo].[EndPointComponent] ([Id], [InstanceId], [EndPointComponentName], [Value]) VALUES (22, 1, N'InsertQuery', NULL)
INSERT [dbo].[EndPointComponent] ([Id], [InstanceId], [EndPointComponentName], [Value]) VALUES (23, 1, N'TotalCountQuery', NULL)
SET IDENTITY_INSERT [dbo].[EndPointComponent] OFF
SET IDENTITY_INSERT [dbo].[EndPointObject] ON 

INSERT [dbo].[EndPointObject] ([Id], [EndPointId]) VALUES (93, 1)
INSERT [dbo].[EndPointObject] ([Id], [EndPointId]) VALUES (94, 3)
INSERT [dbo].[EndPointObject] ([Id], [EndPointId]) VALUES (97, 4)
INSERT [dbo].[EndPointObject] ([Id], [EndPointId]) VALUES (98, 5)
INSERT [dbo].[EndPointObject] ([Id], [EndPointId]) VALUES (99, 6)
INSERT [dbo].[EndPointObject] ([Id], [EndPointId]) VALUES (100, 109)
INSERT [dbo].[EndPointObject] ([Id], [EndPointId]) VALUES (103, 1)
INSERT [dbo].[EndPointObject] ([Id], [EndPointId]) VALUES (104, 1)
SET IDENTITY_INSERT [dbo].[EndPointObject] OFF
SET IDENTITY_INSERT [dbo].[EndPointObjectComponent] ON 

INSERT [dbo].[EndPointObjectComponent] ([Id], [Name], [Value], [EndPointObjectId]) VALUES (177, N'AuthType', N'''I was a girl now I am a boy named tom tim Yes.'';', 93)
INSERT [dbo].[EndPointObjectComponent] ([Id], [Name], [Value], [EndPointObjectId]) VALUES (178, N'UserName', NULL, 94)
INSERT [dbo].[EndPointObjectComponent] ([Id], [Name], [Value], [EndPointObjectId]) VALUES (182, N'AuthType', NULL, 94)
INSERT [dbo].[EndPointObjectComponent] ([Id], [Name], [Value], [EndPointObjectId]) VALUES (185, N'Version', N'''Ver6'';', 103)
INSERT [dbo].[EndPointObjectComponent] ([Id], [Name], [Value], [EndPointObjectId]) VALUES (186, N'App', N'''IntegrationApi'';', 93)
INSERT [dbo].[EndPointObjectComponent] ([Id], [Name], [Value], [EndPointObjectId]) VALUES (191, N'RequestUrl', N'Component.RequestUrl +''/''+''test'';', 93)
INSERT [dbo].[EndPointObjectComponent] ([Id], [Name], [Value], [EndPointObjectId]) VALUES (192, N'Version', N'''Ver9'';', 93)
INSERT [dbo].[EndPointObjectComponent] ([Id], [Name], [Value], [EndPointObjectId]) VALUES (196, N'InsertQuery', NULL, 93)
INSERT [dbo].[EndPointObjectComponent] ([Id], [Name], [Value], [EndPointObjectId]) VALUES (197, N'TotalCountQuery', N'''This is it'';', 93)
SET IDENTITY_INSERT [dbo].[EndPointObjectComponent] OFF
SET IDENTITY_INSERT [dbo].[EndPointObjectGroup] ON 

INSERT [dbo].[EndPointObjectGroup] ([Id], [EndPointObjectId], [Section]) VALUES (45, 93, N'9.8Release')
INSERT [dbo].[EndPointObjectGroup] ([Id], [EndPointObjectId], [Section]) VALUES (46, 100, N'9.8Release')
INSERT [dbo].[EndPointObjectGroup] ([Id], [EndPointObjectId], [Section]) VALUES (47, 103, N'9.8Release')
SET IDENTITY_INSERT [dbo].[EndPointObjectGroup] OFF
SET IDENTITY_INSERT [dbo].[Environment] ON 

INSERT [dbo].[Environment] ([Id], [AppServer], [AppPort], [DBHostName], [DBPortNumber], [DBServiceName], [DBUserId], [DBPassword]) VALUES (1, N'm040145.ellucian.com', 8088, N'149.24.38.229', 1521, N'BAN83', N'baninst1', N'u_pick_it')
INSERT [dbo].[Environment] ([Id], [AppServer], [AppPort], [DBHostName], [DBPortNumber], [DBServiceName], [DBUserId], [DBPassword]) VALUES (2, N'149.24.38.75', 7004, N'149.24.38.229', 1521, N'BAN83', N'baninst1', N'u_pick_it')
INSERT [dbo].[Environment] ([Id], [AppServer], [AppPort], [DBHostName], [DBPortNumber], [DBServiceName], [DBUserId], [DBPassword]) VALUES (3, N'34.193.79.158', 7005, N'149.24.38.229', 1521, N'BAN83', N'baninst1', N'u_pick_it')
INSERT [dbo].[Environment] ([Id], [AppServer], [AppPort], [DBHostName], [DBPortNumber], [DBServiceName], [DBUserId], [DBPassword]) VALUES (4, N'149.24.38.75', 7005, N'149.24.38.229', 1521, N'BAN83', N'baninst1', N'u_pick_it')
INSERT [dbo].[Environment] ([Id], [AppServer], [AppPort], [DBHostName], [DBPortNumber], [DBServiceName], [DBUserId], [DBPassword]) VALUES (5, N'52.201.103.2', 7005, N'149.24.38.229', 1521, N'BAN83', N'baninst1', N'u_pick_it')
INSERT [dbo].[Environment] ([Id], [AppServer], [AppPort], [DBHostName], [DBPortNumber], [DBServiceName], [DBUserId], [DBPassword]) VALUES (6, N'149.24.12.180', 8080, N'149.24.38.229', 1521, N'BAN83', N'baninst1', N'u_pick_it')
INSERT [dbo].[Environment] ([Id], [AppServer], [AppPort], [DBHostName], [DBPortNumber], [DBServiceName], [DBUserId], [DBPassword]) VALUES (7, N'52.202.27.120', 7006, N'149.24.38.229', 1521, N'BAN83', N'baninst1', N'u_pick_it')
SET IDENTITY_INSERT [dbo].[Environment] OFF
SET IDENTITY_INSERT [dbo].[Instance] ON 

INSERT [dbo].[Instance] ([Id], [InstanceName]) VALUES (1, N'Banner')
SET IDENTITY_INSERT [dbo].[Instance] OFF
SET IDENTITY_INSERT [dbo].[TestCase] ON 

INSERT [dbo].[TestCase] ([Id], [Name], [Template], [Condition]) VALUES (16, N'InvalidGuidHeaderMessageCheck', N'InvalidGuidHeaderMessage', N'{"Request":"GlobalSettings.Request"}')
INSERT [dbo].[TestCase] ([Id], [Name], [Template], [Condition]) VALUES (17, N'GuidHeaderMessageCheck', N'GuidHeaderMessage', N'{"Request":"GlobalSettings.Request"}')
INSERT [dbo].[TestCase] ([Id], [Name], [Template], [Condition]) VALUES (18, N'LatestVersionCheck', N'LatestVersion', N'{"Request":"GlobalSettings.Request","Version":"GlobalSettings.Version"}')
INSERT [dbo].[TestCase] ([Id], [Name], [Template], [Condition]) VALUES (19, N'ListHeaderMessageCheck', N'ListHeaderMessage', N'{"Request":"GlobalSettings.Request"}')
INSERT [dbo].[TestCase] ([Id], [Name], [Template], [Condition]) VALUES (21, N'SchemaValidationCheck', N'SchemaValidation', N'{"Request":"GlobalSettings.Request","RawschemaUrl":"GlobalSettings.RawschemaUrl"}')
INSERT [dbo].[TestCase] ([Id], [Name], [Template], [Condition]) VALUES (22, N'TotalCountCheck', N'TotalCount', N'{"Request":"GlobalSettings.Request","TotalCountQuery":"GlobalSettings.TotalCountQuery"}')
INSERT [dbo].[TestCase] ([Id], [Name], [Template], [Condition]) VALUES (23, N'MaxPageSizeCheck', N'MaxPageSize', N'{"Request":"GlobalSettings.Request"}')
SET IDENTITY_INSERT [dbo].[TestCase] OFF
ALTER TABLE [dbo].[EndPointObject]  WITH CHECK ADD  CONSTRAINT [FK_EndPointObject_EndPoint] FOREIGN KEY([EndPointId])
REFERENCES [dbo].[EndPoint] ([Id])
GO
ALTER TABLE [dbo].[EndPointObject] CHECK CONSTRAINT [FK_EndPointObject_EndPoint]
GO
ALTER TABLE [dbo].[EndPointObjectComponent]  WITH CHECK ADD  CONSTRAINT [FK_EndPointObjectComponent_EndPointObject] FOREIGN KEY([EndPointObjectId])
REFERENCES [dbo].[EndPointObject] ([Id])
GO
ALTER TABLE [dbo].[EndPointObjectComponent] CHECK CONSTRAINT [FK_EndPointObjectComponent_EndPointObject]
GO
ALTER TABLE [dbo].[EndPointObjectGroup]  WITH CHECK ADD  CONSTRAINT [FK_EndPointObjectGroup_EndPointObject] FOREIGN KEY([EndPointObjectId])
REFERENCES [dbo].[EndPointObject] ([Id])
GO
ALTER TABLE [dbo].[EndPointObjectGroup] CHECK CONSTRAINT [FK_EndPointObjectGroup_EndPointObject]
GO
/****** Object:  StoredProcedure [dbo].[Add_EndPoint_For_InstanceId]    Script Date: 1/11/2017 4:35:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Rekha Parmesh
-- Create date: Oct 2nd 2017
-- Description:	Adds a Nonduplicate Endpoint for a specific Instance in EndPoint Table
-- =============================================
CREATE PROCEDURE [dbo].[Add_EndPoint_For_InstanceId]
		@InstanceId int,
		@EndPointName nvarchar(1000)
AS
BEGIN
	SET NOCOUNT ON;
	  IF NOT EXISTS (SELECT * FROM EndPoint WHERE InstanceId=@InstanceId and Name=@EndPointName)	
		BEGIN
			BEGIN TRY
				BEGIN TRANSACTION;
      				INSERT INTO EndPoint(InstanceId, Name)
					OUTPUT INSERTED.Id,INSERTED.InstanceId,INSERTED.Name
					VALUES (@InstanceId,@EndPointName)
				COMMIT TRANSACTION;
				-- Severity 1 - 10 is informational Message;	
				RAISERROR ('Record Added Successfully', 10, 1);
				RETURN 0;			
			END TRY
			BEGIN CATCH
				IF @@TRANCOUNT > 0 ROLLBACK;
				DECLARE @ErrMsg AS NVARCHAR(4000) = '',
						@ErrSeverity AS INT = 0,
						@ErrState AS INT = 0;

				-- Server/ Database errors
				SELECT @ErrMsg = 'Error in Add_EndPoint_For_InstanceId : ' + ERROR_MESSAGE(), 
						@ErrSeverity = ERROR_SEVERITY(), 
						@ErrState = ERROR_STATE();

				RAISERROR (@ErrMsg, @ErrSeverity, @ErrState);
			END CATCH
		END
	  ELSE
		BEGIN
			RAISERROR ('Record Already Exists', 16, 1);
			RETURN 1;
		END
	RETURN
END
GO
/****** Object:  StoredProcedure [dbo].[Add_EndPointComponent_For_InstanceId]    Script Date: 1/11/2017 4:35:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Rekha Parmesh
-- Create date: Oct 2nd 2017
-- Description:	Adds a Nonduplicate EndPointComponent for a specific Instance in EndPointComponent Table
-- =============================================
CREATE PROCEDURE [dbo].[Add_EndPointComponent_For_InstanceId]
	@InstanceId int,
	@ComponentName nvarchar(200)
AS
BEGIN
	SET NOCOUNT ON;
	  IF NOT EXISTS (SELECT * FROM EndPointComponent WHERE InstanceId=@InstanceId and EndPointComponentName=@ComponentName)	
		BEGIN
			BEGIN TRY
				BEGIN TRANSACTION;
      				INSERT INTO EndPointComponent(InstanceId, EndPointComponentName)
					OUTPUT INSERTED.Id,INSERTED.InstanceId,INSERTED.EndPointComponentName,INSERTED.Value
					VALUES (@InstanceId,@ComponentName)
				COMMIT TRANSACTION;
				-- Severity 1 - 10 is informational Message;	
				RAISERROR ('Record Added Successfully', 10, 1);
				RETURN 0;			
			END TRY
			BEGIN CATCH
				IF @@TRANCOUNT > 0 ROLLBACK;
				DECLARE @ErrMsg AS NVARCHAR(4000) = '',
						@ErrSeverity AS INT = 0,
						@ErrState AS INT = 0;

				-- Server/ Database errors
				SELECT @ErrMsg = 'Add_EndPointComponent_For_InstanceId : ' + ERROR_MESSAGE(), 
						@ErrSeverity = ERROR_SEVERITY(), 
						@ErrState = ERROR_STATE();

				RAISERROR (@ErrMsg, @ErrSeverity, @ErrState);
			END CATCH
		END
	  ELSE
		BEGIN
			RAISERROR ('Record Already Exists', 16, 1);
			RETURN 1;
		END
	RETURN
END
GO
/****** Object:  StoredProcedure [dbo].[Add_EndPointObject_For_EndPointId]    Script Date: 1/11/2017 4:35:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Rekha Parmesh
-- Create date: Oct 2nd 2017
-- Description:	Adds EndpointObject for a specific EndPoint in EndPointObject Table
-- =============================================
CREATE PROCEDURE [dbo].[Add_EndPointObject_For_EndPointId]
		@EndPointId INT
AS
BEGIN
	SET NOCOUNT ON;
		BEGIN
			BEGIN TRY
				BEGIN TRANSACTION;
					INSERT INTO EndPointObject (EndPointId)
					OUTPUT INSERTED.Id,INSERTED.EndPointId
					VALUES        (@EndPointId)
				COMMIT TRANSACTION;
				-- Severity 1 - 10 is informational Message;	
				RAISERROR ('Record Added Successfully', 10, 1);
				RETURN 0;			
			END TRY
			BEGIN CATCH
				IF @@TRANCOUNT > 0 ROLLBACK;
				DECLARE @ErrMsg AS NVARCHAR(4000) = '',
						@ErrSeverity AS INT = 0,
						@ErrState AS INT = 0;

				-- Server/ Database errors
				SELECT @ErrMsg = 'Error in Add_EndPointObject_For_EndPointId : ' + ERROR_MESSAGE(), 
						@ErrSeverity = ERROR_SEVERITY(), 
						@ErrState = ERROR_STATE();

				RAISERROR (@ErrMsg, @ErrSeverity, @ErrState);
			END CATCH
		END
	RETURN
END
GO
/****** Object:  StoredProcedure [dbo].[Add_EndPointObjectComponent_For_EndPointObjectId]    Script Date: 1/11/2017 4:35:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Rekha Parmesh
-- Create date: Oct 2nd 2017
-- Description:	Adds a Nonduplicate EndPointComponent for a specific EndPointObject in EndPointComponent Table
-- =============================================
CREATE PROCEDURE [dbo].[Add_EndPointObjectComponent_For_EndPointObjectId]
	@EndPointObjectId int,
	@EndPointObjectComponentName nvarchar(200)

AS
BEGIN
	SET NOCOUNT ON;
	  IF NOT EXISTS (SELECT * FROM EndPointObjectComponent WHERE EndPointObjectId=@EndPointObjectId and Name=@EndPointObjectComponentName)	
		BEGIN
			BEGIN TRY
				BEGIN TRANSACTION;
      				INSERT INTO EndPointObjectComponent(EndPointObjectId,Name)
					OUTPUT INSERTED.Id,INSERTED.Name,INSERTED.EndPointObjectId,INSERTED.Value
					VALUES (@EndPointObjectId,@EndPointObjectComponentName)
				COMMIT TRANSACTION;
				-- Severity 1 - 10 is informational Message;	
				RAISERROR ('Record Added Successfully', 10, 1);
				RETURN 0;			
			END TRY
			BEGIN CATCH
				IF @@TRANCOUNT > 0 ROLLBACK;
				DECLARE @ErrMsg AS NVARCHAR(4000) = '',
						@ErrSeverity AS INT = 0,
						@ErrState AS INT = 0;

				-- Server/ Database errors
				SELECT @ErrMsg = 'Add_EndPointObjectComponent_For_EndPointObjectId : ' + ERROR_MESSAGE(), 
						@ErrSeverity = ERROR_SEVERITY(), 
						@ErrState = ERROR_STATE();

				RAISERROR (@ErrMsg, @ErrSeverity, @ErrState);
			END CATCH
		END
	  ELSE
		BEGIN
			RAISERROR ('Record Already Exists', 16, 1);
			RETURN 1;
		END
	RETURN
END
GO
/****** Object:  StoredProcedure [dbo].[Add_Instance]    Script Date: 1/11/2017 4:35:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Rekha Parmesh
-- Create date: Oct 2nd 2017
-- Description:	Adds Instance in Instance Table
-- =============================================
CREATE PROCEDURE [dbo].[Add_Instance]
		@InstaneName nvarchar(200)
AS
BEGIN
	SET NOCOUNT ON;
		BEGIN
			BEGIN TRY
				BEGIN TRANSACTION;
					INSERT INTO Instance(InstanceName)
					OUTPUT INSERTED.Id,INSERTED.InstanceName
					VALUES        (@InstaneName)
				COMMIT TRANSACTION;
				-- Severity 1 - 10 is informational Message;	
				RAISERROR ('Record Added Successfully', 10, 1);
				RETURN 0;			
			END TRY
			BEGIN CATCH
				IF @@TRANCOUNT > 0 ROLLBACK;
				DECLARE @ErrMsg AS NVARCHAR(4000) = '',
						@ErrSeverity AS INT = 0,
						@ErrState AS INT = 0;

				-- Server/ Database errors
				SELECT @ErrMsg = 'Error in Add_Instance : ' + ERROR_MESSAGE(), 
						@ErrSeverity = ERROR_SEVERITY(), 
						@ErrState = ERROR_STATE();

				RAISERROR (@ErrMsg, @ErrSeverity, @ErrState);
			END CATCH
		END
	RETURN
END
GO
/****** Object:  StoredProcedure [dbo].[Edit_EndPointComponentValue_For_EndPointComponentId]    Script Date: 1/11/2017 4:35:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Rekha Parmesh
-- Create date: Oct 3rd 2017
-- Description:	Update EndPointComponent Value for EndPointComponentId in EndPointComponent table
-- =============================================
CREATE PROCEDURE [dbo].[Edit_EndPointComponentValue_For_EndPointComponentId]
	@EndPointComponentId int,
	@EndPointComponentValue nvarchar(max)
AS
BEGIN
	SET NOCOUNT ON;
	  IF EXISTS (SELECT * FROM EndPointComponent WHERE Id = @EndPointComponentId)	
		BEGIN
			BEGIN TRY
				BEGIN TRANSACTION;				
					UPDATE EndPointComponent					
					SET Value = @EndPointComponentValue
					OUTPUT INSERTED.Id,INSERTED.InstanceId,INSERTED.EndPointComponentName,INSERTED.Value
					WHERE (Id = @EndPointComponentId)
				COMMIT TRANSACTION;
				-- Severity 1 - 10 is informational Message;	
				RAISERROR ('Record Edited Successfully', 10, 1);
				RETURN 0;			
			END TRY
			BEGIN CATCH
				IF @@TRANCOUNT > 0 ROLLBACK;
				DECLARE @ErrMsg AS NVARCHAR(4000) = '',
						@ErrSeverity AS INT = 0,
						@ErrState AS INT = 0;

				-- Server/ Database errors
				SELECT @ErrMsg = 'Edit_EndPointComponentValue_For_EndPointComponentId : ' + ERROR_MESSAGE(), 
						@ErrSeverity = ERROR_SEVERITY(), 
						@ErrState = ERROR_STATE();

				RAISERROR (@ErrMsg, @ErrSeverity, @ErrState);
			END CATCH
		END
	  ELSE
		BEGIN
			RAISERROR ('Record does not Exist', 16, 1);
			RETURN 1;
		END
	RETURN
END
GO
/****** Object:  StoredProcedure [dbo].[Edit_EndPointObjectComponentValue_For_EndPointObjectComponentId]    Script Date: 1/11/2017 4:35:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Rekha Parmesh
-- Create date: Oct 3rd 2017
-- Description:	Update EndPointObjectComponent Value for EndPointObjectComponentId in EndPointObjectComponent table
-- =============================================
CREATE PROCEDURE [dbo].[Edit_EndPointObjectComponentValue_For_EndPointObjectComponentId]
	@EndPointObjectComponentId int,
	@EndPointObjectComponentValue nvarchar(max)
AS
BEGIN
	SET NOCOUNT ON;
	  IF EXISTS (SELECT * FROM EndPointObjectComponent WHERE Id = @EndPointObjectComponentId)	
		BEGIN
			BEGIN TRY
				BEGIN TRANSACTION;				
					UPDATE EndPointObjectComponent					
					SET Value = @EndPointObjectComponentValue
					OUTPUT INSERTED.Id,INSERTED.Name,INSERTED.EndPointObjectId,INSERTED.Value
					WHERE (Id = @EndPointObjectComponentId)
				COMMIT TRANSACTION;
				-- Severity 1 - 10 is informational Message;	
				RAISERROR ('Record Edited Successfully', 10, 1);
				RETURN 0;			
			END TRY
			BEGIN CATCH
				IF @@TRANCOUNT > 0 ROLLBACK;
				DECLARE @ErrMsg AS NVARCHAR(4000) = '',
						@ErrSeverity AS INT = 0,
						@ErrState AS INT = 0;

				-- Server/ Database errors
				SELECT @ErrMsg = 'Edit_EndPointObjectComponentValue_For_EndPointObjectComponentId : ' + ERROR_MESSAGE(), 
						@ErrSeverity = ERROR_SEVERITY(), 
						@ErrState = ERROR_STATE();

				RAISERROR (@ErrMsg, @ErrSeverity, @ErrState);
			END CATCH
		END
	  ELSE
		BEGIN
			RAISERROR ('Record does not Exist', 16, 1);
			RETURN 1;
		END
	RETURN
END
GO
/****** Object:  StoredProcedure [dbo].[Group_EndPointObject_By_EndPointObjectId]    Script Date: 1/11/2017 4:35:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Rekha Parmesh
-- Create date: Oct 2nd 2017
-- Description:	Creates unique records of EndPointObjectId and GroupId in EndPointObjectGroup Table
-- =============================================
CREATE PROCEDURE [dbo].[Group_EndPointObject_By_EndPointObjectId]
	@EndPointObjectId int,
	@Section nvarchar(200)
AS
BEGIN
	SET NOCOUNT ON;
	  IF NOT EXISTS (SELECT * FROM EndPointObjectGroup WHERE EndPointObjectId=@EndPointObjectId and Section=@Section)	
		BEGIN
			BEGIN TRY
				BEGIN TRANSACTION;
      				INSERT INTO EndPointObjectGroup(EndPointObjectId,Section)
					OUTPUT INSERTED.Id,INSERTED.EndPointObjectId,INSERTED.Section
					VALUES (@EndPointObjectId,@Section)
				COMMIT TRANSACTION;
				-- Severity 1 - 10 is informational Message;	
				RAISERROR ('Record Added Successfully', 10, 1);
				RETURN 0;			
			END TRY
			BEGIN CATCH
				IF @@TRANCOUNT > 0 ROLLBACK;
				DECLARE @ErrMsg AS NVARCHAR(4000) = '',
						@ErrSeverity AS INT = 0,
						@ErrState AS INT = 0;

				-- Server/ Database errors
				SELECT @ErrMsg = 'Group_EndPointObject_By_EndPointObjectId : ' + ERROR_MESSAGE(), 
						@ErrSeverity = ERROR_SEVERITY(), 
						@ErrState = ERROR_STATE();

				RAISERROR (@ErrMsg, @ErrSeverity, @ErrState);
			END CATCH
		END
	  ELSE
		BEGIN
			RAISERROR ('Record Already Exists', 16, 1);
			RETURN 1;
		END
	RETURN
END
GO
/****** Object:  StoredProcedure [dbo].[Pivoted_EndPointObjectComponent_For_EndPointObjectGroupSection]    Script Date: 1/11/2017 4:35:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Rekha Parmesh
-- Create date: Oct 9th 2017
-- Description:	Pivoting the EndPointObjectComponents
-- =============================================
CREATE PROCEDURE [dbo].[Pivoted_EndPointObjectComponent_For_EndPointObjectGroupSection]
		@EndPointObjectGroupSection nvarchar(200)
AS

BEGIN
	SET NOCOUNT OFF;
	      DECLARE @cols AS NVARCHAR(MAX),
		          @query  AS NVARCHAR(MAX);
			BEGIN TRY
			
				SET @cols = STUFF((SELECT distinct ',' + QUOTENAME(c.ComponentName) 
					FROM (SELECT EndPoint, EndPointObjectId, EndPointObjectComponentId, 
						  EndPointObjectComponentName AS ComponentName, EndPointObjectComponentValue AS ComponentValue
						  FROM View_EndPointObjectComponent_By_EndPointObjectGroupIdWise
						  WHERE (EndPointObjectGroupSection = @EndPointObjectGroupSection)) c
					      FOR XML PATH(''), TYPE).value('.', 'NVARCHAR(MAX)'),1,1,'')

				SET @query = 'SELECT EndPointObjectId,EndPoint, ' + @cols + ' 
					FROM (SELECT EndPoint, EndPointObjectId, EndPointObjectComponentId, 
						  EndPointObjectComponentName AS ComponentName, EndPointObjectComponentValue AS ComponentValue
						  FROM View_EndPointObjectComponent_By_EndPointObjectGroupIdWise
						  WHERE (EndPointObjectGroupSection = '''+ @EndPointObjectGroupSection + ''')
							) X
						  PIVOT(Max(ComponentValue) FOR ComponentName IN (' + @cols + ')) P'

				EXEC SP_EXECUTESQL @query

				-- Severity 1 - 10 is informational Message;	
				RAISERROR ('Successfully Executed', 10, 1);
				RETURN 0;			
			END TRY
			BEGIN CATCH

				DECLARE @ErrMsg AS NVARCHAR(4000) = '',
						@ErrSeverity AS INT = 0,
						@ErrState AS INT = 0;

				-- Server/ Database errors
				SELECT @ErrMsg = 'Pivoted_EndPointObjectComponent_For_EndPointObjectGroupSection : ' + ERROR_MESSAGE(), 
						@ErrSeverity = ERROR_SEVERITY(), 
						@ErrState = ERROR_STATE();

				RAISERROR (@ErrMsg, @ErrSeverity, @ErrState);
			END CATCH
	RETURN
END
GO
/****** Object:  StoredProcedure [dbo].[Pivoted_EndPointObjectComponent_For_EndPointObjectId]    Script Date: 1/11/2017 4:35:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Rekha Parmesh
-- Create date: Oct 9th 2017
-- Description:	Pivoting the EndPointObjectComponents
-- =============================================
CREATE PROCEDURE [dbo].[Pivoted_EndPointObjectComponent_For_EndPointObjectId]
		@EndPointObjectId as int=93
AS

BEGIN
	SET NOCOUNT ON;
	      DECLARE @cols AS NVARCHAR(MAX),
		          @query  AS NVARCHAR(MAX);
			BEGIN TRY
			IF 1=0 BEGIN
    SET FMTONLY OFF
END
				SET @cols = STUFF((SELECT distinct ',' + QUOTENAME(c.ComponentName) 
					FROM (SELECT EndPoint, EndPointObjectId, EndPointObjectComponentId, 
						  EndPointObjectComponentName AS ComponentName, EndPointObjectComponentValue AS ComponentValue
					FROM View_EndPointObjectComponent_By_EndPointObjectIdWise
					WHERE (EndPointObjectId = @EndPointObjectId)) c
					FOR XML PATH(''), TYPE).value('.', 'NVARCHAR(MAX)'),1,1,'')

				SELECT @query = 'SELECT EndPointObjectId, EndPoint,' + @cols + ' 
					FROM (SELECT EndPoint, EndPointObjectId, EndPointObjectComponentId, 
						  EndPointObjectComponentName AS ComponentName, EndPointObjectComponentValue AS ComponentValue
					FROM View_EndPointObjectComponent_By_EndPointObjectIdWise
					WHERE (EndPointObjectId =' + CAST(@EndPointObjectId AS varchar(10)) + ')
					) X
					PIVOT(Max(ComponentValue) FOR ComponentName IN (' + @cols + ')) P'
				EXEC SP_EXECUTESQL @query

				-- Severity 1 - 10 is informational Message;	
				RAISERROR ('Successfully Executed', 10, 1);
				RETURN 0;			
			END TRY
			BEGIN CATCH

				DECLARE @ErrMsg AS NVARCHAR(4000) = '',
						@ErrSeverity AS INT = 0,
						@ErrState AS INT = 0;

				-- Server/ Database errors
				SELECT @ErrMsg = 'Pivoted_EndPointObjectComponent_For_EndPointObjectId : ' + ERROR_MESSAGE(), 
						@ErrSeverity = ERROR_SEVERITY(), 
						@ErrState = ERROR_STATE();

				RAISERROR (@ErrMsg, @ErrSeverity, @ErrState);
			END CATCH
	RETURN
	SET NOCOUNT OFF;
END

GO
/****** Object:  StoredProcedure [dbo].[Remove_EndPoint_By_EndPointId]    Script Date: 1/11/2017 4:35:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Rekha Parmesh
-- Create date: Oct 2nd 2017
-- Description:	Removes EndPoint in EndPoint Table 
-- =============================================
CREATE PROCEDURE [dbo].[Remove_EndPoint_By_EndPointId]
	@EndPointId int
AS
BEGIN
	SET NOCOUNT ON;
	  IF EXISTS (SELECT * FROM EndPoint WHERE Id=@EndPointId)	
		BEGIN
			BEGIN TRY
				BEGIN TRANSACTION;
					DELETE FROM EndPoint
					OUTPUT DELETED.Id, DELETED.InstanceId, DELETED.Name
					WHERE        (Id = @EndPointId)
				COMMIT TRANSACTION;
				-- Severity 1 - 10 is informational Message;	
				RAISERROR ('Record Removed Successfully', 10, 1);
				RETURN 0;			
			END TRY
			BEGIN CATCH
				IF @@TRANCOUNT > 0 ROLLBACK;
				DECLARE @ErrMsg AS NVARCHAR(4000) = '',
						@ErrSeverity AS INT = 0,
						@ErrState AS INT = 0;

				-- Server/ Database errors
				SELECT @ErrMsg = 'Error in Remove_EndPoint_By_EndPointId : ' + ERROR_MESSAGE(), 
						@ErrSeverity = ERROR_SEVERITY(), 
						@ErrState = ERROR_STATE();

				RAISERROR (@ErrMsg, @ErrSeverity, @ErrState);
			END CATCH
		END
	  ELSE
		BEGIN
			RAISERROR ('Record Does Not Exist', 16, 1);
			RETURN 1;
		END
	RETURN
END
GO
/****** Object:  StoredProcedure [dbo].[Remove_EndPointComponent_By_EndPointComponentId]    Script Date: 1/11/2017 4:35:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Rekha Parmesh
-- Create date: Oct 2nd 2017
-- Description:	Removes EndPointComponent in EndPointComponent Table 
-- =============================================
CREATE PROCEDURE [dbo].[Remove_EndPointComponent_By_EndPointComponentId]
	@EndPointComponentId int
AS
BEGIN
	SET NOCOUNT ON;
	  IF EXISTS (SELECT * FROM EndPointComponent WHERE Id=@EndPointComponentId)	
		BEGIN
			BEGIN TRY
				BEGIN TRANSACTION;
					DELETE FROM EndPointComponent
					OUTPUT DELETED.Id, DELETED.InstanceId, DELETED.Name,DELETED.Value
					WHERE        (Id = @EndPointComponentId)
				COMMIT TRANSACTION;
				-- Severity 1 - 10 is informational Message;	
				RAISERROR ('Record Removed Successfully', 10, 1);
				RETURN 0;			
			END TRY
			BEGIN CATCH
				IF @@TRANCOUNT > 0 ROLLBACK;
				DECLARE @ErrMsg AS NVARCHAR(4000) = '',
						@ErrSeverity AS INT = 0,
						@ErrState AS INT = 0;

				-- Server/ Database errors
				SELECT @ErrMsg = 'Error in Remove_EndPointComponent_By_EndPointComponentId : ' + ERROR_MESSAGE(), 
						@ErrSeverity = ERROR_SEVERITY(), 
						@ErrState = ERROR_STATE();

				RAISERROR (@ErrMsg, @ErrSeverity, @ErrState);
			END CATCH
		END
	  ELSE
		BEGIN
			RAISERROR ('Record Does Not Exist', 16, 1);
			RETURN 1;
		END
	RETURN
END
GO
/****** Object:  StoredProcedure [dbo].[Remove_EndPointObject_By_EndPointObjectId]    Script Date: 1/11/2017 4:35:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Rekha Parmesh
-- Create date: Oct 2nd 2017
-- Description:	Removes EndPointObject in EndPointObject Table 
-- =============================================
CREATE PROCEDURE [dbo].[Remove_EndPointObject_By_EndPointObjectId]
	@EndPointObjectId int
AS
BEGIN
	SET NOCOUNT ON;
	  IF EXISTS (SELECT * FROM EndPointObject WHERE Id=@EndPointObjectId)	
		BEGIN
			BEGIN TRY
				BEGIN TRANSACTION;
					DELETE FROM EndPointObject
					OUTPUT DELETED.Id, DELETED.EndPointId
					WHERE        (Id = @EndPointObjectId)
				COMMIT TRANSACTION;
				-- Severity 1 - 10 is informational Message;	
				RAISERROR ('Record Removed Successfully', 10, 1);
				RETURN 0;			
			END TRY
			BEGIN CATCH
				IF @@TRANCOUNT > 0 ROLLBACK;
				DECLARE @ErrMsg AS NVARCHAR(4000) = '',
						@ErrSeverity AS INT = 0,
						@ErrState AS INT = 0;

				-- Server/ Database errors
				SELECT @ErrMsg = 'Error in Remove_EndPointObject_By_EndPointObjectId : ' + ERROR_MESSAGE(), 
						@ErrSeverity = ERROR_SEVERITY(), 
						@ErrState = ERROR_STATE();

				RAISERROR (@ErrMsg, @ErrSeverity, @ErrState);
			END CATCH
		END
	  ELSE
		BEGIN
			RAISERROR ('Record Does Not Exist', 16, 1);
			RETURN 1;
		END
	RETURN
END
GO
/****** Object:  StoredProcedure [dbo].[Remove_EndPointObjectComponent_By_EndPointObjectComponentId]    Script Date: 1/11/2017 4:35:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Rekha Parmesh
-- Create date: Oct 2nd 2017
-- Description:	Removes EndPointObjectComponent in EndPointObjectComponent Table 
-- =============================================
CREATE PROCEDURE [dbo].[Remove_EndPointObjectComponent_By_EndPointObjectComponentId]
	@EndPointObjectComponentId int
AS
BEGIN
	SET NOCOUNT ON;
	  IF EXISTS (SELECT * FROM EndPointObjectComponent WHERE Id=@EndPointObjectComponentId)	
		BEGIN
			BEGIN TRY
				BEGIN TRANSACTION;
					DELETE FROM EndPointObjectComponent
					OUTPUT DELETED.Id,DELETED.EndPointObjectId,DELETED.Name,DELETED.Value
					WHERE        (Id = @EndPointObjectComponentId)
				COMMIT TRANSACTION;
				-- Severity 1 - 10 is informational Message;	
				RAISERROR ('Record Removed Successfully', 10, 1);
				RETURN 0;			
			END TRY
			BEGIN CATCH
				IF @@TRANCOUNT > 0 ROLLBACK;
				DECLARE @ErrMsg AS NVARCHAR(4000) = '',
						@ErrSeverity AS INT = 0,
						@ErrState AS INT = 0;

				-- Server/ Database errors
				SELECT @ErrMsg = 'Error in Remove_EndPointObjectComponent_By_EndPointObjectComponentId : ' + ERROR_MESSAGE(), 
						@ErrSeverity = ERROR_SEVERITY(), 
						@ErrState = ERROR_STATE();

				RAISERROR (@ErrMsg, @ErrSeverity, @ErrState);
			END CATCH
		END
	  ELSE
		BEGIN
			RAISERROR ('Record Does Not Exist', 16, 1);
			RETURN 1;
		END
	RETURN
END
GO
/****** Object:  StoredProcedure [dbo].[Remove_Instace_For_InstanceId]    Script Date: 1/11/2017 4:35:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Rekha Parmesh
-- Create date: Oct 2nd 2017
-- Description:	Removes Instance in Instance Table
-- =============================================
CREATE PROCEDURE [dbo].[Remove_Instace_For_InstanceId]
		@InstanceId int
AS
BEGIN
	SET NOCOUNT ON;
	  IF EXISTS (SELECT * FROM Instance WHERE Id=@InstanceId)	
		BEGIN
			BEGIN TRY
				BEGIN TRANSACTION;
					DELETE FROM Instance
					OUTPUT DELETED.Id, DELETED.InstanceName 
					WHERE        (Id = @InstanceId)
				COMMIT TRANSACTION;
				-- Severity 1 - 10 is informational Message;	
				RAISERROR ('Record Removed Successfully', 10, 1);
				RETURN 0;			
			END TRY
			BEGIN CATCH
				IF @@TRANCOUNT > 0 ROLLBACK;
				DECLARE @ErrMsg AS NVARCHAR(4000) = '',
						@ErrSeverity AS INT = 0,
						@ErrState AS INT = 0;

				-- Server/ Database errors
				SELECT @ErrMsg = 'Error in Remove_Instace_For_InstanceId : ' + ERROR_MESSAGE(), 
						@ErrSeverity = ERROR_SEVERITY(), 
						@ErrState = ERROR_STATE();

				RAISERROR (@ErrMsg, @ErrSeverity, @ErrState);
			END CATCH
		END
	  ELSE
		BEGIN
			RAISERROR ('Record Does Not Exist', 16, 1);
			RETURN 1;
		END
	RETURN
END
GO
/****** Object:  StoredProcedure [dbo].[UnGroup_EndPointObject_By_EndPointObjectGroupId]    Script Date: 1/11/2017 4:35:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Rekha Parmesh
-- Create date: Oct 2nd 2017
-- Description:	Removes the record that Groups with EndPointObjectId and GroupId in EndPointObjectGroup Table
-- =============================================
CREATE PROCEDURE [dbo].[UnGroup_EndPointObject_By_EndPointObjectGroupId]
	@EndPointObjectGroupId int
AS
BEGIN
	SET NOCOUNT ON;
	  IF EXISTS (SELECT * FROM EndPointObjectGroup WHERE Id=@EndPointObjectGroupId)	
		BEGIN
			BEGIN TRY
				BEGIN TRANSACTION;
					DELETE FROM EndPointObjectGroup
					OUTPUT DELETED.Id, DELETED.EndPointObjectId,DELETED.Section
					WHERE        (Id = @EndPointObjectGroupId)
				COMMIT TRANSACTION;
				-- Severity 1 - 10 is informational Message;	
				RAISERROR ('Record Removed Successfully', 10, 1);
				RETURN 0;			
			END TRY
			BEGIN CATCH
				IF @@TRANCOUNT > 0 ROLLBACK;
				DECLARE @ErrMsg AS NVARCHAR(4000) = '',
						@ErrSeverity AS INT = 0,
						@ErrState AS INT = 0;

				-- Server/ Database errors
				SELECT @ErrMsg = 'Error in UnGroup_EndPointObject_By_EndPointObjectGroupId : ' + ERROR_MESSAGE(), 
						@ErrSeverity = ERROR_SEVERITY(), 
						@ErrState = ERROR_STATE();

				RAISERROR (@ErrMsg, @ErrSeverity, @ErrState);
			END CATCH
		END
	  ELSE
		BEGIN
			RAISERROR ('Record Does Not Exist', 16, 1);
			RETURN 1;
		END
	RETURN
END
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "EndPointComponent"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 246
               Right = 379
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1995
         Width = 2070
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 2805
         Alias = 3390
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_EndPointComponent'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_EndPointComponent'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "EndPoint"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 119
               Right = 224
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Instance"
            Begin Extent = 
               Top = 6
               Left = 262
               Bottom = 102
               Right = 448
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "EndPointObject"
            Begin Extent = 
               Top = 6
               Left = 486
               Bottom = 102
               Right = 672
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 3390
         Alias = 3075
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_EndPointObject_By_Count'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_EndPointObject_By_Count'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[34] 4[25] 2[14] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "EndPointObjectGroup"
            Begin Extent = 
               Top = 13
               Left = 76
               Bottom = 143
               Right = 258
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Instance"
            Begin Extent = 
               Top = 6
               Left = 1131
               Bottom = 102
               Right = 1301
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "EndPoint"
            Begin Extent = 
               Top = 180
               Left = 0
               Bottom = 293
               Right = 170
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "EndPointObject"
            Begin Extent = 
               Top = 62
               Left = 418
               Bottom = 158
               Right = 588
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "EndPointObjectComponent"
            Begin Extent = 
               Top = 53
               Left = 661
               Bottom = 253
               Right = 872
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 12
         Width = 284
         Width = 2820
         Width = 2970
         Width = 2610
         Width = 2280
         Width = 2175
         Width = 1500
         Width = 2490
         Width = 2820
         Width = 1500
         Width = 3480
         Width = 1500
      End
   End
   B' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_EndPointObjectComponent_By_EndPointObjectGroupIdWise'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'egin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 3570
         Alias = 3630
         Table = 2880
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_EndPointObjectComponent_By_EndPointObjectGroupIdWise'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_EndPointObjectComponent_By_EndPointObjectGroupIdWise'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[28] 4[21] 2[18] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Instance"
            Begin Extent = 
               Top = 45
               Left = 44
               Bottom = 172
               Right = 214
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "EndPoint"
            Begin Extent = 
               Top = 37
               Left = 277
               Bottom = 150
               Right = 447
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "EndPointObject"
            Begin Extent = 
               Top = 38
               Left = 609
               Bottom = 149
               Right = 779
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "EndPointObjectComponent"
            Begin Extent = 
               Top = 184
               Left = 221
               Bottom = 397
               Right = 490
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "EndPointObjectGroup"
            Begin Extent = 
               Top = 54
               Left = 881
               Bottom = 184
               Right = 1063
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 10
         Width = 284
         Width = 1875
         Width = 1500
         Width = 1590
         Width = 2250
         Width = 2550
         Width = 3315
         Width = 2865
         Width = 2820
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidt' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_EndPointObjectComponent_By_EndPointObjectIdWise'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'hs = 12
         Column = 6225
         Alias = 4050
         Table = 3735
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_EndPointObjectComponent_By_EndPointObjectIdWise'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_EndPointObjectComponent_By_EndPointObjectIdWise'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[20] 2[11] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "EndPointObjectGroup"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 314
               Right = 370
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 2865
         Width = 3255
         Width = 3435
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 3540
         Table = 2640
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_EndPointObjectGroup_By_Count'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_EndPointObjectGroup_By_Count'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "EndPointObjectGroup"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 210
               Right = 338
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_EndPointObjectGroup_Distinct'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_EndPointObjectGroup_Distinct'
GO
USE [master]
GO
ALTER DATABASE [tbot] SET  READ_WRITE 
GO
