USE [model]
GO
/****** Object:  Table [dbo].[HUB_Clubs]    Script Date: 8/2/2023 1:51:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HUB_Clubs](
	[HubClubsKey] [varchar](100) NOT NULL,
	[HubSourceID] [varchar](100) NOT NULL,
	[HubLoadDate] [datetime] NOT NULL,
	[ClubID] [varchar](255) NULL
) ON [PRIMARY]
GO
