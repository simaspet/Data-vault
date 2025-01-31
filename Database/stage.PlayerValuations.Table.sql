USE [model]
GO
/****** Object:  Table [stage].[PlayerValuations]    Script Date: 8/2/2023 1:51:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [stage].[PlayerValuations](
	[player_id] [int] NULL,
	[last_season] [int] NULL,
	[datetime] [datetime] NULL,
	[date] [date] NULL,
	[dateweek] [date] NULL,
	[market_value_in_eur] [int] NULL,
	[n] [int] NULL,
	[current_club_id] [int] NULL,
	[player_club_domestic_competition_id] [nvarchar](255) NULL
) ON [PRIMARY]
GO
