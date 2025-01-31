USE [model]
GO
/****** Object:  Table [dtmart].[DIM_Competitions]    Script Date: 8/8/2023 10:50:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dtmart].[DIM_Competitions](
	[CompetitionsKey] [varchar](125) NULL,
	[GameID] [int] NULL,
	[CompetitionID] [varchar](255) NULL,
	[Season] [int] NULL,
	[Round] [varchar](125) NULL,
	[HomeClubID] [int] NULL,
	[AwayClubID] [int] NULL,
	[HomeClubManagerName] [varchar](125) NULL,
	[AwayClubManagerName] [varchar](125) NULL,
	[Stadium] [varchar](125) NULL,
	[Referee] [varchar](125) NULL,
	[Url] [varchar](125) NULL,
	[HomeClubName] [varchar](125) NULL,
	[AwayClubName] [varchar](125) NULL,
	[CompetitionType] [varchar](125) NULL,
	[CompetitionCode] [varchar](125) NULL,
	[Name] [varchar](125) NULL,
	[SubType] [varchar](125) NULL,
	[Type] [varchar](125) NULL,
	[CountryID] [int] NULL,
	[CountryName] [varchar](125) NULL,
	[DomesticLeagueCode] [varchar](125) NULL,
	[Confederation] [varchar](125) NULL,
	[UrlCompetition] [varchar](125) NULL,
	[DimLoadDate] [datetime] NULL,
	[SourceLoadDate] [datetime] NULL
) ON [PRIMARY]
GO
