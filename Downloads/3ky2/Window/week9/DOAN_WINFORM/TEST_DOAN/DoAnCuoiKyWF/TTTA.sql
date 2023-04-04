CREATE DATABASE TTTA
use TTTA

CREATE TABLE dbo.ACCOUNTS_ADMIN
(
	username char(100),
	pass char(100) NOT NULL,
	CONSTRAINT PK_ACCOUNTS_ADMIN PRIMARY KEY (username)
)
CREATE TABLE dbo.ACCOUNTS_STUDENT
(
	username char(100),
	pass char(100) NOT NULL,
	CONSTRAINT PK_ACCOUNTS_STUDENT PRIMARY KEY (username)
)
CREATE TABLE dbo.ACCOUNTS_TEACHER
(
	username char(100),
	pass char(100) NOT NULL,
	CONSTRAINT PK_ACCOUNTS_TEACHER PRIMARY KEY (username)
)
INSERT INTO ACCOUNTS_ADMIN(username, pass) VALUES 
('admin1','passadmin1'),
('admin2','passadmin2')
INSERT INTO ACCOUNTS_STUDENT(username, pass) VALUES 
('student1','passstudent1'),
('student2','passstudent2')
INSERT INTO ACCOUNTS_TEACHER(username, pass) VALUES 
('teacher1','passteacher1'),
('teacher2','passteacher2')

--Khóa học
CREATE TABLE dbo.KHOAHOC
(
	MaKH char(20) PRIMARY KEY,
	TenKH char(100)
)
--Lớp học
CREATE TABLE dbo.LOPHOC
(
	MaMon char(20), --tham chieu toi MONHOC.MaMon
	Phong char(20), --tham chieu toi PHONGHOC.Phong
	SoHocVien char(3),--tham chieu den PHONGHOC.SoLuongChoNgoi
	NgayBatDau DATE,
	NgayKetThuc DATE,
	CONSTRAINT PK_LOPHOC PRIMARY KEY (MaMon, Phong)
)
SELECT * FROM LOPHOC 
--Phòng học
CREATE TABLE dbo.PHONGHOC
(	
	Phong char(20) PRIMARY KEY,
	SoLuongChoNgoi char(3)
)
--các mon học của mỗi khóa học
CREATE TABLE dbo.MONHOC
(	
	MaMon char(20), -- tham chieu toi MONHOC.MaMon
	MaKH char(20), --tham chieu toi KHOAHOC.MaKH
	TenMon char(100),
	SoBuoiTrongTuan char(2),
	HocPhi int,
	CONSTRAINT PK_MAMONHOC PRIMARY KEY (MaMon)
)
--Điểm qua môn
CREATE TABLE dbo.DIEMQUAMON
(
	MaMon char(20) PRIMARY KEY,
	DiemTBQuaMon char(10)
)

-----------------HOC VIEN-------------------
--thong tin học viên
CREATE TABLE dbo.STUDENT
(
	HSID CHAR(20) PRIMARY KEY,
	--foreign key -> ACC.username
	USERNAME char(100) NOT NULL,
	HOTEN NVARCHAR(100) NOT NULL,
	GIOITINH NVARCHAR(20) NULL,
	NGAYSINH DATE NULL,
	DIACHI NVARCHAR(4000) NULL,
	SDT CHAR(20) NULL,
	CMND CHAR(20) NULL,
	EMAIL CHAR(100) NULL,
	AVATAR IMAGE NULL,
	TienTaiKhoan int NULL
)
--người thân của học viên
CREATE TABLE dbo.THANNHAN
(
	HSID CHAR(20) ,
	TenNguoiThan char(100),
	SDT char(11),
	QuanHe char(50)
)
--thông tin ghi danh từng học viên
CREATE TABLE dbo.GHIDANH
(
	HSID char(20), --tham chieu den bang STUDENT
	NgayDKAcc DATE
)
--Trạng thái môn học
CREATE TABLE dbo.TRANGTHAIMON
(
	TRANGTHAI NVARCHAR(50) PRIMARY KEY --Hoan thanh/Chua hoan thanh
)
--Danh sách lớp đã đki của học viên 
CREATE TABLE dbo.LOPDANGKI
(
	MaLop char(20),
	HSID char(20),--tham chieu den STUDENT		
)
select *from LOPDANGKI
select HOCSINH.ACCID,LOPHOC.MaLop FROM HOCSINH,LOPHOC WHERE 
--Các đợt thi
CREATE TABLE dbo.DOTTHI
(
	DotThi char(50) PRIMARY KEY --giữa kì và cuối kì
)
--Bảng điểm thi các đợt
CREATE TABLE dbo.DIEMTHI --cho cả giữa kì và cuối kì 
(
	HSID char(20),--tham chieu toi STUDEN.HSID
	MaLop char(20),--ThamChieu toi LOPHOC.MaLop
	DotThi char(50),--tham chiieu toi DOTTHI.DotThi
	DiemNghe char(10),
	DiemNoi char(10),
	DiemDoc char(10), 
	DiemViet char(10),
	CONSTRAINT PK_DIEMGIUAKY PRIMARY KEY (HSID, MaLop, DotThi)
	--Muốn tính Điểm TB cả môn -> tính TB của GK và CK -> Tính TB cả môn 
)
--Lịch sử đóng tiền học phí, tiền quỹ, tiền mua khóa học,...
CREATE TABLE dbo.LICHSUDONGTIEN
(
	HSID char(20),--tham chieu den STUDENT.HSID
	MaLop char(20),--tham chieu den MONHOC.MaLop
	LoaiTien nvarchar(50), --tham chieu toi LOAIPHIEUTHU.LoaiPhieuThu
	SoTienDong int,
	Ngay DATE,
	Gio TIME
	CONSTRAINT PK_LICHSUDONGTIEN PRIMARY KEY (HSID, Ngay, Gio)
)

-------------------GIANG VIEN--------------------
--thong tin giang vien
CREATE TABLE dbo.GIANGVIEN
(
	GvID CHAR(20) PRIMARY KEY,
	--foreign key -> ACC.username
	USERNAME char(100) NOT NULL,
	HOTEN NVARCHAR(100) NOT NULL,
	GIOITINH NVARCHAR(20) NULL,
	NGAYSINH DATE NULL,
	DIACHI NVARCHAR(4000) NULL,
	SDT CHAR(20) NULL,
	CMND CHAR(20) NULL,
	EMAIL CHAR(100) NULL,
	AVATAR IMAGE NULL
)
--Bảng phân công
CREATE TABLE dbo.PHANCONG
(
	MaMon char(20),--tham chieu toi MonHoc.MaMon
	GvID char(20), --tham chieu toi GIANGVIEN.GvID
	CONSTRAINT PK_PHANCONG PRIMARY KEY (MaMon, GvID)
)

---------------------------NHAN VIEN----------------------
--thong tin giang vien
CREATE TABLE dbo.NHANVIEN
(
	NVID CHAR(20) PRIMARY KEY,
	--foreign key -> ACC.username
	USERNAME char(100) NOT NULL,
	HOTEN NVARCHAR(100) NOT NULL,
	GIOITINH NVARCHAR(20) NULL,
	NGAYSINH DATE NULL,
	DIACHI NVARCHAR(4000) NULL,
	SDT CHAR(20) NULL,
	CMND CHAR(20) NULL,
	EMAIL CHAR(100) NULL,
	AVATAR IMAGE NULL
)
SELECT *FROM GIAOVIEN
select NVID ,HOTEN ,GIOITINH from NHANVIEN where HOTEN like '%N%'
SELECT * FROM NHANVIEN
INSERT INTO NHANVIEN(NVID,USERNAME, HOTEN,GIOITINH,NGAYSINH,DIACHI,SDT,CMND,EMAIL) VALUES 
('admin1','passadmin1')


------Tạo bảng AllPeople( gồm tất cả cả mssv, msgv, msnv trong 1 bảng mới) == select into ...
-----------------------------GV + NV-------------------------
--Bảng lương
CREATE TABLE dbo.BANGLUONG
(
	ID char(20) PRIMARY KEY, --tham chieu toi ALlPeople.ID
	Luong int,
	PhuCap int,
	TienThuong int,
	TienBaoHiem int
)

--Bảng nhận tiền lương,thưởng, ứng lương...
CREATE TABLE dbo.LICHSUGIAODICH
(
	ID char(20),
	LoaiTienKhac nvarchar(50),-- tham chieu toi LOAIPHIEUCHI.LoaiPhieuChi
	SoTienGiaoDich int,
	Ngay DATE,
	Gio TIME
	CONSTRAINT PK_LICHSUGIAODICH PRIMARY KEY (ID, Ngay, Gio)
)

---------------------------THU CHI----------------------
--Các loại phiếu thu
CREATE TABLE dbo.LOAIPHIEUTHU
(
	LoaiPhieuThu nvarchar(50) PRIMARY KEY
)
--Các loại phiếu chi
CREATE TABLE dbo.LOAIPHIEUCHI
(
	LoaiPhieuChi nvarchar(50) PRIMARY KEY
)
--Bảng thu phiếu
CREATE TABLE dbo.PHIEUTHU
(
	MaPT char(20) PRIMARY KEY,
	LoaiPT nvarchar(50), --tham chieu toi LOAIPHIEUTHU.LoaiPhieuThu
	NguoiThu nvarchar(100) NULL--tham chieu toi NHANVIEN.HOTEN (nếu có)

)
--Bảng phiếu chi
CREATE TABLE dbo.PHIEUCHI
(
	MaPC char(20) PRIMARY KEY,
	LoaiPC nvarchar(50), --tham chieu toi LOAIPHIEUCHI.LoaiPhieuChi
)