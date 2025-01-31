USE [model]
GO
/****** Object:  Table [dbo].[SAT_ClubsGames]    Script Date: 8/2/2023 1:51:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SAT_ClubsGames](
	[HubClubGamesKey] [nvarchar](100) NOT NULL,
	[SatLoadDate] [datetime] NULL,
	[SatEndDate] [datetime] NULL,
	[SatRecordSourceID] [nvarchar](100) NOT NULL,
	[SatRecordHash] [nvarchar](100) NOT NULL,
	[GameID] [int] NULL,
	[ClubID] [int] NULL,
	[OwnGoals] [int] NULL,
	[OwnPosition] [int] NULL,
	[OwnManagerName] [varchar](255) NULL,
	[OpponentID] [int] NULL,
	[OpponentGoals] [int] NULL,
	[OpponentPosition] [int] NULL,
	[OpponentManagerName] [varchar](255) NULL,
	[Hosting] [varchar](255) NULL,
	[IsWin] [int] NULL
) ON [PRIMARY]
GO
