USE [model]
GO
/****** Object:  Table [dbo].[HUB_ClubsGames]    Script Date: 8/2/2023 1:51:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HUB_ClubsGames](
	[HubClubsGamesKey] [nvarchar](100) NULL,
	[HubSourceID] [nvarchar](100) NULL,
	[HubLoadDate] [datetime] NULL,
	[GameID] [int] NULL,
	[ClubID] [int] NULL
) ON [PRIMARY]
GO
