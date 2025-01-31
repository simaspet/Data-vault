USE [model]
GO
/****** Object:  Table [stage].[GameEvents]    Script Date: 8/2/2023 1:51:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [stage].[GameEvents](
	[game_id] [int] NULL,
	[minute_id] [int] NULL,
	[type] [varchar](255) NULL,
	[club_id] [int] NULL,
	[player_id] [int] NULL,
	[description] [varchar](255) NULL,
	[player_in_id] [int] NULL
) ON [PRIMARY]
GO
