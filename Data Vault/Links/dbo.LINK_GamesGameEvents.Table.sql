USE [model]
GO
/****** Object:  Table [dbo].[LINK_GamesGameEvents]    Script Date: 8/2/2023 1:51:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LINK_GamesGameEvents](
	[LinkGamesGameEventsKey] [nvarchar](100) NOT NULL,
	[HubGamesKey] [nvarchar](100) NOT NULL,
	[HubGameEventsKey] [nvarchar](100) NOT NULL,
	[LinkRecordSourceID] [nvarchar](100) NOT NULL,
	[LinkLoadDate] [datetime] NULL,
	[GameID] [int] NULL,
	[GameID+MinuteID+PlayerID] [varchar](255) NULL
) ON [PRIMARY]
GO
