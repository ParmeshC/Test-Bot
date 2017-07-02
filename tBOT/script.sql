USE [master]
GO
/****** Object:  Database [tbot]    Script Date: 7/2/2017 10:22:33 AM ******/
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
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
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
/****** Object:  Table [dbo].[API]    Script Date: 7/2/2017 10:22:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[API](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[APP] [nvarchar](50) NULL,
 CONSTRAINT [PK_API] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Api_Config]    Script Date: 7/2/2017 10:22:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Api_Config](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Api_Id] [int] NOT NULL,
	[Env_Id] [int] NOT NULL,
	[Auth_Id] [int] NOT NULL,
 CONSTRAINT [PK_Api_Config] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Authorization]    Script Date: 7/2/2017 10:22:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Authorization](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[Type] [nvarchar](50) NULL,
	[UserName] [nvarchar](50) NULL,
	[Password] [nvarchar](50) NULL,
 CONSTRAINT [PK_Authorization] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Environment]    Script Date: 7/2/2017 10:22:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Environment](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[Server] [nvarchar](50) NULL,
	[Port] [nvarchar](50) NULL,
 CONSTRAINT [PK_Environment] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Group]    Script Date: 7/2/2017 10:22:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Group](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
 CONSTRAINT [PK_Group] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Group_Config]    Script Date: 7/2/2017 10:22:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Group_Config](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Api_Config_Id] [int] NOT NULL,
	[Group_Id] [int] NOT NULL,
 CONSTRAINT [PK_Group_Config] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Validation]    Script Date: 7/2/2017 10:22:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Validation](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Api_Config_Id] [int] NULL,
	[Type] [nvarchar](50) NULL,
	[Expected_Value] [nvarchar](50) NULL,
 CONSTRAINT [PK_Validation] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[API] ON 

INSERT [dbo].[API] ([Id], [Name], [APP]) VALUES (85, N'accounts-payable-sources', N'IntegrationApi')
INSERT [dbo].[API] ([Id], [Name], [APP]) VALUES (86, N'bargaining-units', N'IntegrationApi')
INSERT [dbo].[API] ([Id], [Name], [APP]) VALUES (87, N'comment-subject-area', N'StudentApi')
INSERT [dbo].[API] ([Id], [Name], [APP]) VALUES (88, N'commodity-codes', N'IntegrationApi')
INSERT [dbo].[API] ([Id], [Name], [APP]) VALUES (89, N'commodity-unit-types', N'IntegrationApi')
INSERT [dbo].[API] ([Id], [Name], [APP]) VALUES (90, N'deduction-types', N'IntegrationApi')
INSERT [dbo].[API] ([Id], [Name], [APP]) VALUES (91, N'employment-leave-of-absence-reasons', N'IntegrationApi')
INSERT [dbo].[API] ([Id], [Name], [APP]) VALUES (92, N'employment-termination-reasons', N'IntegrationApi')
INSERT [dbo].[API] ([Id], [Name], [APP]) VALUES (169, N'vendor-hold-reasons', N'IntegrationApi')
INSERT [dbo].[API] ([Id], [Name], [APP]) VALUES (170, N'financial-aid-years', N'StudentApi')
INSERT [dbo].[API] ([Id], [Name], [APP]) VALUES (171, N'academic-periods', N'StudentApi')
INSERT [dbo].[API] ([Id], [Name], [APP]) VALUES (172, N'sections-maximum', N'StudentApi')
INSERT [dbo].[API] ([Id], [Name], [APP]) VALUES (173, N'instructional-events', N'StudentApi')
INSERT [dbo].[API] ([Id], [Name], [APP]) VALUES (174, N'student-financial-aid-awards', N'StudentApi')
INSERT [dbo].[API] ([Id], [Name], [APP]) VALUES (175, N'restricted-student-financial-aid-awards', N'StudentApi')
INSERT [dbo].[API] ([Id], [Name], [APP]) VALUES (176, N'institution-jobs', N'IntegrationApi')
INSERT [dbo].[API] ([Id], [Name], [APP]) VALUES (177, N'financial-aid-funds', N'StudentApi')
INSERT [dbo].[API] ([Id], [Name], [APP]) VALUES (178, N'payroll-deduction-arrangements', N'IntegrationApi')
INSERT [dbo].[API] ([Id], [Name], [APP]) VALUES (179, N'vendor-hold-reasons', N'IntegrationApi')
INSERT [dbo].[API] ([Id], [Name], [APP]) VALUES (180, N'sections', N'StudentApi')
INSERT [dbo].[API] ([Id], [Name], [APP]) VALUES (181, N'financial-aid-years', N'StudentApi')
INSERT [dbo].[API] ([Id], [Name], [APP]) VALUES (182, N'employment-termination-reasons', N'IntegrationApi')
INSERT [dbo].[API] ([Id], [Name], [APP]) VALUES (183, N'student-registration-eligibilities', N'StudentApi')
INSERT [dbo].[API] ([Id], [Name], [APP]) VALUES (184, N'admission-applications', N'StudentApi')
INSERT [dbo].[API] ([Id], [Name], [APP]) VALUES (185, N'section-registrations', N'StudentApi')
SET IDENTITY_INSERT [dbo].[API] OFF
SET IDENTITY_INSERT [dbo].[Authorization] ON 

INSERT [dbo].[Authorization] ([Id], [Name], [Type], [UserName], [Password]) VALUES (1, N'GrailsUser', N'Basic', N'grails_user', N'u_pick_it')
INSERT [dbo].[Authorization] ([Id], [Name], [Type], [UserName], [Password]) VALUES (2, N'SaisUsr', N'Basic', N'saisusr', N'u_pick_it')
SET IDENTITY_INSERT [dbo].[Authorization] OFF
SET IDENTITY_INSERT [dbo].[Environment] ON 

INSERT [dbo].[Environment] ([Id], [Name], [Server], [Port]) VALUES (1, N'Environment-1', N'm040145.ellucian.com', N'8088')
INSERT [dbo].[Environment] ([Id], [Name], [Server], [Port]) VALUES (2, N'Environment-2', N'149.24.38.75', N'7004')
INSERT [dbo].[Environment] ([Id], [Name], [Server], [Port]) VALUES (3, N'Environment-3', N'34.193.79.158', N'7005')
INSERT [dbo].[Environment] ([Id], [Name], [Server], [Port]) VALUES (4, N'Environment-4', N'149.24.38.75', N'7005')
INSERT [dbo].[Environment] ([Id], [Name], [Server], [Port]) VALUES (5, N'Environment-5', N'52.201.103.2', N'7005')
INSERT [dbo].[Environment] ([Id], [Name], [Server], [Port]) VALUES (6, N'Environment-6', N'149.24.12.180', N'8080')
INSERT [dbo].[Environment] ([Id], [Name], [Server], [Port]) VALUES (7, N'Environment-7', N'52.202.27.120', N'7006')
SET IDENTITY_INSERT [dbo].[Environment] OFF
USE [master]
GO
ALTER DATABASE [tbot] SET  READ_WRITE 
GO
