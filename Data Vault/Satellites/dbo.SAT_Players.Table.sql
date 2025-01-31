USE [model]
GO
/****** Object:  Table [dbo].[SAT_Players]    Script Date: 8/2/2023 1:51:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SAT_Players](
	[HubPlayersKey] [nvarchar](100) NOT NULL,
	[SatLoadDate] [datetime] NULL,
	[SatEndDate] [datetime] NULL,
	[SatRecordSourceID] [nvarchar](100) NOT NULL,
	[SatRecordHash] [nvarchar](100) NOT NULL,
	[PlayerID] [int] NULL,
	[FirstName] [varchar](255) NULL,
	[LastName] [varchar](255) NULL,
	[Name] [varchar](255) NULL,
	[LastSeason] [int] NULL,
	[CurrentClubID] [int] NULL,
	[PlayerCode] [varchar](255) NULL,
	[CountryOfBirth] [varchar](255) NULL,
	[CityOfBirth] [varchar](255) NULL,
	[CountryOfCitizenship] [varchar](255) NULL,
	[DateOfBirth] [date] NULL,
	[SubPosition] [varchar](255) NULL,
	[Position] [varchar](255) NULL,
	[Foot] [varchar](255) NULL,
	[HeightInCm] [int] NULL,
	[MarketValueInEur] [int] NULL,
	[HighestMarketValueInEur] [int] NULL,
	[ContractExpirationDate] [datetime] NULL,
	[AgentName] [varchar](255) NULL,
	[ImageUrl] [varchar](255) NULL,
	[Url] [varchar](255) NULL,
	[CurrentClubDomesticCompetitionID] [varchar](255) NULL,
	[CurrentClubName] [varchar](255) NULL
) ON [PRIMARY]
GO
