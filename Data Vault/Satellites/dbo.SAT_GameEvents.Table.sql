USE [model]
GO
/****** Object:  Table [dbo].[SAT_GameEvents]    Script Date: 8/2/2023 1:51:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SAT_GameEvents](
	[HubGameEventsKey] [nvarchar](100) NOT NULL,
	[SatLoadDate] [datetime] NULL,
	[SatEndDate] [datetime] NULL,
	[SatRecordSourceID] [nvarchar](100) NOT NULL,
	[SatRecordHash] [nvarchar](100) NOT NULL,
	[GameID] [int] NULL,
	[MinuteID] [int] NULL,
	[Type] [varchar](255) NULL,
	[ClubID] [int] NULL,
	[PlayerID] [int] NULL,
	[Description] [varchar](255) NULL,
	[PlayerInID] [int] NULL
) ON [PRIMARY]
GO
