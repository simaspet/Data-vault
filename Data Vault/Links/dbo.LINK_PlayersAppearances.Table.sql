USE [model]
GO
/****** Object:  Table [dbo].[LINK_PlayersAppearances]    Script Date: 8/2/2023 1:51:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LINK_PlayersAppearances](
	[LinkPlayersAppearancesKey] [nvarchar](100) NOT NULL,
	[HubPlayersKey] [nvarchar](100) NOT NULL,
	[HubAppearancesKey] [nvarchar](100) NOT NULL,
	[LinkRecordSourceID] [nvarchar](100) NOT NULL,
	[LinkLoadDate] [datetime] NULL,
	[PlayerID] [int] NULL,
	[AppearanceID] [varchar](255) NULL
) ON [PRIMARY]
GO
