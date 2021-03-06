USE [master]
GO
/****** Object:  Database [ICE]    Script Date: 02/03/2006 15:21:17 ******/
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = N'ICE')
BEGIN
CREATE DATABASE [ICE] ON  PRIMARY 
( NAME = N'ICE', FILENAME = N'c:\Program Files\Microsoft SQL Server\MSSQL.1\MSSQL\DATA\ICE.mdf' , SIZE = 3072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'ICE_log', FILENAME = N'c:\Program Files\Microsoft SQL Server\MSSQL.1\MSSQL\DATA\ICE_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
END

GO
EXEC dbo.sp_dbcmptlevel @dbname=N'ICE', @new_cmptlevel=90
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ICE].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ICE] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ICE] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ICE] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ICE] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ICE] SET ARITHABORT OFF 
GO
ALTER DATABASE [ICE] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [ICE] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [ICE] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ICE] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ICE] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ICE] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ICE] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ICE] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ICE] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ICE] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ICE] SET  ENABLE_BROKER 
GO
ALTER DATABASE [ICE] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ICE] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ICE] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ICE] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ICE] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ICE] SET  READ_WRITE 
GO
ALTER DATABASE [ICE] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [ICE] SET  MULTI_USER 
GO
ALTER DATABASE [ICE] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ICE] SET DB_CHAINING OFF 
GO
USE [ICE]
GO
/****** Object:  User [Chris]    Script Date: 02/03/2006 15:21:19 ******/
GO
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'Chris')
CREATE USER [Chris] FOR LOGIN [Chris] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [ice]    Script Date: 02/03/2006 15:21:19 ******/
GO
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'ice')
CREATE USER [ice] FOR LOGIN [ice] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [TTLIVE\csandow]    Script Date: 02/03/2006 15:21:19 ******/
GO
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'TTLIVE\csandow')
CREATE USER [TTLIVE\csandow] FOR LOGIN [TTLIVE\csandow] WITH DEFAULT_SCHEMA=[dbo]
GO
GRANT CONNECT TO [Chris]
GO
GRANT CONNECT TO [ice]
GO
GRANT CREATE REMOTE SERVICE BINDING TO [ice]
GO
GRANT AUTHENTICATE TO [TTLIVE\csandow]
GO
GRANT CONNECT TO [TTLIVE\csandow]
GO
GRANT CONNECT REPLICATION TO [TTLIVE\csandow]
GO
GRANT CREATE REMOTE SERVICE BINDING TO [TTLIVE\csandow]
/****** Object:  Login [TTLIVE\csandow]    Script Date: 02/03/2006 15:21:57 ******/
/****** Object:  Login [TTLIVE\csandow]    Script Date: 02/03/2006 15:21:57 ******/
IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'TTLIVE\csandow')
CREATE LOGIN [TTLIVE\csandow] FROM WINDOWS WITH DEFAULT_DATABASE=[ICE], DEFAULT_LANGUAGE=[us_english]
GO
/****** Object:  Login [P002957\SQLServer2005MSSQLUser$P002957$MSSQLSERVER]    Script Date: 02/03/2006 15:21:57 ******/
/****** Object:  Login [P002957\SQLServer2005MSSQLUser$P002957$MSSQLSERVER]    Script Date: 02/03/2006 15:21:57 ******/
IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'P002957\SQLServer2005MSSQLUser$P002957$MSSQLSERVER')
CREATE LOGIN [P002957\SQLServer2005MSSQLUser$P002957$MSSQLSERVER] FROM WINDOWS WITH DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english]
GO
/****** Object:  Login [NT AUTHORITY\SYSTEM]    Script Date: 02/03/2006 15:21:57 ******/
/****** Object:  Login [NT AUTHORITY\SYSTEM]    Script Date: 02/03/2006 15:21:57 ******/
IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'NT AUTHORITY\SYSTEM')
CREATE LOGIN [NT AUTHORITY\SYSTEM] FROM WINDOWS WITH DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english]
GO
/****** Object:  Login [ice]    Script Date: 02/03/2006 15:21:58 ******/
/* For security reasons the login is created disabled and with a random password. */
/****** Object:  Login [ice]    Script Date: 02/03/2006 15:21:57 ******/
IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'ice')
CREATE LOGIN [ice] WITH PASSWORD=N'i%ÄÆ°ÕõÏ&=è#GTw¯Æîë«ÕI×Sëß', DEFAULT_DATABASE=[ICE], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=OFF, CHECK_POLICY=ON
GO
EXEC sys.sp_addsrvrolemember @loginame = N'ice', @rolename = N'sysadmin'
GO
EXEC sys.sp_addsrvrolemember @loginame = N'ice', @rolename = N'securityadmin'
GO
EXEC sys.sp_addsrvrolemember @loginame = N'ice', @rolename = N'serveradmin'
GO
EXEC sys.sp_addsrvrolemember @loginame = N'ice', @rolename = N'setupadmin'
GO
EXEC sys.sp_addsrvrolemember @loginame = N'ice', @rolename = N'processadmin'
GO
EXEC sys.sp_addsrvrolemember @loginame = N'ice', @rolename = N'diskadmin'
GO
EXEC sys.sp_addsrvrolemember @loginame = N'ice', @rolename = N'dbcreator'
GO
EXEC sys.sp_addsrvrolemember @loginame = N'ice', @rolename = N'bulkadmin'
GO
ALTER LOGIN [ice] DISABLE
GO
/****** Object:  Login [Chris]    Script Date: 02/03/2006 15:21:58 ******/
/* For security reasons the login is created disabled and with a random password. */
/****** Object:  Login [Chris]    Script Date: 02/03/2006 15:21:58 ******/
IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'Chris')
CREATE LOGIN [Chris] WITH PASSWORD=N'ÅÕ`½v|©Ï=ôUBòUý4-"WÄ|oj:	xÚ', DEFAULT_DATABASE=[ICE], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
GO
EXEC sys.sp_addsrvrolemember @loginame = N'Chris', @rolename = N'sysadmin'
GO
EXEC sys.sp_addsrvrolemember @loginame = N'Chris', @rolename = N'securityadmin'
GO
EXEC sys.sp_addsrvrolemember @loginame = N'Chris', @rolename = N'serveradmin'
GO
EXEC sys.sp_addsrvrolemember @loginame = N'Chris', @rolename = N'setupadmin'
GO
EXEC sys.sp_addsrvrolemember @loginame = N'Chris', @rolename = N'processadmin'
GO
EXEC sys.sp_addsrvrolemember @loginame = N'Chris', @rolename = N'diskadmin'
GO
EXEC sys.sp_addsrvrolemember @loginame = N'Chris', @rolename = N'dbcreator'
GO
EXEC sys.sp_addsrvrolemember @loginame = N'Chris', @rolename = N'bulkadmin'
GO
ALTER LOGIN [Chris] DISABLE
GO
/****** Object:  Login [BUILTIN\Users]    Script Date: 02/03/2006 15:21:58 ******/
/****** Object:  Login [BUILTIN\Users]    Script Date: 02/03/2006 15:21:58 ******/
IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'BUILTIN\Users')
CREATE LOGIN [BUILTIN\Users] FROM WINDOWS WITH DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english]
GO
/****** Object:  Login [BUILTIN\Administrators]    Script Date: 02/03/2006 15:21:58 ******/
/****** Object:  Login [BUILTIN\Administrators]    Script Date: 02/03/2006 15:21:58 ******/
IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'BUILTIN\Administrators')
CREATE LOGIN [BUILTIN\Administrators] FROM WINDOWS WITH DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english]
GO
USE [ICE]
GO
/****** Object:  User [TTLIVE\csandow]    Script Date: 02/03/2006 15:21:59 ******/
GO
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'TTLIVE\csandow')
CREATE USER [TTLIVE\csandow] FOR LOGIN [TTLIVE\csandow] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [ice]    Script Date: 02/03/2006 15:21:59 ******/
GO
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'ice')
CREATE USER [ice] FOR LOGIN [ice] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [Chris]    Script Date: 02/03/2006 15:21:59 ******/
GO
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'Chris')
CREATE USER [Chris] FOR LOGIN [Chris] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  Table [dbo].[AddressBook]    Script Date: 02/03/2006 15:21:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AddressBook]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[AddressBook](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ContactName] [varchar](255) NOT NULL,
	[ContactMail] [varchar](255) NOT NULL,
 CONSTRAINT [PK_AddressBook] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO

/****** Object:  Index [IX_AddressBook_Mail]    Script Date: 02/03/2006 15:21:59 ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[AddressBook]') AND name = N'IX_AddressBook_Mail')
CREATE NONCLUSTERED INDEX [IX_AddressBook_Mail] ON [dbo].[AddressBook] 
(
	[ContactMail] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
GO

/****** Object:  Index [IX_AddressBook_Name]    Script Date: 02/03/2006 15:21:59 ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[AddressBook]') AND name = N'IX_AddressBook_Name')
CREATE NONCLUSTERED INDEX [IX_AddressBook_Name] ON [dbo].[AddressBook] 
(
	[ContactName] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ListBook]    Script Date: 02/03/2006 15:21:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ListBook]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ListBook](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ListName] [varchar](255) NOT NULL
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ListItems]    Script Date: 02/03/2006 15:21:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ListItems]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ListItems](
	[List_id] [int] NOT NULL,
	[AddressBook_Id] [int] NOT NULL,
 CONSTRAINT [PK_ListItems] PRIMARY KEY CLUSTERED 
(
	[List_id] ASC,
	[AddressBook_Id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[System]    Script Date: 02/03/2006 15:21:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[System]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[System](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Description] [varchar](16) NOT NULL,
	[Value] [varchar](50) NOT NULL,
 CONSTRAINT [PK_System] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Config]    Script Date: 02/03/2006 15:21:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Config]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Config](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Description] [varchar](16) NOT NULL,
	[Value] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Config] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Rules]    Script Date: 02/03/2006 15:21:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Rules]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Rules](
	[Id] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_Rules] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Company]    Script Date: 02/03/2006 15:21:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Company]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Company](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ExCode] [varchar](50) NOT NULL,
	[Description] [varchar](50) NOT NULL,
	[LastUpdate] [datetime] NULL,
 CONSTRAINT [PK_Company] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO

/****** Object:  Index [IX_Company_ExCode]    Script Date: 02/03/2006 15:21:59 ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Company]') AND name = N'IX_Company_ExCode')
CREATE UNIQUE NONCLUSTERED INDEX [IX_Company_ExCode] ON [dbo].[Company] 
(
	[ExCode] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MailBoxes]    Script Date: 02/03/2006 15:21:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MailBoxes]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[MailBoxes](
	[Id] [int] NOT NULL,
	[PoolingTime] [int] NOT NULL,
	[UserName] [varchar](50) NOT NULL,
	[PassWord] [varchar](50) NOT NULL,
	[Server] [varchar](255) NOT NULL,
	[Port] [int] NOT NULL,
	[Active] [bit] NOT NULL,
 CONSTRAINT [PK_MailBoxes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ScheduleType]    Script Date: 02/03/2006 15:21:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ScheduleType]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ScheduleType](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Description] [varchar](32) NOT NULL,
 CONSTRAINT [PK_ScheduleType] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[IceLog]    Script Date: 02/03/2006 15:21:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[IceLog]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[IceLog](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Description] [varchar](255) NOT NULL,
	[Location] [varchar](64) NULL,
	[LastUpdate] [datetime] NOT NULL CONSTRAINT [DF__IceLog__LastUpda__31EC6D26]  DEFAULT ((0)),
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[User]    Script Date: 02/03/2006 15:21:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[User]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[User](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [varchar](32) NOT NULL,
	[Password] [varchar](16) NOT NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[OutboxMsgBody]    Script Date: 02/03/2006 15:21:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OutboxMsgBody]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[OutboxMsgBody](
	[Outbox_Id] [int] NOT NULL,
	[Outbox_Guid] [varchar](38) NOT NULL,
	[MsgBody] [text] NOT NULL,
 CONSTRAINT [PK_OutboxMsgBody] PRIMARY KEY CLUSTERED 
(
	[Outbox_Id] ASC,
	[Outbox_Guid] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO

/****** Object:  Index [IX_OutboxMsgBody_Outbox_id]    Script Date: 02/03/2006 15:21:59 ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[OutboxMsgBody]') AND name = N'IX_OutboxMsgBody_Outbox_id')
CREATE UNIQUE NONCLUSTERED INDEX [IX_OutboxMsgBody_Outbox_id] ON [dbo].[OutboxMsgBody] 
(
	[Outbox_Id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Schedule]    Script Date: 02/03/2006 15:21:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Schedule]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Schedule](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Outbox_Id] [int] NOT NULL,
	[Outbox_Guid] [varchar](38) NOT NULL,
	[ScheduleType_Id] [int] NOT NULL,
	[StartTime] [datetime] NOT NULL,
 CONSTRAINT [PK_Schedule] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO

/****** Object:  Index [IX_Schedule_Outbox_Guid]    Script Date: 02/03/2006 15:21:59 ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Schedule]') AND name = N'IX_Schedule_Outbox_Guid')
CREATE NONCLUSTERED INDEX [IX_Schedule_Outbox_Guid] ON [dbo].[Schedule] 
(
	[Outbox_Guid] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
GO

/****** Object:  Index [IX_Schedule_Schedule_Type]    Script Date: 02/03/2006 15:21:59 ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Schedule]') AND name = N'IX_Schedule_Schedule_Type')
CREATE NONCLUSTERED INDEX [IX_Schedule_Schedule_Type] ON [dbo].[Schedule] 
(
	[ScheduleType_Id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
GO

/****** Object:  Index [IX_Schedule_StartTime]    Script Date: 02/03/2006 15:21:59 ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Schedule]') AND name = N'IX_Schedule_StartTime')
CREATE NONCLUSTERED INDEX [IX_Schedule_StartTime] ON [dbo].[Schedule] 
(
	[StartTime] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[InboxMsgBody]    Script Date: 02/03/2006 15:21:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InboxMsgBody]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[InboxMsgBody](
	[Inbox_Id] [int] NOT NULL,
	[Inbox_Guid] [varchar](38) NOT NULL,
	[Msgbody] [text] NOT NULL,
 CONSTRAINT [PK_InboxMsgBody] PRIMARY KEY CLUSTERED 
(
	[Inbox_Id] ASC,
	[Inbox_Guid] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO

/****** Object:  Index [IX_InboxMsgBody_Inbox_Id]    Script Date: 02/03/2006 15:21:59 ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[InboxMsgBody]') AND name = N'IX_InboxMsgBody_Inbox_Id')
CREATE NONCLUSTERED INDEX [IX_InboxMsgBody_Inbox_Id] ON [dbo].[InboxMsgBody] 
(
	[Inbox_Id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserRule]    Script Date: 02/03/2006 15:21:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UserRule]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[UserRule](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[User_Id] [int] NOT NULL,
	[Role_Id] [int] NOT NULL,
 CONSTRAINT [PK_UserRole] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[WeekSchedule]    Script Date: 02/03/2006 15:21:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[WeekSchedule]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[WeekSchedule](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Schedule_Id] [int] NOT NULL,
	[EveryWeek] [smallint] NOT NULL,
	[Monday] [bit] NULL CONSTRAINT [DF_WeekSchedule_Monday]  DEFAULT ((0)),
	[Tuesday] [bit] NULL CONSTRAINT [DF_WeekSchedule_Tuesday]  DEFAULT ((0)),
	[Wednesday] [bit] NULL CONSTRAINT [DF_WeekSchedule_Wednesday]  DEFAULT ((0)),
	[Thursday] [bit] NULL CONSTRAINT [DF_WeekSchedule_Thursday]  DEFAULT ((0)),
	[Friday] [bit] NULL CONSTRAINT [DF_WeekSchedule_Friday]  DEFAULT ((0)),
	[Saturday] [bit] NULL CONSTRAINT [DF_WeekSchedule_Saturday]  DEFAULT ((0)),
	[Sunday] [bit] NULL CONSTRAINT [DF_WeekSchedule_Sunday]  DEFAULT ((0)),
 CONSTRAINT [PK_WeekSchedule_1] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO

/****** Object:  Index [IX_WeekSchedule_Shcedule_Id]    Script Date: 02/03/2006 15:21:59 ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[WeekSchedule]') AND name = N'IX_WeekSchedule_Shcedule_Id')
CREATE NONCLUSTERED INDEX [IX_WeekSchedule_Shcedule_Id] ON [dbo].[WeekSchedule] 
(
	[Schedule_Id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DaySchedule]    Script Date: 02/03/2006 15:21:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DaySchedule]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[DaySchedule](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Schedule_Id] [int] NOT NULL,
	[StartDate] [datetime] NOT NULL,
	[AllDays] [bit] NULL CONSTRAINT [DF_DaySchedule_AllDays]  DEFAULT ((0)),
	[WeekDays] [bit] NULL CONSTRAINT [DF_DaySchedule_WeekDays]  DEFAULT ((0)),
	[Everyday] [smallint] NULL,
 CONSTRAINT [PK_DaySchedule] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO

/****** Object:  Index [IX_DaySchedule_Shcedule_Id]    Script Date: 02/03/2006 15:21:59 ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[DaySchedule]') AND name = N'IX_DaySchedule_Shcedule_Id')
CREATE NONCLUSTERED INDEX [IX_DaySchedule_Shcedule_Id] ON [dbo].[DaySchedule] 
(
	[Schedule_Id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MonthSchedule]    Script Date: 02/03/2006 15:21:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MonthSchedule]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[MonthSchedule](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Schedule_Id] [int] NOT NULL,
	[Day] [smallint] NOT NULL,
	[Jan] [bit] NULL CONSTRAINT [DF_MonthlySchedule_Jan]  DEFAULT ((0)),
	[Feb] [bit] NULL CONSTRAINT [DF_MonthlySchedule_Feb]  DEFAULT ((0)),
	[Mar] [bit] NULL CONSTRAINT [DF_MonthlySchedule_Mar]  DEFAULT ((0)),
	[Apr] [bit] NULL CONSTRAINT [DF_MonthlySchedule_Apr]  DEFAULT ((0)),
	[May] [bit] NULL CONSTRAINT [DF_MonthlySchedule_May]  DEFAULT ((0)),
	[Jun] [bit] NULL CONSTRAINT [DF_MonthlySchedule_Jun]  DEFAULT ((0)),
	[Jul] [bit] NULL CONSTRAINT [DF_MonthlySchedule_Jul]  DEFAULT ((0)),
	[Aug] [bit] NULL CONSTRAINT [DF_MonthlySchedule_Aug]  DEFAULT ((0)),
	[Sep] [bit] NULL CONSTRAINT [DF_MonthlySchedule_Sep]  DEFAULT ((0)),
	[Oct] [bit] NULL CONSTRAINT [DF_MonthlySchedule_Oct]  DEFAULT ((0)),
	[Nov] [bit] NULL CONSTRAINT [DF_MonthlySchedule_Nov]  DEFAULT ((0)),
	[Dec] [bit] NULL CONSTRAINT [DF_MonthlySchedule_Dec]  DEFAULT ((0)),
 CONSTRAINT [PK_MonthlySchedule] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO

/****** Object:  Index [IX_MonthlySchedule_Shcedule_Id]    Script Date: 02/03/2006 15:21:59 ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[MonthSchedule]') AND name = N'IX_MonthlySchedule_Shcedule_Id')
CREATE NONCLUSTERED INDEX [IX_MonthlySchedule_Shcedule_Id] ON [dbo].[MonthSchedule] 
(
	[Schedule_Id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OneTimeSchedule]    Script Date: 02/03/2006 15:21:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OneTimeSchedule]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[OneTimeSchedule](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Schedule_Id] [int] NOT NULL,
	[StartDate] [datetime] NOT NULL,
	[Process] [bit] NOT NULL,
 CONSTRAINT [PK_OneTimeSchedule] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO

/****** Object:  Index [IX_OneTimeSchedule_Schedule_Id]    Script Date: 02/03/2006 15:21:59 ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[OneTimeSchedule]') AND name = N'IX_OneTimeSchedule_Schedule_Id')
CREATE NONCLUSTERED INDEX [IX_OneTimeSchedule_Schedule_Id] ON [dbo].[OneTimeSchedule] 
(
	[Schedule_Id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ExpPackage]    Script Date: 02/03/2006 15:21:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ExpPackage]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ExpPackage](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Company_Id] [int] NOT NULL,
	[Description] [varchar](255) NOT NULL,
	[FileGuid] [varchar](38) NOT NULL,
	[FileXML] [varchar](255) NOT NULL,
	[FileXSL] [varchar](255) NOT NULL,
	[FileXSD] [varchar](255) NOT NULL,
	[UserReference] [int] NOT NULL,
 CONSTRAINT [PK_ExpPackage] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO

/****** Object:  Index [IX_ExpPackage_Company_Id]    Script Date: 02/03/2006 15:21:59 ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[ExpPackage]') AND name = N'IX_ExpPackage_Company_Id')
CREATE NONCLUSTERED INDEX [IX_ExpPackage_Company_Id] ON [dbo].[ExpPackage] 
(
	[Company_Id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
GO

/****** Object:  Index [IX_PackageId]    Script Date: 02/03/2006 15:21:59 ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[ExpPackage]') AND name = N'IX_PackageId')
CREATE NONCLUSTERED INDEX [IX_PackageId] ON [dbo].[ExpPackage] 
(
	[UserReference] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ImpPackage]    Script Date: 02/03/2006 15:21:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ImpPackage]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ImpPackage](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Company_Id] [int] NOT NULL,
	[Description] [varchar](255) NOT NULL,
	[FileGuid] [varchar](38) NOT NULL,
	[FileXML] [varchar](255) NOT NULL,
	[FileXSL] [varchar](255) NOT NULL,
	[FileXSD] [varchar](255) NOT NULL,
	[UserReference] [int] NOT NULL,
 CONSTRAINT [PK_impPackage] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO

/****** Object:  Index [IX_ImpPackage_Company_Id]    Script Date: 02/03/2006 15:21:59 ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[ImpPackage]') AND name = N'IX_ImpPackage_Company_Id')
CREATE NONCLUSTERED INDEX [IX_ImpPackage_Company_Id] ON [dbo].[ImpPackage] 
(
	[Company_Id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Outbox]    Script Date: 02/03/2006 15:21:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Outbox]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Outbox](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Guid] [varchar](38) NOT NULL,
	[Company_Id] [int] NOT NULL CONSTRAINT [DF_Outbox_Company_Id]  DEFAULT ((0)),
	[Subject] [varchar](50) NULL,
	[UserFrom] [varchar](255) NOT NULL,
	[UserTo] [varchar](255) NOT NULL,
	[Package_Id] [int] NOT NULL CONSTRAINT [DF__Outbox__MessageT__0EA330E9]  DEFAULT ((0)),
	[Status] [tinyint] NOT NULL CONSTRAINT [DF__Outbox__Status__0F975522]  DEFAULT ((0)),
	[Param1] [varchar](50) NULL,
	[Param2] [varchar](50) NULL,
	[TotalItems] [smallint] NOT NULL CONSTRAINT [DF__Outbox__TotalIte__300424B4]  DEFAULT ((0)),
	[IrMark] [varchar](30) NULL,
	[Sent] [datetime] NOT NULL CONSTRAINT [DF__Outbox__LastUpda__32E0915F]  DEFAULT ((0)),
	[LastUpdate] [datetime] NULL,
 CONSTRAINT [PK_Outbox_1] PRIMARY KEY CLUSTERED 
(
	[Id] ASC,
	[Guid] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO

/****** Object:  Index [IX_Outbox_Company_Id]    Script Date: 02/03/2006 15:21:59 ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Outbox]') AND name = N'IX_Outbox_Company_Id')
CREATE NONCLUSTERED INDEX [IX_Outbox_Company_Id] ON [dbo].[Outbox] 
(
	[Company_Id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Inbox]    Script Date: 02/03/2006 15:21:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Inbox]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Inbox](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Guid] [varchar](38) NOT NULL,
	[Company_Id] [int] NOT NULL CONSTRAINT [DF_Inbox_Company_Id]  DEFAULT ((0)),
	[Subject] [varchar](50) NULL,
	[UserFrom] [varchar](256) NOT NULL,
	[UserTo] [varchar](256) NOT NULL,
	[Package_Id] [int] NOT NULL,
	[TotalItems] [smallint] NOT NULL,
	[Status] [tinyint] NOT NULL,
	[Received] [datetime] NOT NULL CONSTRAINT [DF__Inbox__LastUpdat__30F848ED]  DEFAULT ((0)),
	[LastUpdate] [datetime] NULL,
 CONSTRAINT [PK_Inbox_1] PRIMARY KEY CLUSTERED 
(
	[Id] ASC,
	[Guid] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO

/****** Object:  Index [IX_Inbox_CompanyId]    Script Date: 02/03/2006 15:21:59 ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Inbox]') AND name = N'IX_Inbox_CompanyId')
CREATE NONCLUSTERED INDEX [IX_Inbox_CompanyId] ON [dbo].[Inbox] 
(
	[Company_Id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[sp_DELETE_ICELOG]    Script Date: 02/03/2006 15:21:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_DELETE_ICELOG]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'



CREATE procedure [dbo].[sp_DELETE_ICELOG] @pDays int
as 
delete from icelog where lastupdate <  DATEADD(dd, - @pDays, GETDATE())



' 
END
GO
USE [ICE]
GO
USE [ICE]
GO
USE [ICE]
GO
USE [ICE]
GO
USE [ICE]
GO
USE [ICE]
GO
USE [ICE]
GO
USE [ICE]
GO
USE [ICE]
GO
USE [ICE]
GO
USE [ICE]
GO
USE [ICE]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_OutboxMsgBody_Outbox]') AND parent_object_id = OBJECT_ID(N'[dbo].[OutboxMsgBody]'))
ALTER TABLE [dbo].[OutboxMsgBody]  WITH CHECK ADD  CONSTRAINT [FK_OutboxMsgBody_Outbox] FOREIGN KEY([Outbox_Id], [Outbox_Guid])
REFERENCES [dbo].[Outbox] ([Id], [Guid])
ON DELETE CASCADE
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Schedule_Outbox]') AND parent_object_id = OBJECT_ID(N'[dbo].[Schedule]'))
ALTER TABLE [dbo].[Schedule]  WITH CHECK ADD  CONSTRAINT [FK_Schedule_Outbox] FOREIGN KEY([Outbox_Id], [Outbox_Guid])
REFERENCES [dbo].[Outbox] ([Id], [Guid])
ON DELETE CASCADE
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Schedule_ScheduleType]') AND parent_object_id = OBJECT_ID(N'[dbo].[Schedule]'))
ALTER TABLE [dbo].[Schedule]  WITH CHECK ADD  CONSTRAINT [FK_Schedule_ScheduleType] FOREIGN KEY([ScheduleType_Id])
REFERENCES [dbo].[ScheduleType] ([Id])
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_InboxMsgBody_Inbox]') AND parent_object_id = OBJECT_ID(N'[dbo].[InboxMsgBody]'))
ALTER TABLE [dbo].[InboxMsgBody]  WITH CHECK ADD  CONSTRAINT [FK_InboxMsgBody_Inbox] FOREIGN KEY([Inbox_Id], [Inbox_Guid])
REFERENCES [dbo].[Inbox] ([Id], [Guid])
ON DELETE CASCADE
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_UserRule_Rules]') AND parent_object_id = OBJECT_ID(N'[dbo].[UserRule]'))
ALTER TABLE [dbo].[UserRule]  WITH CHECK ADD  CONSTRAINT [FK_UserRule_Rules] FOREIGN KEY([Role_Id])
REFERENCES [dbo].[Rules] ([Id])
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_UserRule_User]') AND parent_object_id = OBJECT_ID(N'[dbo].[UserRule]'))
ALTER TABLE [dbo].[UserRule]  WITH CHECK ADD  CONSTRAINT [FK_UserRule_User] FOREIGN KEY([User_Id])
REFERENCES [dbo].[User] ([Id])
ON DELETE CASCADE
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_WeekSchedule_Schedule]') AND parent_object_id = OBJECT_ID(N'[dbo].[WeekSchedule]'))
ALTER TABLE [dbo].[WeekSchedule]  WITH CHECK ADD  CONSTRAINT [FK_WeekSchedule_Schedule] FOREIGN KEY([Schedule_Id])
REFERENCES [dbo].[Schedule] ([Id])
ON DELETE CASCADE
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_DaySchedule_Schedule]') AND parent_object_id = OBJECT_ID(N'[dbo].[DaySchedule]'))
ALTER TABLE [dbo].[DaySchedule]  WITH CHECK ADD  CONSTRAINT [FK_DaySchedule_Schedule] FOREIGN KEY([Schedule_Id])
REFERENCES [dbo].[Schedule] ([Id])
ON DELETE CASCADE
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_MonthSchedule_Schedule]') AND parent_object_id = OBJECT_ID(N'[dbo].[MonthSchedule]'))
ALTER TABLE [dbo].[MonthSchedule]  WITH CHECK ADD  CONSTRAINT [FK_MonthSchedule_Schedule] FOREIGN KEY([Schedule_Id])
REFERENCES [dbo].[Schedule] ([Id])
ON DELETE CASCADE
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_OneTimeSchedule_Schedule]') AND parent_object_id = OBJECT_ID(N'[dbo].[OneTimeSchedule]'))
ALTER TABLE [dbo].[OneTimeSchedule]  WITH CHECK ADD  CONSTRAINT [FK_OneTimeSchedule_Schedule] FOREIGN KEY([Schedule_Id])
REFERENCES [dbo].[Schedule] ([Id])
ON DELETE CASCADE
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ExpPackage_Company]') AND parent_object_id = OBJECT_ID(N'[dbo].[ExpPackage]'))
ALTER TABLE [dbo].[ExpPackage]  WITH CHECK ADD  CONSTRAINT [FK_ExpPackage_Company] FOREIGN KEY([Company_Id])
REFERENCES [dbo].[Company] ([Id])
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ImpPackage_Company]') AND parent_object_id = OBJECT_ID(N'[dbo].[ImpPackage]'))
ALTER TABLE [dbo].[ImpPackage]  WITH CHECK ADD  CONSTRAINT [FK_ImpPackage_Company] FOREIGN KEY([Company_Id])
REFERENCES [dbo].[Company] ([Id])
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Outbox_Company]') AND parent_object_id = OBJECT_ID(N'[dbo].[Outbox]'))
ALTER TABLE [dbo].[Outbox]  WITH CHECK ADD  CONSTRAINT [FK_Outbox_Company] FOREIGN KEY([Company_Id])
REFERENCES [dbo].[Company] ([Id])
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Inbox_Company]') AND parent_object_id = OBJECT_ID(N'[dbo].[Inbox]'))
ALTER TABLE [dbo].[Inbox]  WITH CHECK ADD  CONSTRAINT [FK_Inbox_Company] FOREIGN KEY([Company_Id])
REFERENCES [dbo].[Company] ([Id])
