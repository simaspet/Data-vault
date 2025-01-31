USE [model]
GO
/****** Object:  Table [dbo].[LINK_ClubsGamesGames]    Script Date: 8/2/2023 1:51:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LINK_ClubsGamesGames](
	[LinkClubsGamesGamesKey] [nvarchar](100) NOT NULL,
	[HubGamesKey] [nvarchar](100) NOT NULL,
	[HubClubsGamesKey] [nvarchar](100) NOT NULL,
	[LinkRecordSourceID] [nvarchar](100) NOT NULL,
	[LinkLoadDate] [datetime] NULL,
	[GameID] [int] NULL,
	[GameID+ClubID] [varchar](255) NULL
) ON [PRIMARY]
GO
