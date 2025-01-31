USE [model]
GO
/****** Object:  Table [stage].[Clubs]    Script Date: 8/2/2023 1:51:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [stage].[Clubs](
	[club_id] [int] NULL,
	[club_code] [varchar](255) NULL,
	[name] [varchar](255) NULL,
	[domestic_competition_id] [varchar](255) NULL,
	[total_market_value] [varchar](225) NULL,
	[squad_size] [int] NULL,
	[average_age] [float] NULL,
	[foreigners_number] [int] NULL,
	[foreigners_percentage] [float] NULL,
	[national_team_players] [int] NULL,
	[stadium_name] [varchar](255) NULL,
	[stadium_seats] [int] NULL,
	[net_transfer_record] [varchar](255) NULL,
	[coach_name] [varchar](255) NULL,
	[last_season] [int] NULL,
	[url] [varchar](255) NULL
) ON [PRIMARY]
GO
