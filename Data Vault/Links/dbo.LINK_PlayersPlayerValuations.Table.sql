USE [model]
GO
/****** Object:  Table [dbo].[LINK_PlayersPlayerValuations]    Script Date: 8/2/2023 1:51:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LINK_PlayersPlayerValuations](
	[LinkPlayersPlayerValuationsKey] [nvarchar](100) NOT NULL,
	[HubPlayersKey] [nvarchar](100) NOT NULL,
	[HubPlayerValuationsKey] [nvarchar](100) NOT NULL,
	[LinkRecordSourceID] [nvarchar](100) NOT NULL,
	[LinkLoadDate] [datetime] NULL,
	[PlayerID] [int] NULL,
	[PlayerID + Date] [nvarchar](255) NULL
) ON [PRIMARY]
GO
