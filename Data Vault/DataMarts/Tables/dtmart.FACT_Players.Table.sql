USE [model]
GO
/****** Object:  Table [dtmart].[FACT_Players]    Script Date: 8/8/2023 10:50:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dtmart].[FACT_Players](
	[PlayersKey] [varchar](125) NULL,
	[PlayerValuationsKey] [varchar](125) NULL,
	[PlayerAppearancesKey] [varchar](125) NULL,
	[ValuationDateKey] [varchar](125) NULL,
	[MarketValueInEur] [int] NULL,
	[HighestMarketValueInEur] [int] NULL,
	[MarketValueInEurYear] [int] NULL,
	[YellowCards] [int] NULL,
	[RedCards] [int] NULL,
	[Goals] [int] NULL,
	[Assists] [int] NULL,
	[MinutesPlayed] [int] NULL,
	[FactLoadDate] [datetime] NULL,
	[SourceLoadDate] [datetime] NULL
) ON [PRIMARY]
GO
