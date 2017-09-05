USE [master]
GO
/****** Object:  Database [tbot]    Script Date: 5/09/2017 11:10:00 PM ******/
CREATE DATABASE [tbot]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'tbot', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.SQLEXPRESS\MSSQL\DATA\tbot.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'tbot_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.SQLEXPRESS\MSSQL\DATA\tbot_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
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
/****** Object:  Table [dbo].[API]    Script Date: 5/09/2017 11:10:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[API](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[APP] [nvarchar](50) NULL,
	[Connector] [nvarchar](50) NULL,
	[EndPoint] [nvarchar](200) NULL,
	[Version] [nvarchar](50) NULL,
	[SchemaUrl] [nvarchar](max) NULL,
 CONSTRAINT [PK_API] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ApiGroup]    Script Date: 5/09/2017 11:10:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ApiGroup](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NULL,
	[ApiId] [int] NULL,
 CONSTRAINT [PK_ApiGroup] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Authorization]    Script Date: 5/09/2017 11:10:00 PM ******/
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
/****** Object:  Table [dbo].[Environment]    Script Date: 5/09/2017 11:10:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Environment](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AppServer] [nvarchar](100) NULL,
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
/****** Object:  Table [dbo].[TestCase]    Script Date: 5/09/2017 11:10:00 PM ******/
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
/****** Object:  Table [dbo].[TestSuite]    Script Date: 5/09/2017 11:10:00 PM ******/
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
SET IDENTITY_INSERT [dbo].[API] ON 

INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (430, N'StudentApi', N'api', N'academic-catalogs', N'Ver6', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/academic-catalogs.json?at=refs%2Fheads%2FVer6.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (431, N'IntegrationApi', N'api', N'account-funds-available-transactions', N'Ver8', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/account-funds-available-transactions.json?at=refs%2Fheads%2FVer8.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (432, N'StudentApi', N'api', N'account-receivable-types', N'Ver6', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/account-receivable-types.json?at=refs%2Fheads%2FVer6.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (433, N'IntegrationApi', N'api', N'accounts-payable-invoices', N'Ver8', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/accounts-payable-invoices.json?at=refs%2Fheads%2FVer8.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (434, N'StudentApi', N'api', N'admission-populations', N'Ver6', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/admission-populations.json?at=refs%2Fheads%2FVer6.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (435, N'StudentApi', N'api', N'admission-residency-types', N'Ver6', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/admission-residency-types.json?at=refs%2Fheads%2FVer6.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (436, N'StudentApi', N'api', N'advisor-types', N'Ver8', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/advisor-types.json?at=refs%2Fheads%2FVer8.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (437, N'StudentApi', N'api', N'aptitude-assessments', N'Ver6', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/aptitude-assessments.json?at=refs%2Fheads%2FVer6.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (438, N'StudentApi', N'api', N'aptitude-assessment-types', N'Ver6', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/aptitude-assessment-types.json?at=refs%2Fheads%2FVer6.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (439, N'StudentApi', N'api', N'assessment-calculation-methods', N'Ver6', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/assessment-calculation-methods.json?at=refs%2Fheads%2FVer6.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (440, N'StudentApi', N'api', N'assessment-special-circumstances', N'Ver6', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/assessment-special-circumstances.json?at=refs%2Fheads%2FVer6.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (441, N'StudentApi', N'api', N'billing-override-reasons', N'Ver8', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/billing-override-reasons.json?at=refs%2Fheads%2FVer8.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (442, N'IntegrationApi', N'api', N'building-wings', N'Ver6', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/building-wings.json?at=refs%2Fheads%2FVer6.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (443, N'IntegrationApi', N'api', N'buyers', N'Ver10', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/buyers.json?at=refs%2Fheads%2FVer10.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (444, N'StudentApi', N'api', N'course-levels', N'Ver6', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/course-levels.json?at=refs%2Fheads%2FVer6.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (445, N'IntegrationApi', N'api', N'employment-performance-review-ratings', N'Ver10', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/employment-performance-review-ratings.json?at=refs%2Fheads%2FVer10.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (446, N'IntegrationApi', N'api', N'employment-performance-reviews', N'Ver10', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/employment-performance-reviews.json?at=refs%2Fheads%2FVer10.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (447, N'IntegrationApi', N'api', N'employment-performance-review-types', N'Ver10', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/employment-performance-review-types.json?at=refs%2Fheads%2FVer10.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (448, N'IntegrationApi', N'api', N'employment-proficiencies', N'Ver10', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/employment-proficiencies.json?at=refs%2Fheads%2FVer10.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (449, N'IntegrationApi', N'api', N'employment-proficiency-levels', N'Ver10', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/employment-proficiency-levels.json?at=refs%2Fheads%2FVer10.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (450, N'IntegrationApi', N'api', N'employment-vocations', N'Ver10', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/employment-vocations.json?at=refs%2Fheads%2FVer10.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (451, N'IntegrationApi', N'api', N'external-employment-positions', N'Ver10', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/external-employment-positions.json?at=refs%2Fheads%2FVer10.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (452, N'IntegrationApi', N'api', N'external-employments', N'Ver10', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/external-employments.json?at=refs%2Fheads%2FVer10.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (453, N'IntegrationApi', N'api', N'external-employment-statuses', N'Ver10', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/external-employment-statuses.json?at=refs%2Fheads%2FVer10.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (454, N'IntegrationApi', N'api', N'floor-characteristics', N'Ver8', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/floor-characteristics.json?at=refs%2Fheads%2FVer8.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (455, N'IntegrationApi', N'api', N'free-on-board-types', N'Ver10', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/free-on-board-types.json?at=refs%2Fheads%2FVer10.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (456, N'IntegrationApi', N'api', N'housing-resident-types', N'Ver10', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/housing-resident-types.json?at=refs%2Fheads%2FVer10.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (457, N'IntegrationApi', N'api', N'identity-document-types', N'Ver6', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/identity-document-types.json?at=refs%2Fheads%2FVer6.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (458, N'IntegrationApi', N'api', N'interest-areas', N'Ver6', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/interest-areas.json?at=refs%2Fheads%2FVer6.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (459, N'IntegrationApi', N'api', N'job-applications', N'Ver10', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/job-applications.json?at=refs%2Fheads%2FVer10.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (460, N'IntegrationApi', N'api', N'job-application-sources', N'Ver10', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/job-application-sources.json?at=refs%2Fheads%2FVer10.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (461, N'IntegrationApi', N'api', N'job-application-statuses', N'Ver10', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/job-application-statuses.json?at=refs%2Fheads%2FVer10.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (462, N'StudentApi', N'api', N'meal-plan-rates', N'Ver10', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/meal-plan-rates.json?at=refs%2Fheads%2FVer10.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (463, N'StudentApi', N'api', N'meal-plans', N'Ver10', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/meal-plans.json?at=refs%2Fheads%2FVer10.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (464, N'StudentApi', N'api', N'meal-types', N'Ver10', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/meal-types.json?at=refs%2Fheads%2FVer10.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (465, N'IntegrationApi', N'api', N'person-achievements', N'Ver10', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/person-achievements.json?at=refs%2Fheads%2FVer10.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (466, N'IntegrationApi', N'api', N'personal-relationship-statuses', N'Ver6', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/personal-relationship-statuses.json?at=refs%2Fheads%2FVer6.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (467, N'IntegrationApi', N'api', N'person-employment-proficiencies', N'Ver10', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/person-employment-proficiencies.json?at=refs%2Fheads%2FVer10.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (468, N'IntegrationApi', N'api', N'person-employment-references', N'Ver10', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/person-employment-references.json?at=refs%2Fheads%2FVer10.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (469, N'StudentApi', N'api', N'person-holds', N'Ver6', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/person-holds.json?at=refs%2Fheads%2FVer6.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (470, N'IntegrationApi', N'api', N'person-publications', N'Ver10', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/person-publications.json?at=refs%2Fheads%2FVer10.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (471, N'IntegrationApi', N'api', N'privacy-statuses', N'Ver6', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/privacy-statuses.json?at=refs%2Fheads%2FVer6.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (472, N'IntegrationApi', N'api', N'proficiency-licensing-authorities', N'Ver10', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/proficiency-licensing-authorities.json?at=refs%2Fheads%2FVer10.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (473, N'IntegrationApi', N'api', N'publication-types', N'Ver10', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/publication-types.json?at=refs%2Fheads%2FVer10.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (474, N'IntegrationApi', N'api', N'purchase-classifications', N'Ver10', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/purchase-classifications.json?at=refs%2Fheads%2FVer10.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (475, N'IntegrationApi', N'api', N'purchase-orders', N'Ver10', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/purchase-orders.json?at=refs%2Fheads%2FVer10.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (476, N'IntegrationApi', N'api', N'rehire-types', N'Ver7', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/rehire-types.json?at=refs%2Fheads%2FVer7.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (477, N'IntegrationApi', N'api', N'roommate-characteristics', N'Ver8', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/roommate-characteristics.json?at=refs%2Fheads%2FVer8.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (478, N'IntegrationApi', N'api', N'rooms', N'Ver10', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/rooms.json?at=refs%2Fheads%2FVer10.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (479, N'StudentApi', N'api', N'rooms_room-availability', N'Ver10', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/rooms_room-availability.json?at=refs%2Fheads%2FVer10.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (480, N'IntegrationApi', N'api', N'room-types', N'Ver10', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/room-types.json?at=refs%2Fheads%2FVer10.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (481, N'StudentApi', N'api', N'section-instructors', N'Ver10', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/section-instructors.json?at=refs%2Fheads%2FVer10.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (482, N'IntegrationApi', N'api', N'ship-to-destinations', N'Ver10', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/ship-to-destinations.json?at=refs%2Fheads%2FVer10.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (483, N'IntegrationApi', N'api', N'social-media-types', N'Ver6', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/social-media-types.json?at=refs%2Fheads%2FVer6.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (484, N'IntegrationApi', N'api', N'source-context', N'Ver6', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/source-context.json?at=refs%2Fheads%2FVer6.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (485, N'StudentApi', N'api', N'student-advisor-relationships', N'Ver10', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/student-advisor-relationships.json?at=refs%2Fheads%2FVer10.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (486, N'StudentApi', N'api', N'student-aptitude-assessments', N'Ver9', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/student-aptitude-assessments.json?at=refs%2Fheads%2FVer9.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (487, N'StudentApi', N'api', N'student-attendances', N'Ver10', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/student-attendances.json?at=refs%2Fheads%2FVer10.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (488, N'StudentApi', N'api', N'student-course-transfers', N'Ver10', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/student-course-transfers.json?at=refs%2Fheads%2FVer10.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (489, N'StudentApi', N'api', N'student-residential-categories', N'Ver10', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/student-residential-categories.json?at=refs%2Fheads%2FVer10.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (490, N'StudentApi', N'api', N'student-section-waitlists', N'Ver10', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/student-section-waitlists.json?at=refs%2Fheads%2FVer10.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (491, N'IntegrationApi', N'api', N'vendors', N'Ver8', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/vendors.json?at=refs%2Fheads%2FVer8.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (492, N'IntegrationApi', N'api', N'veteran-statuses', N'Ver9', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/veteran-statuses.json?at=refs%2Fheads%2FVer9.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (493, N'IntegrationApi', N'api', N'accounts-payable-invoices', N'Ver11', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/accounts-payable-invoices.json?at=refs%2Fheads%2FVer11.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (494, N'IntegrationApi', N'api', N'requisitions', N'Ver11', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/requisitions.json?at=refs%2Fheads%2FVer11.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (495, N'IntegrationApi', N'api', N'ledger-activities', N'Ver11', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/ledger-activities.json?at=refs%2Fheads%2FVer11.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (496, N'IntegrationApi', N'api', N'financial-document-types', N'Ver11', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/financial-document-types.json?at=refs%2Fheads%2FVer11.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (497, N'IntegrationApi', N'api', N'grants', N'Ver11', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/grants.json?at=refs%2Fheads%2FVer11.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (498, N'IntegrationApi', N'api', N'purchase-orders', N'Ver11', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/purchase-orders.json?at=refs%2Fheads%2FVer11.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (499, N'IntegrationApi', N'api', N'accounting-string-component-values', N'Ver11', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/accounting-string-component-values.json?at=refs%2Fheads%2FVer11.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (500, N'IntegrationApi', N'api', N'fiscal-years', N'Ver11', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/fiscal-years.json?at=refs%2Fheads%2FVer11.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (501, N'IntegrationApi', N'api', N'fiscal-periods', N'Ver11', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/fiscal-periods.json?at=refs%2Fheads%2FVer11.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (502, N'IntegrationApi', N'api', N'institution-jobs', N'Ver11', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/institution-jobs.json?at=refs%2Fheads%2FVer11.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (503, N'IntegrationApi', N'api', N'institution-employers', N'Ver11', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/institution-employers.json?at=refs%2Fheads%2FVer11.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (504, N'IntegrationApi', N'api', N'institution-job-supervisors', N'Ver11', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/institution-job-supervisors.json?at=refs%2Fheads%2FVer11.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (505, N'IntegrationApi', N'api', N'employees', N'Ver11', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/employees.json?at=refs%2Fheads%2FVer11.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (506, N'IntegrationApi', N'api', N'pay-classifications', N'Ver11', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/pay-classifications.json?at=refs%2Fheads%2FVer11.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (507, N'IntegrationApi', N'api', N'pay-scales', N'Ver11', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/pay-scales.json?at=refs%2Fheads%2FVer11.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (508, N'IntegrationApi', N'api', N'leave-plans', N'Ver11', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/leave-plans.json?at=refs%2Fheads%2FVer11.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (509, N'IntegrationApi', N'api', N'leave-categories', N'Ver11', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/leave-categories.json?at=refs%2Fheads%2FVer11.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (510, N'IntegrationApi', N'api', N'employee-leave-transactions', N'Ver11', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/employee-leave-transactions.json?at=refs%2Fheads%2FVer11.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (511, N'IntegrationApi', N'api', N'leave-types', N'Ver11', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/leave-types.json?at=refs%2Fheads%2FVer11.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (512, N'IntegrationApi', N'api', N'employee-leave-plans', N'Ver11', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/employee-leave-plans.json?at=refs%2Fheads%2FVer11.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (513, N'IntegrationApi', N'api', N'institution-positions', N'Ver11', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/institution-positions.json?at=refs%2Fheads%2FVer11.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (514, N'StudentApi', N'api', N'housing-assignments', N'Ver10', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/housing-assignments.json?at=refs%2Fheads%2FVer10.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (515, N'IntegrationApi', N'api', N'vendors', N'Ver11', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/vendors.json?at=refs%2Fheads%2FVer11.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (516, N'StudentApi', N'api', N'restricted-student-financial-aid-awards', N'Ver11', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/restricted-student-financial-aid-awards.json?at=refs%2Fheads%2FVer11.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (517, N'StudentApi', N'api', N'student-financial-aid-awards', N'Ver11', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/student-financial-aid-awards.json?at=refs%2Fheads%2FVer11.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (518, N'StudentApi', N'api', N'accounting-codes', N'Ver11', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/accounting-codes.json?at=refs%2Fheads%2FVer11.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (519, N'StudentApi', N'api', N'accounting-code-categories', N'Ver11', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/accounting-code-categories.json?at=refs%2Fheads%2FVer11.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (520, N'StudentApi', N'api', N'student-charges', N'Ver11', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/student-charges.json?at=refs%2Fheads%2FVer11.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (521, N'StudentApi', N'api', N'student-payments', N'Ver11', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/student-payments.json?at=refs%2Fheads%2FVer11.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (522, N'StudentApi', N'api', N'section-statuses', N'Ver11', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/section-statuses.json?at=refs%2Fheads%2FVer11.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (523, N'StudentApi', N'api', N'instructional-deliVery-method', N'Ver11', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/instructional-deliVery-method.json?at=refs%2Fheads%2FVer11.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (524, N'StudentApi', N'api', N'meal-plan-requests', N'Ver10', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/meal-plan-requests.json?at=refs%2Fheads%2FVer10.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (525, N'StudentApi', N'api', N'meal-plan-assignments', N'Ver10', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/meal-plan-assignments.json?at=refs%2Fheads%2FVer10.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (526, N'IntegrationApi', N'api', N'deduction-types', N'Ver11', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/deduction-types.json?at=refs%2Fheads%2FVer11.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (527, N'IntegrationApi', N'api', N'person-benefit-dependents', N'Ver11', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/person-benefit-dependents.json?at=refs%2Fheads%2FVer11.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (528, N'IntegrationApi', N'api', N'person-beneficiaries', N'Ver11', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/person-beneficiaries.json?at=refs%2Fheads%2FVer11.0')
GO
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (529, N'IntegrationApi', N'api', N'deduction-categories', N'Ver11', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/deduction-categories.json?at=refs%2Fheads%2FVer11.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (530, N'IntegrationApi', N'api', N'cost-calculation-methods', N'Ver11', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/cost-calculation-methods.json?at=refs%2Fheads%2FVer11.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (531, N'IntegrationApi', N'api', N'beneficiary-preference-types', N'Ver11', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/beneficiary-preference-types.json?at=refs%2Fheads%2FVer11.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (532, N'IntegrationApi', N'api', N'payroll-deductions', N'Ver11', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/payroll-deductions.json?at=refs%2Fheads%2FVer11.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (533, N'StudentApi', N'api', N'financial-aid-application-outcomes', N'Ver9', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/financial-aid-application-outcomes.json?at=refs%2Fheads%2FVer9.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (534, N'StudentApi', N'api', N'financial-aid-applications', N'Ver9', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/financial-aid-applications.json?at=refs%2Fheads%2FVer9.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (535, N'StudentApi', N'api', N'student-financial-aid-need-summaries', N'Ver9', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/student-financial-aid-need-summaries.json?at=refs%2Fheads%2FVer9.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (536, N'StudentApi', N'api', N'student-financial-aid-award-payments', N'Ver11', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/student-financial-aid-award-payments.json?at=refs%2Fheads%2FVer11.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (537, N'StudentApi', N'api', N'restricted-student-financial-aid-award-payments', N'Ver11', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/restricted-student-financial-aid-award-payments.json?at=refs%2Fheads%2FVer11.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (538, N'StudentApi', N'api', N'housing-requests', N'Ver10', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/housing-requests.json?at=refs%2Fheads%2FVer10.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (539, N'StudentApi', N'api', N'room-rates', N'Ver10', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/room-rates.json?at=refs%2Fheads%2FVer10.0')
SET IDENTITY_INSERT [dbo].[API] OFF
SET IDENTITY_INSERT [dbo].[Authorization] ON 

INSERT [dbo].[Authorization] ([Id], [UserName], [Password], [Type]) VALUES (1, N'grails_user', N'u_pick_it', N'Basic')
INSERT [dbo].[Authorization] ([Id], [UserName], [Password], [Type]) VALUES (2, N'saisusr', N'u_pick_it', N'Basic')
SET IDENTITY_INSERT [dbo].[Authorization] OFF
SET IDENTITY_INSERT [dbo].[Environment] ON 

INSERT [dbo].[Environment] ([Id], [AppServer], [DBHostName], [DBPortNumber], [DBServiceName], [DBUserId], [DBPassword]) VALUES (1, N'm040145.ellucian.com:8088', N'149.24.38.229', 1521, N'BAN83', N'baninst1', N'u_pick_it')
INSERT [dbo].[Environment] ([Id], [AppServer], [DBHostName], [DBPortNumber], [DBServiceName], [DBUserId], [DBPassword]) VALUES (2, N'149.24.38.75:7004', N'149.24.38.229', 1521, N'BAN83', N'baninst1', N'u_pick_it')
INSERT [dbo].[Environment] ([Id], [AppServer], [DBHostName], [DBPortNumber], [DBServiceName], [DBUserId], [DBPassword]) VALUES (3, N'34.193.79.158:7005', N'149.24.38.229', 1521, N'BAN83', N'baninst1', N'u_pick_it')
INSERT [dbo].[Environment] ([Id], [AppServer], [DBHostName], [DBPortNumber], [DBServiceName], [DBUserId], [DBPassword]) VALUES (4, N'149.24.38.75:7005', N'149.24.38.229', 1521, N'BAN83', N'baninst1', N'u_pick_it')
INSERT [dbo].[Environment] ([Id], [AppServer], [DBHostName], [DBPortNumber], [DBServiceName], [DBUserId], [DBPassword]) VALUES (5, N'52.201.103.2:7005', N'149.24.38.229', 1521, N'BAN83', N'baninst1', N'u_pick_it')
INSERT [dbo].[Environment] ([Id], [AppServer], [DBHostName], [DBPortNumber], [DBServiceName], [DBUserId], [DBPassword]) VALUES (6, N'149.24.12.180:8080', N'149.24.38.229', 1521, N'BAN83', N'baninst1', N'u_pick_it')
INSERT [dbo].[Environment] ([Id], [AppServer], [DBHostName], [DBPortNumber], [DBServiceName], [DBUserId], [DBPassword]) VALUES (7, N'52.202.27.120:7006', N'149.24.38.229', 1521, N'BAN83', N'baninst1', N'u_pick_it')
SET IDENTITY_INSERT [dbo].[Environment] OFF
SET IDENTITY_INSERT [dbo].[TestCase] ON 

INSERT [dbo].[TestCase] ([Id], [Name], [Template], [Condition]) VALUES (16, N'InvalidGuidHeaderMessageCheck', N'InvalidGuidHeaderMessage', N'{"Request":"GlobalSettings.Request"}')
INSERT [dbo].[TestCase] ([Id], [Name], [Template], [Condition]) VALUES (17, N'GuidHeaderMessageCheck', N'GuidHeaderMessage', N'{"Request":"GlobalSettings.Request"}')
INSERT [dbo].[TestCase] ([Id], [Name], [Template], [Condition]) VALUES (18, N'LatestVersionCheck', N'LatestVersion', N'{"Request":"GlobalSettings.Request","Version":"GlobalSettings.Version"}')
INSERT [dbo].[TestCase] ([Id], [Name], [Template], [Condition]) VALUES (19, N'ListHeaderMessageCheck', N'ListHeaderMessage', N'{"Request":"GlobalSettings.Request"}')
INSERT [dbo].[TestCase] ([Id], [Name], [Template], [Condition]) VALUES (21, N'SchemaValidationCheck', N'SchemaValidation', N'{"Request":"GlobalSettings.Request","RawschemaUrl":"GlobalSettings.RawschemaUrl"}')
INSERT [dbo].[TestCase] ([Id], [Name], [Template], [Condition]) VALUES (22, N'TotalCountCheck', N'TotalCount', N'{"Request":"GlobalSettings.Request","TotalCountQuery":"GlobalSettings.TotalCountQuery"}')
INSERT [dbo].[TestCase] ([Id], [Name], [Template], [Condition]) VALUES (23, N'MaxPageSizeCheck', N'MaxPageSize', N'{"Request":"GlobalSettings.Request"}')
SET IDENTITY_INSERT [dbo].[TestCase] OFF
USE [master]
GO
ALTER DATABASE [tbot] SET  READ_WRITE 
GO
