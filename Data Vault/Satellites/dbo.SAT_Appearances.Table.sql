USE [model]
GO
/****** Object:  Table [dbo].[SAT_Appearances]    Script Date: 8/2/2023 1:51:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SAT_Appearances](
	[HubAppearancesKey] [nvarchar](100) NOT NULL,
	[SatLoadDate] [datetime] NULL,
	[SatEndDate] [datetime] NULL,
	[SatRecordSourceID] [nvarchar](100) NOT NULL,
	[SatRecordHash] [nvarchar](100) NOT NULL,
	[AppearanceID] [varchar](255) NULL,
	[GameID] [int] NULL,
	[PlayerID] [int] NULL,
	[PlayerClubId] [int] NULL,
	[PlayerCurrentClubID] [int] NULL,
	[Date] [date] NULL,
	[PlayerName] [varchar](255) NULL,
	[CompetitionID] [varchar](255) NULL,
	[YellowCards] [int] NULL,
	[RedCards] [int] NULL,
	[Goals] [int] NULL,
	[Assists] [int] NULL,
	[MinutesPlayed] [int] NULL
) ON [PRIMARY]
GO
