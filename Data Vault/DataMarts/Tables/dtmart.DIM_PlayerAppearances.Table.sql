USE [model]
GO
/****** Object:  Table [dtmart].[DIM_PlayerAppearances]    Script Date: 8/8/2023 10:50:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dtmart].[DIM_PlayerAppearances](
	[AppearancesKey] [varchar](125) NULL,
	[AppearanceID] [varchar](125) NULL,
	[GameID] [int] NULL,
	[PlayerID] [int] NULL,
	[PlayerClubID] [int] NULL,
	[PlayerCurrentClubID] [int] NULL,
	[Date] [date] NULL,
	[CompetitionID] [varchar](125) NULL,
	[PlayerName] [varchar](125) NULL,
	[DimLoadDate] [datetime] NULL,
	[SourceLoadDate] [datetime] NULL
) ON [PRIMARY]
GO
