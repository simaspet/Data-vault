USE [model]
GO
/****** Object:  Table [dtmart].[DIM_GameEvents]    Script Date: 8/8/2023 10:50:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dtmart].[DIM_GameEvents](
	[GameEventsKey] [varchar](125) NULL,
	[GameID] [int] NULL,
	[Type] [varchar](125) NULL,
	[ClubID] [int] NULL,
	[PlayerID] [int] NULL,
	[Description] [varchar](125) NULL,
	[PlayerInID] [int] NULL,
	[DimLoadDate] [datetime] NULL,
	[SourceLoadDate] [datetime] NULL
) ON [PRIMARY]
GO
