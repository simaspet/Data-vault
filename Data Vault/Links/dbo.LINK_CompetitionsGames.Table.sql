USE [model]
GO
/****** Object:  Table [dbo].[LINK_CompetitionsGames]    Script Date: 8/2/2023 1:51:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LINK_CompetitionsGames](
	[LinkCompetitionsGamesKey] [nvarchar](100) NOT NULL,
	[HubCompetitionsKey] [nvarchar](100) NOT NULL,
	[HubGamesKey] [nvarchar](100) NOT NULL,
	[LinkRecordSourceID] [nvarchar](100) NOT NULL,
	[LinkLoadDate] [datetime] NULL,
	[CompetitionID] [varchar](255) NULL,
	[GameID] [int] NULL
) ON [PRIMARY]
GO
