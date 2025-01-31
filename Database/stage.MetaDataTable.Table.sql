USE [model]
GO
/****** Object:  Table [stage].[MetaDataTable]    Script Date: 8/2/2023 1:51:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [stage].[MetaDataTable](
	[StageTable] [varchar](255) NULL,
	[StageColumn1] [varchar](255) NULL,
	[StageColumn2] [varchar](255) NULL,
	[StageColumn3] [varchar](255) NULL,
	[HubTable] [varchar](255) NULL,
	[HubColumn1] [varchar](255) NULL,
	[HubColumn2] [varchar](255) NULL,
	[HubColumn3] [varchar](255) NULL,
	[SatTable] [varchar](255) NULL
) ON [PRIMARY]
GO
