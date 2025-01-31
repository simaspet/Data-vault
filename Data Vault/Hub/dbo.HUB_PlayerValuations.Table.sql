USE [model]
GO
/****** Object:  Table [dbo].[HUB_PlayerValuations]    Script Date: 8/2/2023 1:51:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HUB_PlayerValuations](
	[HubPlayerValuationsKey] [nvarchar](100) NOT NULL,
	[HubSourceID] [nvarchar](100) NOT NULL,
	[HubLoadDate] [datetime] NOT NULL,
	[PlayerID] [int] NULL,
	[Date] [date] NULL
) ON [PRIMARY]
GO
