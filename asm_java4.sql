create database asm_java4
go

use asm_java4
go

create table Users(
    Id nvarchar(50) primary key,
	Password nvarchar(50) not null,
    Email nvarchar(50) not null unique,
    Fullname nvarchar(50) not null,
    Admin bit not null default 0
);
go

create table Video(
    Id nvarchar(50) primary key,
    Title nvarchar(200) not null,
    Poster nvarchar(200),
    Views int not null default 0,
    Description nvarchar(max),
    Active bit not null default 1,
    Link nvarchar(500)
);
go

create table Favorite(
    Id bigint identity(1,1) primary key,
    UserId nvarchar(50) not null,
    VideoId nvarchar(50) not null,
    LikeDate date not null default getdate(),
    FOREIGN KEY (UserId) references Users(Id),
    foreign key (VideoId) references Video(Id),
    unique (UserId, VideoId)
);
go

create table Share(
    Id bigint identity (1,1) primary key,
    UserId nvarchar(50) not null,
    VideoId nvarchar(50) not null,
    Emails nvarchar(50) not null,
    ShareDate date not null default getdate(),
    foreign key (UserId) references Users(Id),
    foreign key (VideoId) references Video(Id)
);
go

-- 2. DỮ LIỆU MẪU BẢNG Users (10 BẢN GHI)
INSERT INTO Users (Id, Password, Email, Fullname, Admin) VALUES
(N'u01', N'123', N'teo@gmail.com', N'Nguyễn Văn Tèo', 0),
(N'u02', N'123', N'lan@gmail.com', N'Trần Thị Lan', 1),
(N'u03', N'111', N'minh@gmail.com', N'Lê Văn Minh', 0),
(N'u04', N'999', N'hoa@gmail.com', N'Phạm Thị Hoa', 0),
(N'u05', N'abc', N'dung@gmail.com', N'Hoàng Dũng', 0),
(N'u06', N'pass', N'anh@gmail.com', N'Nguyễn Tuấn Anh', 0),
(N'u07', N'12345', N'binh@gmail.com', N'Võ An Bình', 1),
(N'u08', N'789', N'cuong@gmail.com', N'Lý Văn Cường', 0),
(N'u09', N'qwe', N'duyen@gmail.com', N'Trần Mỹ Duyên', 0),
(N'u10', N'zzz', N'giang@gmail.com', N'Phạm Thu Giang', 0);
GO

-- 3. DỮ LIỆU MẪU BẢNG Video (10 BẢN GHI)
INSERT INTO Video (Id, Title, Poster, Views, Description, Active, Link) VALUES

-- 4. DỮ LIỆU MẪU BẢNG Favorite (10 BẢN GHI)
INSERT INTO Favorite (UserId, VideoId, LikeDate) VALUES

-- 5. DỮ LIỆU MẪU BẢNG Share (10 BẢN GHI)
INSERT INTO Share (UserId, VideoId, Emails, ShareDate) VALUES


select * from Users
select * from Video
select * from Favorite
select * from Share
