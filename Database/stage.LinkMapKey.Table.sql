USE [model]
GO
/****** Object:  Table [stage].[LinkMapKey]    Script Date: 8/2/2023 1:51:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [stage].[LinkMapKey](
	[LinkTable] [varchar](255) NULL,
	[StageTable] [varchar](255) NULL,
	[PK] [varchar](255) NULL
) ON [PRIMARY]
GO
