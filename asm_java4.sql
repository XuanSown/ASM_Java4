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
    Active bit not null default 1
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
INSERT INTO Video (Id, Title, Poster, Views, Description, Active) VALUES
(N'v01', N'Kén vợ tập 3', N'poster1.jpg', 1500, N'Phim hài đặc sắc', 1),
(N'v02', N'Hướng dẫn Java Swing Lab 1', N'poster2.jpg', 500, N'Dành cho sinh viên FPT Poly', 1),
(N'v03', N'SQL Server cho người mới bắt đầu', N'poster3.jpg', 2000, N'Học CSDL từ A-Z', 1),
(N'v04', N'So sánh Vue.js và React', N'poster4.jpg', 900, N'Nên chọn framework nào?', 0),
(N'v05', N'Top 10 Mì Ăn Liền Ngon Nhất', N'poster5.jpg', 10000, N'Review ẩm thực', 1),
(N'v06', N'Học Hibernate/JPA trong 30 phút', N'poster6.jpg', 3500, N'JPA cho người mới', 1),
(N'v07', N'MV "Lạc Trôi" - Sơn Tùng MTP', N'poster7.jpg', 500000, N'Âm nhạc Việt Nam', 1),
(N'v08', N'Cách làm Bánh Mì Nướng Muối Ớt', N'poster8.jpg', 7800, N'Ẩm thực đường phố', 1),
(N'v09', N'Vì sao Trái Đất quay?', N'poster9.jpg', 1200, N'Khám phá khoa học', 1),
(N'v10', N'Hướng dẫn làm Servlet/JSP Lab 3', N'poster10.jpg', 800, N'Dành cho sinh viên Poly', 1);
GO

-- 4. DỮ LIỆU MẪU BẢNG Favorite (10 BẢN GHI)
INSERT INTO Favorite (UserId, VideoId, LikeDate) VALUES
-- Nguyễn Văn Tèo (u01) thích 4 video:
(N'u01', N'v01', '2024-12-01'), -- Tèo thích Kén vợ tập 3
(N'u01', N'v02', '2025-01-10'), -- Tèo thích Hướng dẫn Java Swing
(N'u01', N'v05', '2025-01-11'), -- Tèo thích Top 10 Mì
(N'u01', N'v08', '2025-02-01'), -- Tèo thích Bánh Mì Nướng

-- Các user khác
(N'u02', N'v07', '2025-01-15'),
(N'u03', N'v01', '2025-02-01'), -- Minh cũng thích Kén vợ
(N'u03', N'v03', '2025-02-02'),
(N'u04', N'v06', '2025-02-10'),
(N'u05', N'v10', '2025-02-11'),
(N'u02', N'v02', '2025-02-12');
GO

-- 5. DỮ LIỆU MẪU BẢNG Share (10 BẢN GHI)
INSERT INTO Share (UserId, VideoId, Emails, ShareDate) VALUES
(N'u01', N'v01', N'banbe@gmail.com', '2025-01-01'), -- Tèo chia sẻ Kén vợ
(N'u02', N'v02', N'student@fpt.edu.vn', '2025-01-11'),
(N'u03', N'v05', N'mom@gmail.com', '2025-01-20'),
(N'u04', N'v03', N'team@company.com', '2025-02-02'),
(N'u01', N'v05', N'anhem@gmail.com', '2025-02-06'), -- Tèo chia sẻ Top 10 Mì
(N'u05', N'v08', N'bep@gmail.com', '2025-02-10'),
(N'u07', N'v07', N'fanclub@gmail.com', '2025-02-11'),
(N'u08', N'v09', N'kids@gmail.com', '2025-02-12'),
(N'u09', N'v04', N'devteam@gmail.com', '2025-02-13'),
(N'u10', N'v10', N'class@fpt.edu.vn', '2025-02-14');
GO

select * from Users
select * from Video
select * from Favorite
select * from Share