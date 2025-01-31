USE [model]
GO
/****** Object:  Table [dbo].[HUB_GameEvents]    Script Date: 8/2/2023 1:51:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HUB_GameEvents](
	[HubGameEventsKey] [nvarchar](100) NULL,
	[HubSourceID] [nvarchar](100) NULL,
	[HubLoadDate] [datetime] NULL,
	[GameID] [int] NULL,
	[MinuteID] [int] NULL,
	[PlayerID] [int] NULL
) ON [PRIMARY]
GO
