USE [model]
GO
/****** Object:  Table [stage].[Games]    Script Date: 8/2/2023 1:51:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [stage].[Games](
	[game_id] [int] NULL,
	[competition_id] [varchar](255) NULL,
	[season] [int] NULL,
	[round] [varchar](255) NULL,
	[date] [date] NULL,
	[home_club_id] [int] NULL,
	[away_club_id] [int] NULL,
	[home_club_goals] [int] NULL,
	[away_club_goals] [int] NULL,
	[home_club_position] [int] NULL,
	[away_club_position] [int] NULL,
	[home_club_manager_name] [varchar](255) NULL,
	[away_club_manager_name] [varchar](255) NULL,
	[stadium] [varchar](255) NULL,
	[attendance] [int] NULL,
	[referee] [varchar](255) NULL,
	[url] [varchar](500) NULL,
	[home_club_name] [varchar](255) NULL,
	[away_club_name] [varchar](255) NULL,
	[aggregate] [varchar](255) NULL,
	[competition_type] [varchar](255) NULL
) ON [PRIMARY]
GO
