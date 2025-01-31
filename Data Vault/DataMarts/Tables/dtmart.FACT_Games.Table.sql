USE [model]
GO
/****** Object:  Table [dtmart].[FACT_Games]    Script Date: 8/8/2023 10:50:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dtmart].[FACT_Games](
	[GamesKey] [varchar](125) NULL,
	[ClubsGamesKey] [varchar](125) NULL,
	[CompetitionsKey] [varchar](125) NULL,
	[GameEventsKey] [varchar](125) NULL,
	[GameDateKey] [varchar](125) NULL,
	[TotalMarketValue] [int] NULL,
	[AverageAge] [float] NULL,
	[ForeignersNumber] [int] NULL,
	[NationalTeamPlayers] [int] NULL,
	[ForeignersPercentage] [float] NULL,
	[OwnGoals] [int] NULL,
	[OwnPosition] [int] NULL,
	[IsWin] [int] NULL,
	[HomeClubGoals] [int] NULL,
	[AwayClubGoals] [int] NULL,
	[HomeClubPosition] [int] NULL,
	[AwayClubPosition] [int] NULL,
	[Attendance] [int] NULL,
	[Aggregate] [varchar](125) NULL,
	[Minute] [int] NULL,
	[FactLoadDate] [datetime] NULL,
	[SourceLoadDate] [datetime] NULL
) ON [PRIMARY]
GO
