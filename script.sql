USE [Examen]
GO
/****** Object:  Table [dbo].[Gender]    Script Date: 24/2/2020 19:46:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Gender](
	[genderId] [int] NOT NULL,
	[label] [varchar](45) NOT NULL,
 CONSTRAINT [PK_Gender] PRIMARY KEY CLUSTERED 
(
	[genderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Person]    Script Date: 24/2/2020 19:46:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Person](
	[personId] [int] NOT NULL,
	[fistName] [varchar](45) NOT NULL,
	[lastName] [varchar](45) NOT NULL,
	[genderId] [int] NOT NULL,
 CONSTRAINT [PK_Person] PRIMARY KEY CLUSTERED 
(
	[personId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Person]  WITH CHECK ADD  CONSTRAINT [FK_Person_Gender] FOREIGN KEY([genderId])
REFERENCES [dbo].[Gender] ([genderId])
GO
ALTER TABLE [dbo].[Person] CHECK CONSTRAINT [FK_Person_Gender]
GO
/****** Object:  StoredProcedure [dbo].[ConsultGender]    Script Date: 24/2/2020 19:46:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ConsultGender]
AS
BEGIN
	SELECT *
	FROM   Gender;

END
GO
/****** Object:  StoredProcedure [dbo].[ConsultPerson]    Script Date: 24/2/2020 19:46:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ConsultPerson]
AS
BEGIN
	SELECT Person.personId, Person.fistName, Person.lastName, Person.genderId, Gender.label
	FROM   Gender INNER JOIN Person ON Gender.genderId = Person.genderId

END
GO
/****** Object:  StoredProcedure [dbo].[CreateGender]    Script Date: 24/2/2020 19:46:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[CreateGender]
@Label varchar(45)
AS
BEGIN

Declare @Codigo int

Select @Codigo=isnull(MAX(genderId),0)+1 from Gender

	INSERT INTO [dbo].[Gender]
           ([genderId]
           ,[label])
     VALUES
           (@Codigo
		   ,@Label)

	Select @Codigo
END
GO
/****** Object:  StoredProcedure [dbo].[CreatePerson]    Script Date: 24/2/2020 19:46:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[CreatePerson]
@FirstName varchar(45),
@LastName varchar(45),
@GenderId int
AS
BEGIN

Declare @Codigo int

Select @Codigo=isnull(MAX(personId),0)+1 from Person

	INSERT INTO [dbo].[Person]
           ([personId]
           ,[fistName]
           ,[lastName]
           ,[genderId])
     VALUES
           (@Codigo
		   ,@FirstName
           ,@LastName
		   ,@GenderId)

	Select @Codigo
END
GO
/****** Object:  StoredProcedure [dbo].[EliminaGender]    Script Date: 24/2/2020 19:46:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================

CREATE PROCEDURE [dbo].[EliminaGender]
@IdGender int
AS
BEGIN
	Delete Gender where genderId=@IdGender
END
GO
/****** Object:  StoredProcedure [dbo].[EliminaPerson]    Script Date: 24/2/2020 19:46:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================

CREATE PROCEDURE [dbo].[EliminaPerson]
@IdPerson int
AS
BEGIN
	Delete Person where personId=@IdPerson
END
GO
/****** Object:  StoredProcedure [dbo].[GetGender]    Script Date: 24/2/2020 19:46:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================

CREATE PROCEDURE [dbo].[GetGender]
@IdGender int
AS
BEGIN
	Select * from Gender where genderId=@IdGender
END
GO
/****** Object:  StoredProcedure [dbo].[GetPerson]    Script Date: 24/2/2020 19:46:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================

CREATE PROCEDURE [dbo].[GetPerson]
@IdPerson int
AS
BEGIN

	SELECT        Person.personId, Person.fistName, Person.lastName, Person.genderId, Gender.label
	FROM            Gender INNER JOIN
                         Person ON Gender.genderId = Person.genderId
	where personId=@IdPerson
END
GO
/****** Object:  StoredProcedure [dbo].[UpdateGender]    Script Date: 24/2/2020 19:46:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================

CREATE PROCEDURE [dbo].[UpdateGender]
@IdGender int,
@Label varchar(45)
AS
BEGIN
	
		update Gender set
			label=@Label
		where genderId=@IdGender
END
GO
/****** Object:  StoredProcedure [dbo].[UpdatePerson]    Script Date: 24/2/2020 19:46:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================

CREATE PROCEDURE [dbo].[UpdatePerson]
@IdPerson int,
@FirstName varchar(45),
@LastName varchar(45),
@IdGender int
AS
BEGIN
	
		update Person set
			fistName=@FirstName,
			lastName=@LastName,
			genderId=@IdGender
		where personId=@IdPerson
END
GO
