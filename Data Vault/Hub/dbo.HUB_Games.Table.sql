USE [model]
GO
/****** Object:  Table [dbo].[HUB_Games]    Script Date: 8/2/2023 1:51:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HUB_Games](
	[HubGamesKey] [nvarchar](100) NOT NULL,
	[HubSourceID] [nvarchar](100) NOT NULL,
	[HubLoadDate] [datetime] NOT NULL,
	[GameID] [int] NULL
) ON [PRIMARY]
GO
