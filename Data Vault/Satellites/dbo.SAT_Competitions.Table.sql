USE [model]
GO
/****** Object:  Table [dbo].[SAT_Competitions]    Script Date: 8/2/2023 1:51:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SAT_Competitions](
	[HubCompetitionsKey] [nvarchar](100) NOT NULL,
	[SatLoadDate] [datetime] NULL,
	[SatEndDate] [datetime] NULL,
	[SatRecordSourceID] [nvarchar](100) NOT NULL,
	[SatRecordHash] [nvarchar](100) NOT NULL,
	[CompetitionID] [varchar](255) NULL,
	[CompetitionCode] [varchar](255) NULL,
	[Name] [varchar](255) NULL,
	[SubType] [varchar](255) NULL,
	[Type] [varchar](255) NULL,
	[CountryID] [int] NULL,
	[CountryName] [varchar](255) NULL,
	[DomesticLeagueCode] [varchar](255) NULL,
	[Confederation] [varchar](255) NULL,
	[Url] [varchar](255) NULL
) ON [PRIMARY]
GO
