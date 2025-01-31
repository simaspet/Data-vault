USE [model]
GO
/****** Object:  Table [dbo].[LINK_MinuteGameEvents]    Script Date: 8/2/2023 1:51:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LINK_MinuteGameEvents](
	[LinkMinuteGameEventsKey] [nvarchar](100) NOT NULL,
	[HubMinuteKey] [nvarchar](100) NOT NULL,
	[HubGameEventsKey] [nvarchar](100) NOT NULL,
	[LinkRecordSourceID] [nvarchar](100) NOT NULL,
	[LinkLoadDate] [datetime] NULL,
	[MinuteID] [int] NULL,
	[GameID+MinuteID+PlayerID] [varchar](255) NULL
) ON [PRIMARY]
GO
