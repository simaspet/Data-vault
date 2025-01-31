USE [model]
GO
/****** Object:  Table [stage].[Appearances]    Script Date: 8/2/2023 1:51:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [stage].[Appearances](
	[appearance_id] [varchar](255) NULL,
	[game_id] [int] NULL,
	[player_id] [int] NULL,
	[player_club_id] [int] NULL,
	[player_current_club_id] [int] NULL,
	[date] [date] NULL,
	[player_name] [varchar](255) NULL,
	[competition_id] [varchar](255) NULL,
	[yellow_cards] [int] NULL,
	[red_cards] [int] NULL,
	[goals] [int] NULL,
	[assists] [int] NULL,
	[minutes_played] [int] NULL
) ON [PRIMARY]
GO
