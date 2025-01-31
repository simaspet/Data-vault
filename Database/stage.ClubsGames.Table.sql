USE [model]
GO
/****** Object:  Table [stage].[ClubsGames]    Script Date: 8/2/2023 1:51:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [stage].[ClubsGames](
	[game_id] [int] NULL,
	[club_id] [int] NULL,
	[own_goals] [int] NULL,
	[own_position] [int] NULL,
	[own_manager_name] [varchar](255) NULL,
	[opponent_id] [int] NULL,
	[opponent_goals] [int] NULL,
	[opponent_position] [int] NULL,
	[opponent_manager_name] [varchar](255) NULL,
	[hosting] [varchar](255) NULL,
	[is_win] [int] NULL
) ON [PRIMARY]
GO
