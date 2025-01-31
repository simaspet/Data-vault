USE [model]
GO
/****** Object:  Table [dtmart].[DIM_PlayerValuations]    Script Date: 8/8/2023 10:50:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dtmart].[DIM_PlayerValuations](
	[PlayerValuationKey] [varchar](125) NULL,
	[PlayerID] [int] NULL,
	[FirstName] [varchar](125) NULL,
	[LastName] [varchar](125) NULL,
	[Name] [varchar](125) NULL,
	[LastSeasonPlayer] [int] NULL,
	[CurrentClubID] [int] NULL,
	[PlayerCode] [varchar](125) NULL,
	[CountryOfBirth] [varchar](125) NULL,
	[CityOfBirth] [varchar](125) NULL,
	[CountryOfCitizenship] [varchar](125) NULL,
	[DateOfBirth] [date] NULL,
	[SubPosition] [varchar](125) NULL,
	[Position] [varchar](125) NULL,
	[Foot] [varchar](125) NULL,
	[HeightInCm] [int] NULL,
	[ContractExpirationDate] [date] NULL,
	[AgentName] [varchar](125) NULL,
	[ImageUrl] [varchar](125) NULL,
	[Url] [varchar](125) NULL,
	[CurrentClubDomesticCompetitionID] [varchar](125) NULL,
	[CurrentClubName] [varchar](125) NULL,
	[LastSeasonPV] [int] NULL,
	[Datetime] [datetime] NULL,
	[DateWeek] [date] NULL,
	[n] [int] NULL,
	[PlayerClubDomesticCompetitionID] [varchar](125) NULL,
	[DimLoadDate] [datetime] NULL,
	[SourceLoadDate] [datetime] NULL
) ON [PRIMARY]
GO
