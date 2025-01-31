USE [model]
GO
/****** Object:  Table [dbo].[SAT_PlayerValuations]    Script Date: 8/2/2023 1:51:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SAT_PlayerValuations](
	[HubPlayerValuationsKey] [nvarchar](100) NOT NULL,
	[SatLoadDate] [datetime] NULL,
	[SatEndDate] [datetime] NULL,
	[SatRecordSourceID] [nvarchar](100) NOT NULL,
	[SatRecordHash] [nvarchar](100) NOT NULL,
	[PlayerID] [int] NULL,
	[LastSeason] [int] NULL,
	[Datetime] [datetime] NULL,
	[Date] [date] NULL,
	[Dateweek] [date] NULL,
	[MarketValueInEur] [int] NULL,
	[n] [int] NULL,
	[CurrentClubID] [int] NULL,
	[PlayerClubDomesticCompetitionID] [nvarchar](255) NULL
) ON [PRIMARY]
GO
