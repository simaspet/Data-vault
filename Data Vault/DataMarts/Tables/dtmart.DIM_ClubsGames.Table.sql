USE [model]
GO
/****** Object:  Table [dtmart].[DIM_ClubsGames]    Script Date: 8/8/2023 10:50:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dtmart].[DIM_ClubsGames](
	[ClubsGamesKey] [varchar](125) NULL,
	[ClubID] [int] NULL,
	[ClubCode] [varchar](125) NULL,
	[Name] [varchar](125) NULL,
	[DomesticCompetitionID] [varchar](125) NULL,
	[StadiumName] [varchar](125) NULL,
	[CoachName] [varchar](125) NULL,
	[LastSeason] [int] NULL,
	[Url] [varchar](125) NULL,
	[SquadSize] [int] NULL,
	[StadiumSeats] [int] NULL,
	[NetTransferRecord] [varchar](125) NULL,
	[GameID] [int] NULL,
	[OwnManagerName] [varchar](125) NULL,
	[OpponentID] [int] NULL,
	[OpponentManagerName] [varchar](125) NULL,
	[Hosting] [varchar](125) NULL,
	[HomeClubManagerName] [varchar](125) NULL,
	[AwayClubManagerName] [varchar](125) NULL,
	[Stadium] [varchar](125) NULL,
	[Referee] [varchar](125) NULL,
	[GameUrl] [varchar](125) NULL,
	[HomeClubName] [varchar](125) NULL,
	[AwayClubName] [varchar](125) NULL,
	[CompetitionType] [varchar](125) NULL,
	[DimLoadDate] [datetime] NULL,
	[SourceLoadDate] [datetime] NULL
) ON [PRIMARY]
GO
