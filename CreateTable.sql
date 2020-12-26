CREATE SCHEMA IF NOT EXISTS CongTyVanChuyen;
-- NhanVien
CREATE TABLE IF NOT EXISTS CongTyVanChuyen.NhanVien (
    IdNhanVien  INT             NOT NULL,
    Cccd        CHAR(12)        NOT NULL,
    HoTen       VARCHAR(64),
    DiaChiNha   VARCHAR(32),
    Tinh        VARCHAR(32),
    Email       VARCHAR(128),
    GioiTinh    CHAR,
    NgaySinh    DATE,
    Luong       DECIMAL(10, 2),
    MatKhau     CHAR(64),
    TrangThaiNv CHAR(2),
    PRIMARY KEY(IdNhanVien),
    UNIQUE(Cccd)
);
CREATE TABLE IF NOT EXISTS CongTyVanChuyen.DienThoaiNv (
    IdNv        INT             NOT NULL,
    DienThoai   CHAR(10)        NOT NULL,
    PRIMARY KEY(IdNv, DienThoai),
    FOREIGN KEY(IdNv) REFERENCES CongTyVanChuyen.NhanVien(IdNhanVien)
);
CREATE TABLE IF NOT EXISTS CongTyVanChuyen.NhanVienVanChuyen (
    IdNvVc      INT             NOT NULL,
    LoaiBgLai   VARCHAR(3)      NOT NULL,
    NgayCap     DATE            NOT NULL,
    PRIMARY KEY(IdNvVc),
    FOREIGN KEY(IdNvVc) REFERENCES CongTyVanChuyen.NhanVien(IdNhanVien)
);
SET FOREIGN_KEY_CHECKS = 0;
CREATE TABLE IF NOT EXISTS CongTyVanChuyen.NhanVienKho (
    IdNvKho     INT             NOT NULL,
    IdKhoLam    INT             NOT NULL,
    LoaiNv      CHAR(2),
    PRIMARY KEY(IdNvKho),
    FOREIGN KEY(IdNvKho) REFERENCES CongTyVanChuyen.NhanVien(IdNhanVien),
    FOREIGN KEY(IdKhoLam) REFERENCES CongTyVanChuyen.Kho(IdKho)
);
-- Kho
CREATE TABLE IF NOT EXISTS CongTyVanChuyen.Kho (
    IdKho       INT             NOT NULL,
    TenKho      VARCHAR(32),
    Tinh        VARCHAR(32),
    DienTich    DECIMAL(10, 2),
    IdQuanLy    INT             NOT NULL,
    TrangThaiKho    CHAR(2),
    SucChua     INT,
    SucChuaHt   INT,
    PRIMARY KEY(IdKho),
    FOREIGN KEY(IdQuanLy) REFERENCES CongTyVanChuyen.NhanVienKho(IdNvKho)
);
-- KhachHang
SET FOREIGN_KEY_CHECKS = 1;
CREATE TABLE IF NOT EXISTS CongTyVanChuyen.KhachHang (
    IdKhachHang INT             NOT NULL,
    HoTen       VARCHAR(64),
    DiaChiNha   VARCHAR(32),
    Tinh        VARCHAR(32),
    DienThoai   CHAR(10),
    PRIMARY KEY(IdKhachHang)
);
-- YeuCau
CREATE TABLE IF NOT EXISTS CongTyVanChuyen.YeuCau (
    IdNgYc      INT             NOT NULL,
    IdYeuCau    INT             NOT NULL,
    TrangThaiYc CHAR(2),
    KhoiLuongH  INT,
    LoaiH       VARCHAR(15),
    SoH         INT,
    PRIMARY KEY(IdNgYc, IdYeuCau),
    FOREIGN KEY(IdNgYc) REFERENCES CongTyVanChuyen.KhachHang(IdKhachHang)
);
-- PhuongTien
CREATE TABLE IF NOT EXISTS CongTyVanChuyen.PhuongTien (
    IdPhuongTien    INT         NOT NULL,
    BienSo      INT,
    TrangThaiPt CHAR(2),
    PRIMARY KEY(IdPhuongTien)
);
-- ThongTinCuocXe
CREATE TABLE IF NOT EXISTS CongTyVanChuyen.ThongTinCuocXe (
    IdCuocXe    INT             NOT NULL,
    NgayDi      DATE,
    IdPhTien    INT             NOT NULL,
    IdNgLai     INT             NOT NULL,
    IdNgPhuLai  INT             NOT NULL,
    PRIMARY KEY(IdCuocXe),
    FOREIGN KEY(IdPhTien) REFERENCES CongTyVanChuyen.PhuongTien(IdPhuongTien),
    FOREIGN KEY(IdNgLai) REFERENCES CongTyVanChuyen.NhanVienVanChuyen(IdNvVc),
    FOREIGN KEY(IdNgPhuLai) REFERENCES CongTyVanChuyen.NhanVienVanChuyen(IdNvVc)
);
CREATE TABLE IF NOT EXISTS CongTyVanChuyen.CuocXeNoiThanh (
    IdCuocXeNt  INT             NOT NULL,
    DoanhThu    DECIMAL(10, 2),
    PRIMARY KEY(IdCuocXeNt),
    FOREIGN KEY(IdCuocXeNt) REFERENCES CongTyVanChuyen.ThongTinCuocXe(IdCuocXe)
);
CREATE TABLE IF NOT EXISTS CongTyVanChuyen.CuocXeLienTinh (
    IdCuocXeLt  INT             NOT NULL,
    NgayDen     DATE,
    PRIMARY KEY(IdCuocXeLt),
    FOREIGN KEY(IdCuocXeLt) REFERENCES CongTyVanChuyen.ThongTinCuocXe(IdCuocXe)
);
-- KienHang
CREATE TABLE IF NOT EXISTS CongTyVanChuyen.KienHang (
    IdKienHang  INT             NOT NULL,
    TongKienHang    INT,
    KhoiLuongKh INT,
    PRIMARY KEY(IdKienHang)
);
-- ThongTinHang
CREATE TABLE IF NOT EXISTS CongTyVanChuyen.ThongTinHang (
    IdThongTin  INT             NOT NULL,
    PhiNx       DECIMAL(10, 2),
    LuongHh     INT,
    IdKhoX      INT             NOT NULL,
    IdKhoN      INT             NOT NULL,
    IdNvXuat    INT             NOT NULL,
    IdCxLt      INT             NOT NULL,
    PRIMARY KEY(IdThongTin),
    FOREIGN KEY(IdKhoX) REFERENCES CongTyVanChuyen.Kho(IdKho),
    FOREIGN KEY(IdKhoN) REFERENCES CongTyVanChuyen.Kho(IdKho),
    FOREIGN KEY(IdNvXuat) REFERENCES CongTyVanChuyen.NhanVienKho(IdNvKho),
    FOREIGN KEY(IdCxLt) REFERENCES CongTyVanChuyen.CuocXeLienTinh(IdCuocXeLt)
);
CREATE TABLE IF NOT EXISTS CongTyVanChuyen.ThongTinNhapHang (
    IdTtinNhap  INT             NOT NULL,
    IdNvNhap    INT             NOT NULL,
    PRIMARY KEY(IdTtinNhap),
    FOREIGN KEY(IdTtinNhap) REFERENCES CongTyVanChuyen.ThongTinHang(IdThongTin),
    FOREIGN KEY(IdNvNhap) REFERENCES CongTyVanChuyen.NhanVienKho(IdNvKho)
);
CREATE TABLE IF NOT EXISTS CongTyVanChuyen.ThongTinXuatHang (
    IdTtinXuat  INT             NOT NULL,
    PRIMARY KEY(IdTtinXuat),
    FOREIGN KEY(IdTtinXuat) REFERENCES CongTyVanChuyen.ThongTinHang(IdThongTin)
);
CREATE TABLE IF NOT EXISTS CongTyVanChuyen.KienHangNx (
    IdTtin      INT             NOT NULL,
    IdKnHang    INT             NOT NULL,
    PRIMARY KEY(IdTtin),
    FOREIGN KEY(IdTtin) REFERENCES CongTyVanChuyen.ThongTinHang(IdThongTin),
    FOREIGN KEY(IdKnHang) REFERENCES CongTyVanChuyen.KienHang(IdKienHang)
);
-- BienBangHang
CREATE TABLE IF NOT EXISTS CongTyVanChuyen.BienBangHang (
    IdBienBan   INT             NOT NULL,
    NgayGui     DATE,
    IdKhGn      INT             NOT NULL,
    IdCxNt      INT             NOT NULL,
    IdNgG       INT             NOT NULL,
    IdNgN       INT             NOT NULL,
    PRIMARY KEY(IdBienBan),
    FOREIGN KEY(IdKhGn) REFERENCES CongTyVanChuyen.KienHang(IdKienHang),
    FOREIGN KEY(IdCxNt) REFERENCES CongTyVanChuyen.CuocXeNoiThanh(IdCuocXeNt),
    FOREIGN KEY(IdNgG) REFERENCES CongTyVanChuyen.KhachHang(IdKhachHang),
    FOREIGN KEY(IdNgN) REFERENCES CongTyVanChuyen.KhachHang(IdKhachHang)
);
CREATE TABLE IF NOT EXISTS CongTyVanChuyen.BienBangGuiHang (
    IdBbanN     INT             NOT NULL,
    PhiGiaoHangNhan DECIMAL(10, 2),
    PhiLienTinh DECIMAL(10, 2),
    NgayNhan    DATE,
    IdKhoNhanTu INT             NOT NULL,
    PRIMARY KEY(IdBbanN),
    FOREIGN KEY(IdBbanN) REFERENCES CongTyVanChuyen.BienBangHang(IdBienBan),
    FOREIGN KEY(IdKhoNhanTu) REFERENCES CongTyVanChuyen.Kho(IdKho)
);
CREATE TABLE IF NOT EXISTS CongTyVanChuyen.BienBangNhanHang (
    IdBbanG     INT             NOT NULL,
    PhiLayHangGui   DECIMAL(10, 2),
    IdKhoGuiToi INT             NOT NULL,
    PRIMARY KEY(IdBbanG),
    FOREIGN KEY(IdBbanG) REFERENCES CongTyVanChuyen.BienBangHang(IdBienBan),
    FOREIGN KEY(IdKhoGuiToi) REFERENCES CongTyVanChuyen.Kho(IdKho)
);