USE [model]
GO
/****** Object:  Table [dbo].[SAT_Clubs]    Script Date: 8/2/2023 1:51:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SAT_Clubs](
	[HubClubsKey] [nvarchar](100) NOT NULL,
	[SatLoadDate] [datetime] NULL,
	[SatEndDate] [datetime] NULL,
	[SatRecordSourceID] [nvarchar](100) NOT NULL,
	[SatRecordHash] [nvarchar](100) NOT NULL,
	[ClubID] [int] NULL,
	[ClubCode] [varchar](255) NULL,
	[Name] [varchar](255) NULL,
	[DomesticCompetitionID] [varchar](255) NULL,
	[TotalMarketValue] [int] NULL,
	[SquadSize] [int] NULL,
	[AverageAge] [float] NULL,
	[ForeignersNumber] [int] NULL,
	[ForeignersPercentage] [float] NULL,
	[NationalTeamPlayers] [int] NULL,
	[StadiumName] [varchar](255) NULL,
	[StadiumSeats] [int] NULL,
	[NetTransferRecord] [varchar](255) NULL,
	[CoachName] [varchar](255) NULL,
	[LastSeason] [int] NULL,
	[Url] [varchar](255) NULL
) ON [PRIMARY]
GO
