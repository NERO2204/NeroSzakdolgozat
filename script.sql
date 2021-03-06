USE [master]
GO
/****** Object:  Database [Filmek]    Script Date: 2021. 05. 10. 11:40:56 ******/
CREATE DATABASE [Filmek]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Filmek', FILENAME = N'D:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER01\MSSQL\DATA\Filmek.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Filmek_log', FILENAME = N'D:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER01\MSSQL\DATA\Filmek_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [Filmek] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Filmek].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Filmek] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Filmek] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Filmek] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Filmek] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Filmek] SET ARITHABORT OFF 
GO
ALTER DATABASE [Filmek] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Filmek] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Filmek] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Filmek] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Filmek] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Filmek] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Filmek] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Filmek] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Filmek] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Filmek] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Filmek] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Filmek] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Filmek] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Filmek] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Filmek] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Filmek] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Filmek] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Filmek] SET RECOVERY FULL 
GO
ALTER DATABASE [Filmek] SET  MULTI_USER 
GO
ALTER DATABASE [Filmek] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Filmek] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Filmek] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Filmek] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Filmek] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Filmek] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'Filmek', N'ON'
GO
ALTER DATABASE [Filmek] SET QUERY_STORE = OFF
GO
USE [Filmek]
GO
/****** Object:  Table [dbo].[film]    Script Date: 2021. 05. 10. 11:40:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[film](
	[id] [int] NOT NULL,
	[cim] [varchar](50) NULL,
	[mufaj] [int] NULL,
	[besorolas] [int] NULL,
	[leiras] [varchar](200) NULL,
	[megjelenesiev] [int] NULL,
	[generikusbesorolas] [int] NULL,
	[kiadasdatum] [date] NULL,
	[kephely] [text] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[adotttablabollekerdez]    Script Date: 2021. 05. 10. 11:40:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[adotttablabollekerdez] 
(	
	-- Add the parameters for the function here
 	 @valtozo varchar(30)
	
)
RETURNS TABLE 
AS
RETURN 
(

	SELECT * from film
)
GO
/****** Object:  Table [dbo].[Tevekenyseg]    Script Date: 2021. 05. 10. 11:40:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tevekenyseg](
	[felhasznalo] [int] NOT NULL,
	[felhasznaloitevekenyseg] [int] NOT NULL,
	[datumido] [datetime] NOT NULL,
 CONSTRAINT [PK_Tevekenyseg] PRIMARY KEY CLUSTERED 
(
	[felhasznalo] ASC,
	[felhasznaloitevekenyseg] ASC,
	[datumido] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FelhasznaloiTevekenyseg]    Script Date: 2021. 05. 10. 11:40:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FelhasznaloiTevekenyseg](
	[id] [int] NOT NULL,
	[leiras] [text] NULL,
 CONSTRAINT [PK_FelhasznaloiTevekenyseg] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[osszaszomltak]    Script Date: 2021. 05. 10. 11:40:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create view [dbo].[osszaszomltak]
as
(
Select  FelhasznaloiTevekenyseg.id,(select COUNT(Tevekenyseg.felhasznaloitevekenyseg)) as tevekenysegszam
from FelhasznaloiTevekenyseg,Tevekenyseg
where FelhasznaloiTevekenyseg.id=Tevekenyseg.felhasznaloitevekenyseg
Group by FelhasznaloiTevekenyseg.id
)
GO
/****** Object:  UserDefinedFunction [dbo].[kiadasevbenkeres]    Script Date: 2021. 05. 10. 11:40:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[kiadasevbenkeres]
(
@kiadaseve int
)
returns table
as 
return 
(
select * from film
where film.megjelenesiev like @kiadaseve
)
GO
/****** Object:  UserDefinedFunction [dbo].[leirasbankeres]    Script Date: 2021. 05. 10. 11:40:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[leirasbankeres]
(
@leiras varchar(50)
)
returns table
return
(
select * from film
where film.cim=@leiras
)
GO
/****** Object:  UserDefinedFunction [dbo].[cimbenkleres]    Script Date: 2021. 05. 10. 11:40:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[cimbenkleres]
(
@cim varchar(50)
)
returns table
return
(
select * from film
where film.cim LIKE '%'+@cim+'%'
)
GO
/****** Object:  Table [dbo].[mufaj]    Script Date: 2021. 05. 10. 11:40:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[mufaj](
	[id] [int] NOT NULL,
	[leiras] [text] NULL,
 CONSTRAINT [PK_mufaj] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[kategoriakListaz]    Script Date: 2021. 05. 10. 11:40:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[kategoriakListaz] AS
SELECT  f.id,f.cim, f.mufaj,m.leiras
FROM film f
inner join
mufaj m
on
f.mufaj=m.id
GO
/****** Object:  View [dbo].[scifiketListaz]    Script Date: 2021. 05. 10. 11:40:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create View [dbo].[scifiketListaz] as
select id,cim from kategoriakListaz
where mufaj=1
GO
/****** Object:  View [dbo].[RomantikusokatListaz]    Script Date: 2021. 05. 10. 11:40:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE View [dbo].[RomantikusokatListaz] as
select id,cim,leiras from kategoriakListaz
where mufaj=3
GO
/****** Object:  View [dbo].[osszesfilm]    Script Date: 2021. 05. 10. 11:40:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create view  [dbo].[osszesfilm]
as
select * from film
GO
/****** Object:  View [dbo].[Remakek]    Script Date: 2021. 05. 10. 11:40:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[Remakek]
as
select * from film
where generikusbesorolas=2
GO
/****** Object:  View [dbo].[ugyanolyancimuek]    Script Date: 2021. 05. 10. 11:40:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create view [dbo].[ugyanolyancimuek]
as
select * from film
where generikusbesorolas=3
GO
/****** Object:  View [dbo].[simafilmek]    Script Date: 2021. 05. 10. 11:40:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[simafilmek]
as
select * from film
where generikusbesorolas=1
GO
/****** Object:  Table [dbo].[besorerolas]    Script Date: 2021. 05. 10. 11:40:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[besorerolas](
	[id] [int] NOT NULL,
	[leiras] [text] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ertekeles]    Script Date: 2021. 05. 10. 11:40:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ertekeles](
	[id] [int] NOT NULL,
	[film] [int] NOT NULL,
	[datum] [date] NULL,
	[leiras] [varchar](200) NULL,
	[pontszam] [int] NULL,
	[felhasznalo] [int] NULL,
 CONSTRAINT [PK_ertekeles] PRIMARY KEY CLUSTERED 
(
	[id] ASC,
	[film] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[felhasznalo]    Script Date: 2021. 05. 10. 11:40:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[felhasznalo](
	[id] [int] NOT NULL,
	[felhasznaloiszint] [int] NULL,
	[nev] [text] NULL,
	[jelszo] [text] NULL,
 CONSTRAINT [PK_Table_1] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[felhasznalofilmje]    Script Date: 2021. 05. 10. 11:40:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[felhasznalofilmje](
	[id] [int] NOT NULL,
	[film] [int] NOT NULL,
	[felhasznalo] [int] NOT NULL,
 CONSTRAINT [PK_felhasznalofilmje] PRIMARY KEY CLUSTERED 
(
	[id] ASC,
	[film] ASC,
	[felhasznalo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[felhasznaloiszint]    Script Date: 2021. 05. 10. 11:40:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[felhasznaloiszint](
	[id] [int] NOT NULL,
	[leiras] [text] NOT NULL,
 CONSTRAINT [PK_felhasznaloiszint] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[generikusbesorolas]    Script Date: 2021. 05. 10. 11:40:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[generikusbesorolas](
	[id] [int] NOT NULL,
	[leiras] [nchar](10) NULL,
 CONSTRAINT [PK_generikusbesorolas] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Kattintasok]    Script Date: 2021. 05. 10. 11:40:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Kattintasok](
	[esemenyID] [int] NULL,
	[Esemenyszam] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Remake]    Script Date: 2021. 05. 10. 11:40:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Remake](
	[Remakeid] [int] NOT NULL,
	[remakeltfilm] [int] NOT NULL,
	[cim] [text] NULL,
	[kiadaseve] [int] NULL,
 CONSTRAINT [PK_Remake] PRIMARY KEY CLUSTERED 
(
	[Remakeid] ASC,
	[remakeltfilm] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[szerep]    Script Date: 2021. 05. 10. 11:40:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[szerep](
	[id] [int] NOT NULL,
	[film] [int] NOT NULL,
	[szinesz] [int] NOT NULL,
	[tipus] [int] NOT NULL,
	[szerep] [text] NULL,
 CONSTRAINT [PK_szerep] PRIMARY KEY CLUSTERED 
(
	[id] ASC,
	[film] ASC,
	[szinesz] ASC,
	[tipus] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Szinesztabla]    Script Date: 2021. 05. 10. 11:40:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Szinesztabla](
	[azon] [int] NOT NULL,
	[nev] [text] NULL,
	[szuldat] [datetime] NULL,
	[haldat] [datetime] NULL,
 CONSTRAINT [PK_Szinesztabla] PRIMARY KEY CLUSTERED 
(
	[azon] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tipus]    Script Date: 2021. 05. 10. 11:40:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tipus](
	[id] [int] NOT NULL,
	[leiras] [text] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[uyganolyancimu]    Script Date: 2021. 05. 10. 11:40:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[uyganolyancimu](
	[UgyanolyanCimuid] [int] NOT NULL,
	[filmid] [int] NOT NULL,
	[cim] [text] NULL,
	[kiadaseve] [int] NULL,
 CONSTRAINT [PK_uyganolyancimu] PRIMARY KEY CLUSTERED 
(
	[UgyanolyanCimuid] ASC,
	[filmid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[ertekeles]  WITH CHECK ADD  CONSTRAINT [FK_ertekeles_felhasznalo] FOREIGN KEY([felhasznalo])
REFERENCES [dbo].[felhasznalo] ([id])
GO
ALTER TABLE [dbo].[ertekeles] CHECK CONSTRAINT [FK_ertekeles_felhasznalo]
GO
ALTER TABLE [dbo].[ertekeles]  WITH CHECK ADD  CONSTRAINT [FK_ertekeles_film] FOREIGN KEY([film])
REFERENCES [dbo].[film] ([id])
GO
ALTER TABLE [dbo].[ertekeles] CHECK CONSTRAINT [FK_ertekeles_film]
GO
ALTER TABLE [dbo].[felhasznalo]  WITH CHECK ADD  CONSTRAINT [FK_felhasznalo_felhasznaloiszint] FOREIGN KEY([felhasznaloiszint])
REFERENCES [dbo].[felhasznaloiszint] ([id])
GO
ALTER TABLE [dbo].[felhasznalo] CHECK CONSTRAINT [FK_felhasznalo_felhasznaloiszint]
GO
ALTER TABLE [dbo].[felhasznalofilmje]  WITH CHECK ADD  CONSTRAINT [FK_felhasznalofilmje_felhasznalo] FOREIGN KEY([felhasznalo])
REFERENCES [dbo].[felhasznalo] ([id])
GO
ALTER TABLE [dbo].[felhasznalofilmje] CHECK CONSTRAINT [FK_felhasznalofilmje_felhasznalo]
GO
ALTER TABLE [dbo].[felhasznalofilmje]  WITH CHECK ADD  CONSTRAINT [FK_felhasznalofilmje_film] FOREIGN KEY([film])
REFERENCES [dbo].[film] ([id])
GO
ALTER TABLE [dbo].[felhasznalofilmje] CHECK CONSTRAINT [FK_felhasznalofilmje_film]
GO
ALTER TABLE [dbo].[film]  WITH CHECK ADD  CONSTRAINT [FK_film_besorerolás] FOREIGN KEY([besorolas])
REFERENCES [dbo].[besorerolas] ([id])
GO
ALTER TABLE [dbo].[film] CHECK CONSTRAINT [FK_film_besorerolás]
GO
ALTER TABLE [dbo].[film]  WITH CHECK ADD  CONSTRAINT [FK_film_generikusbesorolas] FOREIGN KEY([generikusbesorolas])
REFERENCES [dbo].[generikusbesorolas] ([id])
GO
ALTER TABLE [dbo].[film] CHECK CONSTRAINT [FK_film_generikusbesorolas]
GO
ALTER TABLE [dbo].[film]  WITH CHECK ADD  CONSTRAINT [FK_film_mufaj] FOREIGN KEY([mufaj])
REFERENCES [dbo].[mufaj] ([id])
GO
ALTER TABLE [dbo].[film] CHECK CONSTRAINT [FK_film_mufaj]
GO
ALTER TABLE [dbo].[Remake]  WITH CHECK ADD  CONSTRAINT [FK_Remake_film] FOREIGN KEY([remakeltfilm])
REFERENCES [dbo].[film] ([id])
GO
ALTER TABLE [dbo].[Remake] CHECK CONSTRAINT [FK_Remake_film]
GO
ALTER TABLE [dbo].[szerep]  WITH CHECK ADD  CONSTRAINT [FK_szerep_film] FOREIGN KEY([film])
REFERENCES [dbo].[film] ([id])
GO
ALTER TABLE [dbo].[szerep] CHECK CONSTRAINT [FK_szerep_film]
GO
ALTER TABLE [dbo].[szerep]  WITH CHECK ADD  CONSTRAINT [FK_szerep_Szinesztabla] FOREIGN KEY([szinesz])
REFERENCES [dbo].[Szinesztabla] ([azon])
GO
ALTER TABLE [dbo].[szerep] CHECK CONSTRAINT [FK_szerep_Szinesztabla]
GO
ALTER TABLE [dbo].[szerep]  WITH CHECK ADD  CONSTRAINT [FK_szerep_tipus] FOREIGN KEY([tipus])
REFERENCES [dbo].[tipus] ([id])
GO
ALTER TABLE [dbo].[szerep] CHECK CONSTRAINT [FK_szerep_tipus]
GO
ALTER TABLE [dbo].[Tevekenyseg]  WITH CHECK ADD  CONSTRAINT [FK_Tevekenyseg_felhasznalo] FOREIGN KEY([felhasznalo])
REFERENCES [dbo].[felhasznalo] ([id])
GO
ALTER TABLE [dbo].[Tevekenyseg] CHECK CONSTRAINT [FK_Tevekenyseg_felhasznalo]
GO
ALTER TABLE [dbo].[Tevekenyseg]  WITH CHECK ADD  CONSTRAINT [FK_Tevekenyseg_FelhasznaloiTevekenyseg] FOREIGN KEY([felhasznaloitevekenyseg])
REFERENCES [dbo].[FelhasznaloiTevekenyseg] ([id])
GO
ALTER TABLE [dbo].[Tevekenyseg] CHECK CONSTRAINT [FK_Tevekenyseg_FelhasznaloiTevekenyseg]
GO
ALTER TABLE [dbo].[uyganolyancimu]  WITH CHECK ADD  CONSTRAINT [FK_uyganolyancimu_film] FOREIGN KEY([filmid])
REFERENCES [dbo].[film] ([id])
GO
ALTER TABLE [dbo].[uyganolyancimu] CHECK CONSTRAINT [FK_uyganolyancimu_film]
GO
/****** Object:  StoredProcedure [dbo].[kattintasokbament]    Script Date: 2021. 05. 10. 11:40:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[kattintasokbament]

as
delete from Kattintasok where esemenyID is not null
insert into Kattintasok(esemenyID,Esemenyszam)
select id,tevekenysegszam from osszaszomltak
GO
/****** Object:  StoredProcedure [dbo].[procedure_name]    Script Date: 2021. 05. 10. 11:40:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[procedure_name]
AS
select * from film
GO;
GO
/****** Object:  StoredProcedure [dbo].[XMLbeir]    Script Date: 2021. 05. 10. 11:40:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[XMLbeir]
@City nvarchar(30)
AS
SELECT * FROM Customers WHERE City = @City
GO
USE [master]
GO
ALTER DATABASE [Filmek] SET  READ_WRITE 
GO
