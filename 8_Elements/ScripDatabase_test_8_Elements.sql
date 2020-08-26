USE [8Element]
GO
/****** Object:  Table [dbo].[RegisterUser]    Script Date: 8/26/2020 7:15:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RegisterUser](
	[trx_id] [uniqueidentifier] NOT NULL,
	[msisdn] [varchar](13) NOT NULL,
	[service_id] [varchar](15) NOT NULL,
	[service_code] [varchar](15) NULL,
	[created_date] [datetime] NOT NULL,
 CONSTRAINT [PK_RegisterUser] PRIMARY KEY CLUSTERED 
(
	[trx_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Transaksi]    Script Date: 8/26/2020 7:15:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Transaksi](
	[id_trx_detail] [int] IDENTITY(1,1) NOT NULL,
	[id_trx] [uniqueidentifier] NOT NULL,
	[price_code] [varchar](10) NOT NULL,
	[subscribe_date] [datetime] NOT NULL,
	[is_subscribe] [bit] NOT NULL,
 CONSTRAINT [PK_Transaksi] PRIMARY KEY CLUSTERED 
(
	[id_trx_detail] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[RegisterUser] ([trx_id], [msisdn], [service_id], [service_code], [created_date]) VALUES (N'46e278ee-c252-4cb4-b76f-01c1bd2ca8aa', N'082245878987', N'MUSIC_WEEKLY', NULL, CAST(N'2020-08-26T18:53:02.017' AS DateTime))
GO
INSERT [dbo].[RegisterUser] ([trx_id], [msisdn], [service_id], [service_code], [created_date]) VALUES (N'b6a4f106-6122-4ae8-8e24-ae39577fc0c1', N'081289658745', N'MUSIC_WEEKLY', NULL, CAST(N'2020-08-26T18:51:52.550' AS DateTime))
GO
INSERT [dbo].[RegisterUser] ([trx_id], [msisdn], [service_id], [service_code], [created_date]) VALUES (N'9ef1822f-19dd-42a7-b1d1-f2b4d7612ec3', N'087854884554', N'MUSIC_MONTHLY', N'98000', CAST(N'2020-08-26T18:51:52.550' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[Transaksi] ON 
GO
INSERT [dbo].[Transaksi] ([id_trx_detail], [id_trx], [price_code], [subscribe_date], [is_subscribe]) VALUES (1, N'46e278ee-c252-4cb4-b76f-01c1bd2ca8aa', N'P1K', CAST(N'2020-09-02T19:02:54.820' AS DateTime), 1)
GO
INSERT [dbo].[Transaksi] ([id_trx_detail], [id_trx], [price_code], [subscribe_date], [is_subscribe]) VALUES (2, N'b6a4f106-6122-4ae8-8e24-ae39577fc0c1', N'P1K', CAST(N'2020-08-29T19:02:54.827' AS DateTime), 0)
GO
INSERT [dbo].[Transaksi] ([id_trx_detail], [id_trx], [price_code], [subscribe_date], [is_subscribe]) VALUES (3, N'9ef1822f-19dd-42a7-b1d1-f2b4d7612ec3', N'P20K', CAST(N'2020-09-26T19:02:54.827' AS DateTime), 0)
GO
SET IDENTITY_INSERT [dbo].[Transaksi] OFF
GO
ALTER TABLE [dbo].[Transaksi]  WITH CHECK ADD  CONSTRAINT [FK_Transaksi_RegisterUser] FOREIGN KEY([id_trx])
REFERENCES [dbo].[RegisterUser] ([trx_id])
GO
ALTER TABLE [dbo].[Transaksi] CHECK CONSTRAINT [FK_Transaksi_RegisterUser]
GO
