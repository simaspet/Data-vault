USE [model]
GO
/****** Object:  Table [stage].[Competitions]    Script Date: 8/2/2023 1:51:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [stage].[Competitions](
	[competition_id] [varchar](255) NULL,
	[competition_code] [varchar](255) NULL,
	[name] [varchar](255) NULL,
	[sub_type] [varchar](255) NULL,
	[type] [varchar](255) NULL,
	[country_id] [int] NULL,
	[country_name] [varchar](255) NULL,
	[domestic_league_code] [varchar](255) NULL,
	[confederation] [varchar](255) NULL,
	[url] [varchar](255) NULL
) ON [PRIMARY]
GO
