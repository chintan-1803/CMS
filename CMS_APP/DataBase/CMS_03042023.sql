USE [master]
GO
/****** Object:  Database [CMS]    Script Date: 03-04-2023 06:43:34 PM ******/
CREATE DATABASE [CMS]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'CMS', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\CMS.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'CMS_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\CMS_log.ldf' , SIZE = 73728KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [CMS] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [CMS].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [CMS] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [CMS] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [CMS] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [CMS] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [CMS] SET ARITHABORT OFF 
GO
ALTER DATABASE [CMS] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [CMS] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [CMS] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [CMS] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [CMS] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [CMS] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [CMS] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [CMS] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [CMS] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [CMS] SET  ENABLE_BROKER 
GO
ALTER DATABASE [CMS] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [CMS] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [CMS] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [CMS] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [CMS] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [CMS] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [CMS] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [CMS] SET RECOVERY FULL 
GO
ALTER DATABASE [CMS] SET  MULTI_USER 
GO
ALTER DATABASE [CMS] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [CMS] SET DB_CHAINING OFF 
GO
ALTER DATABASE [CMS] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [CMS] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [CMS] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [CMS] SET QUERY_STORE = OFF
GO
USE [CMS]
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
USE [CMS]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_IsBitSetInBitmask]    Script Date: 03-04-2023 06:43:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create function [dbo].[fn_IsBitSetInBitmask]  
(@bitmask varbinary(500), @colid int)  
    returns int  
as  
begin  
    declare @word smallint  
    declare @bit  smallint  
    declare @mask binary(2)  
    declare @mval int  
    declare @oldword binary(2)    
    if @colid < 1 return 0  
    SELECT @word = 1 + FLOOR((@colid -1)/16)  
    SELECT @bit = (@colid -1) % 16  
    SELECT @mval = POWER(2, @bit)  
    SELECT @mask = convert( binary(2), unicode( substring( convert( nchar(2), convert( binary(4), @mval ) ), 2, 1 ) ) )  
    SELECT @oldword = convert( binary(2), SUBSTRING( convert( nvarchar(64),@bitmask), @word, 1) )  
    IF @oldword IS NULL return 0  
    return  convert( smallint, @oldword ) & convert( smallint, @mask )  
end
GO
/****** Object:  Table [dbo].[Tbl_AccessRights]    Script Date: 03-04-2023 06:43:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_AccessRights](
	[RoleId] [int] NULL,
	[MenuId] [int] NULL,
	[AccessLevel] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tbl_Audit_DesignationMaster]    Script Date: 03-04-2023 06:43:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_Audit_DesignationMaster](
	[auditId] [int] IDENTITY(1,1) NOT NULL,
	[DesignationID] [int] NOT NULL,
	[change_date] [datetime] NULL,
	[change_user] [varchar](50) NULL,
	[change_category] [nvarchar](50) NULL,
	[field] [nvarchar](50) NULL,
	[previous_value] [nvarchar](200) NULL,
	[changed_to_value] [nvarchar](200) NULL,
 CONSTRAINT [PK_Tbl_Audit_DesignationMaster] PRIMARY KEY CLUSTERED 
(
	[auditId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tbl_Audit_Interviewer]    Script Date: 03-04-2023 06:43:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_Audit_Interviewer](
	[auditId] [int] IDENTITY(1,1) NOT NULL,
	[InterviewerId] [int] NOT NULL,
	[change_date] [datetime] NULL,
	[change_user] [varchar](50) NULL,
	[change_category] [nvarchar](50) NULL,
	[field] [nvarchar](50) NULL,
	[previous_value] [nvarchar](200) NULL,
	[changed_to_value] [nvarchar](200) NULL,
 CONSTRAINT [PK_Tbl_Audit_Interviewer] PRIMARY KEY CLUSTERED 
(
	[auditId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tbl_Audit_ReasonMaster]    Script Date: 03-04-2023 06:43:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_Audit_ReasonMaster](
	[auditId] [int] IDENTITY(1,1) NOT NULL,
	[ReasonID] [int] NOT NULL,
	[change_date] [datetime] NULL,
	[change_user] [varchar](50) NULL,
	[change_category] [nvarchar](50) NULL,
	[field] [nvarchar](50) NULL,
	[previous_value] [nvarchar](200) NULL,
	[changed_to_value] [nvarchar](200) NULL,
 CONSTRAINT [PK_Tbl_Audit_ReasonMaster] PRIMARY KEY CLUSTERED 
(
	[auditId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tbl_Audit_RoleMaster]    Script Date: 03-04-2023 06:43:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_Audit_RoleMaster](
	[auditId] [int] IDENTITY(1,1) NOT NULL,
	[RoleId] [int] NOT NULL,
	[change_date] [datetime] NULL,
	[change_user] [varchar](50) NULL,
	[change_category] [nvarchar](50) NULL,
	[field] [nvarchar](50) NULL,
	[previous_value] [nvarchar](200) NULL,
	[changed_to_value] [nvarchar](200) NULL,
 CONSTRAINT [PK_Tbl_Audit_RoleMaster] PRIMARY KEY CLUSTERED 
(
	[auditId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tbl_Audit_RoundMaster]    Script Date: 03-04-2023 06:43:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_Audit_RoundMaster](
	[auditId] [int] IDENTITY(1,1) NOT NULL,
	[RoundID] [int] NOT NULL,
	[change_date] [datetime] NULL,
	[change_user] [varchar](50) NULL,
	[change_category] [nvarchar](50) NULL,
	[field] [nvarchar](50) NULL,
	[previous_value] [nvarchar](200) NULL,
	[changed_to_value] [nvarchar](200) NULL,
 CONSTRAINT [PK_Tbl_Audit_RoundMaster] PRIMARY KEY CLUSTERED 
(
	[auditId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tbl_Audit_TechnologyMaster]    Script Date: 03-04-2023 06:43:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_Audit_TechnologyMaster](
	[auditId] [int] IDENTITY(1,1) NOT NULL,
	[TechnologyId] [int] NOT NULL,
	[change_date] [datetime] NULL,
	[change_user] [varchar](50) NULL,
	[change_category] [nvarchar](50) NULL,
	[field] [nvarchar](50) NULL,
	[previous_value] [nvarchar](200) NULL,
	[changed_to_value] [nvarchar](200) NULL,
 CONSTRAINT [PK_Tbl_Audit_TechnologyMaster] PRIMARY KEY CLUSTERED 
(
	[auditId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tbl_CandidateRegistration]    Script Date: 03-04-2023 06:43:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_CandidateRegistration](
	[CandidateId] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [varchar](50) NULL,
	[LastName] [varchar](50) NULL,
	[Email] [varchar](50) NOT NULL,
	[Password] [varchar](50) NOT NULL,
	[Confirm_Password] [varchar](50) NULL,
	[ContactNo] [numeric](10, 0) NULL,
	[CandidateImage] [varbinary](max) NULL,
	[Technology] [varchar](100) NULL,
	[Skills] [varchar](max) NULL,
	[PrimaryLocation] [varchar](max) NULL,
	[AgreeForChangeLocation] [bit] NULL,
	[CityId] [int] NULL,
	[StateId] [int] NULL,
	[Address] [varchar](150) NULL,
	[PR_10] [numeric](18, 0) NULL,
	[PR_12] [numeric](18, 0) NULL,
	[College_CGPA] [numeric](18, 0) NULL,
	[IsExperience] [bit] NULL,
	[TotalExperience] [int] NULL,
	[NoticePeriod] [varchar](50) NULL,
	[CurrentCTC] [numeric](18, 0) NULL,
	[ExpectedCTC] [numeric](18, 0) NULL,
	[ReasoneForChange] [nvarchar](max) NULL,
	[AnyRefrence] [bit] NULL,
	[RefrenceId] [int] NULL,
	[CreatedBy] [varchar](50) NULL,
	[CreatedDate] [datetime] NULL,
	[UpdatedBy] [varchar](50) NULL,
	[UpdatedDate] [datetime] NULL,
 CONSTRAINT [PK_Tbl_CandidateMaster] PRIMARY KEY CLUSTERED 
(
	[CandidateId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tbl_CityMaster]    Script Date: 03-04-2023 06:43:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_CityMaster](
	[CityId] [int] IDENTITY(1,1) NOT NULL,
	[CityName] [varchar](100) NULL,
	[IsActive] [bit] NULL,
	[StateId] [int] NULL,
 CONSTRAINT [PK_Table_CityMaster] PRIMARY KEY CLUSTERED 
(
	[CityId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tbl_DesignationMaster]    Script Date: 03-04-2023 06:43:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_DesignationMaster](
	[DesignationID] [int] IDENTITY(1,1) NOT NULL,
	[Designation] [varchar](50) NULL,
	[create_user] [nvarchar](50) NULL,
	[create_date] [datetime] NULL,
	[change_user] [nvarchar](50) NULL,
	[change_date] [datetime] NULL,
	[IsDeleted] [bit] NULL,
 CONSTRAINT [PK_Tbl_DesignationMaster] PRIMARY KEY CLUSTERED 
(
	[DesignationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tbl_InterviewDetails]    Script Date: 03-04-2023 06:43:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_InterviewDetails](
	[InterviewId] [int] IDENTITY(1,1) NOT NULL,
	[CandidateId] [int] NOT NULL,
	[InterviewerId] [int] NOT NULL,
	[Technology] [varchar](50) NULL,
	[InterviewStage] [nvarchar](max) NULL,
	[InterviewDate&Time] [datetime] NULL,
	[Performance] [int] NULL,
	[IsActive] [bit] NULL,
	[Status] [varchar](max) NULL,
	[Discription] [varchar](max) NULL,
	[IsCancel] [bit] NULL,
	[Reason] [varchar](max) NULL,
	[CreatedBy] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[UpdatedBy] [int] NULL,
	[UpdatedDate] [datetime] NULL,
 CONSTRAINT [PK_Tbl_InterviewMaster] PRIMARY KEY CLUSTERED 
(
	[InterviewId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tbl_Interviewers]    Script Date: 03-04-2023 06:43:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_Interviewers](
	[InterviewerId] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [varchar](50) NULL,
	[LastName] [varchar](50) NULL,
	[Email] [nvarchar](50) NULL,
	[TechnologyId] [int] NULL,
	[TechnologyName] [varchar](50) NULL,
	[YearOfExperience] [float] NULL,
	[DesignationId] [int] NULL,
	[Designation] [varchar](50) NULL,
	[TotalInterviewsConducted] [int] NULL,
	[create_user] [nvarchar](50) NULL,
	[create_date] [datetime] NULL,
	[change_user] [nvarchar](50) NULL,
	[change_date] [datetime] NULL,
	[IsDeleted] [bit] NULL,
 CONSTRAINT [PK_Tbl_Interviewers] PRIMARY KEY CLUSTERED 
(
	[InterviewerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tbl_MenuMaster]    Script Date: 03-04-2023 06:43:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_MenuMaster](
	[MenuId] [int] IDENTITY(1,1) NOT NULL,
	[MenuName] [varchar](500) NOT NULL,
	[ControllerName] [varchar](50) NOT NULL,
	[ActionName] [varchar](50) NOT NULL,
	[IconClass] [varchar](100) NULL,
	[IsActive] [bit] NULL,
	[DisplayOrder] [int] NULL,
 CONSTRAINT [PK_Tbl_MenuMaster_1] PRIMARY KEY CLUSTERED 
(
	[MenuId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tbl_ReasonMaster]    Script Date: 03-04-2023 06:43:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_ReasonMaster](
	[ReasonID] [int] IDENTITY(1,1) NOT NULL,
	[Reason] [varchar](max) NULL,
	[create_user] [nvarchar](50) NULL,
	[create_date] [datetime] NULL,
	[change_user] [nvarchar](50) NULL,
	[change_date] [datetime] NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_Tbl_ReasonMaster] PRIMARY KEY CLUSTERED 
(
	[ReasonID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tbl_RoleMaster]    Script Date: 03-04-2023 06:43:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_RoleMaster](
	[RoleId] [int] IDENTITY(1,1) NOT NULL,
	[RoleName] [varchar](100) NOT NULL,
	[create_user] [nvarchar](50) NULL,
	[create_date] [datetime] NULL,
	[change_user] [nvarchar](50) NULL,
	[change_date] [datetime] NULL,
	[IsDeleted] [bit] NULL,
 CONSTRAINT [PK_Tbl_RoleMaster_1] PRIMARY KEY CLUSTERED 
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tbl_RoundMaster]    Script Date: 03-04-2023 06:43:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_RoundMaster](
	[RoundID] [int] IDENTITY(1,1) NOT NULL,
	[Round_Name] [varchar](50) NOT NULL,
	[create_user] [nvarchar](50) NULL,
	[create_date] [datetime] NULL,
	[change_user] [nvarchar](50) NULL,
	[change_date] [datetime] NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_Tbl_RoundMaster] PRIMARY KEY CLUSTERED 
(
	[RoundID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tbl_StateMaster]    Script Date: 03-04-2023 06:43:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_StateMaster](
	[StateId] [int] IDENTITY(1,1) NOT NULL,
	[StateName] [varchar](100) NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_Tbl_StateMaster] PRIMARY KEY CLUSTERED 
(
	[StateId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tbl_TechnologyMaster]    Script Date: 03-04-2023 06:43:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_TechnologyMaster](
	[TechnologyId] [int] IDENTITY(1,1) NOT NULL,
	[TechnologyName] [varchar](100) NULL,
	[IsActive] [bit] NULL,
	[Description] [nvarchar](max) NULL,
	[create_user] [nvarchar](50) NULL,
	[create_date] [datetime] NULL,
	[change_user] [nvarchar](50) NULL,
	[change_date] [datetime] NULL,
	[IsDeleted] [bit] NULL,
 CONSTRAINT [PK_Tbl_TechnologyMaster] PRIMARY KEY CLUSTERED 
(
	[TechnologyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tbl_UserLogin]    Script Date: 03-04-2023 06:43:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_UserLogin](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[InterviewerId] [int] NULL,
	[EmailId] [varchar](150) NULL,
	[Password] [varchar](max) NULL,
	[RoleId] [int] NULL,
	[LoginDateTime] [datetime] NULL,
	[LoginMessage] [varchar](max) NULL,
 CONSTRAINT [PK_Tbl_UserLogin] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tbl_UserRights]    Script Date: 03-04-2023 06:43:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_UserRights](
	[UserId] [int] NULL,
	[RoleId] [int] NULL
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Tbl_Audit_DesignationMaster] ON 

INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1, 5, NULL, NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (2, 5, NULL, N'Muskan', N'U', N'Designation', N'cold', N'H.R.')
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (3, 5, NULL, N'Muskan', N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (4, 5, CAST(N'2023-03-01T19:24:21.747' AS DateTime), N'Muskan', N'U', N'Designation', N'H.R.', N'BD')
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (5, 0, CAST(N'2023-03-05T13:28:19.550' AS DateTime), NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (6, 6, CAST(N'2023-03-06T10:55:59.680' AS DateTime), NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (7, 7, CAST(N'2023-03-06T11:00:19.833' AS DateTime), NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (8, 8, CAST(N'2023-03-06T11:03:48.063' AS DateTime), NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (9, 9, CAST(N'2023-03-06T11:07:47.383' AS DateTime), NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (11, 1, CAST(N'2023-03-06T16:20:10.753' AS DateTime), N'string', N'U', N'Designation', N'Manager', N'string')
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (12, 1, CAST(N'2023-03-06T16:22:54.630' AS DateTime), N'MUSKAN', N'U', N'Designation', N'string', N'H.R.')
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (13, 1, CAST(N'2023-03-06T16:26:23.697' AS DateTime), N'muskan', N'U', N'Designation', N'H.R.', N'MANAGER')
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (14, 1, CAST(N'2023-03-06T16:29:10.017' AS DateTime), N'TOM', N'U', N'Designation', N'MANAGER', N'hr')
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (15, 1, CAST(N'2023-03-06T17:02:35.380' AS DateTime), N'string', N'U', N'Designation', N'hr', N'string')
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (16, 1, CAST(N'2023-03-06T17:02:35.400' AS DateTime), N'string', N'U', N'IsDeleted', NULL, N'0')
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (17, 1, CAST(N'2023-03-06T17:10:08.123' AS DateTime), N'mUSKAN', N'U', N'Designation', N'string', N'hr')
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (18, 0, CAST(N'2023-03-06T17:15:35.887' AS DateTime), N'string', N'U', N'Designation', N'TeamLeader', N'string')
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (19, 11, CAST(N'2023-03-06T17:20:15.580' AS DateTime), NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (20, 1, CAST(N'2023-03-06T17:41:44.140' AS DateTime), N'mUSKAN', N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (21, 0, CAST(N'2023-03-06T18:40:51.680' AS DateTime), N'string', N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (22, 12, CAST(N'2023-03-07T09:24:25.400' AS DateTime), NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (23, 13, CAST(N'2023-03-07T12:05:09.427' AS DateTime), NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (24, 14, CAST(N'2023-03-07T14:25:34.197' AS DateTime), NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (25, 15, CAST(N'2023-03-07T14:30:55.703' AS DateTime), NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (26, 16, CAST(N'2023-03-07T14:33:25.287' AS DateTime), NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (27, 17, CAST(N'2023-03-07T15:59:38.067' AS DateTime), NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (28, 18, CAST(N'2023-03-14T09:43:09.343' AS DateTime), N'', N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (29, 19, CAST(N'2023-03-14T09:51:38.737' AS DateTime), NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (30, 20, CAST(N'2023-03-14T10:02:30.167' AS DateTime), NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (31, 21, CAST(N'2023-03-14T10:08:57.850' AS DateTime), NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (32, 22, CAST(N'2023-03-14T10:13:46.703' AS DateTime), NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (33, 23, CAST(N'2023-03-14T10:20:52.427' AS DateTime), NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (34, 24, CAST(N'2023-03-14T10:27:56.187' AS DateTime), NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (35, 25, CAST(N'2023-03-14T10:40:02.230' AS DateTime), NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (36, 26, CAST(N'2023-03-14T10:45:51.543' AS DateTime), NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (37, 27, CAST(N'2023-03-14T10:52:15.533' AS DateTime), NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (38, 28, CAST(N'2023-03-14T11:28:04.830' AS DateTime), NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (39, 29, CAST(N'2023-03-14T11:30:39.027' AS DateTime), NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (40, 30, CAST(N'2023-03-14T11:43:42.517' AS DateTime), NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (41, 31, CAST(N'2023-03-14T11:52:39.110' AS DateTime), NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (42, 32, CAST(N'2023-03-14T11:54:01.527' AS DateTime), NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (43, 33, CAST(N'2023-03-14T12:02:10.367' AS DateTime), NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (44, 34, CAST(N'2023-03-14T12:02:31.093' AS DateTime), NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1028, 1018, CAST(N'2023-03-15T09:51:05.987' AS DateTime), NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1029, 1019, CAST(N'2023-03-15T10:07:18.447' AS DateTime), NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1030, 1020, CAST(N'2023-03-15T10:15:07.383' AS DateTime), NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1031, 1021, CAST(N'2023-03-15T10:19:06.370' AS DateTime), NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1032, 5, CAST(N'2023-03-15T10:20:33.577' AS DateTime), N'Muskan', N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1033, 3, CAST(N'2023-03-15T10:20:33.577' AS DateTime), NULL, N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1034, 1, CAST(N'2023-03-15T10:20:33.577' AS DateTime), N'mUSKAN', N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1035, 0, CAST(N'2023-03-15T10:20:33.577' AS DateTime), N'string', N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1036, 1022, CAST(N'2023-03-15T10:26:31.077' AS DateTime), NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1037, 9, CAST(N'2023-03-15T10:39:08.927' AS DateTime), NULL, N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1038, 8, CAST(N'2023-03-15T10:39:08.927' AS DateTime), NULL, N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1039, 7, CAST(N'2023-03-15T10:39:08.927' AS DateTime), NULL, N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1040, 6, CAST(N'2023-03-15T10:39:08.927' AS DateTime), NULL, N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1041, 1023, CAST(N'2023-03-15T12:24:05.333' AS DateTime), NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1042, 1024, CAST(N'2023-03-16T13:20:47.183' AS DateTime), NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1043, 2, CAST(N'2023-03-16T15:11:43.710' AS DateTime), N'Parasar', N'U', N'Designation', N'Manager1', N'Manager')
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1044, 2, CAST(N'2023-03-17T11:08:57.513' AS DateTime), N'Parasar', N'U', N'IsDeleted', NULL, N'1')
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1045, 4, CAST(N'2023-03-17T11:41:41.110' AS DateTime), N'Muskan', N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1046, 11, CAST(N'2023-03-17T11:42:59.437' AS DateTime), NULL, N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1047, 12, CAST(N'2023-03-17T11:43:24.110' AS DateTime), N'string', N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1048, 13, CAST(N'2023-03-17T16:43:44.670' AS DateTime), NULL, N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1049, 16, CAST(N'2023-03-17T17:47:29.483' AS DateTime), N'Muskan', N'U', N'Designation', N'hr', N'--HR--1')
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1050, 14, CAST(N'2023-03-17T17:49:13.447' AS DateTime), N'muskan', N'U', N'Designation', N'BD1', N'--BD1--')
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1051, 15, CAST(N'2023-03-17T17:49:40.780' AS DateTime), N'meera', N'U', N'Designation', N'BD2', N'BD2--')
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1052, 15, CAST(N'2023-03-17T17:50:07.733' AS DateTime), N'meera', N'U', N'Designation', N'BD2--', N'---BD2--')
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1053, 14, CAST(N'2023-03-17T17:54:52.267' AS DateTime), N'joey', N'U', N'Designation', N'--BD1--', N'--BD1')
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1054, 14, CAST(N'2023-03-17T17:55:11.047' AS DateTime), N'joey', N'U', N'Designation', N'--BD1', N'BD1')
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1055, 15, CAST(N'2023-03-17T17:57:05.397' AS DateTime), N'meera', N'U', N'Designation', N'---BD2--', N'BD2')
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1056, 15, CAST(N'2023-03-17T17:58:56.527' AS DateTime), N'meera', N'U', N'Designation', N'BD2', N'BD2--')
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1057, 14, CAST(N'2023-03-17T18:01:25.903' AS DateTime), N'joey', N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1058, 16, CAST(N'2023-03-20T12:15:17.487' AS DateTime), N'Muskan', N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1059, 18, CAST(N'2023-03-20T12:15:41.103' AS DateTime), N'', N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1060, 20, CAST(N'2023-03-20T13:22:22.143' AS DateTime), NULL, N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1061, 19, CAST(N'2023-03-20T13:22:37.527' AS DateTime), NULL, N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1062, 21, CAST(N'2023-03-20T13:22:51.427' AS DateTime), NULL, N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1063, 23, CAST(N'2023-03-20T18:54:22.333' AS DateTime), NULL, N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1064, 15, CAST(N'2023-03-20T19:03:14.223' AS DateTime), N'RohitTiwari@Techcronus.com', N'U', N'Designation', N'BD2--', N'BD2')
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1065, 1025, CAST(N'2023-03-20T19:06:15.660' AS DateTime), NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1066, 1025, CAST(N'2023-03-20T19:06:26.753' AS DateTime), NULL, N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1067, 15, CAST(N'2023-03-21T10:57:04.517' AS DateTime), N'RohitTiwari@Techcronus.com', N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1068, 17, CAST(N'2023-03-21T11:02:43.120' AS DateTime), N'joey', N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1069, 22, CAST(N'2023-03-21T11:18:17.297' AS DateTime), N'RohitTiwari@Techcronus.com', N'U', N'Designation', N'Team leader', NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1070, 22, CAST(N'2023-03-21T11:18:33.440' AS DateTime), N'RohitTiwari@Techcronus.com', N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1071, 24, CAST(N'2023-03-21T11:36:19.493' AS DateTime), N'RohitTiwari@Techcronus.com', N'U', N'Designation', N'string1', NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1072, 24, CAST(N'2023-03-21T11:36:29.830' AS DateTime), N'RohitTiwari@Techcronus.com', N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1073, 25, CAST(N'2023-03-21T11:38:01.627' AS DateTime), N'RohitTiwari@Techcronus.com', N'U', N'Designation', N'Team_Leader', NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1074, 25, CAST(N'2023-03-21T11:38:11.720' AS DateTime), N'RohitTiwari@Techcronus.com', N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1075, 1026, CAST(N'2023-03-21T12:20:03.037' AS DateTime), NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1076, 1027, CAST(N'2023-03-21T12:37:28.553' AS DateTime), NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1077, 1028, CAST(N'2023-03-21T12:42:59.007' AS DateTime), NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1078, 1029, CAST(N'2023-03-21T13:11:49.963' AS DateTime), NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1079, 1030, CAST(N'2023-03-21T13:12:02.103' AS DateTime), NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1080, 1031, CAST(N'2023-03-21T13:13:11.420' AS DateTime), NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1081, 1032, CAST(N'2023-03-21T13:13:16.733' AS DateTime), NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1082, 1033, CAST(N'2023-03-21T13:13:32.847' AS DateTime), NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1083, 1034, CAST(N'2023-03-21T13:14:20.090' AS DateTime), NULL, N'I', NULL, NULL, NULL)
GO
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1084, 1035, CAST(N'2023-03-21T13:14:41.520' AS DateTime), NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1085, 26, CAST(N'2023-03-21T13:22:27.177' AS DateTime), N'RohitTiwari@Techcronus.com', N'U', N'Designation', N'SA', NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1086, 26, CAST(N'2023-03-21T13:22:37.730' AS DateTime), N'RohitTiwari@Techcronus.com', N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1087, 27, CAST(N'2023-03-21T14:10:16.143' AS DateTime), N'RohitTiwari@Techcronus.com', N'U', N'Designation', N'Software Developer', NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1088, 27, CAST(N'2023-03-21T14:12:13.540' AS DateTime), N'RohitTiwari@Techcronus.com', N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1089, 28, CAST(N'2023-03-21T14:16:38.110' AS DateTime), N'RohitTiwari@Techcronus.com', N'U', N'Designation', N'team', NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1090, 28, CAST(N'2023-03-21T14:17:20.700' AS DateTime), N'RohitTiwari@Techcronus.com', N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1091, 1026, CAST(N'2023-03-21T14:17:45.473' AS DateTime), NULL, N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1092, 1027, CAST(N'2023-03-21T14:17:51.690' AS DateTime), NULL, N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1093, 1028, CAST(N'2023-03-21T14:17:57.430' AS DateTime), NULL, N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1094, 1029, CAST(N'2023-03-21T14:18:03.800' AS DateTime), NULL, N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1095, 1035, CAST(N'2023-03-21T14:18:15.190' AS DateTime), NULL, N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1096, 1034, CAST(N'2023-03-21T14:18:20.693' AS DateTime), NULL, N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1097, 1033, CAST(N'2023-03-21T14:18:26.930' AS DateTime), NULL, N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1098, 1030, CAST(N'2023-03-21T14:18:37.310' AS DateTime), NULL, N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1099, 1031, CAST(N'2023-03-21T14:18:44.740' AS DateTime), NULL, N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1100, 1032, CAST(N'2023-03-21T14:18:53.807' AS DateTime), NULL, N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1101, 1036, CAST(N'2023-03-21T14:21:55.843' AS DateTime), NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1102, 1036, CAST(N'2023-03-21T14:22:09.407' AS DateTime), NULL, N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1103, 1037, CAST(N'2023-03-21T14:23:47.350' AS DateTime), NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1104, 1037, CAST(N'2023-03-21T14:25:42.977' AS DateTime), NULL, N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1105, 29, CAST(N'2023-03-21T14:50:19.380' AS DateTime), N'RohitTiwari@Techcronus.com', N'U', N'Designation', N'TEAM-A', N'TEAM-A--')
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1106, 1038, CAST(N'2023-03-21T15:09:44.267' AS DateTime), NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1107, 1039, CAST(N'2023-03-21T15:16:31.287' AS DateTime), NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1108, 1040, CAST(N'2023-03-21T15:20:08.647' AS DateTime), NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1109, 1041, CAST(N'2023-03-21T15:24:31.217' AS DateTime), NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1110, 1042, CAST(N'2023-03-21T15:26:12.250' AS DateTime), NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1111, 1043, CAST(N'2023-03-21T15:27:36.840' AS DateTime), NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1112, 1044, CAST(N'2023-03-21T15:39:03.867' AS DateTime), NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1113, 1045, CAST(N'2023-03-21T15:43:57.007' AS DateTime), NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1114, 1046, CAST(N'2023-03-21T15:46:11.877' AS DateTime), NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1115, 1047, CAST(N'2023-03-21T15:52:24.830' AS DateTime), NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1116, 29, CAST(N'2023-03-21T16:02:27.503' AS DateTime), N'RohitTiwari@Techcronus.com', N'U', N'Designation', N'TEAM-A--', N'TEAM-A--123')
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1117, 30, CAST(N'2023-03-21T16:14:08.630' AS DateTime), N'RohitTiwari@Techcronus.com', N'U', N'Designation', N'Manager--', N'Manager')
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1118, 29, CAST(N'2023-03-21T17:29:18.690' AS DateTime), N'RohitTiwari@Techcronus.com', N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1119, 30, CAST(N'2023-03-21T18:06:23.893' AS DateTime), N'RohitTiwari@Techcronus.com', N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1120, 1046, CAST(N'2023-03-21T18:09:02.500' AS DateTime), NULL, N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1121, 33, CAST(N'2023-03-21T18:14:18.253' AS DateTime), NULL, N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1122, 34, CAST(N'2023-03-21T18:15:55.423' AS DateTime), NULL, N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1123, 31, CAST(N'2023-03-21T18:18:25.890' AS DateTime), NULL, N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1124, 32, CAST(N'2023-03-21T18:22:24.130' AS DateTime), NULL, N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1125, 1048, CAST(N'2023-03-22T10:08:43.160' AS DateTime), NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1126, 1049, CAST(N'2023-03-22T10:09:01.420' AS DateTime), NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1127, 1018, CAST(N'2023-03-22T10:09:32.917' AS DateTime), N'RohitTiwari@Techcronus.com', N'U', N'Designation', N'Admin-', N'AdminNew')
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1128, 1018, CAST(N'2023-03-22T10:09:44.060' AS DateTime), N'RohitTiwari@Techcronus.com', N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1129, 1050, CAST(N'2023-03-22T10:30:06.520' AS DateTime), NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1130, 1051, CAST(N'2023-03-22T10:46:46.137' AS DateTime), NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1131, 1052, CAST(N'2023-03-22T11:00:00.910' AS DateTime), NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1132, 1051, CAST(N'2023-03-22T12:01:25.983' AS DateTime), N'', N'U', N'Designation', N'New TEAMS', N'Ne TEAMS')
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1133, 1051, CAST(N'2023-03-22T12:01:37.057' AS DateTime), N'', N'U', N'Designation', N'Ne TEAMS', N'New TEAMS')
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1134, 1019, CAST(N'2023-03-22T12:29:10.107' AS DateTime), N'RohitTiwari@Techcronus.com', N'U', N'Designation', N'hr2', N'-BA-')
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1135, 1053, CAST(N'2023-03-22T12:49:11.570' AS DateTime), NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1136, 1053, CAST(N'2023-03-22T12:49:26.163' AS DateTime), NULL, N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1137, 1054, CAST(N'2023-03-22T13:04:17.077' AS DateTime), NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1138, 1054, CAST(N'2023-03-22T13:04:28.560' AS DateTime), NULL, N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1139, 1055, CAST(N'2023-03-22T14:29:56.300' AS DateTime), NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1140, 1056, CAST(N'2023-03-22T14:33:50.917' AS DateTime), NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1141, 1056, CAST(N'2023-03-22T14:38:16.637' AS DateTime), NULL, N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1142, 1055, CAST(N'2023-03-22T14:38:24.693' AS DateTime), NULL, N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1143, 1038, CAST(N'2023-03-22T14:39:51.210' AS DateTime), N'RohitTiwari@Techcronus.com', N'U', N'Designation', N'TEAM K', N'TEAM2')
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1144, 1020, CAST(N'2023-03-22T14:56:59.860' AS DateTime), N'RohitTiwari@Techcronus.com', N'U', N'Designation', N'-BA-', N'Team a1')
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1145, 1019, CAST(N'2023-03-22T14:57:51.110' AS DateTime), N'RohitTiwari@Techcronus.com', N'U', N'Designation', N'-BA-', N'TEAM AB1')
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1146, 1057, CAST(N'2023-03-22T16:03:57.773' AS DateTime), NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1147, 1058, CAST(N'2023-03-22T16:05:06.807' AS DateTime), NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1148, 1059, CAST(N'2023-03-22T16:05:36.350' AS DateTime), NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1149, 1060, CAST(N'2023-03-22T16:08:54.100' AS DateTime), NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1150, 1061, CAST(N'2023-03-23T17:32:11.563' AS DateTime), NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1151, 1019, CAST(N'2023-03-23T17:32:45.110' AS DateTime), N'RohitTiwari@Techcronus.com', N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1152, 1061, CAST(N'2023-03-24T00:04:21.357' AS DateTime), N'', N'U', N'Designation', N' Team ', N'Team')
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1153, 1020, CAST(N'2023-03-24T11:15:17.200' AS DateTime), N'', N'U', N'Designation', N'Team a1', N'PQR')
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1154, 1020, CAST(N'2023-03-24T11:16:35.310' AS DateTime), N'', N'U', N'Designation', N'PQR', N'lQR')
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1155, 1020, CAST(N'2023-03-24T11:18:10.540' AS DateTime), N'RohitTiwari@Techcronus.com', N'U', N'Designation', N'lQR', N'PQR')
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1156, 1020, CAST(N'2023-03-24T11:21:40.110' AS DateTime), N'RohitTiwari@Techcronus.com', N'U', N'Designation', N'PQR', N'yhj')
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1157, 1020, CAST(N'2023-03-24T11:37:05.890' AS DateTime), N'RohitTiwari@Techcronus.com', N'U', N'Designation', N'yhj', N'kml')
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1158, 1020, CAST(N'2023-03-24T12:50:37.167' AS DateTime), N'RohitTiwari@Techcronus.com', N'U', N'Designation', N'kml', N'kml m')
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1159, 1020, CAST(N'2023-03-24T12:59:26.890' AS DateTime), N'RohitTiwari@Techcronus.com', N'U', N'Designation', N'kml m', N'kml p')
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1160, 1020, CAST(N'2023-03-24T13:05:15.300' AS DateTime), N'RohitTiwari@Techcronus.com', N'U', N'Designation', N'kml p', N'kml poko')
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1161, 1020, CAST(N'2023-03-24T14:28:26.923' AS DateTime), N'RohitTiwari@Techcronus.com', N'U', N'Designation', N'kml poko', N'kml po')
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1162, 1020, CAST(N'2023-03-24T14:30:24.630' AS DateTime), N'RohitTiwari@Techcronus.com', N'U', N'Designation', N'kml po', N'B A')
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1163, 1020, CAST(N'2023-03-24T14:32:52.910' AS DateTime), N'RohitTiwari@Techcronus.com', N'U', N'Designation', N'B A', N'Leader')
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1164, 1020, CAST(N'2023-03-24T14:38:09.767' AS DateTime), N'RohitTiwari@Techcronus.com', N'U', N'Designation', N'Leader', N'Leader 1')
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1165, 1020, CAST(N'2023-03-24T14:49:58.283' AS DateTime), N'RohitTiwari@Techcronus.com', N'U', N'Designation', N'Leader 1', N'Leader 0')
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1166, 1062, CAST(N'2023-03-24T17:49:23.153' AS DateTime), NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1167, 1063, CAST(N'2023-03-24T17:52:28.867' AS DateTime), NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1168, 1064, CAST(N'2023-03-24T18:01:51.450' AS DateTime), NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1169, 1062, CAST(N'2023-03-24T18:04:13.963' AS DateTime), NULL, N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1170, 1063, CAST(N'2023-03-24T18:04:24.963' AS DateTime), NULL, N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1171, 1020, CAST(N'2023-03-24T19:17:59.270' AS DateTime), N'RohitTiwari@Techcronus.com', N'U', N'Designation', N'Leader 0', N'Leader p')
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1172, 1045, CAST(N'2023-03-27T10:16:04.270' AS DateTime), NULL, N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1173, 1021, CAST(N'2023-03-28T10:23:23.933' AS DateTime), NULL, N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1174, 1020, CAST(N'2023-03-28T10:23:59.277' AS DateTime), N'RohitTiwari@Techcronus.com', N'U', N'Designation', N'Leader p', N'Leader p1')
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1175, 1020, CAST(N'2023-03-29T11:12:29.650' AS DateTime), N'RohitTiwari@Techcronus.com', N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1176, 1064, CAST(N'2023-03-29T11:13:00.987' AS DateTime), NULL, N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1177, 1060, CAST(N'2023-03-29T11:13:07.647' AS DateTime), NULL, N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1178, 1022, CAST(N'2023-03-29T11:42:23.403' AS DateTime), NULL, N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1179, 1024, CAST(N'2023-03-29T11:45:55.163' AS DateTime), NULL, N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1180, 1065, CAST(N'2023-03-29T11:46:31.450' AS DateTime), NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1181, 1065, CAST(N'2023-03-29T11:47:38.947' AS DateTime), N'RohitTiwari@Techcronus.com', N'U', N'Designation', N'SSS', N'sp')
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1182, 1066, CAST(N'2023-03-29T11:53:18.860' AS DateTime), NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1183, 1066, CAST(N'2023-03-29T11:53:29.330' AS DateTime), NULL, N'U', N'IsDeleted', N'0', N'1')
GO
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1184, 1065, CAST(N'2023-03-29T11:53:37.427' AS DateTime), N'RohitTiwari@Techcronus.com', N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1185, 1067, CAST(N'2023-03-29T11:55:11.523' AS DateTime), NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1186, 1067, CAST(N'2023-03-29T11:55:22.597' AS DateTime), NULL, N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1187, 1068, CAST(N'2023-03-29T11:55:42.220' AS DateTime), NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1188, 1068, CAST(N'2023-03-29T11:55:51.313' AS DateTime), NULL, N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1189, 1069, CAST(N'2023-03-29T12:18:48.253' AS DateTime), NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1190, 1023, CAST(N'2023-03-29T16:27:09.983' AS DateTime), N'RohitTiwari@Techcronus.com', N'U', N'Designation', N'Director', N'Director1')
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1191, 1023, CAST(N'2023-03-29T16:28:10.567' AS DateTime), N'RohitTiwari@Techcronus.com', N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1192, 1069, CAST(N'2023-03-29T16:28:22.813' AS DateTime), NULL, N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1193, 1070, CAST(N'2023-03-29T16:31:59.053' AS DateTime), NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1194, 1070, CAST(N'2023-03-29T16:32:23.027' AS DateTime), NULL, N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1195, 1061, CAST(N'2023-03-29T16:32:41.000' AS DateTime), N'RohitTiwari@Techcronus.com', N'U', N'Designation', N'Team', N'Team1')
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1196, 1038, CAST(N'2023-03-29T17:19:56.807' AS DateTime), N'', N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1197, 1039, CAST(N'2023-03-29T17:20:19.993' AS DateTime), NULL, N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1198, 1071, CAST(N'2023-03-30T19:22:33.947' AS DateTime), NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1199, 1072, CAST(N'2023-03-30T19:28:16.833' AS DateTime), NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1200, 1072, CAST(N'2023-03-31T10:45:13.250' AS DateTime), NULL, N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1201, 34, CAST(N'2023-04-03T16:57:42.227' AS DateTime), NULL, N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1202, 33, CAST(N'2023-04-03T16:57:42.227' AS DateTime), NULL, N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1203, 32, CAST(N'2023-04-03T16:57:42.227' AS DateTime), NULL, N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1204, 31, CAST(N'2023-04-03T16:57:42.227' AS DateTime), NULL, N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1205, 30, CAST(N'2023-04-03T16:57:42.227' AS DateTime), N'RohitTiwari@Techcronus.com', N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1206, 29, CAST(N'2023-04-03T16:57:42.227' AS DateTime), N'RohitTiwari@Techcronus.com', N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1207, 28, CAST(N'2023-04-03T16:57:42.227' AS DateTime), N'RohitTiwari@Techcronus.com', N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1208, 27, CAST(N'2023-04-03T16:57:42.227' AS DateTime), N'RohitTiwari@Techcronus.com', N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1209, 26, CAST(N'2023-04-03T16:57:42.227' AS DateTime), N'RohitTiwari@Techcronus.com', N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1210, 25, CAST(N'2023-04-03T16:57:42.227' AS DateTime), N'RohitTiwari@Techcronus.com', N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1211, 24, CAST(N'2023-04-03T16:57:42.227' AS DateTime), N'RohitTiwari@Techcronus.com', N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1212, 23, CAST(N'2023-04-03T16:57:42.227' AS DateTime), NULL, N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1213, 22, CAST(N'2023-04-03T16:57:42.227' AS DateTime), N'RohitTiwari@Techcronus.com', N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1214, 21, CAST(N'2023-04-03T16:57:42.227' AS DateTime), NULL, N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1215, 20, CAST(N'2023-04-03T16:57:42.227' AS DateTime), NULL, N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1216, 19, CAST(N'2023-04-03T16:57:42.227' AS DateTime), NULL, N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1217, 18, CAST(N'2023-04-03T16:57:42.227' AS DateTime), N'', N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1218, 17, CAST(N'2023-04-03T16:57:42.227' AS DateTime), N'joey', N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1219, 16, CAST(N'2023-04-03T16:57:42.227' AS DateTime), N'Muskan', N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1220, 15, CAST(N'2023-04-03T16:57:42.227' AS DateTime), N'RohitTiwari@Techcronus.com', N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1221, 14, CAST(N'2023-04-03T16:57:42.227' AS DateTime), N'joey', N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1222, 13, CAST(N'2023-04-03T16:57:42.227' AS DateTime), NULL, N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1223, 12, CAST(N'2023-04-03T16:57:42.227' AS DateTime), N'string', N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1224, 11, CAST(N'2023-04-03T16:57:42.227' AS DateTime), NULL, N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1225, 1051, CAST(N'2023-04-03T16:58:17.373' AS DateTime), N'', N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1226, 1050, CAST(N'2023-04-03T16:58:17.373' AS DateTime), N'', N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1227, 1049, CAST(N'2023-04-03T16:58:17.373' AS DateTime), NULL, N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1228, 1048, CAST(N'2023-04-03T16:58:17.373' AS DateTime), NULL, N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1229, 1047, CAST(N'2023-04-03T16:58:17.373' AS DateTime), NULL, N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1230, 1046, CAST(N'2023-04-03T16:58:17.373' AS DateTime), N'', N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1231, 1045, CAST(N'2023-04-03T16:58:17.373' AS DateTime), NULL, N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1232, 1044, CAST(N'2023-04-03T16:58:17.373' AS DateTime), NULL, N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1233, 1043, CAST(N'2023-04-03T16:58:17.373' AS DateTime), NULL, N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1234, 1042, CAST(N'2023-04-03T16:58:17.373' AS DateTime), NULL, N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1235, 1041, CAST(N'2023-04-03T16:58:17.373' AS DateTime), NULL, N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1236, 1040, CAST(N'2023-04-03T16:58:17.373' AS DateTime), NULL, N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1237, 1039, CAST(N'2023-04-03T16:58:17.373' AS DateTime), NULL, N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1238, 1038, CAST(N'2023-04-03T16:58:17.373' AS DateTime), N'', N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1239, 1037, CAST(N'2023-04-03T16:58:17.373' AS DateTime), NULL, N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1240, 1036, CAST(N'2023-04-03T16:58:17.373' AS DateTime), NULL, N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1241, 1035, CAST(N'2023-04-03T16:58:17.373' AS DateTime), NULL, N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1242, 1034, CAST(N'2023-04-03T16:58:17.373' AS DateTime), NULL, N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1243, 1033, CAST(N'2023-04-03T16:58:17.373' AS DateTime), NULL, N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1244, 1032, CAST(N'2023-04-03T16:58:17.373' AS DateTime), NULL, N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1245, 1031, CAST(N'2023-04-03T16:58:17.373' AS DateTime), NULL, N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1246, 1030, CAST(N'2023-04-03T16:58:17.373' AS DateTime), NULL, N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1247, 1029, CAST(N'2023-04-03T16:58:17.373' AS DateTime), NULL, N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1248, 1028, CAST(N'2023-04-03T16:58:17.373' AS DateTime), NULL, N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1249, 1027, CAST(N'2023-04-03T16:58:17.373' AS DateTime), NULL, N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1250, 1026, CAST(N'2023-04-03T16:58:17.373' AS DateTime), NULL, N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1251, 1025, CAST(N'2023-04-03T16:58:17.373' AS DateTime), NULL, N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1252, 1024, CAST(N'2023-04-03T16:58:17.373' AS DateTime), NULL, N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1253, 1023, CAST(N'2023-04-03T16:58:17.373' AS DateTime), N'RohitTiwari@Techcronus.com', N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1254, 1022, CAST(N'2023-04-03T16:58:17.373' AS DateTime), NULL, N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1255, 1021, CAST(N'2023-04-03T16:58:17.373' AS DateTime), NULL, N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1256, 1020, CAST(N'2023-04-03T16:58:17.373' AS DateTime), N'RohitTiwari@Techcronus.com', N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1257, 1019, CAST(N'2023-04-03T16:58:17.373' AS DateTime), N'RohitTiwari@Techcronus.com', N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1258, 1018, CAST(N'2023-04-03T16:58:17.373' AS DateTime), N'RohitTiwari@Techcronus.com', N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1259, 1072, CAST(N'2023-04-03T16:58:41.037' AS DateTime), NULL, N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1260, 1071, CAST(N'2023-04-03T16:58:41.037' AS DateTime), NULL, N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1261, 1070, CAST(N'2023-04-03T16:58:41.037' AS DateTime), NULL, N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1262, 1069, CAST(N'2023-04-03T16:58:41.037' AS DateTime), NULL, N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1263, 1068, CAST(N'2023-04-03T16:58:41.037' AS DateTime), NULL, N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1264, 1067, CAST(N'2023-04-03T16:58:41.037' AS DateTime), NULL, N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1265, 1066, CAST(N'2023-04-03T16:58:41.037' AS DateTime), NULL, N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1266, 1065, CAST(N'2023-04-03T16:58:41.037' AS DateTime), N'RohitTiwari@Techcronus.com', N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1267, 1064, CAST(N'2023-04-03T16:58:41.037' AS DateTime), NULL, N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1268, 1063, CAST(N'2023-04-03T16:58:41.037' AS DateTime), NULL, N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1269, 1062, CAST(N'2023-04-03T16:58:41.037' AS DateTime), NULL, N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1270, 1061, CAST(N'2023-04-03T16:58:41.037' AS DateTime), N'RohitTiwari@Techcronus.com', N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1271, 1060, CAST(N'2023-04-03T16:58:41.037' AS DateTime), NULL, N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1272, 1059, CAST(N'2023-04-03T16:58:41.037' AS DateTime), NULL, N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1273, 1058, CAST(N'2023-04-03T16:58:41.037' AS DateTime), NULL, N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1274, 1057, CAST(N'2023-04-03T16:58:41.037' AS DateTime), NULL, N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1275, 1056, CAST(N'2023-04-03T16:58:41.037' AS DateTime), N'', N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1276, 1055, CAST(N'2023-04-03T16:58:41.037' AS DateTime), NULL, N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1277, 1054, CAST(N'2023-04-03T16:58:41.037' AS DateTime), NULL, N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1278, 1053, CAST(N'2023-04-03T16:58:41.037' AS DateTime), NULL, N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1279, 4, CAST(N'2023-04-03T16:58:59.580' AS DateTime), N'Muskan', N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_DesignationMaster] ([auditId], [DesignationID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1280, 2, CAST(N'2023-04-03T16:59:15.440' AS DateTime), N'Parasar', N'D', NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[Tbl_Audit_DesignationMaster] OFF
GO
SET IDENTITY_INSERT [dbo].[Tbl_Audit_Interviewer] ON 

INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1, 90, NULL, N'vishnu', N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (2, 91, NULL, N'vishnu', N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (3, 92, NULL, NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (4, 93, NULL, NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (5, 90, NULL, N'User1', N'U', N'FirstName', N'vishnu', N'John')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (6, 90, NULL, N'User1', N'U', N'LastName', N'prajapti', N'Doe')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (7, 90, NULL, N'User1', N'U', N'YearOfExperiance', N'10', N'5')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (8, 90, NULL, N'User1', N'U', N'Designation', N'devloper', N'Senior Developer')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (9, 90, NULL, N'string', N'U', N'FirstName', N'John', N'string')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (10, 90, NULL, N'string', N'U', N'LastName', N'Doe', N'string')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (11, 90, NULL, N'string', N'U', N'Technology', N'Java', N'string')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (12, 90, NULL, N'string', N'U', N'YearOfExperiance', N'5', N'0')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (13, 90, NULL, N'string', N'U', N'Designation', N'Senior Developer', N'string')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (14, 90, NULL, N'string', N'U', N'TotalInterviewsConducted', N'10', N'0')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (15, 90, NULL, N'string', N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1015, 94, NULL, NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1016, 95, NULL, NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1017, 95, NULL, N'string', N'U', N'FirstName', N'John', N'string')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1018, 95, NULL, N'string', N'U', N'LastName', N'Doe', N'string')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1019, 95, NULL, N'string', N'U', N'Technology', N'ASP.NET Core', N'string')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1020, 95, NULL, N'string', N'U', N'YearOfExperiance', N'5', N'0')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1021, 95, NULL, N'string', N'U', N'Designation', N'Senior Software Engineer', N'string')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1022, 95, NULL, N'string', N'U', N'TotalInterviewsConducted', N'10', N'0')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1023, 1, NULL, NULL, N'U', N'FirstName', N'Rohit ', N'')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1024, 1, NULL, NULL, N'U', N'LastName', N'Tiwari', N'')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1025, 1, NULL, NULL, N'U', N'Email', NULL, N'')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1026, 1, NULL, NULL, N'U', N'Technology', N'Asp.Net', N'')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1027, 1, NULL, NULL, N'U', N'YearOfExperience', N'2', N'0')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1028, 1, NULL, NULL, N'U', N'Designation', N'1', N'')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1029, 1, NULL, NULL, N'U', N'TotalInterviewsConducted', N'7', N'0')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1030, 1, NULL, NULL, N'U', N'create_user', NULL, N'')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1031, 90, NULL, N'string', N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1032, 96, NULL, NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1033, 96, NULL, NULL, N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1034, 95, NULL, N'string', N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1035, 94, NULL, NULL, N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1036, 1, NULL, N'string', N'U', N'FirstName', N'', N'string')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1037, 1, NULL, N'string', N'U', N'LastName', N'', N'string')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1038, 1, NULL, N'string', N'U', N'Technology', N'', N'string')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1039, 1, NULL, N'string', N'U', N'YearOfExperience', N'0', N'2')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1040, 1, NULL, N'string', N'U', N'Designation', N'', N'string')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1041, 1, NULL, N'string', N'U', N'IsDeleted', NULL, N'0')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1042, 1, NULL, N'string', N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1043, 91, NULL, N'string', N'U', N'LastName', N'prajapti', N'string')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1044, 91, NULL, N'string', N'U', N'Technology', N'Java', N'.net')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1045, 91, NULL, N'string', N'U', N'YearOfExperience', N'10', N'3')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1046, 91, NULL, N'string', N'U', N'Designation', N'devloper', N'SE')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1047, 91, NULL, N'string', N'U', N'TotalInterviewsConducted', N'10', N'0')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1048, 1, NULL, N'string', N'U', N'FirstName', N'string', N'Rohit')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1049, 1, NULL, N'string', N'U', N'LastName', N'string', N'Tiwari')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1050, 1, NULL, N'string', N'U', N'Technology', N'string', N'.net')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1051, 1, NULL, N'string', N'U', N'YearOfExperience', N'2', N'3')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1052, 1, NULL, N'string', N'U', N'Designation', N'string', N'SE')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1053, 1, NULL, N'string', N'U', N'IsDeleted', N'1', N'0')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1054, 1, NULL, N'string', N'U', N'YearOfExperience', N'3', N'2')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1055, 1, NULL, N'string', N'U', N'Designation', N'SE', N'8')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1056, 1, NULL, N'string', N'U', N'Designation', N'8', N'SE')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1057, 97, NULL, NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1058, 97, NULL, NULL, N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1059, 1, NULL, N'string', N'U', N'TechnologyId', NULL, N'9')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1060, 1, NULL, N'string', N'U', N'DesignationId', NULL, N'2')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1061, 1, NULL, N'string', N'U', N'Technology', N'.net', N'')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1062, 1, NULL, N'string', N'U', N'Designation', N'SE', N'')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1063, 91, NULL, N'string', N'U', N'TechnologyId', NULL, N'25')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1064, 91, NULL, N'string', N'U', N'Technology', N'.net', N'')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1065, 91, NULL, N'string', N'U', N'DesignationId', NULL, N'23')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1066, 91, NULL, N'string', N'U', N'Designation', N'SE', N'')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1067, 93, NULL, NULL, N'U', N'FirstName', N'string', N'hello')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1068, 93, NULL, NULL, N'U', N'Email', N'string', N'dk@gmail.com')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1069, 93, NULL, NULL, N'U', N'TechnologyId', NULL, N'25')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1070, 93, NULL, NULL, N'U', N'Technology', N'string', N'')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1071, 93, NULL, NULL, N'U', N'DesignationId', NULL, N'23')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1072, 93, NULL, NULL, N'U', N'Designation', N'string', N'')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1073, 94, NULL, NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1074, 94, NULL, NULL, N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1075, 93, NULL, NULL, N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1076, 91, NULL, N'string', N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1077, 95, NULL, NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1078, 95, NULL, NULL, N'U', N'Technology', NULL, N'NET Core')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1079, 1, NULL, N'string', N'U', N'Technology', N'', N'ML')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1080, 95, NULL, NULL, N'U', N'Designation', NULL, N'ff')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1081, 1, NULL, N'string', N'U', N'Designation', N'', N'Manager')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1082, 92, NULL, NULL, N'U', N'TechnologyId', NULL, N'24')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1083, 92, NULL, NULL, N'U', N'DesignationId', NULL, N'31')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1084, 92, NULL, NULL, N'U', N'Technology', N'C#', N'PYTHON 2.1')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1085, 92, NULL, NULL, N'U', N'Designation', N'Software Engineer', N'team-b')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1086, 92, NULL, NULL, N'U', N'TechnologyId', N'24', N'12')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1087, 92, NULL, NULL, N'U', N'DesignationId', N'31', N'12')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1088, 96, NULL, NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1089, 97, NULL, NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1090, 98, NULL, NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1091, 99, NULL, NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1092, 100, NULL, NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1093, 95, NULL, NULL, N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1094, 96, NULL, NULL, N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1095, 97, NULL, NULL, N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1096, 98, NULL, NULL, N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1097, 101, NULL, NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1098, 92, NULL, NULL, N'D', NULL, NULL, NULL)
GO
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1099, 99, NULL, N'muskan', N'U', N'LastName', N'kachoriya', N'')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1100, 99, NULL, N'muskan', N'U', N'TechnologyId', N'26', N'11')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1101, 99, NULL, N'muskan', N'U', N'TechnologyName', NULL, N'.NET -')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1102, 99, NULL, N'muskan', N'U', N'YearOfExperience', N'2', N'1')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1103, 99, NULL, N'muskan', N'U', N'DesignationId', N'29', N'1038')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1104, 99, NULL, N'muskan', N'U', N'Designation', N'TEAM-A--123', N'TEAM2')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1105, 99, NULL, N'muskan', N'U', N'TotalInterviewsConducted', N'4', N'3')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1106, 100, NULL, NULL, N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1107, 104, NULL, NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1108, 100, NULL, NULL, N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1109, 101, NULL, NULL, N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1110, 107, NULL, NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1111, 104, NULL, NULL, N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1112, 107, NULL, NULL, N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1113, 99, NULL, N'string', N'U', N'LastName', N'', N'Kachoriya')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1114, 99, NULL, N'string', N'U', N'Email', N'muskan', N'string')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1115, 99, NULL, N'string', N'U', N'TechnologyId', N'11', N'24')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1116, 99, NULL, N'string', N'U', N'TechnologyName', N'.NET -', N'PYTHON 2.1')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1117, 99, NULL, N'string', N'U', N'YearOfExperience', N'1', N'0')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1118, 99, NULL, N'string', N'U', N'DesignationId', N'1038', N'1042')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1119, 99, NULL, N'string', N'U', N'Designation', N'TEAM2', N'TEAm z')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1120, 99, NULL, N'string', N'U', N'TotalInterviewsConducted', N'3', N'0')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1121, 99, NULL, N'string', N'U', N'FirstName', N'Muskan', N'string')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1122, 99, NULL, N'string', N'U', N'LastName', N'Kachoriya', N'string')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1123, 99, NULL, N'string', N'U', N'TechnologyId', N'24', N'26')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1124, 99, NULL, N'string', N'U', N'DesignationId', N'1042', N'1040')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1125, 99, NULL, N'string', N'U', N'Designation', N'TEAm z', N'TEAm C')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1126, 99, NULL, N'string', N'U', N'YearOfExperience', N'0', N'1')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1127, 99, NULL, N'string', N'U', N'TotalInterviewsConducted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1128, 99, NULL, N'string', N'U', N'YearOfExperience', N'1', N'0')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1129, 99, NULL, N'string', N'U', N'TotalInterviewsConducted', N'1', N'0')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1130, 99, NULL, N'Muskan', N'U', N'FirstName', N'string', N'Muskan')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1131, 99, NULL, N'Muskan', N'U', N'LastName', N'string', N'Muskan')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1132, 99, NULL, N'null', N'U', N'FirstName', N'Muskan', N'string')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1133, 99, NULL, N'null', N'U', N'LastName', N'Muskan', N'string')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1134, 99, NULL, N'string', N'U', N'YearOfExperience', N'0', N'1')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1135, 99, NULL, N'string', N'U', N'TotalInterviewsConducted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1136, 99, NULL, N'null', N'U', N'YearOfExperience', N'1', N'0')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1137, 99, NULL, N'null', N'U', N'TotalInterviewsConducted', N'1', N'0')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1138, 99, NULL, N'string', N'U', N'YearOfExperience', N'0', N'1')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1139, 99, NULL, N'string', N'U', N'TotalInterviewsConducted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1140, 99, NULL, N'string', N'U', N'YearOfExperience', N'1', N'0')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1141, 99, NULL, N'string', N'U', N'TotalInterviewsConducted', N'1', N'0')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1142, 99, NULL, N'string', N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1143, 108, NULL, NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1144, 109, NULL, NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1145, 110, NULL, NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1146, 111, NULL, NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1147, 112, NULL, NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1148, 99, NULL, N'string', N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1149, 108, NULL, NULL, N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1150, 109, NULL, NULL, N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1151, 110, NULL, NULL, N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1152, 112, NULL, NULL, N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1153, 113, NULL, NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1154, 113, NULL, NULL, N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1155, 112, NULL, NULL, N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1156, 113, NULL, NULL, N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1157, 114, NULL, NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1158, 114, NULL, NULL, N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1159, 114, NULL, NULL, N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1160, 115, NULL, NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1161, 115, NULL, NULL, N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1162, 116, NULL, NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1163, 116, NULL, NULL, N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1164, 115, NULL, NULL, N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1165, 116, NULL, NULL, N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1167, 118, NULL, NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1168, 118, NULL, NULL, N'U', N'TechnologyId', N'19', N'31')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1169, 118, NULL, NULL, N'U', N'TechnologyName', N'NET CORE', N'PYTHON 2.3')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1170, 118, NULL, NULL, N'U', N'YearOfExperience', N'2', N'5')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1171, 118, NULL, NULL, N'U', N'DesignationId', N'1023', N'1058')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1172, 118, NULL, NULL, N'U', N'Designation', N'Director', N'SD2')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1173, 118, NULL, NULL, N'U', N'TotalInterviewsConducted', N'3', N'1')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1174, 119, NULL, NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1175, 120, NULL, NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1176, 118, NULL, NULL, N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1177, 118, NULL, NULL, N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1178, 119, NULL, NULL, N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1179, 1, NULL, NULL, N'U', N'Email', N'', N'rohit@gmail.com')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1180, 1, NULL, NULL, N'U', N'TechnologyId', N'9', N'28')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1181, 1, NULL, NULL, N'U', N'TechnologyName', NULL, N'ASP.net')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1182, 1, NULL, NULL, N'U', N'YearOfExperience', N'2', N'4')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1183, 1, NULL, NULL, N'U', N'DesignationId', N'2', N'1052')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1184, 1, NULL, NULL, N'U', N'Designation', NULL, N'Admin-')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1185, 1, NULL, NULL, N'U', N'TotalInterviewsConducted', N'0', N'2')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1186, 121, NULL, NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1187, 121, NULL, NULL, N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1188, 122, NULL, NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1189, 122, NULL, NULL, N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1190, 123, NULL, NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1191, 123, NULL, NULL, N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1192, 121, NULL, NULL, N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1193, 122, NULL, NULL, N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1194, 123, NULL, NULL, N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1195, 124, NULL, NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1196, 124, NULL, NULL, N'U', N'FirstName', N'KHANDHAR', NULL)
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1197, 124, NULL, NULL, N'U', N'LastName', N'MANISHBHAI', NULL)
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1198, 124, NULL, NULL, N'U', N'Email', N'meerakhandhar2711@gmail.com', NULL)
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1199, 124, NULL, NULL, N'U', N'TechnologyId', N'27', NULL)
GO
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1200, 124, NULL, NULL, N'U', N'TechnologyName', N'Tensorflow', NULL)
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1201, 124, NULL, NULL, N'U', N'YearOfExperience', N'-7', NULL)
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1202, 124, NULL, NULL, N'U', N'DesignationId', N'1041', NULL)
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1203, 124, NULL, NULL, N'U', N'Designation', N'TEAm q', NULL)
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1204, 124, NULL, NULL, N'U', N'TotalInterviewsConducted', N'0', NULL)
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1205, 124, NULL, NULL, N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1206, 125, NULL, NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1207, 125, NULL, NULL, N'U', N'FirstName', N'm', N'i')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1208, 125, NULL, NULL, N'U', N'LastName', N'm', N'i')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1209, 125, NULL, NULL, N'U', N'Email', N'm@gmail.com', N'i@gmail.com')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1210, 125, NULL, NULL, N'U', N'TechnologyId', N'28', N'27')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1211, 125, NULL, NULL, N'U', N'TechnologyName', N'ASP.net', N'Tensorflow')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1212, 125, NULL, NULL, N'U', N'YearOfExperience', N'4', N'1')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1213, 125, NULL, NULL, N'U', N'DesignationId', N'1048', N'1043')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1214, 125, NULL, NULL, N'U', N'Designation', N'HighPostManager', N'TEAm y')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1215, 125, NULL, NULL, N'U', N'TotalInterviewsConducted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1216, 126, NULL, NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1217, 127, NULL, NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1218, 128, NULL, NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1219, 125, NULL, NULL, N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1220, 126, NULL, NULL, N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1221, 125, NULL, NULL, N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1222, 126, NULL, NULL, N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1223, 129, NULL, NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1224, 128, NULL, NULL, N'U', N'FirstName', N'j', N'k')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1225, 128, NULL, NULL, N'U', N'LastName', N'j', N'k')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1226, 128, NULL, NULL, N'U', N'Email', N'j@gmail.com', N'k@gmail.com')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1227, 128, NULL, NULL, N'U', N'YearOfExperience', N'8', N'1')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1228, 128, NULL, NULL, N'U', N'DesignationId', N'1050', N'1057')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1229, 128, NULL, NULL, N'U', N'Designation', N'New Admin', N'ASB 23')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1230, 128, NULL, NULL, N'U', N'TotalInterviewsConducted', N'1', N'0')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1231, 128, NULL, NULL, N'U', N'FirstName', N'k', N'u')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1232, 128, NULL, NULL, N'U', N'LastName', N'k', N'u')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1233, 128, NULL, NULL, N'U', N'Email', N'k@gmail.com', N'u@gmail.com')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1234, 128, NULL, NULL, N'U', N'DesignationId', N'1057', N'1052')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1235, 128, NULL, NULL, N'U', N'Designation', N'ASB 23', N'Admin-')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1236, 128, NULL, NULL, N'U', N'TotalInterviewsConducted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1237, 128, NULL, NULL, N'U', N'FirstName', N'u', N'k')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1238, 128, NULL, NULL, N'U', N'LastName', N'u', N'm')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1239, 128, NULL, NULL, N'U', N'Email', N'u@gmail.com', N'k@gmail.com')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1240, 128, NULL, NULL, N'U', N'TechnologyId', N'27', N'19')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1241, 128, NULL, NULL, N'U', N'TechnologyName', N'Tensorflow', N'NET CORE')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1242, 128, NULL, NULL, N'U', N'YearOfExperience', N'1', N'2')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1243, 128, NULL, NULL, N'U', N'FirstName', N'k', N'j')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1244, 128, NULL, NULL, N'U', N'LastName', N'm', N'j')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1245, 128, NULL, NULL, N'U', N'Email', N'k@gmail.com', N'j@gmail.com')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1246, 128, NULL, NULL, N'U', N'TechnologyId', N'19', N'28')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1247, 128, NULL, NULL, N'U', N'TechnologyName', N'NET CORE', N'ASP.net')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1248, 128, NULL, NULL, N'U', N'YearOfExperience', N'2', N'3')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1249, 128, NULL, NULL, N'U', N'DesignationId', N'1052', N'1042')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1250, 128, NULL, NULL, N'U', N'Designation', N'Admin-', N'TEAm z')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1251, 130, NULL, NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1252, 130, NULL, NULL, N'U', N'FirstName', N'p', N'k')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1253, 130, NULL, NULL, N'U', N'LastName', N'p', N'k')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1254, 130, NULL, NULL, N'U', N'Email', N'm@gmail.com', N'k@gmail.com')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1255, 130, NULL, NULL, N'U', N'YearOfExperience', N'2', N'21')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1256, 130, NULL, NULL, N'U', N'DesignationId', N'1044', N'1047')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1257, 130, NULL, NULL, N'U', N'Designation', N'testxrtfff', N'dfsdfsdfsdf')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1258, 131, NULL, NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1259, 129, NULL, NULL, N'U', N'FirstName', N'i', N'h')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1260, 129, NULL, NULL, N'U', N'LastName', N'i', N'h')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1261, 129, NULL, NULL, N'U', N'Email', N'i@gmail.com', N'h@gmail.com')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1262, 129, NULL, NULL, N'U', N'TechnologyId', N'27', N'28')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1263, 129, NULL, NULL, N'U', N'TechnologyName', N'Tensorflow', N'ASP.net')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1264, 129, NULL, NULL, N'U', N'DesignationId', N'1047', N'1041')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1265, 129, NULL, NULL, N'U', N'Designation', N'dfsdfsdfsdf', N'TEAm q')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1266, 130, NULL, NULL, N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1267, 131, NULL, NULL, N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1268, 129, NULL, NULL, N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1269, 128, NULL, NULL, N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1270, 127, NULL, NULL, N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1271, 120, NULL, NULL, N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1272, 120, NULL, NULL, N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1273, 127, NULL, NULL, N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1274, 128, NULL, NULL, N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1275, 129, NULL, NULL, N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1276, 130, NULL, NULL, N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1277, 131, NULL, NULL, N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1278, 132, NULL, NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1279, 132, NULL, NULL, N'U', N'FirstName', N'p', N'k')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1280, 132, NULL, NULL, N'U', N'LastName', N'p', N'k')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1281, 132, NULL, NULL, N'U', N'Email', N'p@gmail.com', N'k@gmail.com')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1282, 132, NULL, NULL, N'U', N'TechnologyId', N'27', N'19')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1283, 132, NULL, NULL, N'U', N'TechnologyName', N'Tensorflow', N'NET CORE')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1284, 132, NULL, NULL, N'U', N'DesignationId', N'1043', N'1051')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1285, 132, NULL, NULL, N'U', N'Designation', N'TEAm y', N'New TEAMS')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1286, 132, NULL, NULL, N'U', N'TechnologyId', N'19', N'27')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1287, 132, NULL, NULL, N'U', N'TechnologyName', N'NET CORE', N'Tensorflow')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1288, 132, NULL, NULL, N'U', N'TotalInterviewsConducted', N'2', N'1')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1289, 132, NULL, NULL, N'U', N'TechnologyId', N'27', N'31')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1290, 132, NULL, NULL, N'U', N'TechnologyName', N'Tensorflow', N'PYTHON 2.3')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1291, 132, NULL, NULL, N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1292, 133, NULL, NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1293, 133, NULL, NULL, N'U', N'FirstName', N'k', N'l')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1294, 133, NULL, NULL, N'U', N'TechnologyId', N'27', N'19')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1295, 133, NULL, NULL, N'U', N'TechnologyName', N'Tensorflow', N'NET CORE')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1296, 133, NULL, NULL, N'U', N'YearOfExperience', NULL, N'1')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1297, 133, NULL, NULL, N'U', N'DesignationId', N'1059', N'1058')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1298, 133, NULL, NULL, N'U', N'Designation', N'Asb', N'SD2')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1299, 133, NULL, NULL, N'U', N'IsDeleted', N'0', N'1')
GO
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1300, 134, NULL, NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1301, 134, NULL, NULL, N'U', N'FirstName', N'h', N'k')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1302, 134, NULL, NULL, N'U', N'LastName', N'h', N'hk')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1303, 134, NULL, NULL, N'U', N'Email', N'h@gmail.com', N'k@gmail.com')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1304, 134, NULL, NULL, N'U', N'TechnologyId', N'28', N'27')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1305, 134, NULL, NULL, N'U', N'TechnologyName', N'ASP.net', N'Tensorflow')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1306, 134, NULL, NULL, N'U', N'YearOfExperience', N'1', N'1.9')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1307, 134, NULL, NULL, N'U', N'TotalInterviewsConducted', N'0', N'2')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1308, 134, NULL, NULL, N'U', N'DesignationId', N'1050', N'1043')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1309, 134, NULL, NULL, N'U', N'Designation', N'New Admin', N'TEAm y')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1310, 135, NULL, NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1311, 134, NULL, NULL, N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1312, 111, NULL, NULL, N'U', N'DesignationId', N'1023', N'1040')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1313, 111, NULL, NULL, N'U', N'Designation', N'Director', N'TEAm C')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1314, 111, NULL, NULL, N'U', N'YearOfExperience', N'0', N'4.2')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1315, 1, NULL, NULL, N'U', N'YearOfExperience', N'4', N'1.3')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1316, 136, NULL, NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1317, 137, NULL, NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1318, 135, NULL, NULL, N'U', N'YearOfExperience', N'2.4', N'2.4')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1319, 135, NULL, NULL, N'U', N'DesignationId', N'1044', N'1051')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1320, 135, NULL, NULL, N'U', N'Designation', N'testxrtfff', N'New TEAMS')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1321, 136, NULL, NULL, N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (2311, 1136, NULL, NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (2312, 135, NULL, NULL, N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (2313, 137, NULL, NULL, N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (2314, 1136, NULL, NULL, N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (2315, 132, NULL, NULL, N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (2316, 133, NULL, NULL, N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (2317, 134, NULL, NULL, N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (2318, 135, NULL, NULL, N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (2319, 136, NULL, NULL, N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (2320, 137, NULL, NULL, N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (2321, 1136, NULL, NULL, N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_Interviewer] ([auditId], [InterviewerId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (2322, 111, NULL, NULL, N'D', NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[Tbl_Audit_Interviewer] OFF
GO
SET IDENTITY_INSERT [dbo].[Tbl_Audit_ReasonMaster] ON 

INSERT [dbo].[Tbl_Audit_ReasonMaster] ([auditId], [ReasonID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1, 4, CAST(N'2023-03-02T10:05:41.157' AS DateTime), NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_ReasonMaster] ([auditId], [ReasonID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (2, 5, CAST(N'2023-03-02T10:34:51.687' AS DateTime), NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_ReasonMaster] ([auditId], [ReasonID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (3, 5, CAST(N'2023-03-02T10:56:31.813' AS DateTime), N'meena', N'U', N'Reason', N'--function--', N'function')
INSERT [dbo].[Tbl_Audit_ReasonMaster] ([auditId], [ReasonID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (4, 5, CAST(N'2023-03-02T10:59:24.033' AS DateTime), N'meena', N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_ReasonMaster] ([auditId], [ReasonID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (5, 6, CAST(N'2023-03-07T15:31:59.280' AS DateTime), NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_ReasonMaster] ([auditId], [ReasonID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (6, 7, CAST(N'2023-03-07T15:49:14.357' AS DateTime), NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_ReasonMaster] ([auditId], [ReasonID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (7, 8, CAST(N'2023-03-07T15:50:26.460' AS DateTime), NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_ReasonMaster] ([auditId], [ReasonID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (8, 9, CAST(N'2023-03-07T15:54:06.247' AS DateTime), NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_ReasonMaster] ([auditId], [ReasonID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (9, 10, CAST(N'2023-03-07T15:56:37.737' AS DateTime), NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_ReasonMaster] ([auditId], [ReasonID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (10, 0, CAST(N'2023-03-07T16:06:09.850' AS DateTime), NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_ReasonMaster] ([auditId], [ReasonID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (11, 11, CAST(N'2023-03-07T16:13:43.287' AS DateTime), NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_ReasonMaster] ([auditId], [ReasonID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (12, 12, CAST(N'2023-03-15T15:49:14.750' AS DateTime), NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_ReasonMaster] ([auditId], [ReasonID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (13, 13, CAST(N'2023-03-15T15:55:10.893' AS DateTime), NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_ReasonMaster] ([auditId], [ReasonID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (14, 14, CAST(N'2023-03-15T16:01:39.670' AS DateTime), NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_ReasonMaster] ([auditId], [ReasonID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (15, 3, CAST(N'2023-03-17T18:32:17.187' AS DateTime), NULL, N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_ReasonMaster] ([auditId], [ReasonID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (16, 6, CAST(N'2023-03-17T18:32:52.277' AS DateTime), NULL, N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_ReasonMaster] ([auditId], [ReasonID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (17, 8, CAST(N'2023-03-17T18:33:20.170' AS DateTime), NULL, N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_ReasonMaster] ([auditId], [ReasonID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (18, 0, CAST(N'2023-03-17T19:30:18.160' AS DateTime), N'muskan', N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_ReasonMaster] ([auditId], [ReasonID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (19, 1, CAST(N'2023-03-20T11:31:53.203' AS DateTime), N'Muskan', N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_ReasonMaster] ([auditId], [ReasonID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (20, 9, CAST(N'2023-03-20T12:26:51.487' AS DateTime), NULL, N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_ReasonMaster] ([auditId], [ReasonID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (21, 4, CAST(N'2023-03-20T12:28:07.637' AS DateTime), N'joy', N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_ReasonMaster] ([auditId], [ReasonID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (22, 14, CAST(N'2023-03-20T12:33:33.440' AS DateTime), NULL, N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_ReasonMaster] ([auditId], [ReasonID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (23, 7, CAST(N'2023-03-20T14:34:45.527' AS DateTime), N'muskan', N'U', N'Reason', N'sick', N'sick---')
INSERT [dbo].[Tbl_Audit_ReasonMaster] ([auditId], [ReasonID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (24, 7, CAST(N'2023-03-20T14:35:40.043' AS DateTime), N'muskan', N'U', N'Reason', N'sick---', N'sick')
INSERT [dbo].[Tbl_Audit_ReasonMaster] ([auditId], [ReasonID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (25, 15, CAST(N'2023-03-20T15:27:08.680' AS DateTime), NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_ReasonMaster] ([auditId], [ReasonID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (26, 16, CAST(N'2023-03-20T15:31:05.690' AS DateTime), NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_ReasonMaster] ([auditId], [ReasonID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (27, 16, CAST(N'2023-03-20T15:33:03.580' AS DateTime), N'RohitTiwari@Techcronus.com', N'U', N'Reason', N'other----', N'other--')
INSERT [dbo].[Tbl_Audit_ReasonMaster] ([auditId], [ReasonID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (28, 10, CAST(N'2023-03-20T15:58:07.943' AS DateTime), N'RohitTiwari@Techcronus.com', N'U', N'Reason', N'string', N'string-')
INSERT [dbo].[Tbl_Audit_ReasonMaster] ([auditId], [ReasonID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (29, 13, CAST(N'2023-03-20T16:07:41.880' AS DateTime), NULL, N'U', N'Reason', N'High Cold', N'High Cold--')
INSERT [dbo].[Tbl_Audit_ReasonMaster] ([auditId], [ReasonID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (30, 13, CAST(N'2023-03-20T16:07:52.277' AS DateTime), NULL, N'U', N'Reason', N'High Cold--', N'--High Cold--')
INSERT [dbo].[Tbl_Audit_ReasonMaster] ([auditId], [ReasonID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (31, 13, CAST(N'2023-03-20T16:09:45.147' AS DateTime), N'RohitTiwari@Techcronus.com', N'U', N'Reason', N'--High Cold--', N'High Cold')
INSERT [dbo].[Tbl_Audit_ReasonMaster] ([auditId], [ReasonID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (32, 10, CAST(N'2023-03-20T16:17:12.403' AS DateTime), N'RohitTiwari@Techcronus.com', N'U', N'Reason', N'string-', N'string---')
INSERT [dbo].[Tbl_Audit_ReasonMaster] ([auditId], [ReasonID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (33, 10, CAST(N'2023-03-20T16:41:32.397' AS DateTime), N'RohitTiwari@Techcronus.com', N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_ReasonMaster] ([auditId], [ReasonID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (34, 17, CAST(N'2023-03-20T19:03:36.613' AS DateTime), NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_ReasonMaster] ([auditId], [ReasonID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (35, 7, CAST(N'2023-03-21T11:02:58.670' AS DateTime), N'muskan', N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_ReasonMaster] ([auditId], [ReasonID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (36, 17, CAST(N'2023-03-22T17:00:10.880' AS DateTime), NULL, N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_ReasonMaster] ([auditId], [ReasonID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (37, 18, CAST(N'2023-03-22T17:02:08.880' AS DateTime), NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_ReasonMaster] ([auditId], [ReasonID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (38, 18, CAST(N'2023-03-22T18:25:23.663' AS DateTime), NULL, N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_ReasonMaster] ([auditId], [ReasonID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (39, 19, CAST(N'2023-03-22T18:28:22.120' AS DateTime), NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_ReasonMaster] ([auditId], [ReasonID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (40, 19, CAST(N'2023-03-22T18:28:53.427' AS DateTime), NULL, N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_ReasonMaster] ([auditId], [ReasonID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (41, 20, CAST(N'2023-03-22T18:29:33.990' AS DateTime), NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_ReasonMaster] ([auditId], [ReasonID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (42, 20, CAST(N'2023-03-22T18:30:01.477' AS DateTime), NULL, N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_ReasonMaster] ([auditId], [ReasonID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (43, 21, CAST(N'2023-03-22T18:30:54.580' AS DateTime), NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_ReasonMaster] ([auditId], [ReasonID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (44, 22, CAST(N'2023-03-23T17:38:37.310' AS DateTime), NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_ReasonMaster] ([auditId], [ReasonID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (45, 21, CAST(N'2023-03-24T01:07:46.643' AS DateTime), N'', N'U', N'Reason', N'Fever', N'ABC')
INSERT [dbo].[Tbl_Audit_ReasonMaster] ([auditId], [ReasonID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (46, 11, CAST(N'2023-03-28T12:24:05.450' AS DateTime), N'other', N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_ReasonMaster] ([auditId], [ReasonID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (47, 23, CAST(N'2023-03-28T12:24:39.280' AS DateTime), NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_ReasonMaster] ([auditId], [ReasonID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (48, 23, CAST(N'2023-03-28T12:25:39.373' AS DateTime), NULL, N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_ReasonMaster] ([auditId], [ReasonID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (49, 24, CAST(N'2023-03-28T12:25:52.773' AS DateTime), NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_ReasonMaster] ([auditId], [ReasonID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (50, 24, CAST(N'2023-03-28T12:30:03.813' AS DateTime), NULL, N'U', N'Reason', N'leaveq', N'leavep')
INSERT [dbo].[Tbl_Audit_ReasonMaster] ([auditId], [ReasonID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (51, 24, CAST(N'2023-03-28T12:31:31.790' AS DateTime), NULL, N'U', N'Reason', N'leavep', N'leavel')
INSERT [dbo].[Tbl_Audit_ReasonMaster] ([auditId], [ReasonID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (52, 25, CAST(N'2023-03-28T12:32:43.743' AS DateTime), NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_ReasonMaster] ([auditId], [ReasonID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (53, 26, CAST(N'2023-03-28T12:34:00.590' AS DateTime), NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_ReasonMaster] ([auditId], [ReasonID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (54, 27, CAST(N'2023-03-28T12:35:20.173' AS DateTime), NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_ReasonMaster] ([auditId], [ReasonID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (55, 12, CAST(N'2023-03-28T12:36:49.610' AS DateTime), NULL, N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_ReasonMaster] ([auditId], [ReasonID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (56, 28, CAST(N'2023-03-28T12:37:12.240' AS DateTime), NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_ReasonMaster] ([auditId], [ReasonID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (57, 24, CAST(N'2023-03-28T12:37:25.423' AS DateTime), NULL, N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_ReasonMaster] ([auditId], [ReasonID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (58, 25, CAST(N'2023-03-28T12:37:32.237' AS DateTime), NULL, N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_ReasonMaster] ([auditId], [ReasonID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (59, 27, CAST(N'2023-03-28T12:37:39.050' AS DateTime), NULL, N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_ReasonMaster] ([auditId], [ReasonID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (60, 26, CAST(N'2023-03-28T12:37:45.960' AS DateTime), NULL, N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_ReasonMaster] ([auditId], [ReasonID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (61, 28, CAST(N'2023-03-28T12:37:53.397' AS DateTime), NULL, N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_ReasonMaster] ([auditId], [ReasonID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (62, 13, CAST(N'2023-03-28T12:53:57.850' AS DateTime), N'RohitTiwari@Techcronus.com', N'U', N'Reason', N'High Cold', N'High Coldp')
INSERT [dbo].[Tbl_Audit_ReasonMaster] ([auditId], [ReasonID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (63, 13, CAST(N'2023-03-28T12:54:12.860' AS DateTime), N'RohitTiwari@Techcronus.com', N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_ReasonMaster] ([auditId], [ReasonID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (64, 15, CAST(N'2023-03-28T13:00:05.453' AS DateTime), N'RohitTiwari@Techcronus.com', N'U', N'Reason', N'other', N'other  s')
INSERT [dbo].[Tbl_Audit_ReasonMaster] ([auditId], [ReasonID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (65, 15, CAST(N'2023-03-28T13:04:15.610' AS DateTime), N'RohitTiwari@Techcronus.com', N'U', N'Reason', N'other  s', N'other')
INSERT [dbo].[Tbl_Audit_ReasonMaster] ([auditId], [ReasonID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (66, 15, CAST(N'2023-03-28T13:04:38.630' AS DateTime), N'RohitTiwari@Techcronus.com', N'U', N'Reason', N'other', N'other Reason')
INSERT [dbo].[Tbl_Audit_ReasonMaster] ([auditId], [ReasonID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (67, 29, CAST(N'2023-03-28T13:54:27.357' AS DateTime), NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_ReasonMaster] ([auditId], [ReasonID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (68, 30, CAST(N'2023-03-29T12:00:01.877' AS DateTime), NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_ReasonMaster] ([auditId], [ReasonID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (69, 31, CAST(N'2023-03-29T12:09:36.103' AS DateTime), NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_ReasonMaster] ([auditId], [ReasonID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (70, 31, CAST(N'2023-03-29T12:10:19.950' AS DateTime), NULL, N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_ReasonMaster] ([auditId], [ReasonID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (71, 16, CAST(N'2023-03-29T12:40:35.570' AS DateTime), N'RohitTiwari@Techcronus.com', N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_ReasonMaster] ([auditId], [ReasonID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (72, 32, CAST(N'2023-03-29T13:28:49.407' AS DateTime), NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_ReasonMaster] ([auditId], [ReasonID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (73, 33, CAST(N'2023-03-29T13:29:07.180' AS DateTime), NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_ReasonMaster] ([auditId], [ReasonID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (74, 33, CAST(N'2023-03-29T13:32:47.413' AS DateTime), NULL, N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_ReasonMaster] ([auditId], [ReasonID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (75, 32, CAST(N'2023-03-29T13:33:07.880' AS DateTime), N'RohitTiwari@Techcronus.com', N'U', N'Reason', N'ABC Dfg', N'ABC sa')
INSERT [dbo].[Tbl_Audit_ReasonMaster] ([auditId], [ReasonID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (76, 32, CAST(N'2023-03-29T13:33:22.047' AS DateTime), N'RohitTiwari@Techcronus.com', N'U', N'Reason', N'ABC sa', N'ABC say')
INSERT [dbo].[Tbl_Audit_ReasonMaster] ([auditId], [ReasonID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (77, 15, CAST(N'2023-04-03T15:43:32.947' AS DateTime), N'RohitTiwari@Techcronus.com', N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_ReasonMaster] ([auditId], [ReasonID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (78, 22, CAST(N'2023-04-03T15:44:18.897' AS DateTime), N'RohitTiwari@Techcronus.com', N'U', N'Reason', N' ABC', N' ABCEF')
INSERT [dbo].[Tbl_Audit_ReasonMaster] ([auditId], [ReasonID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (79, 34, CAST(N'2023-04-03T15:45:15.850' AS DateTime), NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_ReasonMaster] ([auditId], [ReasonID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (80, 34, CAST(N'2023-04-03T15:45:24.363' AS DateTime), NULL, N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_ReasonMaster] ([auditId], [ReasonID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (81, 32, CAST(N'2023-04-03T15:45:31.750' AS DateTime), N'RohitTiwari@Techcronus.com', N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_ReasonMaster] ([auditId], [ReasonID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (82, 30, CAST(N'2023-04-03T15:47:32.560' AS DateTime), NULL, N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_ReasonMaster] ([auditId], [ReasonID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (83, 21, CAST(N'2023-04-03T15:57:03.737' AS DateTime), N'RohitTiwari@Techcronus.com', N'U', N'Reason', N'ABC', N'ABCqq')
INSERT [dbo].[Tbl_Audit_ReasonMaster] ([auditId], [ReasonID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (84, 21, CAST(N'2023-04-03T15:58:52.307' AS DateTime), N'RohitTiwari@Techcronus.com', N'U', N'IsDeleted', N'0', N'1')
SET IDENTITY_INSERT [dbo].[Tbl_Audit_ReasonMaster] OFF
GO
SET IDENTITY_INSERT [dbo].[Tbl_Audit_RoleMaster] ON 

INSERT [dbo].[Tbl_Audit_RoleMaster] ([auditId], [RoleId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1, 3, CAST(N'2023-03-02T11:18:50.353' AS DateTime), NULL, N'U', N'IsDeleted', NULL, N'1')
INSERT [dbo].[Tbl_Audit_RoleMaster] ([auditId], [RoleId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (2, 3, CAST(N'2023-03-02T11:21:05.010' AS DateTime), N'meena', N'U', N'RoleName', N'Candidate', N'Candidate--')
INSERT [dbo].[Tbl_Audit_RoleMaster] ([auditId], [RoleId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (3, 2, CAST(N'2023-03-02T11:22:49.370' AS DateTime), NULL, N'U', N'IsDeleted', NULL, N'1')
INSERT [dbo].[Tbl_Audit_RoleMaster] ([auditId], [RoleId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (4, 1, CAST(N'2023-03-02T11:30:18.303' AS DateTime), N'tom', N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_RoleMaster] ([auditId], [RoleId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (5, 1, CAST(N'2023-03-07T16:40:10.957' AS DateTime), N'BOB', N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_RoleMaster] ([auditId], [RoleId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (6, 1, CAST(N'2023-03-07T17:07:03.307' AS DateTime), NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_RoleMaster] ([auditId], [RoleId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (7, 3, CAST(N'2023-03-15T18:41:02.133' AS DateTime), N'meena', N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_RoleMaster] ([auditId], [RoleId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (8, 2, CAST(N'2023-03-15T18:41:02.133' AS DateTime), NULL, N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_RoleMaster] ([auditId], [RoleId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (9, 4, CAST(N'2023-03-15T18:54:48.530' AS DateTime), NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_RoleMaster] ([auditId], [RoleId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (10, 5, CAST(N'2023-03-15T19:02:37.600' AS DateTime), NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_RoleMaster] ([auditId], [RoleId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (11, 6, CAST(N'2023-03-16T09:34:29.133' AS DateTime), NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_RoleMaster] ([auditId], [RoleId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (12, 5, CAST(N'2023-03-17T19:40:00.950' AS DateTime), NULL, N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_RoleMaster] ([auditId], [RoleId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (13, 6, CAST(N'2023-03-20T12:54:05.747' AS DateTime), NULL, N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_RoleMaster] ([auditId], [RoleId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (14, 1, CAST(N'2023-03-20T14:41:36.847' AS DateTime), N'muskan', N'U', N'RoleName', N'Admin', N'HR')
INSERT [dbo].[Tbl_Audit_RoleMaster] ([auditId], [RoleId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (15, 1, CAST(N'2023-03-20T16:57:04.137' AS DateTime), N'RohitTiwari@Techcronus.com', N'U', N'RoleName', N'HR', N'HR--')
INSERT [dbo].[Tbl_Audit_RoleMaster] ([auditId], [RoleId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (16, 7, CAST(N'2023-03-20T16:58:37.010' AS DateTime), NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_RoleMaster] ([auditId], [RoleId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (17, 7, CAST(N'2023-03-20T16:59:50.397' AS DateTime), NULL, N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_RoleMaster] ([auditId], [RoleId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (18, 1, CAST(N'2023-03-20T17:00:13.087' AS DateTime), N'RohitTiwari@Techcronus.com', N'U', N'RoleName', N'HR--', N'HR')
INSERT [dbo].[Tbl_Audit_RoleMaster] ([auditId], [RoleId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (19, 8, CAST(N'2023-03-22T19:01:49.290' AS DateTime), NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_RoleMaster] ([auditId], [RoleId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (20, 1, CAST(N'2023-03-22T19:22:47.333' AS DateTime), N'RohitTiwari@Techcronus.com', N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_RoleMaster] ([auditId], [RoleId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (21, 9, CAST(N'2023-03-22T19:23:13.543' AS DateTime), NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_RoleMaster] ([auditId], [RoleId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (22, 10, CAST(N'2023-03-23T18:23:44.937' AS DateTime), NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_RoleMaster] ([auditId], [RoleId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (23, 10, CAST(N'2023-03-23T18:28:07.630' AS DateTime), NULL, N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_RoleMaster] ([auditId], [RoleId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (24, 11, CAST(N'2023-03-28T17:35:09.457' AS DateTime), NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_RoleMaster] ([auditId], [RoleId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (25, 12, CAST(N'2023-03-28T17:36:22.833' AS DateTime), NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_RoleMaster] ([auditId], [RoleId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (26, 11, CAST(N'2023-03-28T17:37:07.370' AS DateTime), NULL, N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_RoleMaster] ([auditId], [RoleId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (27, 12, CAST(N'2023-03-28T17:37:13.143' AS DateTime), NULL, N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_RoleMaster] ([auditId], [RoleId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (28, 8, CAST(N'2023-03-28T17:40:56.610' AS DateTime), NULL, N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_RoleMaster] ([auditId], [RoleId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (29, 9, CAST(N'2023-03-28T17:44:04.793' AS DateTime), NULL, N'U', N'RoleName', N'H R', N'H R az')
INSERT [dbo].[Tbl_Audit_RoleMaster] ([auditId], [RoleId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (30, 9, CAST(N'2023-03-28T17:44:15.573' AS DateTime), NULL, N'U', N'RoleName', N'H R az', N'H R ')
INSERT [dbo].[Tbl_Audit_RoleMaster] ([auditId], [RoleId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (31, 9, CAST(N'2023-03-28T17:44:40.543' AS DateTime), NULL, N'U', N'RoleName', N'H R ', N'H R q')
INSERT [dbo].[Tbl_Audit_RoleMaster] ([auditId], [RoleId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (32, 9, CAST(N'2023-03-28T17:44:50.253' AS DateTime), NULL, N'U', N'RoleName', N'H R q', N'H R')
INSERT [dbo].[Tbl_Audit_RoleMaster] ([auditId], [RoleId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (33, 9, CAST(N'2023-03-29T12:42:39.817' AS DateTime), NULL, N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_RoleMaster] ([auditId], [RoleId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (34, 4, CAST(N'2023-04-03T16:10:59.097' AS DateTime), N'RohitTiwari@Techcronus.com', N'U', N'RoleName', N'Candidate', N'Candidate ss')
INSERT [dbo].[Tbl_Audit_RoleMaster] ([auditId], [RoleId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (35, 4, CAST(N'2023-04-03T16:12:43.960' AS DateTime), N'RohitTiwari@Techcronus.com', N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_RoleMaster] ([auditId], [RoleId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (36, 12, CAST(N'2023-04-03T16:14:09.733' AS DateTime), NULL, N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_RoleMaster] ([auditId], [RoleId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (37, 11, CAST(N'2023-04-03T16:14:09.733' AS DateTime), NULL, N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_RoleMaster] ([auditId], [RoleId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (38, 10, CAST(N'2023-04-03T16:14:09.733' AS DateTime), NULL, N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_RoleMaster] ([auditId], [RoleId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (39, 9, CAST(N'2023-04-03T16:14:09.733' AS DateTime), NULL, N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_RoleMaster] ([auditId], [RoleId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (40, 8, CAST(N'2023-04-03T16:14:09.733' AS DateTime), NULL, N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_RoleMaster] ([auditId], [RoleId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (41, 7, CAST(N'2023-04-03T16:14:09.733' AS DateTime), NULL, N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_RoleMaster] ([auditId], [RoleId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (42, 6, CAST(N'2023-04-03T16:14:09.733' AS DateTime), NULL, N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_RoleMaster] ([auditId], [RoleId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (43, 5, CAST(N'2023-04-03T16:14:09.733' AS DateTime), NULL, N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_RoleMaster] ([auditId], [RoleId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (44, 4, CAST(N'2023-04-03T16:14:09.733' AS DateTime), N'RohitTiwari@Techcronus.com', N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_RoleMaster] ([auditId], [RoleId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (45, 1, CAST(N'2023-04-03T16:14:09.733' AS DateTime), N'RohitTiwari@Techcronus.com', N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_RoleMaster] ([auditId], [RoleId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (46, 14, CAST(N'2023-04-03T16:14:16.960' AS DateTime), NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_RoleMaster] ([auditId], [RoleId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (47, 15, CAST(N'2023-04-03T16:14:51.667' AS DateTime), NULL, N'I', NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[Tbl_Audit_RoleMaster] OFF
GO
SET IDENTITY_INSERT [dbo].[Tbl_Audit_RoundMaster] ON 

INSERT [dbo].[Tbl_Audit_RoundMaster] ([auditId], [RoundID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1, 5, CAST(N'2023-03-02T12:16:40.813' AS DateTime), NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_RoundMaster] ([auditId], [RoundID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (2, 5, CAST(N'2023-03-02T12:18:55.277' AS DateTime), N'Muskan', N'U', N'Round_Name', N'Tecnical', N'Coding')
INSERT [dbo].[Tbl_Audit_RoundMaster] ([auditId], [RoundID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (3, 5, CAST(N'2023-03-02T12:19:24.987' AS DateTime), N'Muskan', N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_RoundMaster] ([auditId], [RoundID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (4, 1, CAST(N'2023-03-07T13:34:33.700' AS DateTime), N'TOM', N'U', N'Round_Name', N'GD', N'G-D')
INSERT [dbo].[Tbl_Audit_RoundMaster] ([auditId], [RoundID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (5, 1, CAST(N'2023-03-07T13:34:47.840' AS DateTime), N'TOM', N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_RoundMaster] ([auditId], [RoundID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (6, 3, CAST(N'2023-03-07T17:19:03.423' AS DateTime), NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_RoundMaster] ([auditId], [RoundID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (7, 6, CAST(N'2023-03-16T10:19:54.363' AS DateTime), NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_RoundMaster] ([auditId], [RoundID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (8, 7, CAST(N'2023-03-16T10:26:41.823' AS DateTime), NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_RoundMaster] ([auditId], [RoundID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (9, 5, CAST(N'2023-03-16T10:28:06.270' AS DateTime), N'Muskan', N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_RoundMaster] ([auditId], [RoundID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (10, 1, CAST(N'2023-03-16T10:28:06.270' AS DateTime), N'TOM', N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_RoundMaster] ([auditId], [RoundID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (11, 8, CAST(N'2023-03-16T10:29:13.987' AS DateTime), NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_RoundMaster] ([auditId], [RoundID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (12, 6, CAST(N'2023-03-17T20:08:19.040' AS DateTime), NULL, N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_RoundMaster] ([auditId], [RoundID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (13, 8, CAST(N'2023-03-17T20:09:11.060' AS DateTime), NULL, N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_RoundMaster] ([auditId], [RoundID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (14, 7, CAST(N'2023-03-17T20:10:08.847' AS DateTime), NULL, N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_RoundMaster] ([auditId], [RoundID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (15, 3, CAST(N'2023-03-20T13:06:19.877' AS DateTime), NULL, N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_RoundMaster] ([auditId], [RoundID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (16, 9, CAST(N'2023-03-20T14:26:34.843' AS DateTime), NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_RoundMaster] ([auditId], [RoundID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (17, 10, CAST(N'2023-03-20T14:27:27.963' AS DateTime), NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_RoundMaster] ([auditId], [RoundID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (18, 2, CAST(N'2023-03-20T17:12:12.150' AS DateTime), N'RohitTiwari@Techcronus.com', N'U', N'Round_Name', N'Aptitude', N'Aptitude--')
INSERT [dbo].[Tbl_Audit_RoundMaster] ([auditId], [RoundID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (19, 2, CAST(N'2023-03-20T17:12:31.730' AS DateTime), N'RohitTiwari@Techcronus.com', N'U', N'Round_Name', N'Aptitude--', N'Aptitude')
INSERT [dbo].[Tbl_Audit_RoundMaster] ([auditId], [RoundID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (20, 11, CAST(N'2023-03-20T17:19:20.233' AS DateTime), NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_RoundMaster] ([auditId], [RoundID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (21, 12, CAST(N'2023-03-20T17:21:01.557' AS DateTime), NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_RoundMaster] ([auditId], [RoundID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (22, 13, CAST(N'2023-03-20T17:22:07.103' AS DateTime), NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_RoundMaster] ([auditId], [RoundID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (23, 13, CAST(N'2023-03-20T17:23:33.180' AS DateTime), NULL, N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_RoundMaster] ([auditId], [RoundID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (24, 12, CAST(N'2023-03-20T17:23:42.700' AS DateTime), NULL, N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_RoundMaster] ([auditId], [RoundID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (25, 11, CAST(N'2023-03-20T17:23:52.857' AS DateTime), NULL, N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_RoundMaster] ([auditId], [RoundID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (26, 10, CAST(N'2023-03-20T17:24:01.737' AS DateTime), NULL, N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_RoundMaster] ([auditId], [RoundID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (27, 14, CAST(N'2023-03-20T17:29:46.660' AS DateTime), NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_RoundMaster] ([auditId], [RoundID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (28, 15, CAST(N'2023-03-20T17:31:38.190' AS DateTime), NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_RoundMaster] ([auditId], [RoundID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (29, 16, CAST(N'2023-03-20T17:34:26.110' AS DateTime), NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_RoundMaster] ([auditId], [RoundID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (30, 15, CAST(N'2023-03-20T17:34:33.453' AS DateTime), NULL, N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_RoundMaster] ([auditId], [RoundID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (31, 14, CAST(N'2023-03-20T17:34:42.907' AS DateTime), NULL, N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_RoundMaster] ([auditId], [RoundID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (32, 16, CAST(N'2023-03-20T17:35:37.907' AS DateTime), NULL, N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_RoundMaster] ([auditId], [RoundID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (33, 2, CAST(N'2023-03-23T12:11:38.513' AS DateTime), N'RohitTiwari@Techcronus.com', N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_RoundMaster] ([auditId], [RoundID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (34, 17, CAST(N'2023-03-23T12:18:48.810' AS DateTime), NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_RoundMaster] ([auditId], [RoundID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (35, 9, CAST(N'2023-03-23T12:21:15.630' AS DateTime), N'RohitTiwari@Techcronus.com', N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_RoundMaster] ([auditId], [RoundID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (36, 17, CAST(N'2023-03-23T12:37:52.100' AS DateTime), NULL, N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_RoundMaster] ([auditId], [RoundID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (37, 18, CAST(N'2023-03-23T18:13:01.737' AS DateTime), NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_RoundMaster] ([auditId], [RoundID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (38, 18, CAST(N'2023-03-23T18:16:23.280' AS DateTime), N'RohitTiwari@Techcronus.com', N'U', N'Round_Name', N'CODDING2', N'CODDING 2')
INSERT [dbo].[Tbl_Audit_RoundMaster] ([auditId], [RoundID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (39, 18, CAST(N'2023-03-29T12:48:11.753' AS DateTime), N'RohitTiwari@Techcronus.com', N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_RoundMaster] ([auditId], [RoundID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (40, 19, CAST(N'2023-03-29T15:00:50.347' AS DateTime), NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_RoundMaster] ([auditId], [RoundID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (41, 20, CAST(N'2023-03-29T15:20:08.450' AS DateTime), NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_RoundMaster] ([auditId], [RoundID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (42, 19, CAST(N'2023-03-29T15:27:18.490' AS DateTime), N'RohitTiwari@Techcronus.com', N'U', N'Round_Name', N'CODDING 1', N'CODDING 1u')
INSERT [dbo].[Tbl_Audit_RoundMaster] ([auditId], [RoundID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (43, 19, CAST(N'2023-03-29T15:27:32.240' AS DateTime), N'RohitTiwari@Techcronus.com', N'U', N'Round_Name', N'CODDING 1u', N'CODDING 1')
INSERT [dbo].[Tbl_Audit_RoundMaster] ([auditId], [RoundID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (44, 20, CAST(N'2023-03-29T15:27:50.793' AS DateTime), N'RohitTiwari@Techcronus.com', N'U', N'Round_Name', N'sss', N'HR Round')
INSERT [dbo].[Tbl_Audit_RoundMaster] ([auditId], [RoundID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (45, 20, CAST(N'2023-03-29T15:29:43.333' AS DateTime), N'RohitTiwari@Techcronus.com', N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_RoundMaster] ([auditId], [RoundID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (46, 19, CAST(N'2023-03-29T15:31:19.647' AS DateTime), N'RohitTiwari@Techcronus.com', N'U', N'Round_Name', N'CODDING 1', N'CODDING 11')
INSERT [dbo].[Tbl_Audit_RoundMaster] ([auditId], [RoundID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (47, 21, CAST(N'2023-03-29T16:43:20.363' AS DateTime), NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_RoundMaster] ([auditId], [RoundID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (48, 22, CAST(N'2023-04-03T16:31:07.347' AS DateTime), NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_RoundMaster] ([auditId], [RoundID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (49, 22, CAST(N'2023-04-03T16:31:36.060' AS DateTime), N'RohitTiwari@Techcronus.com', N'U', N'Round_Name', N'Codding level1', N'Codding level')
INSERT [dbo].[Tbl_Audit_RoundMaster] ([auditId], [RoundID], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (50, 19, CAST(N'2023-04-03T16:32:08.600' AS DateTime), N'RohitTiwari@Techcronus.com', N'U', N'IsDeleted', N'0', N'1')
SET IDENTITY_INSERT [dbo].[Tbl_Audit_RoundMaster] OFF
GO
SET IDENTITY_INSERT [dbo].[Tbl_Audit_TechnologyMaster] ON 

INSERT [dbo].[Tbl_Audit_TechnologyMaster] ([auditId], [TechnologyId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (1, 5, NULL, N'joy', N'U', N'TechnologyName', N'Android', N'Flutter')
INSERT [dbo].[Tbl_Audit_TechnologyMaster] ([auditId], [TechnologyId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (2, 5, NULL, N'joy', N'U', N'Discription', NULL, N'front-end')
INSERT [dbo].[Tbl_Audit_TechnologyMaster] ([auditId], [TechnologyId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (3, 8, NULL, NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_TechnologyMaster] ([auditId], [TechnologyId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (4, 8, NULL, NULL, N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_TechnologyMaster] ([auditId], [TechnologyId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (5, 9, NULL, NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_TechnologyMaster] ([auditId], [TechnologyId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (6, 11, NULL, NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_TechnologyMaster] ([auditId], [TechnologyId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (7, 1, NULL, N'SUSER_NAME', N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_TechnologyMaster] ([auditId], [TechnologyId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (8, 12, NULL, NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_TechnologyMaster] ([auditId], [TechnologyId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (9, 8, NULL, NULL, N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_TechnologyMaster] ([auditId], [TechnologyId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (10, 1, NULL, N'SUSER_NAME', N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_TechnologyMaster] ([auditId], [TechnologyId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (11, 2, NULL, NULL, N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_TechnologyMaster] ([auditId], [TechnologyId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (12, 4, NULL, NULL, N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_TechnologyMaster] ([auditId], [TechnologyId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (13, 3, NULL, NULL, N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_TechnologyMaster] ([auditId], [TechnologyId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (14, 6, NULL, NULL, N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_TechnologyMaster] ([auditId], [TechnologyId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (15, 7, NULL, NULL, N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_TechnologyMaster] ([auditId], [TechnologyId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (16, 5, NULL, N'joy', N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_TechnologyMaster] ([auditId], [TechnologyId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (17, 14, NULL, NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_TechnologyMaster] ([auditId], [TechnologyId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (18, 15, NULL, NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_TechnologyMaster] ([auditId], [TechnologyId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (19, 16, NULL, NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_TechnologyMaster] ([auditId], [TechnologyId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (20, 17, NULL, NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_TechnologyMaster] ([auditId], [TechnologyId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (21, 16, NULL, NULL, N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_TechnologyMaster] ([auditId], [TechnologyId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (22, 15, NULL, NULL, N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_TechnologyMaster] ([auditId], [TechnologyId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (23, 17, NULL, NULL, N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_TechnologyMaster] ([auditId], [TechnologyId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (24, 18, NULL, NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_TechnologyMaster] ([auditId], [TechnologyId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (25, 19, NULL, NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_TechnologyMaster] ([auditId], [TechnologyId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (26, 18, NULL, NULL, N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_TechnologyMaster] ([auditId], [TechnologyId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (27, 12, NULL, N'Muskan', N'U', N'TechnologyName', N'Cyber', N'Cyber--')
INSERT [dbo].[Tbl_Audit_TechnologyMaster] ([auditId], [TechnologyId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (28, 12, NULL, N'Muskan', N'U', N'IsActive', N'0', N'1')
INSERT [dbo].[Tbl_Audit_TechnologyMaster] ([auditId], [TechnologyId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (29, 9, NULL, NULL, N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_TechnologyMaster] ([auditId], [TechnologyId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (30, 12, NULL, N'Muskan', N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_TechnologyMaster] ([auditId], [TechnologyId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (31, 14, NULL, N'muskan', N'U', N'Discription', N'MVC', N'MVC--')
INSERT [dbo].[Tbl_Audit_TechnologyMaster] ([auditId], [TechnologyId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (32, 14, NULL, N'muskan', N'U', N'Discription', N'MVC--', N'MVC')
INSERT [dbo].[Tbl_Audit_TechnologyMaster] ([auditId], [TechnologyId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (33, 11, NULL, N'Muskan', N'U', N'TechnologyName', N'DL', N'Dl---')
INSERT [dbo].[Tbl_Audit_TechnologyMaster] ([auditId], [TechnologyId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (34, 20, NULL, NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_TechnologyMaster] ([auditId], [TechnologyId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (35, 11, NULL, N'RohitTiwari@Techcronus.com', N'U', N'TechnologyName', N'Dl---', N'Dl')
INSERT [dbo].[Tbl_Audit_TechnologyMaster] ([auditId], [TechnologyId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (36, 14, NULL, N'muskan', N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_TechnologyMaster] ([auditId], [TechnologyId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (37, 20, NULL, NULL, N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_TechnologyMaster] ([auditId], [TechnologyId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (38, 20, NULL, NULL, N'U', N'IsActive', N'1', N'0')
INSERT [dbo].[Tbl_Audit_TechnologyMaster] ([auditId], [TechnologyId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (39, 14, NULL, N'muskan', N'U', N'IsActive', N'1', N'0')
INSERT [dbo].[Tbl_Audit_TechnologyMaster] ([auditId], [TechnologyId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (40, 12, NULL, N'Muskan', N'U', N'IsActive', N'1', N'0')
INSERT [dbo].[Tbl_Audit_TechnologyMaster] ([auditId], [TechnologyId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (41, 9, NULL, NULL, N'U', N'IsActive', N'1', N'0')
INSERT [dbo].[Tbl_Audit_TechnologyMaster] ([auditId], [TechnologyId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (42, 21, NULL, NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_TechnologyMaster] ([auditId], [TechnologyId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (43, 21, NULL, NULL, N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_TechnologyMaster] ([auditId], [TechnologyId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (44, 21, NULL, NULL, N'U', N'IsActive', N'1', N'0')
INSERT [dbo].[Tbl_Audit_TechnologyMaster] ([auditId], [TechnologyId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (45, 11, NULL, N'RohitTiwari@Techcronus.com', N'U', N'TechnologyName', N'Dl', NULL)
INSERT [dbo].[Tbl_Audit_TechnologyMaster] ([auditId], [TechnologyId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (46, 11, NULL, N'RohitTiwari@Techcronus.com', N'U', N'TechnologyName', NULL, N'Dl')
INSERT [dbo].[Tbl_Audit_TechnologyMaster] ([auditId], [TechnologyId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (47, 11, NULL, N'RohitTiwari@Techcronus.com', N'U', N'TechnologyName', N'Dl', N'.NET -')
INSERT [dbo].[Tbl_Audit_TechnologyMaster] ([auditId], [TechnologyId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (48, 22, NULL, NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_TechnologyMaster] ([auditId], [TechnologyId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (49, 23, NULL, NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_TechnologyMaster] ([auditId], [TechnologyId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (50, 11, NULL, N'RohitTiwari@Techcronus.com', N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_TechnologyMaster] ([auditId], [TechnologyId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (51, 11, NULL, N'RohitTiwari@Techcronus.com', N'U', N'IsActive', N'1', N'0')
INSERT [dbo].[Tbl_Audit_TechnologyMaster] ([auditId], [TechnologyId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (52, 24, NULL, NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_TechnologyMaster] ([auditId], [TechnologyId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (53, 25, NULL, NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_TechnologyMaster] ([auditId], [TechnologyId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (54, 26, NULL, NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_TechnologyMaster] ([auditId], [TechnologyId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (55, 19, NULL, N'RohitTiwari@Techcronus.com', N'U', N'TechnologyName', N'.NET Core', N'NET Core')
INSERT [dbo].[Tbl_Audit_TechnologyMaster] ([auditId], [TechnologyId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (56, 26, NULL, N'SUSER_NAME', N'U', N'TechnologyName', N'.net 2', N'PYTHON 2.1')
INSERT [dbo].[Tbl_Audit_TechnologyMaster] ([auditId], [TechnologyId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (57, 25, NULL, NULL, N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_TechnologyMaster] ([auditId], [TechnologyId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (58, 25, NULL, NULL, N'U', N'IsActive', N'1', N'0')
INSERT [dbo].[Tbl_Audit_TechnologyMaster] ([auditId], [TechnologyId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (59, 22, NULL, NULL, N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_TechnologyMaster] ([auditId], [TechnologyId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (60, 22, NULL, NULL, N'U', N'IsActive', N'1', N'0')
INSERT [dbo].[Tbl_Audit_TechnologyMaster] ([auditId], [TechnologyId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (61, 26, NULL, N'SUSER_NAME', N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_TechnologyMaster] ([auditId], [TechnologyId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (62, 26, NULL, N'SUSER_NAME', N'U', N'IsActive', N'1', N'0')
INSERT [dbo].[Tbl_Audit_TechnologyMaster] ([auditId], [TechnologyId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (63, 19, NULL, N'RohitTiwari@Techcronus.com', N'U', N'TechnologyName', N'NET Core', N'NET COR')
INSERT [dbo].[Tbl_Audit_TechnologyMaster] ([auditId], [TechnologyId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (64, 19, NULL, N'RohitTiwari@Techcronus.com', N'U', N'TechnologyName', N'NET COR', N'NET CORE')
INSERT [dbo].[Tbl_Audit_TechnologyMaster] ([auditId], [TechnologyId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (65, 19, NULL, N'RohitTiwari@Techcronus.com', N'U', N'TechnologyName', N'NET CORE', N'NET C')
INSERT [dbo].[Tbl_Audit_TechnologyMaster] ([auditId], [TechnologyId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (66, 19, NULL, N'RohitTiwari@Techcronus.com', N'U', N'TechnologyName', N'NET C', N'NET CORE')
INSERT [dbo].[Tbl_Audit_TechnologyMaster] ([auditId], [TechnologyId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (67, 24, NULL, NULL, N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_TechnologyMaster] ([auditId], [TechnologyId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (68, 24, NULL, NULL, N'U', N'IsActive', N'1', N'0')
INSERT [dbo].[Tbl_Audit_TechnologyMaster] ([auditId], [TechnologyId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (69, 27, NULL, NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_TechnologyMaster] ([auditId], [TechnologyId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (70, 23, NULL, NULL, N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_TechnologyMaster] ([auditId], [TechnologyId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (71, 23, NULL, NULL, N'U', N'IsActive', N'1', N'0')
INSERT [dbo].[Tbl_Audit_TechnologyMaster] ([auditId], [TechnologyId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (72, 28, NULL, NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_TechnologyMaster] ([auditId], [TechnologyId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (73, 28, NULL, N'muskan', N'U', N'Description', N'MVC', N'ddd')
INSERT [dbo].[Tbl_Audit_TechnologyMaster] ([auditId], [TechnologyId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (74, 28, NULL, N'RohitTiwari@Techcronus.com', N'U', N'Description', N'ddd', N'd')
INSERT [dbo].[Tbl_Audit_TechnologyMaster] ([auditId], [TechnologyId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (75, 27, NULL, N'RohitTiwari@Techcronus.com', N'U', N'Description', N'AI', N'AI ML')
INSERT [dbo].[Tbl_Audit_TechnologyMaster] ([auditId], [TechnologyId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (76, 27, NULL, N'RohitTiwari@Techcronus.com', N'U', N'TechnologyName', N'Tensorflow', N'NET p')
INSERT [dbo].[Tbl_Audit_TechnologyMaster] ([auditId], [TechnologyId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (77, 27, NULL, N'RohitTiwari@Techcronus.com', N'U', N'TechnologyName', N'NET p', N'TENSORFLOW')
INSERT [dbo].[Tbl_Audit_TechnologyMaster] ([auditId], [TechnologyId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (78, 29, NULL, NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_TechnologyMaster] ([auditId], [TechnologyId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (79, 29, NULL, NULL, N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_TechnologyMaster] ([auditId], [TechnologyId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (80, 29, NULL, NULL, N'U', N'IsActive', N'1', N'0')
INSERT [dbo].[Tbl_Audit_TechnologyMaster] ([auditId], [TechnologyId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (81, 30, NULL, NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_TechnologyMaster] ([auditId], [TechnologyId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (82, 30, NULL, NULL, N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_TechnologyMaster] ([auditId], [TechnologyId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (83, 30, NULL, NULL, N'U', N'IsActive', N'1', N'0')
INSERT [dbo].[Tbl_Audit_TechnologyMaster] ([auditId], [TechnologyId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (84, 31, NULL, NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_TechnologyMaster] ([auditId], [TechnologyId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (85, 32, NULL, NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_TechnologyMaster] ([auditId], [TechnologyId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (86, 33, NULL, NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_TechnologyMaster] ([auditId], [TechnologyId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (87, 33, NULL, NULL, N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_TechnologyMaster] ([auditId], [TechnologyId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (88, 33, NULL, NULL, N'U', N'IsActive', N'1', N'0')
INSERT [dbo].[Tbl_Audit_TechnologyMaster] ([auditId], [TechnologyId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (89, 32, NULL, NULL, N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_TechnologyMaster] ([auditId], [TechnologyId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (90, 32, NULL, NULL, N'U', N'IsActive', N'1', N'0')
INSERT [dbo].[Tbl_Audit_TechnologyMaster] ([auditId], [TechnologyId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (91, 27, NULL, N'RohitTiwari@Techcronus.com', N'U', N'TechnologyName', N'Tensorflow', N'Tensorflow 1')
INSERT [dbo].[Tbl_Audit_TechnologyMaster] ([auditId], [TechnologyId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (92, 27, NULL, N'RohitTiwari@Techcronus.com', N'U', N'TechnologyName', N'Tensorflow 1', N'Tensorflow')
INSERT [dbo].[Tbl_Audit_TechnologyMaster] ([auditId], [TechnologyId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (93, 34, NULL, NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_TechnologyMaster] ([auditId], [TechnologyId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (94, 35, NULL, NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_TechnologyMaster] ([auditId], [TechnologyId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (95, 34, NULL, NULL, N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_TechnologyMaster] ([auditId], [TechnologyId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (96, 34, NULL, NULL, N'U', N'IsActive', N'1', N'0')
INSERT [dbo].[Tbl_Audit_TechnologyMaster] ([auditId], [TechnologyId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (97, 35, NULL, NULL, N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_TechnologyMaster] ([auditId], [TechnologyId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (98, 35, NULL, NULL, N'U', N'IsActive', N'1', N'0')
INSERT [dbo].[Tbl_Audit_TechnologyMaster] ([auditId], [TechnologyId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (99, 28, NULL, N'RohitTiwari@Techcronus.com', N'U', N'IsDeleted', N'0', N'1')
GO
INSERT [dbo].[Tbl_Audit_TechnologyMaster] ([auditId], [TechnologyId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (100, 28, NULL, N'RohitTiwari@Techcronus.com', N'U', N'IsActive', N'1', N'0')
INSERT [dbo].[Tbl_Audit_TechnologyMaster] ([auditId], [TechnologyId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (101, 19, NULL, N'RohitTiwari@Techcronus.com', N'U', N'IsDeleted', N'0', N'1')
INSERT [dbo].[Tbl_Audit_TechnologyMaster] ([auditId], [TechnologyId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (102, 19, NULL, N'RohitTiwari@Techcronus.com', N'U', N'IsActive', N'1', N'0')
INSERT [dbo].[Tbl_Audit_TechnologyMaster] ([auditId], [TechnologyId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (103, 36, NULL, NULL, N'I', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_TechnologyMaster] ([auditId], [TechnologyId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (104, 36, NULL, N'RohitTiwari@Techcronus.com', N'U', N'TechnologyName', N'HTML', N'HTML CSS')
INSERT [dbo].[Tbl_Audit_TechnologyMaster] ([auditId], [TechnologyId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (105, 36, NULL, N'RohitTiwari@Techcronus.com', N'U', N'Description', N'Basic', N'Basic Sample')
INSERT [dbo].[Tbl_Audit_TechnologyMaster] ([auditId], [TechnologyId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (106, 9, NULL, NULL, N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_TechnologyMaster] ([auditId], [TechnologyId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (107, 11, NULL, N'RohitTiwari@Techcronus.com', N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_TechnologyMaster] ([auditId], [TechnologyId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (108, 12, NULL, N'Muskan', N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_TechnologyMaster] ([auditId], [TechnologyId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (109, 25, NULL, NULL, N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_TechnologyMaster] ([auditId], [TechnologyId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (110, 24, NULL, NULL, N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_TechnologyMaster] ([auditId], [TechnologyId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (111, 23, NULL, NULL, N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_TechnologyMaster] ([auditId], [TechnologyId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (112, 22, NULL, NULL, N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_TechnologyMaster] ([auditId], [TechnologyId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (113, 21, NULL, NULL, N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_TechnologyMaster] ([auditId], [TechnologyId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (114, 35, NULL, NULL, N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_TechnologyMaster] ([auditId], [TechnologyId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (115, 34, NULL, NULL, N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_TechnologyMaster] ([auditId], [TechnologyId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (116, 33, NULL, NULL, N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_TechnologyMaster] ([auditId], [TechnologyId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (117, 32, NULL, NULL, N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_TechnologyMaster] ([auditId], [TechnologyId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (118, 14, NULL, N'muskan', N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_TechnologyMaster] ([auditId], [TechnologyId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (119, 30, NULL, NULL, N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_TechnologyMaster] ([auditId], [TechnologyId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (120, 29, NULL, NULL, N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_TechnologyMaster] ([auditId], [TechnologyId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (121, 26, NULL, N'SUSER_NAME', N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_TechnologyMaster] ([auditId], [TechnologyId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (122, 19, NULL, N'RohitTiwari@Techcronus.com', N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_TechnologyMaster] ([auditId], [TechnologyId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (123, 20, NULL, NULL, N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_TechnologyMaster] ([auditId], [TechnologyId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (124, 27, NULL, N'RohitTiwari@Techcronus.com', N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_TechnologyMaster] ([auditId], [TechnologyId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (125, 31, NULL, NULL, N'D', NULL, NULL, NULL)
INSERT [dbo].[Tbl_Audit_TechnologyMaster] ([auditId], [TechnologyId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (126, 36, NULL, N'RohitTiwari@Techcronus.com', N'U', N'Description', N'Basic Sample', N'Basic ')
INSERT [dbo].[Tbl_Audit_TechnologyMaster] ([auditId], [TechnologyId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (127, 36, NULL, N'', N'U', N'TechnologyName', N'HTML CSS', N'html')
INSERT [dbo].[Tbl_Audit_TechnologyMaster] ([auditId], [TechnologyId], [change_date], [change_user], [change_category], [field], [previous_value], [changed_to_value]) VALUES (128, 36, NULL, N'', N'U', N'Description', N'Basic ', N'hello')
SET IDENTITY_INSERT [dbo].[Tbl_Audit_TechnologyMaster] OFF
GO
SET IDENTITY_INSERT [dbo].[Tbl_DesignationMaster] ON 

INSERT [dbo].[Tbl_DesignationMaster] ([DesignationID], [Designation], [create_user], [create_date], [change_user], [change_date], [IsDeleted]) VALUES (1052, N'Admin-', N'RohitTiwari@Techcronus.com', CAST(N'2023-03-22T11:00:00.793' AS DateTime), N'', CAST(N'2023-03-22T11:11:13.970' AS DateTime), 0)
SET IDENTITY_INSERT [dbo].[Tbl_DesignationMaster] OFF
GO
SET IDENTITY_INSERT [dbo].[Tbl_Interviewers] ON 

INSERT [dbo].[Tbl_Interviewers] ([InterviewerId], [FirstName], [LastName], [Email], [TechnologyId], [TechnologyName], [YearOfExperience], [DesignationId], [Designation], [TotalInterviewsConducted], [create_user], [create_date], [change_user], [change_date], [IsDeleted]) VALUES (1, N'Rohit', N'Tiwari', N'rohit@gmail.com', 28, N'ASP.net', 1.3, 1052, N'Admin-', 2, N'', NULL, NULL, CAST(N'2023-03-31T14:36:06.040' AS DateTime), 0)
SET IDENTITY_INSERT [dbo].[Tbl_Interviewers] OFF
GO
SET IDENTITY_INSERT [dbo].[Tbl_ReasonMaster] ON 

INSERT [dbo].[Tbl_ReasonMaster] ([ReasonID], [Reason], [create_user], [create_date], [change_user], [change_date], [IsDeleted]) VALUES (0, N'string', N'string', CAST(N'2023-03-07T16:06:09.767' AS DateTime), N'muskan', CAST(N'2023-03-17T18:58:40.160' AS DateTime), 1)
INSERT [dbo].[Tbl_ReasonMaster] ([ReasonID], [Reason], [create_user], [create_date], [change_user], [change_date], [IsDeleted]) VALUES (1, N'Technical', N'Muskan', CAST(N'1900-01-01T00:00:00.000' AS DateTime), N'Muskan', CAST(N'2023-03-01T16:14:57.140' AS DateTime), 1)
INSERT [dbo].[Tbl_ReasonMaster] ([ReasonID], [Reason], [create_user], [create_date], [change_user], [change_date], [IsDeleted]) VALUES (2, N'---other reason---', N'Muskan', CAST(N'2023-03-01T15:21:53.550' AS DateTime), N'Bob', CAST(N'2023-03-07T10:15:32.900' AS DateTime), 1)
INSERT [dbo].[Tbl_ReasonMaster] ([ReasonID], [Reason], [create_user], [create_date], [change_user], [change_date], [IsDeleted]) VALUES (3, N'cold', N'Muskan', CAST(N'2023-03-01T17:41:59.660' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[Tbl_ReasonMaster] ([ReasonID], [Reason], [create_user], [create_date], [change_user], [change_date], [IsDeleted]) VALUES (4, N'--function--', N'Muskan', CAST(N'2023-03-02T10:05:41.127' AS DateTime), N'joy', CAST(N'2023-03-02T10:21:28.140' AS DateTime), 1)
INSERT [dbo].[Tbl_ReasonMaster] ([ReasonID], [Reason], [create_user], [create_date], [change_user], [change_date], [IsDeleted]) VALUES (5, N'function', N'joy', CAST(N'2023-03-02T10:34:51.647' AS DateTime), N'meena', CAST(N'2023-03-02T10:56:31.807' AS DateTime), 1)
INSERT [dbo].[Tbl_ReasonMaster] ([ReasonID], [Reason], [create_user], [create_date], [change_user], [change_date], [IsDeleted]) VALUES (6, N'Sick', N'Jerry', CAST(N'2023-03-07T15:31:59.227' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[Tbl_ReasonMaster] ([ReasonID], [Reason], [create_user], [create_date], [change_user], [change_date], [IsDeleted]) VALUES (7, N'sick', N'mona', CAST(N'2023-03-07T15:49:14.297' AS DateTime), N'muskan', CAST(N'2023-03-20T14:35:42.560' AS DateTime), 1)
INSERT [dbo].[Tbl_ReasonMaster] ([ReasonID], [Reason], [create_user], [create_date], [change_user], [change_date], [IsDeleted]) VALUES (8, N'COLD', N'Jelly', CAST(N'2023-03-07T15:50:26.413' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[Tbl_ReasonMaster] ([ReasonID], [Reason], [create_user], [create_date], [change_user], [change_date], [IsDeleted]) VALUES (9, N'Headache', N'Roy', CAST(N'2023-03-07T15:54:06.183' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[Tbl_ReasonMaster] ([ReasonID], [Reason], [create_user], [create_date], [change_user], [change_date], [IsDeleted]) VALUES (10, N'string---', N'string', CAST(N'2023-03-07T15:56:37.687' AS DateTime), N'RohitTiwari@Techcronus.com', CAST(N'2023-03-20T16:17:12.397' AS DateTime), 1)
INSERT [dbo].[Tbl_ReasonMaster] ([ReasonID], [Reason], [create_user], [create_date], [change_user], [change_date], [IsDeleted]) VALUES (11, N'leave', N'string', CAST(N'2023-03-07T16:13:43.240' AS DateTime), N'other', CAST(N'2023-03-20T14:35:23.727' AS DateTime), 1)
INSERT [dbo].[Tbl_ReasonMaster] ([ReasonID], [Reason], [create_user], [create_date], [change_user], [change_date], [IsDeleted]) VALUES (12, N'High Fever', N'nick', CAST(N'2023-03-15T15:49:14.630' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[Tbl_ReasonMaster] ([ReasonID], [Reason], [create_user], [create_date], [change_user], [change_date], [IsDeleted]) VALUES (13, N'High Coldp', N'muskan', CAST(N'2023-03-15T15:55:10.833' AS DateTime), N'RohitTiwari@Techcronus.com', CAST(N'2023-03-28T12:53:57.773' AS DateTime), 1)
INSERT [dbo].[Tbl_ReasonMaster] ([ReasonID], [Reason], [create_user], [create_date], [change_user], [change_date], [IsDeleted]) VALUES (14, N'-Other Reason__', N'muskan', CAST(N'2023-03-15T16:01:39.600' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[Tbl_ReasonMaster] ([ReasonID], [Reason], [create_user], [create_date], [change_user], [change_date], [IsDeleted]) VALUES (15, N'other Reason', N'Muskan', CAST(N'2023-03-20T15:27:08.537' AS DateTime), N'RohitTiwari@Techcronus.com', CAST(N'2023-03-28T13:04:38.550' AS DateTime), 1)
INSERT [dbo].[Tbl_ReasonMaster] ([ReasonID], [Reason], [create_user], [create_date], [change_user], [change_date], [IsDeleted]) VALUES (16, N'other--', N'RohitTiwari@Techcronus.com', CAST(N'2023-03-20T15:31:05.600' AS DateTime), N'RohitTiwari@Techcronus.com', CAST(N'2023-03-20T15:33:04.850' AS DateTime), 1)
INSERT [dbo].[Tbl_ReasonMaster] ([ReasonID], [Reason], [create_user], [create_date], [change_user], [change_date], [IsDeleted]) VALUES (17, NULL, N'RohitTiwari@Techcronus.com', CAST(N'2023-03-20T19:03:36.560' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[Tbl_ReasonMaster] ([ReasonID], [Reason], [create_user], [create_date], [change_user], [change_date], [IsDeleted]) VALUES (18, NULL, N'RohitTiwari@Techcronus.com', CAST(N'2023-03-22T17:02:08.823' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[Tbl_ReasonMaster] ([ReasonID], [Reason], [create_user], [create_date], [change_user], [change_date], [IsDeleted]) VALUES (19, N'other 11', N'RohitTiwari@Techcronus.com', CAST(N'2023-03-22T18:28:22.070' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[Tbl_ReasonMaster] ([ReasonID], [Reason], [create_user], [create_date], [change_user], [change_date], [IsDeleted]) VALUES (20, N'uy4', N'RohitTiwari@Techcronus.com', CAST(N'2023-03-22T18:29:33.940' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[Tbl_ReasonMaster] ([ReasonID], [Reason], [create_user], [create_date], [change_user], [change_date], [IsDeleted]) VALUES (21, N'ABCqq', N'RohitTiwari@Techcronus.com', CAST(N'2023-03-22T18:30:54.530' AS DateTime), N'RohitTiwari@Techcronus.com', CAST(N'2023-04-03T15:57:03.670' AS DateTime), 1)
INSERT [dbo].[Tbl_ReasonMaster] ([ReasonID], [Reason], [create_user], [create_date], [change_user], [change_date], [IsDeleted]) VALUES (22, N' ABCEF', N'RohitTiwari@Techcronus.com', CAST(N'2023-03-23T17:38:37.250' AS DateTime), N'RohitTiwari@Techcronus.com', CAST(N'2023-04-03T15:44:18.830' AS DateTime), 0)
INSERT [dbo].[Tbl_ReasonMaster] ([ReasonID], [Reason], [create_user], [create_date], [change_user], [change_date], [IsDeleted]) VALUES (23, N'ABCo', NULL, CAST(N'2023-03-28T12:24:39.227' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[Tbl_ReasonMaster] ([ReasonID], [Reason], [create_user], [create_date], [change_user], [change_date], [IsDeleted]) VALUES (24, N'leavel', NULL, CAST(N'2023-03-28T12:25:52.773' AS DateTime), NULL, CAST(N'2023-03-28T12:31:31.727' AS DateTime), 1)
INSERT [dbo].[Tbl_ReasonMaster] ([ReasonID], [Reason], [create_user], [create_date], [change_user], [change_date], [IsDeleted]) VALUES (25, N'aaaa', NULL, CAST(N'2023-03-28T12:32:43.693' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[Tbl_ReasonMaster] ([ReasonID], [Reason], [create_user], [create_date], [change_user], [change_date], [IsDeleted]) VALUES (26, N'ss', NULL, CAST(N'2023-03-28T12:34:00.527' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[Tbl_ReasonMaster] ([ReasonID], [Reason], [create_user], [create_date], [change_user], [change_date], [IsDeleted]) VALUES (27, N'qqq', NULL, CAST(N'2023-03-28T12:35:20.127' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[Tbl_ReasonMaster] ([ReasonID], [Reason], [create_user], [create_date], [change_user], [change_date], [IsDeleted]) VALUES (28, N'aa', N'RohitTiwari@Techcronus.com', CAST(N'2023-03-28T12:37:12.100' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[Tbl_ReasonMaster] ([ReasonID], [Reason], [create_user], [create_date], [change_user], [change_date], [IsDeleted]) VALUES (29, N'leave adc', N'RohitTiwari@Techcronus.com', CAST(N'2023-03-28T13:54:27.307' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[Tbl_ReasonMaster] ([ReasonID], [Reason], [create_user], [create_date], [change_user], [change_date], [IsDeleted]) VALUES (30, N'PQR ', N'RohitTiwari@Techcronus.com', CAST(N'2023-03-29T12:00:01.763' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[Tbl_ReasonMaster] ([ReasonID], [Reason], [create_user], [create_date], [change_user], [change_date], [IsDeleted]) VALUES (31, N'xyx', N'RohitTiwari@Techcronus.com', CAST(N'2023-03-29T12:09:36.017' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[Tbl_ReasonMaster] ([ReasonID], [Reason], [create_user], [create_date], [change_user], [change_date], [IsDeleted]) VALUES (32, N'ABC say', N'RohitTiwari@Techcronus.com', CAST(N'2023-03-29T13:28:49.147' AS DateTime), N'RohitTiwari@Techcronus.com', CAST(N'2023-03-29T13:33:21.903' AS DateTime), 1)
INSERT [dbo].[Tbl_ReasonMaster] ([ReasonID], [Reason], [create_user], [create_date], [change_user], [change_date], [IsDeleted]) VALUES (33, N'A', N'RohitTiwari@Techcronus.com', CAST(N'2023-03-29T13:29:07.127' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[Tbl_ReasonMaster] ([ReasonID], [Reason], [create_user], [create_date], [change_user], [change_date], [IsDeleted]) VALUES (34, N'sss', N'RohitTiwari@Techcronus.com', CAST(N'2023-04-03T15:45:15.800' AS DateTime), NULL, NULL, 1)
SET IDENTITY_INSERT [dbo].[Tbl_ReasonMaster] OFF
GO
SET IDENTITY_INSERT [dbo].[Tbl_RoleMaster] ON 

INSERT [dbo].[Tbl_RoleMaster] ([RoleId], [RoleName], [create_user], [create_date], [change_user], [change_date], [IsDeleted]) VALUES (14, N'Admin', N'RohitTiwari@Techcronus.com', CAST(N'2023-04-03T16:14:16.913' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[Tbl_RoleMaster] ([RoleId], [RoleName], [create_user], [create_date], [change_user], [change_date], [IsDeleted]) VALUES (15, N'Candidate', N'RohitTiwari@Techcronus.com', CAST(N'2023-04-03T16:14:51.667' AS DateTime), NULL, NULL, 0)
SET IDENTITY_INSERT [dbo].[Tbl_RoleMaster] OFF
GO
SET IDENTITY_INSERT [dbo].[Tbl_RoundMaster] ON 

INSERT [dbo].[Tbl_RoundMaster] ([RoundID], [Round_Name], [create_user], [create_date], [change_user], [change_date], [IsDeleted]) VALUES (2, N'Aptitude', N'Muskan', CAST(N'2023-03-01T16:03:27.090' AS DateTime), N'RohitTiwari@Techcronus.com', CAST(N'2023-03-20T17:12:31.710' AS DateTime), 1)
INSERT [dbo].[Tbl_RoundMaster] ([RoundID], [Round_Name], [create_user], [create_date], [change_user], [change_date], [IsDeleted]) VALUES (3, N'Communication', N'string', CAST(N'2023-03-07T17:19:03.367' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[Tbl_RoundMaster] ([RoundID], [Round_Name], [create_user], [create_date], [change_user], [change_date], [IsDeleted]) VALUES (6, N'Basic Coding', N'muskan', CAST(N'2023-03-16T10:19:54.273' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[Tbl_RoundMaster] ([RoundID], [Round_Name], [create_user], [create_date], [change_user], [change_date], [IsDeleted]) VALUES (7, N'Basic Aptitude', N'nick', CAST(N'2023-03-16T10:26:41.777' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[Tbl_RoundMaster] ([RoundID], [Round_Name], [create_user], [create_date], [change_user], [change_date], [IsDeleted]) VALUES (8, N'G-D', N'muskan', CAST(N'2023-03-16T10:29:13.940' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[Tbl_RoundMaster] ([RoundID], [Round_Name], [create_user], [create_date], [change_user], [change_date], [IsDeleted]) VALUES (9, N'GD', N'Muskan', CAST(N'2023-03-20T14:26:34.750' AS DateTime), N'RohitTiwari@Techcronus.com', CAST(N'2023-03-20T17:24:19.010' AS DateTime), 1)
INSERT [dbo].[Tbl_RoundMaster] ([RoundID], [Round_Name], [create_user], [create_date], [change_user], [change_date], [IsDeleted]) VALUES (10, N'GD--', NULL, CAST(N'2023-03-20T14:27:27.843' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[Tbl_RoundMaster] ([RoundID], [Round_Name], [create_user], [create_date], [change_user], [change_date], [IsDeleted]) VALUES (11, N'Coding', NULL, CAST(N'2023-03-20T17:19:20.180' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[Tbl_RoundMaster] ([RoundID], [Round_Name], [create_user], [create_date], [change_user], [change_date], [IsDeleted]) VALUES (12, N'Coding1', NULL, CAST(N'2023-03-20T17:21:01.503' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[Tbl_RoundMaster] ([RoundID], [Round_Name], [create_user], [create_date], [change_user], [change_date], [IsDeleted]) VALUES (13, N'Coding4', NULL, CAST(N'2023-03-20T17:22:07.053' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[Tbl_RoundMaster] ([RoundID], [Round_Name], [create_user], [create_date], [change_user], [change_date], [IsDeleted]) VALUES (14, N'CODDING', NULL, CAST(N'2023-03-20T17:29:46.610' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[Tbl_RoundMaster] ([RoundID], [Round_Name], [create_user], [create_date], [change_user], [change_date], [IsDeleted]) VALUES (15, N'APTITUDE---', NULL, CAST(N'2023-03-20T17:31:38.143' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[Tbl_RoundMaster] ([RoundID], [Round_Name], [create_user], [create_date], [change_user], [change_date], [IsDeleted]) VALUES (16, N'CODDING1', N'RohitTiwari@Techcronus.com', CAST(N'2023-03-20T17:34:26.063' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[Tbl_RoundMaster] ([RoundID], [Round_Name], [create_user], [create_date], [change_user], [change_date], [IsDeleted]) VALUES (17, N' GD', N'RohitTiwari@Techcronus.com', CAST(N'2023-03-23T12:18:48.757' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[Tbl_RoundMaster] ([RoundID], [Round_Name], [create_user], [create_date], [change_user], [change_date], [IsDeleted]) VALUES (18, N'CODDING 2', N'RohitTiwari@Techcronus.com', CAST(N'2023-03-23T18:13:01.193' AS DateTime), N'RohitTiwari@Techcronus.com', CAST(N'2023-03-23T18:16:23.030' AS DateTime), 1)
INSERT [dbo].[Tbl_RoundMaster] ([RoundID], [Round_Name], [create_user], [create_date], [change_user], [change_date], [IsDeleted]) VALUES (19, N'CODDING 11', N'RohitTiwari@Techcronus.com', CAST(N'2023-03-29T15:00:50.120' AS DateTime), N'RohitTiwari@Techcronus.com', CAST(N'2023-03-29T15:31:19.350' AS DateTime), 1)
INSERT [dbo].[Tbl_RoundMaster] ([RoundID], [Round_Name], [create_user], [create_date], [change_user], [change_date], [IsDeleted]) VALUES (20, N'HR Round', N'RohitTiwari@Techcronus.com', CAST(N'2023-03-29T15:20:07.290' AS DateTime), N'RohitTiwari@Techcronus.com', CAST(N'2023-03-29T15:27:50.640' AS DateTime), 1)
INSERT [dbo].[Tbl_RoundMaster] ([RoundID], [Round_Name], [create_user], [create_date], [change_user], [change_date], [IsDeleted]) VALUES (21, N'G D', N'RohitTiwari@Techcronus.com', CAST(N'2023-03-29T16:43:19.963' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[Tbl_RoundMaster] ([RoundID], [Round_Name], [create_user], [create_date], [change_user], [change_date], [IsDeleted]) VALUES (22, N'Codding level', N'RohitTiwari@Techcronus.com', CAST(N'2023-04-03T16:31:07.300' AS DateTime), N'RohitTiwari@Techcronus.com', CAST(N'2023-04-03T16:31:36.043' AS DateTime), 0)
SET IDENTITY_INSERT [dbo].[Tbl_RoundMaster] OFF
GO
SET IDENTITY_INSERT [dbo].[Tbl_TechnologyMaster] ON 

INSERT [dbo].[Tbl_TechnologyMaster] ([TechnologyId], [TechnologyName], [IsActive], [Description], [create_user], [create_date], [change_user], [change_date], [IsDeleted]) VALUES (28, N'ASP.net', 0, N'd', N'RohitTiwari@Techcronus.com', CAST(N'2023-03-29T14:11:13.670' AS DateTime), N'RohitTiwari@Techcronus.com', CAST(N'2023-03-29T14:28:10.673' AS DateTime), 1)
INSERT [dbo].[Tbl_TechnologyMaster] ([TechnologyId], [TechnologyName], [IsActive], [Description], [create_user], [create_date], [change_user], [change_date], [IsDeleted]) VALUES (36, N'html', 1, N'hello', N'RohitTiwari@Techcronus.com', CAST(N'2023-04-03T13:12:41.933' AS DateTime), N'', CAST(N'2023-04-03T17:22:48.010' AS DateTime), 0)
SET IDENTITY_INSERT [dbo].[Tbl_TechnologyMaster] OFF
GO
SET IDENTITY_INSERT [dbo].[Tbl_UserLogin] ON 

INSERT [dbo].[Tbl_UserLogin] ([Id], [InterviewerId], [EmailId], [Password], [RoleId], [LoginDateTime], [LoginMessage]) VALUES (1, 1, N'RohitTiwari@Techcronus.com', N'jucwGSA5xlxs27Y2wrLo/w==', 1, CAST(N'2023-04-03T18:27:17.227' AS DateTime), N'Successfull User Login')
SET IDENTITY_INSERT [dbo].[Tbl_UserLogin] OFF
GO
ALTER TABLE [dbo].[Tbl_Audit_DesignationMaster] ADD  CONSTRAINT [DF_Tbl_Audit_DesignationMaster_change_date]  DEFAULT (getdate()) FOR [change_date]
GO
ALTER TABLE [dbo].[Tbl_Audit_ReasonMaster] ADD  CONSTRAINT [DF_Tbl_Audit_ReasonMaster_change_date]  DEFAULT (getdate()) FOR [change_date]
GO
ALTER TABLE [dbo].[Tbl_Audit_RoleMaster] ADD  CONSTRAINT [DF_Tbl_Audit_RoleMaster_change_date]  DEFAULT (getdate()) FOR [change_date]
GO
ALTER TABLE [dbo].[Tbl_Audit_RoundMaster] ADD  CONSTRAINT [DF_Tbl_Audit_RoundMaster_change_date]  DEFAULT (getdate()) FOR [change_date]
GO
ALTER TABLE [dbo].[Tbl_MenuMaster] ADD  CONSTRAINT [DF_Tbl_MenuMaster_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[Tbl_CityMaster]  WITH CHECK ADD  CONSTRAINT [FK_Table_CityMaster_Table_CityMaster] FOREIGN KEY([StateId])
REFERENCES [dbo].[Tbl_StateMaster] ([StateId])
GO
ALTER TABLE [dbo].[Tbl_CityMaster] CHECK CONSTRAINT [FK_Table_CityMaster_Table_CityMaster]
GO
ALTER TABLE [dbo].[Tbl_Interviewers]  WITH CHECK ADD  CONSTRAINT [FK_Tbl_Interviewers_Tbl_DesignationMaster] FOREIGN KEY([DesignationId])
REFERENCES [dbo].[Tbl_DesignationMaster] ([DesignationID])
GO
ALTER TABLE [dbo].[Tbl_Interviewers] CHECK CONSTRAINT [FK_Tbl_Interviewers_Tbl_DesignationMaster]
GO
ALTER TABLE [dbo].[Tbl_Interviewers]  WITH CHECK ADD  CONSTRAINT [FK_Tbl_Interviewers_Tbl_TechnologyMaster] FOREIGN KEY([TechnologyId])
REFERENCES [dbo].[Tbl_TechnologyMaster] ([TechnologyId])
GO
ALTER TABLE [dbo].[Tbl_Interviewers] CHECK CONSTRAINT [FK_Tbl_Interviewers_Tbl_TechnologyMaster]
GO
ALTER TABLE [dbo].[Tbl_UserLogin]  WITH CHECK ADD  CONSTRAINT [FK_Tbl_UserLogin_Tbl_Interviewers] FOREIGN KEY([InterviewerId])
REFERENCES [dbo].[Tbl_Interviewers] ([InterviewerId])
GO
ALTER TABLE [dbo].[Tbl_UserLogin] CHECK CONSTRAINT [FK_Tbl_UserLogin_Tbl_Interviewers]
GO
/****** Object:  StoredProcedure [dbo].[GetAllDesignationMasterData]    Script Date: 03-04-2023 06:43:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetAllDesignationMasterData]
AS
BEGIN

     SELECT DesignationID,Designation, create_user, create_date FROM Tbl_DesignationMaster WHERE IsDeleted='false';
END
GO
/****** Object:  StoredProcedure [dbo].[GetAllInterviewersData]    Script Date: 03-04-2023 06:43:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetAllInterviewersData]
   
AS
BEGIN
   SELECT Tbl_Interviewers.InterviewerId, Tbl_Interviewers.FirstName, Tbl_Interviewers.LastName, Tbl_Interviewers.Email, Tbl_TechnologyMaster.TechnologyId, Tbl_TechnologyMaster.TechnologyName, Tbl_DesignationMaster.DesignationID, Tbl_DesignationMaster.Designation, Tbl_Interviewers.YearOfExperience, Tbl_Interviewers.TotalInterviewsConducted, Tbl_Interviewers.change_user, Tbl_Interviewers.create_date, Tbl_Interviewers.change_user, Tbl_Interviewers.change_date, Tbl_Interviewers.IsDeleted
	FROM ((Tbl_Interviewers 
	INNER JOIN Tbl_DesignationMaster ON Tbl_Interviewers.DesignationId = Tbl_DesignationMaster.DesignationID)
	INNER JOIN Tbl_TechnologyMaster ON Tbl_Interviewers.TechnologyId = Tbl_TechnologyMaster.TechnologyId)
	WHERE Tbl_Interviewers.IsDeleted = 0;
END
GO
/****** Object:  StoredProcedure [dbo].[GetAllMasterData]    Script Date: 03-04-2023 06:43:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetAllMasterData] 

AS
BEGIN
	SET NOCOUNT ON;
	-- only take those fields which are required to be displayed in grid
	 SELECT DesignationID,Designation, create_user, create_date FROM Tbl_DesignationMaster WHERE IsDeleted='false';
	SELECT ReasonID,Reason,create_user,create_date,change_date FROM Tbl_ReasonMaster where IsDeleted='false';
	SELECT RoleId,RoleName,create_user,create_date,change_date FROM Tbl_RoleMaster where IsDeleted='false';
	SELECT RoundId,Round_Name,create_user,create_date,change_date FROM Tbl_RoundMaster where IsDeleted='false';
	SELECT TechnologyId,TechnologyName,Description,create_user,create_date,change_date FROM Tbl_TechnologyMaster where IsDeleted='false';
	
END
GO
/****** Object:  StoredProcedure [dbo].[GetAllReasonMasterData]    Script Date: 03-04-2023 06:43:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetAllReasonMasterData]
AS
BEGIN
    SELECT ReasonID,Reason,create_user,create_date FROM Tbl_ReasonMaster where IsDeleted='false'
END
GO
/****** Object:  StoredProcedure [dbo].[GetAllRoleMasterData]    Script Date: 03-04-2023 06:43:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetAllRoleMasterData]
AS
BEGIN
    SELECT RoleId,RoleName,create_user,create_date FROM Tbl_RoleMaster where IsDeleted='false'
END
GO
/****** Object:  StoredProcedure [dbo].[GetAllRoundMasterData]    Script Date: 03-04-2023 06:43:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetAllRoundMasterData]
AS
BEGIN
    SELECT RoundID,Round_Name,create_user,create_date FROM Tbl_RoundMaster where IsDeleted='false'
END
GO
/****** Object:  StoredProcedure [dbo].[GetAllTechnologyMasterData]    Script Date: 03-04-2023 06:43:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetAllTechnologyMasterData]
AS
BEGIN
    SELECT TechnologyId,TechnologyName,Description,create_user,create_date FROM Tbl_TechnologyMaster where IsDeleted='false'
END
GO
/****** Object:  StoredProcedure [dbo].[PageDesignationMaster]    Script Date: 03-04-2023 06:43:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PageDesignationMaster]
    @PageNumber INT = 1,
    @RowsOfPage INT = 5
AS
BEGIN
    DECLARE @MaxTablePage AS FLOAT
    SELECT @MaxTablePage = CEILING(COUNT(*) / CAST(@RowsOfPage AS FLOAT)) FROM  Tbl_DesignationMaster IF @PageNumber > @MaxTablePage
    BEGIN
        SET @PageNumber = @MaxTablePage
    END     SELECT * FROM (
        SELECT ROW_NUMBER() OVER (ORDER BY DesignationID) AS RowNum, *
        FROM Tbl_DesignationMaster
    ) AS EmployeeDataWithRowNum
    WHERE RowNum > (@PageNumber - 1) * @RowsOfPage AND RowNum <= @PageNumber * @RowsOfPage
END 
GO
/****** Object:  StoredProcedure [dbo].[PageReasonMaster]    Script Date: 03-04-2023 06:43:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PageReasonMaster]
    @PageNumber INT = 1,
    @RowsOfPage INT = 5
AS
BEGIN
    DECLARE @MaxTablePage AS FLOAT
    SELECT @MaxTablePage = CEILING(COUNT(*) / CAST(@RowsOfPage AS FLOAT)) FROM  Tbl_ReasonMaster IF @PageNumber > @MaxTablePage
    BEGIN
        SET @PageNumber = @MaxTablePage
    END     SELECT * FROM (
        SELECT ROW_NUMBER() OVER (ORDER BY ReasonID) AS RowNum, *
        FROM Tbl_ReasonMaster
    ) AS EmployeeDataWithRowNum
    WHERE RowNum > (@PageNumber - 1) * @RowsOfPage AND RowNum <= @PageNumber * @RowsOfPage
END 
GO
/****** Object:  StoredProcedure [dbo].[PageRoleMaster]    Script Date: 03-04-2023 06:43:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PageRoleMaster]
    @PageNumber INT = 1,
    @RowsOfPage INT = 5
AS
BEGIN
    DECLARE @MaxTablePage AS FLOAT
    SELECT @MaxTablePage = CEILING(COUNT(*) / CAST(@RowsOfPage AS FLOAT)) FROM  Tbl_RoleMaster IF @PageNumber > @MaxTablePage
    BEGIN
        SET @PageNumber = @MaxTablePage
    END     SELECT * FROM (
        SELECT ROW_NUMBER() OVER (ORDER BY RoleID) AS RowNum, *
        FROM Tbl_RoleMaster
    ) AS EmployeeDataWithRowNum
    WHERE RowNum > (@PageNumber - 1) * @RowsOfPage AND RowNum <= @PageNumber * @RowsOfPage
END 
GO
/****** Object:  StoredProcedure [dbo].[PageRoundMaster]    Script Date: 03-04-2023 06:43:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PageRoundMaster]
    @PageNumber INT = 1,
    @RowsOfPage INT = 5
AS
BEGIN
    DECLARE @MaxTablePage AS FLOAT
    SELECT @MaxTablePage = CEILING(COUNT(*) / CAST(@RowsOfPage AS FLOAT)) FROM  Tbl_RoundMaster IF @PageNumber > @MaxTablePage
    BEGIN
        SET @PageNumber = @MaxTablePage
    END     SELECT * FROM (
        SELECT ROW_NUMBER() OVER (ORDER BY RoundID) AS RowNum, *
        FROM Tbl_RoundMaster
    ) AS EmployeeDataWithRowNum
    WHERE RowNum > (@PageNumber - 1) * @RowsOfPage AND RowNum <= @PageNumber * @RowsOfPage
END 
GO
/****** Object:  StoredProcedure [dbo].[PageTechnologyMaster]    Script Date: 03-04-2023 06:43:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PageTechnologyMaster]
    @PageNumber INT = 1,
    @RowsOfPage INT = 5
AS
BEGIN
    DECLARE @MaxTablePage AS FLOAT
    SELECT @MaxTablePage = CEILING(COUNT(*) / CAST(@RowsOfPage AS FLOAT)) FROM  Tbl_TechnologyMaster IF @PageNumber > @MaxTablePage
    BEGIN
        SET @PageNumber = @MaxTablePage
    END     SELECT * FROM (
        SELECT ROW_NUMBER() OVER (ORDER BY TechnologyID) AS RowNum, *
        FROM Tbl_TechnologyMaster
    ) AS EmployeeDataWithRowNum
    WHERE RowNum > (@PageNumber - 1) * @RowsOfPage AND RowNum <= @PageNumber * @RowsOfPage
END 
GO
/****** Object:  StoredProcedure [dbo].[sp_AuthenticateUserLogin]    Script Date: 03-04-2023 06:43:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Rohit Tiwari>
-- Create date: <Create Date : 30/01/2023>
-- Description:	<Check login user is valid or not.>
-- Exec [sp_AuthenticateUserLogin] 'RohitTiwari@Techcronus.com','Cdu8ugFusrwvh7Yli/ZlkQ=='
-- =============================================
CREATE PROCEDURE [dbo].[sp_AuthenticateUserLogin] 
@email nvarchar(100),
@password nvarchar(1000)        
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
   
   IF EXISTS (Select 1 From Tbl_UserLogin Where ltrim(rtrim(EmailId)) = ltrim(rtrim(@email)) And Password = @password )
    Begin
      Select Id,EmailId,CONCAT(I.FirstName,I.LastName) As UserFullName,R.RoleName As UserRoleName,1 As AccessToken From Tbl_UserLogin As U Left Join Tbl_Interviewers As I ON I.InterviewerId = U.InterviewerId
	  Left Join Tbl_RoleMaster As R ON U.RoleId = R.RoleId

	  Update Tbl_UserLogin Set LoginDateTime = GETDATE(),
	                           LoginMessage = 'Successfull User Login' 
	  Where ltrim(rtrim(EmailId)) = ltrim(rtrim(@email))
    End
   Else
    Begin
      Select 2 As AccessToken
	  Update Tbl_UserLogin Set LoginDateTime = GETDATE(),
	                           LoginMessage = 'Unsuccessfull User Login' 
	  Where ltrim(rtrim(EmailId)) = ltrim(rtrim(@email))
    End
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Delete_DesignationMaster]    Script Date: 03-04-2023 06:43:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Delete_DesignationMaster]
(
    @DesignationID int
)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION
        UPDATE Tbl_DesignationMaster SET IsDeleted = 1 WHERE DesignationID = @DesignationID
        COMMIT TRANSACTION
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION
        SELECT ERROR_MESSAGE()
    END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Delete_Interviewer]    Script Date: 03-04-2023 06:43:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [dbo].[sp_Delete_Interviewer]
(
    @InterviewerId int
)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION
        UPDATE Tbl_Interviewers SET IsDeleted = 1 WHERE InterviewerId = @InterviewerId
        COMMIT TRANSACTION
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION
        SELECT ERROR_MESSAGE()
    END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Delete_ReasonMaster]    Script Date: 03-04-2023 06:43:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Delete_ReasonMaster]
(
    @ReasonID int
)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION
        UPDATE Tbl_ReasonMaster SET IsDeleted = 1 WHERE ReasonId = @ReasonId
        COMMIT TRANSACTION
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION
        SELECT ERROR_MESSAGE()
    END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Delete_RoleMaster]    Script Date: 03-04-2023 06:43:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Delete_RoleMaster]
(
    @RoleId int
)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION
        UPDATE Tbl_RoleMaster SET IsDeleted = 1 WHERE RoleId = @RoleId
        SELECT 'Successful' AS ResultMessage;
        COMMIT TRANSACTION
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION
        SELECT ERROR_MESSAGE()
    END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Delete_RoundMaster]    Script Date: 03-04-2023 06:43:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Delete_RoundMaster]
(
    @RoundID int
)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION
        UPDATE Tbl_RoundMaster SET IsDeleted = 1 WHERE RoundID = @RoundID
        COMMIT TRANSACTION
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION
        SELECT ERROR_MESSAGE()
    END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Delete_TechnologyMaster]    Script Date: 03-04-2023 06:43:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Delete_TechnologyMaster]
(
    @TechnologyId int
)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION
         UPDATE  Tbl_TechnologyMaster  SET IsDeleted = 1 WHERE TechnologyId = @TechnologyId
         UPDATE  Tbl_TechnologyMaster  SET IsActive = 0 WHERE IsDeleted = 1

        COMMIT TRANSACTION
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION
        SELECT ERROR_MESSAGE()
    END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Insert_DesignationMaster]    Script Date: 03-04-2023 06:43:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Insert_DesignationMaster]
(
    
    @Designation VARCHAR(50),
    @create_user nvarchar(50) = SUSER_NAME,
    @IsDeleted BIT = 0
   -- @ErrorMessage VARCHAR(500) OUTPUT
)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @RowCount INT = 0;
    SET @RowCount = (SELECT COUNT(1) FROM dbo.Tbl_DesignationMaster WHERE Designation = @Designation);
	
    IF (@RowCount = 0)
    begin
       
            INSERT INTO Tbl_DesignationMaster ( Designation, create_user, create_date, IsDeleted)
            VALUES ( @Designation, @create_user, GETDATE(), @IsDeleted)
			SELECT 'Successful' AS ResultMessage;
	end
   ELSE
     SELECT 'Unsuccessful' AS ResultMessage;
      
          
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Insert_Interviewers]    Script Date: 03-04-2023 06:43:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Insert_Interviewers]
(
    @FirstName varchar(50),
    @LastName varchar(50),
    @Email nvarchar(50),
    @TechnologyId int,
    @YearOfExperience float,
    @DesignationId int,
    @TotalInterviewsConducted int,
    @create_user nvarchar(50) = SUSER_NAME,
    @IsDeleted bit = 0
)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @RowCount INT = 0;
    SET @RowCount = (SELECT COUNT(1) FROM dbo.Tbl_Interviewers WHERE Email = @Email);

    IF (@RowCount = 0)
    BEGIN
        
			DECLARE @TechnologyName varchar(50);
			SELECT @TechnologyName = TechnologyName FROM Tbl_TechnologyMaster WHERE TechnologyId = @TechnologyId;

			DECLARE @Designation varchar(50);
            SELECT @Designation = Designation FROM Tbl_DesignationMaster WHERE DesignationID = @DesignationID;

            INSERT INTO Tbl_Interviewers
                (FirstName, LastName, Email, TechnologyId, TechnologyName, YearOfExperience, DesignationId, Designation, TotalInterviewsConducted, create_user, create_date, IsDeleted)
            VALUES 
                (@FirstName, @LastName, @Email, @TechnologyId, @TechnologyName, @YearOfExperience, @DesignationId, @Designation, @TotalInterviewsConducted, @create_user, GETDATE(), @IsDeleted);

            
            SELECT 'Successful' AS ResultMessage;
    END
    ELSE
    BEGIN
        SELECT 'Unsuccessful' AS ResultMessage;
    END
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Insert_ReasonMaster]    Script Date: 03-04-2023 06:43:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Insert_ReasonMaster]
(
    @Reason VARCHAR(100),
    @create_user nvarchar(50) = SUSER_NAME,
    @IsDeleted bit = 0
)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @RowCount INT = 0;
    SET @RowCount = (SELECT COUNT(1) FROM dbo.Tbl_ReasonMaster WHERE Reason = @Reason);
	
    IF (@RowCount = 0)
    begin
       
            INSERT INTO Tbl_ReasonMaster (Reason, create_user, create_date, IsDeleted)
            VALUES (@Reason, @create_user, GETDATE(), @IsDeleted)
			SELECT 'Successful' AS ResultMessage;
	end
   ELSE
     SELECT 'Unsuccessful' AS ResultMessage;         
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Insert_RoleMaster]    Script Date: 03-04-2023 06:43:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Insert_RoleMaster]
(
    @RoleName VARCHAR(100) ,
    @create_user nvarchar(50) = SUSER_NAME,
    @IsDeleted bit = 0
)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @RowCount INT = 0;
    SET @RowCount = (SELECT COUNT(1) FROM dbo.Tbl_RoleMaster WHERE RoleName = @RoleName);
	
    IF (@RowCount = 0)
    begin
       
            INSERT INTO Tbl_RoleMaster ( RoleName, create_user, create_date, IsDeleted)
            VALUES ( @RoleName, @create_user, GETDATE(), @IsDeleted)
			SELECT 'Successful' AS ResultMessage;
	end
   ELSE
     SELECT 'Unsuccessful' AS ResultMessage;
      
          
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Insert_RoundMaster]    Script Date: 03-04-2023 06:43:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Insert_RoundMaster]
(
	@Round_Name varchar(50),
	@create_user nvarchar(50) = SUSER_NAME,
	@IsDeleted bit = 0
)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @RowCount INT = 0;
    SET @RowCount = (SELECT COUNT(1) FROM dbo.Tbl_RoundMaster WHERE Round_Name = @Round_Name);
	
    IF (@RowCount = 0)
    begin
       
            INSERT INTO Tbl_RoundMaster (Round_Name, create_user, create_date, IsDeleted)
            VALUES ( @Round_Name, @create_user, GETDATE(), @IsDeleted)
			SELECT 'Successful' AS ResultMessage;
	end
   ELSE
     SELECT 'Unsuccessful' AS ResultMessage;
      
          
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Insert_TechnologyMaster]    Script Date: 03-04-2023 06:43:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_Insert_TechnologyMaster] 
(     
    @TechnologyName varchar(100) ,
    @Description nvarchar(max) NULL,
    @IsActive bit = 1,
    @create_user nvarchar(50),
    --@CreatedDate datetime ,
    @IsDeleted bit = 0
)
AS
BEGIN
    DECLARE @RowCount int = 0
    SET @RowCount = (SELECT COUNT(1) FROM dbo.Tbl_TechnologyMaster WHERE TechnologyName = @TechnologyName)
   
        IF (@RowCount = 0)
        BEGIN
            INSERT INTO Tbl_TechnologyMaster
            (
                TechnologyName,
                Description,
                create_user, 
                IsActive,
                create_date,
                IsDeleted
            )
            VALUES
            (
                @TechnologyName,
                @Description,
                @create_user,
                @IsActive,
                GETDATE(),
                @IsDeleted
            )
            Select 'Sucessfull ' AS resultmessage
        END
        ELSE
            BEGIN
                 Select 'Unsucessfull' AS resultmessage
            END
      
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Update_DesignationMaster]    Script Date: 03-04-2023 06:43:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Update_DesignationMaster]
(
    @DesignationID int ,
    @Designation varchar(50) ,
    @change_user nvarchar(50) = SUSER_NAME
)
AS
BEGIN
    DECLARE @DesignationCount int = 0
    SELECT @DesignationCount = COUNT(1) FROM dbo.Tbl_DesignationMaster WHERE Designation = @Designation
    
    IF (@DesignationCount >0 AND 
        ((SELECT DesignationID FROM dbo.Tbl_DesignationMaster WHERE Designation = @Designation) <> @DesignationID OR
        (SELECT Designation FROM dbo.Tbl_DesignationMaster WHERE DesignationID = @DesignationID) = @Designation))
    BEGIN
        SELECT 'Data already exists' AS ResultMessage
        RETURN 
    END

    
    UPDATE Tbl_DesignationMaster
    SET
        Designation = @Designation,
        change_user = @change_user,
        change_date = GETDATE()
    WHERE DesignationID = @DesignationID
    
    SELECT 'Success' AS ResultMessage
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Update_Interviewers]    Script Date: 03-04-2023 06:43:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Update_Interviewers]
(
	@InterviewerId int,
    @FirstName varchar(50),
    @LastName varchar(50),
    @Email nvarchar(50),
    @TechnologyId int,
    @YearOfExperience float,
    @DesignationId int,
    @TotalInterviewsConducted int,
    @change_user nvarchar(50) = SUSER_NAME,
    @IsDeleted BIT = 0
   -- @UpdatedDate datetime 
)
AS
BEGIN
    --SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRAN

        DECLARE @TechnologyName varchar(50);
        SELECT @TechnologyName = TechnologyName FROM Tbl_TechnologyMaster WHERE TechnologyId = @TechnologyId;

        DECLARE @Designation varchar(50);
        SELECT @Designation = Designation FROM Tbl_DesignationMaster WHERE DesignationID = @DesignationID;

        UPDATE Tbl_Interviewers SET
            FirstName = @FirstName,
            LastName = @LastName,
            Email = @Email,
            TechnologyId = @TechnologyId,
            TechnologyName = @TechnologyName,
            YearOfExperience = @YearOfExperience,
            DesignationId = @DesignationId,
            Designation = @Designation,
            TotalInterviewsConducted = @TotalInterviewsConducted,
            change_user = @change_user,
            change_date = GETDATE(),
            IsDeleted = @IsDeleted
        WHERE InterviewerId = @InterviewerId;

        COMMIT TRAN;
        SELECT 'Successful' AS ResultMessage;
    END TRY
    BEGIN CATCH
        ROLLBACK TRAN;
        SELECT 'Unsuccessful' AS ResultMessage;
    END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Update_ReasonMaster]    Script Date: 03-04-2023 06:43:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Update_ReasonMaster]
(
    @ReasonID INT ,
    @Reason VARCHAR(100) ,
    @change_user nvarchar(50) = SUSER_NAME
)
AS
BEGIN
    DECLARE @ReasonCount int = 0
    SELECT @ReasonCount = COUNT(1) FROM dbo.Tbl_ReasonMaster WHERE Reason = @Reason

    IF (@ReasonCount >0 AND 
        ((SELECT ReasonID FROM dbo.Tbl_ReasonMaster WHERE Reason = @Reason) <> @ReasonID OR
        (SELECT Reason FROM dbo.Tbl_ReasonMaster WHERE ReasonID = @ReasonID) = @Reason))
    BEGIN
        SELECT 'Data already exists' AS ResultMessage
        RETURN
    END
	
    
    UPDATE Tbl_ReasonMaster
    SET
        Reason = @Reason,
        change_user = @change_user,
        change_date = GETDATE()
    WHERE ReasonID = @ReasonID
    
    SELECT 'Success' AS ResultMessage
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Update_RoleMaster]    Script Date: 03-04-2023 06:43:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Update_RoleMaster]
(
    @RoleId INT ,
    @RoleName VARCHAR(100) ,
    @change_user nvarchar(50) = SUSER_NAME
 
)
AS
BEGIN
    DECLARE @RoleCount int = 0
    SELECT @RoleCount = COUNT(1) FROM dbo.Tbl_RoleMaster WHERE RoleName = @RoleName

    IF (@RoleCount >0 AND 
        ((SELECT RoleId FROM dbo.Tbl_RoleMaster WHERE RoleName = @RoleName) <> @RoleId OR
        (SELECT RoleName FROM dbo.Tbl_RoleMaster WHERE RoleId = @RoleId) = @RoleName))
    BEGIN
        SELECT 'Data already exists' AS ResultMessage
        RETURN
    END


    UPDATE Tbl_RoleMaster
    SET
        RoleName = @RoleName,
        change_user = @change_user,
        change_date = GETDATE()
    WHERE RoleId = @RoleId
    
    SELECT 'Success' AS ResultMessage
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Update_RoundMaster]    Script Date: 03-04-2023 06:43:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Update_RoundMaster]
(
    @RoundID INT,
    @Round_Name varchar(50) ,
    @change_user  nvarchar(50) = SUSER_NAME
)
AS
BEGIN
    DECLARE @RoundCount int = 0
    SELECT @RoundCount = COUNT(1) FROM dbo.Tbl_RoundMaster WHERE Round_Name = @Round_Name

    IF (@RoundCount >0 AND 
        ((SELECT RoundID FROM dbo.Tbl_RoundMaster WHERE Round_Name = @Round_Name) <> @RoundID OR
        (SELECT Round_Name FROM dbo.Tbl_RoundMaster WHERE RoundID = @RoundID) = @Round_Name))
    BEGIN
        SELECT 'Data already exists.' AS ResultMessage
        RETURN
    END
	
    
    UPDATE Tbl_RoundMaster
    SET
        Round_Name = @Round_Name,
        change_user = @change_user,
        change_date = GETDATE()
    WHERE RoundID = @RoundID
    
    SELECT 'Success' AS ResultMessage
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Update_TechnologyMaster]    Script Date: 03-04-2023 06:43:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Update_TechnologyMaster] 
(
    @TechnologyId int ,
    @TechnologyName varchar(100) ,
    @Description nvarchar(max) NULL,
    @change_user nvarchar(50) = SUSER_NAME
)
AS
BEGIN
    DECLARE @TechnologyCount int = 0
    SELECT @TechnologyCount = COUNT(1) FROM dbo.Tbl_TechnologyMaster WHERE TechnologyName = @TechnologyName

    IF (@TechnologyCount >0 AND
      ((SELECT TechnologyId FROM dbo.Tbl_TechnologyMaster WHERE TechnologyName = @TechnologyName) <> @TechnologyId ))
	  --OR
      --(SELECT TechnologyName FROM dbo.Tbl_TechnologyMaster WHERE TechnologyId = @TechnologyId) = @TechnologyName))
    BEGIN
        SELECT 'Data already exists.' AS ResultMessage
        RETURN
    END

    UPDATE Tbl_TechnologyMaster
    SET
        TechnologyName = @TechnologyName,
		Description= @Description,
        change_user = @change_user,
        change_date = GETDATE()
    WHERE TechnologyId = @TechnologyId
    
    SELECT 'Success' AS ResultMessage
END
GO
USE [master]
GO
ALTER DATABASE [CMS] SET  READ_WRITE 
GO
