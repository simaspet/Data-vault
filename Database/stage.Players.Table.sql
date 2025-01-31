USE [model]
GO
/****** Object:  Table [stage].[Players]    Script Date: 8/2/2023 1:51:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [stage].[Players](
	[player_id] [int] NULL,
	[first_name] [varchar](255) NULL,
	[last_name] [varchar](255) NULL,
	[name] [varchar](255) NULL,
	[last_season] [int] NULL,
	[current_club_id] [int] NULL,
	[player_code] [varchar](255) NULL,
	[country_of_birth] [varchar](255) NULL,
	[city_of_birth] [varchar](255) NULL,
	[country_of_citizenship] [varchar](255) NULL,
	[date_of_birth] [date] NULL,
	[sub_position] [varchar](255) NULL,
	[position] [varchar](255) NULL,
	[foot] [varchar](255) NULL,
	[height_in_cm] [int] NULL,
	[market_value_in_eur] [int] NULL,
	[highest_market_value_in_eur] [int] NULL,
	[contract_expiration_date] [varchar](255) NULL,
	[agent_name] [varchar](255) NULL,
	[image_url] [varchar](255) NULL,
	[url] [varchar](255) NULL,
	[current_club_domestic_competition_id] [varchar](255) NULL,
	[current_club_name] [varchar](255) NULL
) ON [PRIMARY]
GO
