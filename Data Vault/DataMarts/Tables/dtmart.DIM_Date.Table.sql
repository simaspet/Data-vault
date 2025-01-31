USE [model]
GO
/****** Object:  Table [dtmart].[DIM_Date]    Script Date: 8/8/2023 10:50:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dtmart].[DIM_Date](
	[DateKey] [varchar](125) NULL,
	[Date] [date] NULL,
	[Year] [int] NULL,
	[Month] [tinyint] NULL,
	[Day] [tinyint] NULL,
	[Time] [time](7) NULL,
	[GameDateKey] [date] NULL,
	[ValuationDateKey] [date] NULL,
	[DimLoadDate] [datetime] NULL,
	[SourceLoadDate] [datetime] NULL
) ON [PRIMARY]
GO
