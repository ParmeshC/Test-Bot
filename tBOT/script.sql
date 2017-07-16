USE [master]
GO
/****** Object:  Database [tbot]    Script Date: 16/07/2017 5:30:54 PM ******/
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
/****** Object:  Table [dbo].[API]    Script Date: 16/07/2017 5:30:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[API](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[APP] [nvarchar](50) NULL,
	[Connector] [nvarchar](50) NULL,
	[EndPoint] [nvarchar](50) NULL,
	[Version] [nvarchar](50) NULL,
	[SchemaUrl] [nvarchar](150) NULL,
 CONSTRAINT [PK_API] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Authorization]    Script Date: 16/07/2017 5:30:54 PM ******/
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
/****** Object:  Table [dbo].[Environment]    Script Date: 16/07/2017 5:30:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Environment](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Server] [nvarchar](100) NULL,
 CONSTRAINT [PK_Environment] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[API] ON 

INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (257, N'IntegrationApi', N'api', N'accounts-payable-invoices', N'Ver8', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/accounts-payable-invoices.json?at=refs%2Fheads%2FVer8.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (258, N'IntegrationApi', N'api', N'vendors', N'Ver8', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/vendors.json?at=refs%2Fheads%2FVer8.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (259, N'IntegrationApi', N'api', N'account-funds-available-transactions', N'Ver8', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/account-funds-available-transactions.json?at=refs%2Fheads%2FVer8.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (260, N'IntegrationApi', N'api', N'purchase-orders', N'Ver10', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/purchase-orders.json?at=refs%2Fheads%2FVer10.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (261, N'IntegrationApi', N'api', N'buyers', N'Ver10', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/buyers.json?at=refs%2Fheads%2FVer10.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (262, N'IntegrationApi', N'api', N'ship-to-destinations', N'Ver10', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/ship-to-destinations.json?at=refs%2Fheads%2FVer10.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (263, N'IntegrationApi', N'api', N'free-on-board-types', N'Ver10', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/free-on-board-types.json?at=refs%2Fheads%2FVer10.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (264, N'IntegrationApi', N'api', N'purchase-classifications', N'Ver10', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/purchase-classifications.json?at=refs%2Fheads%2FVer10.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (265, N'IntegrationApi', N'api', N'employment-proficiencies', N'Ver10', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/employment-proficiencies.json?at=refs%2Fheads%2FVer10.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (266, N'IntegrationApi', N'api', N'external-employments', N'Ver10', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/external-employments.json?at=refs%2Fheads%2FVer10.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (267, N'IntegrationApi', N'api', N'job-applications', N'Ver10', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/job-applications.json?at=refs%2Fheads%2FVer10.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (268, N'IntegrationApi', N'api', N'job-application-sources', N'Ver10', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/job-application-sources.json?at=refs%2Fheads%2FVer10.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (269, N'IntegrationApi', N'api', N'job-application-statuses', N'Ver10', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/job-application-statuses.json?at=refs%2Fheads%2FVer10.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (270, N'IntegrationApi', N'api', N'proficiency-licensing-authorities', N'Ver10', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/proficiency-licensing-authorities.json?at=refs%2Fheads%2FVer10.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (271, N'IntegrationApi', N'api', N'person-achievements', N'Ver10', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/person-achievements.json?at=refs%2Fheads%2FVer10.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (272, N'IntegrationApi', N'api', N'person-employment-proficiencies', N'Ver10', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/person-employment-proficiencies.json?at=refs%2Fheads%2FVer10.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (273, N'IntegrationApi', N'api', N'employment-proficiency-levels', N'Ver10', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/employment-proficiency-levels.json?at=refs%2Fheads%2FVer10.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (274, N'IntegrationApi', N'api', N'person-employment-references', N'Ver10', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/person-employment-references.json?at=refs%2Fheads%2FVer10.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (275, N'IntegrationApi', N'api', N'person-publications', N'Ver10', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/person-publications.json?at=refs%2Fheads%2FVer10.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (276, N'IntegrationApi', N'api', N'publication-types', N'Ver10', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/publication-types.json?at=refs%2Fheads%2FVer10.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (277, N'StudentApi', N'api', N'section-instructors', N'Ver10', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/section-instructors.json?at=refs%2Fheads%2FVer10.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (278, N'StudentApi', N'api', N'meal-plan-rates', N'Ver10', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/meal-plan-rates.json?at=refs%2Fheads%2FVer10.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (279, N'StudentApi', N'api', N'meal-plans', N'Ver10', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/meal-plans.json?at=refs%2Fheads%2FVer10.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (280, N'StudentApi', N'api', N'advisor-types', N'Ver8', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/advisor-types.json?at=refs%2Fheads%2FVer8.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (281, N'StudentApi', N'api', N'student-advisor-relationships', N'Ver10', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/student-advisor-relationships.json?at=refs%2Fheads%2FVer10.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (282, N'StudentApi', N'api', N'student-course-transfers', N'Ver10', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/student-course-transfers.json?at=refs%2Fheads%2FVer10.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (283, N'StudentApi', N'api', N'student-attendances', N'Ver10', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/student-attendances.json?at=refs%2Fheads%2FVer10.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (284, N'IntegrationApi', N'api', N'rooms', N'Ver10', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/rooms.json?at=refs%2Fheads%2FVer10.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (285, N'IntegrationApi', N'api', N'room-types', N'Ver10', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/room-types.json?at=refs%2Fheads%2FVer10.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (286, N'StudentApi', N'api', N'rooms_room-availability', N'Ver10', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/rooms_room-availability.json?at=refs%2Fheads%2FVer10.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (287, N'StudentApi', N'api', N'aptitude-assessments', N'Ver6', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/aptitude-assessments.json?at=refs%2Fheads%2FVer6.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (288, N'StudentApi', N'api', N'student-aptitude-assessments', N'Ver9', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/student-aptitude-assessments.json?at=refs%2Fheads%2FVer9.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (289, N'StudentApi', N'api', N'admission-populations', N'Ver6', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/admission-populations.json?at=refs%2Fheads%2FVer6.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (290, N'StudentApi', N'api', N'person-holds', N'Ver6', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/person-holds.json?at=refs%2Fheads%2FVer6.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (291, N'StudentApi', N'api', N'student-section-waitlists', N'Ver10', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/student-section-waitlists.json?at=refs%2Fheads%2FVer10.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (292, N'IntegrationApi', N'api', N'employment-performance-reviews', N'Ver10', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/employment-performance-reviews.json?at=refs%2Fheads%2FVer10.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (293, N'IntegrationApi', N'api', N'employment-performance-review-types', N'Ver10', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/employment-performance-review-types.json?at=refs%2Fheads%2FVer10.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (294, N'StudentApi', N'api', N'billing-override-reasons', N'Ver8', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/billing-override-reasons.json?at=refs%2Fheads%2FVer8.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (295, N'IntegrationApi', N'api', N'roommate-characteristics', N'Ver8', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/roommate-characteristics.json?at=refs%2Fheads%2FVer8.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (296, N'IntegrationApi', N'api', N'housing-resident-types', N'Ver10', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/housing-resident-types.json?at=refs%2Fheads%2FVer10.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (297, N'IntegrationApi', N'api', N'source-context', N'Ver6', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/source-context.json?at=refs%2Fheads%2FVer6.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (298, N'StudentApi', N'api', N'meal-types', N'Ver10', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/meal-types.json?at=refs%2Fheads%2FVer10.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (299, N'IntegrationApi', N'api', N'veteran-statuses', N'Ver9', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/veteran-statuses.json?at=refs%2Fheads%2FVer9.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (300, N'StudentApi', N'api', N'student-residential-categories', N'Ver10', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/student-residential-categories.json?at=refs%2Fheads%2FVer10.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (301, N'IntegrationApi', N'api', N'identity-document-types', N'Ver6', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/identity-document-types.json?at=refs%2Fheads%2FVer6.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (302, N'IntegrationApi', N'api', N'social-media-types', N'Ver6', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/social-media-types.json?at=refs%2Fheads%2FVer6.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (303, N'IntegrationApi', N'api', N'privacy-statuses', N'Ver6', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/privacy-statuses.json?at=refs%2Fheads%2FVer6.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (304, N'IntegrationApi', N'api', N'interest-areas', N'Ver6', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/interest-areas.json?at=refs%2Fheads%2FVer6.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (305, N'IntegrationApi', N'api', N'floor-characteristics', N'Ver8', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/floor-characteristics.json?at=refs%2Fheads%2FVer8.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (306, N'IntegrationApi', N'api', N'building-wings', N'Ver6', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/building-wings.json?at=refs%2Fheads%2FVer6.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (307, N'StudentApi', N'api', N'course-levels', N'Ver6', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/course-levels.json?at=refs%2Fheads%2FVer6.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (308, N'StudentApi', N'api', N'academic-catalogs', N'Ver6', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/academic-catalogs.json?at=refs%2Fheads%2FVer6.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (309, N'StudentApi', N'api', N'account-receivable-types', N'Ver6', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/account-receivable-types.json?at=refs%2Fheads%2FVer6.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (310, N'StudentApi', N'api', N'assessment-special-circumstances', N'Ver6', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/assessment-special-circumstances.json?at=refs%2Fheads%2FVer6.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (311, N'StudentApi', N'api', N'assessment-calculation-methods', N'Ver6', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/assessment-calculation-methods.json?at=refs%2Fheads%2FVer6.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (312, N'StudentApi', N'api', N'aptitude-assessment-types', N'Ver6', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/aptitude-assessment-types.json?at=refs%2Fheads%2FVer6.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (313, N'StudentApi', N'api', N'admission-residency-types', N'Ver6', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/admission-residency-types.json?at=refs%2Fheads%2FVer6.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (314, N'IntegrationApi', N'api', N'rehire-types', N'Ver7', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/rehire-types.json?at=refs%2Fheads%2FVer7.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (315, N'IntegrationApi', N'api', N'personal-relationship-statuses', N'Ver6', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/personal-relationship-statuses.json?at=refs%2Fheads%2FVer6.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (316, N'IntegrationApi', N'api', N'employment-vocations', N'Ver10', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/employment-vocations.json?at=refs%2Fheads%2FVer10.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (317, N'IntegrationApi', N'api', N'external-employment-statuses', N'Ver10', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/external-employment-statuses.json?at=refs%2Fheads%2FVer10.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (318, N'IntegrationApi', N'api', N'external-employment-positions', N'Ver10', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/external-employment-positions.json?at=refs%2Fheads%2FVer10.0')
INSERT [dbo].[API] ([Id], [APP], [Connector], [EndPoint], [Version], [SchemaUrl]) VALUES (319, N'IntegrationApi', N'api', N'employment-performance-review-ratings', N'Ver10', N'https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/employment-performance-review-ratings.json?at=refs%2Fheads%2FVer10.0')
SET IDENTITY_INSERT [dbo].[API] OFF
SET IDENTITY_INSERT [dbo].[Authorization] ON 

INSERT [dbo].[Authorization] ([Id], [UserName], [Password], [Type]) VALUES (1, N'grails_user', N'u_pick_it', N'Basic')
INSERT [dbo].[Authorization] ([Id], [UserName], [Password], [Type]) VALUES (2, N'saisusr', N'u_pick_it', N'Basic')
SET IDENTITY_INSERT [dbo].[Authorization] OFF
SET IDENTITY_INSERT [dbo].[Environment] ON 

INSERT [dbo].[Environment] ([Id], [Server]) VALUES (1, N'm040145.ellucian.com:8088')
INSERT [dbo].[Environment] ([Id], [Server]) VALUES (2, N'149.24.38.75:7004')
INSERT [dbo].[Environment] ([Id], [Server]) VALUES (3, N'34.193.79.158:7005')
INSERT [dbo].[Environment] ([Id], [Server]) VALUES (4, N'149.24.38.75:7005')
INSERT [dbo].[Environment] ([Id], [Server]) VALUES (5, N'52.201.103.2:7005')
INSERT [dbo].[Environment] ([Id], [Server]) VALUES (6, N'149.24.12.180:8080')
INSERT [dbo].[Environment] ([Id], [Server]) VALUES (7, N'52.202.27.120:7006')
SET IDENTITY_INSERT [dbo].[Environment] OFF
USE [master]
GO
ALTER DATABASE [tbot] SET  READ_WRITE 
GO
