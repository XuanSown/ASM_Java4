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

ALTER TABLE Video
ALTER COLUMN Poster nvarchar(500);
GO

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

create table ChatMessage(
    Id bigint identity(1,1) primary key,
    UserId nvarchar(50) not null,
    Content nvarchar(max) not null,
    CreatedDate datetime default getdate(),
    foreign key (UserId) references Users(Id)
);

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
(N'v01', N'LIVERPOOL - MAN UNITED', N'https://img.youtube.com/vi/U_ygjQ6Ypro/maxresdefault.jpg', 15000000, N'MAGUIRE TỎA SÁNG, QUỶ ĐỎ BẢN LĨNH KÉO SẬP ANFIELD | NGOẠI HẠNG ANH 25/26', 1, N'https://www.youtube.com/embed/U_ygjQ6Ypro'),
(N'v02', N'Dương Domic ft. Lou Hoàng - Pin Dự Phòng | EP Dữ Liệu Quý', N'https://img.youtube.com/vi/IfMv0pJJtAA&list=RDIfMv0pJJtAA&start_radio=1/maxresdefault.jpg', 24000500, N'Đã công chiếu vào 22 thg 11, 2024  #LouHoang #DuLieuQuy #DuongDomic', 1, N'https://www.youtube.com/embed/IfMv0pJJtAA&list=RDIfMv0pJJtAA&start_radio=1')

UPDATE Video
SET Poster = N'https://img.youtube.com/vi/IfMv0pJJtAA/maxresdefault.jpg',
    Link = N'https://www.youtube.com/embed/IfMv0pJJtAA'
WHERE Id = N'v02';

INSERT INTO Video (Id, Title, Poster, Views, Description, Active, Link) VALUES
(N'v03', N'Tất cả về kẻ chén vợ bạn Thibaut Courtois trong 15 phút', N'https://img.youtube.com/vi/RvJUPgam2dY/maxresdefault.jpg', 8500000, N'...', 1, N'https://www.youtube.com/embed/RvJUPgam2dY'),
(N'v04', N'Chúng Ta Của Hiện Tại | Sơn Tùng M-TP', N'https://img.youtube.com/vi/psZ1g9fMfeo/maxresdefault.jpg', 95000000, N'Bản hit đình đám năm xưa', 1, N'https://www.youtube.com/embed/psZ1g9fMfeo'),
(N'v05', N'Wren Evans - Từng Quen', N'https://img.youtube.com/vi/zepHPnUDROE/maxresdefault.jpg', 1200000, N'Album Loi Choi', 1, N'https://www.youtube.com/embed/zepHPnUDROE'),
(N'v06', N'HIEUTHUHAI - Ngủ Một Mình (tình rất tình)', N'https://img.youtube.com/vi/STjzkjnLlZ4/maxresdefault.jpg', 33000000, N'Nhạc HIEUTHUHAI cực cuốn', 1, N'https://www.youtube.com/embed/STjzkjnLlZ4'),
(N'v07', N'SAU 5000 NGÀY, ĐÂY LÀ 4 CHIẾC iPHONE THAY ĐỔI THẾ GIỚI !!!', N'https://img.youtube.com/vi/47ys7FTYqy4/maxresdefault.jpg', 71246000, N'...', 1, N'https://www.youtube.com/embed/47ys7FTYqy4'),
(N'v08', N'Giải thích về Warren Buffet trong 13 phút', N'https://img.youtube.com/vi/6EAYxmn4JKY/maxresdefault.jpg', 106128000, N'...', 1, N'https://www.youtube.com/embed/6EAYxmn4JKY'),
(N'v09', N'SƠN TÙNG M-TP | HÃY TRAO CHO ANH ft. Snoop Dogg', N'https://img.youtube.com/vi/knW7-x7Y7RE/maxresdefault.jpg', 302230000, N'Màn hợp tác quốc tế đỉnh cao với Snoop Dogg', 1, N'https://www.youtube.com/embed/knW7-x7Y7RE'),
(N'v10', N'SÓNG GIÓ | ICM x JACK | OFFICIAL MUSIC VIDEO', N'https://img.youtube.com/vi/j8U06veqxdU/maxresdefault.jpg', 466469000, N'Bản hit trăm triệu view của Jack và K-ICM', 1, N'https://www.youtube.com/embed/j8U06veqxdU'),
(N'v11', N'Khóa học Java đầy đủ miễn phí', N'https://img.youtube.com/vi/xk4_1vDrzzo/maxresdefault.jpg', 193900000, N'...', 1, N'https://www.youtube.com/embed/xk4_1vDrzzo'),
(N'v12', N'Generics In Java - Full Simple Tutorial', N'https://img.youtube.com/vi/K1iu1kXkVoA/maxresdefault.jpg', 36468000, N'...', 1, N'https://www.youtube.com/embed/K1iu1kXkVoA'),
(N'v13', N'Học Cách Biến Ý Tưởng → Database → API | Hướng Dẫn Thiết Kế Backend', N'https://img.youtube.com/vi/3lH2oqKK-3U/maxresdefault.jpg', 178425000, N'...', 1, N'https://www.youtube.com/embed/3lH2oqKK-3U'),
(N'v14', N'LẠC TRÔI | OFFICIAL MUSIC VIDEO | SƠN TÙNG M-TP', N'https://img.youtube.com/vi/Llw9Q6akRo4/maxresdefault.jpg', 282093000, N'Bản hit đánh dấu phong cách cổ trang của Sơn Tùng', 1, N'https://www.youtube.com/embed/Llw9Q6akRo4'),
(N'v15', N'Khu Ổ Chuột Băng Đảng Lớn & Nguy Hiểm Nhất Brazil', N'https://img.youtube.com/vi/axW90p8wslo/maxresdefault.jpg', 43926000, N'...', 1, N'https://www.youtube.com/embed/axW90p8wslo');
GO

-- 4. DỮ LIỆU MẪU BẢNG Favorite (10 BẢN GHI)
INSERT INTO Favorite (UserId, VideoId, LikeDate) VALUES

-- 5. DỮ LIỆU MẪU BẢNG Share (10 BẢN GHI)
INSERT INTO Share (UserId, VideoId, Emails, ShareDate) VALUES


select * from Users
select * from Video
select * from Favorite
select * from Share


