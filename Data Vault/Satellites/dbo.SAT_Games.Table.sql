USE [model]
GO
/****** Object:  Table [dbo].[SAT_Games]    Script Date: 8/2/2023 1:51:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SAT_Games](
	[HubGamesKey] [nvarchar](100) NOT NULL,
	[SatLoadDate] [datetime] NULL,
	[SatEndDate] [datetime] NULL,
	[SatRecordSourceID] [nvarchar](100) NOT NULL,
	[SatRecordHash] [nvarchar](100) NOT NULL,
	[GameID] [int] NULL,
	[CompetitionID] [varchar](255) NULL,
	[Season] [varchar](255) NULL,
	[Round] [varchar](255) NULL,
	[Date] [date] NULL,
	[homeClubId] [int] NULL,
	[AwayClubId] [int] NULL,
	[HomeClubGoals] [int] NULL,
	[AwayClubGoals] [int] NULL,
	[HomeClubPosition] [int] NULL,
	[AwayClubPosition] [int] NULL,
	[HomeClubManagerName] [varchar](255) NULL,
	[AwayClubManagerName] [varchar](255) NULL,
	[Stadium] [varchar](255) NULL,
	[Attendance] [int] NULL,
	[Referee] [varchar](255) NULL,
	[Url] [varchar](500) NULL,
	[HomeClubName] [varchar](255) NULL,
	[AwayClubName] [varchar](255) NULL,
	[Aggregate] [varchar](255) NULL,
	[CompetitionType] [varchar](255) NULL
) ON [PRIMARY]
GO
