DELIMITER $$
-- Function

DROP FUNCTION IF EXISTS CongTyVanChuyen.txtLoaiNv$$
CREATE FUNCTION CongTyVanChuyen.txtLoaiNv(
	sym_loaiNv CHAR(2)
) 
RETURNS VARCHAR(32)
DETERMINISTIC
BEGIN
	DECLARE loaiNv VARCHAR(32);

	IF (STRCMP(sym_loaiNv, 'QK')) THEN
		SET loaiNv = 'Quản lý kho';
	ELSEIF (STRCMP(sym_loaiNv, 'NX')) THEN
		SET loaiNv = 'Nhân viên nhập xuất';
	ELSEIF (STRCMP(sym_loaiNv, 'KT')) THEN
		SET loaiNv = 'Kế toán';
	ELSEIF (STRCMP(sym_loaiNv, 'TV')) THEN
		SET loaiNv = 'Tạp vụ';
	ELSEIF (STRCMP(sym_loaiNv, 'QL')) THEN
		SET loaiNv = 'Quản lý chính';
	END IF;
	RETURN (loaiNv);
END$$

DROP FUNCTION IF EXISTS CongTyVanChuyen.txtTrangThai$$
CREATE FUNCTION CongTyVanChuyen.txtTrangThai(
	sym_TrangThai CHAR(2)
) 
RETURNS VARCHAR(32)
DETERMINISTIC
BEGIN
	DECLARE trangThai VARCHAR(32);

	IF (STRCMP(sym_TrangThai, 'HD')) THEN
		SET trangThai = 'Hoạt động';
	ELSEIF (STRCMP(sym_TrangThai, 'DX')) THEN
		SET trangThai = 'Đã xóa';
	END IF;
	RETURN (trangThai);
END$$

DROP FUNCTION IF EXISTS CongTyVanChuyen.txtTrangThaiPt$$
CREATE FUNCTION CongTyVanChuyen.txtTrangThaiPt(
	sym_TrangThaiPt CHAR(2)
) 
RETURNS VARCHAR(32)
DETERMINISTIC
BEGIN
	DECLARE trangThaiPt VARCHAR(32);

	IF (STRCMP(sym_TrangThaiPt, 'HD')) THEN
		SET trangThaiPt = 'Đang hoạt động';
	ELSEIF (STRCMP(sym_TrangThaiPt, 'SS')) THEN
		SET trangThaiPt = 'Sẵn sàng';
	ELSEIF (STRCMP(sym_TrangThaiPt, 'BD')) THEN
		SET trangThaiPt = 'Đang bảo dưỡng';
	END IF;
	RETURN (trangThaiPt);
END$$

DROP FUNCTION IF EXISTS CongTyVanChuyen.tinhDoanhThuNam$$
CREATE FUNCTION CongTyVanChuyen.tinhDoanhThuNam(
	nam INT
) 
RETURNS DECIMAL(10, 2)
READS SQL DATA
NOT DETERMINISTIC
BEGIN
	DECLARE doanhThu DECIMAL(10, 2);
    SELECT SUM(CxNoiThanh.DoanhThu) INTO doanhThu
    FROM CongTyVanChuyen.CxNoiThanh WHERE YEAR(NgayDi) = nam;
	RETURN (doanhThu);
END$$

-- Procedure query
DROP PROCEDURE IF EXISTS CongTyVanChuyen.searchNhanVien$$
CREATE PROCEDURE CongTyVanChuyen.searchNhanVien(
	IN		searchStr		VARCHAR(64),
    -- kieuNv 0 Nhan vien van chuyen, 1 Nhan vien kho, 2 ca 2 kieu
    IN		kieuNv			INT,
    -- coSapXep -1 sap xe theo chieu giam DEC 0 khong sap xep, 1 co sap xep theo chieu tang ASC
    IN		coSapXep		INT
)
BEGIN
IF (kieuNv = 0) THEN
	SELECT IdNhanVien, Cccd, HoTen, 'Nhân viên vận chuyển' AS KieuNv, DiaChiNha, Tinh, Email, GioiTinh, NgaySinh, Luong, MatKhau, TrangThaiNv FROM CongTyVanChuyen.NhanVien
    RIGHT JOIN CongTyVanChuyen.NhanVienVanChuyen
    ON IdNhanVien = IdNvVc
	WHERE HoTen LIKE CONCAT('%', searchStr, '%')
	ORDER BY
		CASE coSapXep WHEN -1 THEN HoTen END DESC,
		CASE coSapXep WHEN 0 THEN 1 END ASC,
		CASE coSapXep WHEN 1 THEN HoTen END ASC;
ELSEIF (kieuNv = 1) THEN
	SELECT IdNhanVien, Cccd, HoTen, 'Nhân viên kho' AS KieuNv, DiaChiNha, Tinh, Email, GioiTinh, NgaySinh, Luong, MatKhau, TrangThaiNv FROM CongTyVanChuyen.NhanVien
    RIGHT JOIN CongTyVanChuyen.NhanVienKho
    ON IdNhanVien = IdNvKho
	WHERE HoTen LIKE CONCAT('%', searchStr, '%')
	ORDER BY
		CASE coSapXep WHEN -1 THEN HoTen END DESC,
		CASE coSapXep WHEN 0 THEN 1 END ASC,
		CASE coSapXep WHEN 1 THEN HoTen END ASC;
ELSE
	SELECT NvKho.* FROM
	(SELECT IdNhanVien, Cccd, HoTen, 'Nhân viên kho' AS KieuNv, DiaChiNha, Tinh, Email, GioiTinh, NgaySinh, Luong, MatKhau, TrangThaiNv FROM CongTyVanChuyen.NhanVien
    RIGHT JOIN CongTyVanChuyen.NhanVienKho
    ON IdNhanVien = IdNvKho
	WHERE HoTen LIKE CONCAT('%', searchStr, '%')) AS NvKho
	UNION ALL
    SELECT NvVc.* FROM
    (SELECT IdNhanVien, Cccd, HoTen, 'Nhân viên vận chuyển' AS KieuNv, DiaChiNha, Tinh, Email, GioiTinh, NgaySinh, Luong, MatKhau, TrangThaiNv FROM CongTyVanChuyen.NhanVien
    RIGHT JOIN CongTyVanChuyen.NhanVienVanChuyen
    ON IdNhanVien = IdNvVc
	WHERE HoTen LIKE CONCAT('%', searchStr, '%')) AS NvVc
	ORDER BY
		CASE coSapXep WHEN -1 THEN HoTen END DESC,
		CASE coSapXep WHEN 0 THEN 1 END ASC,
		CASE coSapXep WHEN 1 THEN HoTen END ASC;
END IF;
END$$

DROP PROCEDURE IF EXISTS CongTyVanChuyen.doanhThuNam$$
CREATE PROCEDURE CongTyVanChuyen.doanhThuNam(
	IN		nam				INT,
    -- dangBieuDo 0 chi moi doanh thu, 1 co xuat bieu do 12 thang
    IN		dangBieuDo		INT,
    OUT		doanhThu		DECIMAL(10, 2)
)
BEGIN
SET doanhThu = tinhDoanhThuNam(nam);
IF (dangBieuDo = 1) THEN
	SELECT SUM(CxNoiThanh.DoanhThu), MONTH(NgayDi) AS Thang FROM CongTyVanChuyen.CxNoiThanh
	WHERE YEAR(NgayDi) = nam
    GROUP BY Thang;
END IF;
END$$

-- Rang buoc boi trigger
-- Insert

DROP TRIGGER IF EXISTS CongTyVanChuyen.trigger_insert_BienBanNhanHang$$
CREATE TRIGGER CongTyVanChuyen.trigger_insert_BienBanNhanHang BEFORE INSERT ON CongTyVanChuyen.BienBanNhanHang
FOR EACH ROW 
BEGIN
DECLARE ngayGui DATE;
SELECT NgayGui FROM CongTyVanChuyen.BienBanHang
WHERE IdBienBan = NEW.IdBbanN
INTO ngayGui;
IF (NEW.NgayNhan <= ngayGui) THEN 
	SIGNAL SQLSTATE '10001'
		SET MESSAGE_TEXT = 'Ngay nhan hang phai dien ra sau ngay gui hang!!!';
ELSEIF (EXISTS(SELECT * FROM CongTyVanChuyen.BienBanGuiHang WHERE IdBbanG = NEW.IdBbanN)) THEN
	SIGNAL SQLSTATE '10002'
		SET MESSAGE_TEXT = 'Id cua bien ban nay da ton tai o bien ban nhan gui!!!';
END IF;
END$$

DROP TRIGGER IF EXISTS CongTyVanChuyen.trigger_insert_BienBanGuiHang$$
CREATE TRIGGER CongTyVanChuyen.trigger_insert_BienBanGuiHang BEFORE INSERT ON CongTyVanChuyen.BienBanGuiHang
FOR EACH ROW 
BEGIN
IF (EXISTS(SELECT * FROM CongTyVanChuyen.BienBanNhanHang WHERE IdBbanN = NEW.IdBbanG)) THEN 
	SIGNAL SQLSTATE '10003'
		SET MESSAGE_TEXT = 'Id cua bien ban nay da ton tai o bien ban nhan hang!!!';
END IF; 
END$$

DROP TRIGGER IF EXISTS CongTyVanChuyen.trigger_insert_CuocXeLienTinh$$
CREATE TRIGGER CongTyVanChuyen.trigger_insert_CuocXeLienTinh BEFORE INSERT ON CongTyVanChuyen.CuocXeLienTinh
FOR EACH ROW 
BEGIN
DECLARE ngayDi DATE;
SELECT NgayDi FROM CongTyVanChuyen.ThongTinCuocXe
WHERE IdCuocXe = NEW.IdCuocXeLt
INTO ngayDi;
IF (NEW.NgayDen <= ngayDi) THEN 
	SIGNAL SQLSTATE '10004'
		SET MESSAGE_TEXT = 'Ngay den cua cuoc xe lien tinh phai dien ra sau ngay di!!!';
ELSEIF (EXISTS(SELECT * FROM CongTyVanChuyen.CuocXeNoiThanh WHERE IdCuocXeNt = NEW.IdCuocXeLt)) THEN
	SIGNAL SQLSTATE '10005'
		SET MESSAGE_TEXT = 'Id cua cuoc xe nay da ton tai o cuoc xe noi thanh!!!';
END IF;
END$$

DROP TRIGGER IF EXISTS CongTyVanChuyen.trigger_insert_CuocXeNoiThanh$$
CREATE TRIGGER CongTyVanChuyen.trigger_insert_CuocXeNoiThanh BEFORE INSERT ON CongTyVanChuyen.CuocXeNoiThanh
FOR EACH ROW
BEGIN
IF (EXISTS(SELECT * FROM CongTyVanChuyen.CuocXeLienTinh WHERE IdCuocXeLt = NEW.IdCuocXeNt)) THEN
	SIGNAL SQLSTATE '10006'
		SET MESSAGE_TEXT = 'Id cua cuoc xe nay da ton tai o cuoc xe lien tinh!!!';
END IF;
END$$

DROP TRIGGER IF EXISTS CongTyVanChuyen.trigger_insert_ThongTinNhapHang$$
CREATE TRIGGER CongTyVanChuyen.trigger_insert_ThongTinNhapHang BEFORE INSERT ON CongTyVanChuyen.ThongTinNhapHang
FOR EACH ROW
BEGIN
IF (EXISTS(SELECT * FROM CongTyVanChuyen.ThongTinXuatHang WHERE IdTtinXuat = NEW.IdTtinNhap)) THEN
	SIGNAL SQLSTATE '10007'
		SET MESSAGE_TEXT = 'Id cua thong tin hang nay da ton tai o thong tin xuat hang!!!';
END IF;
END$$

DROP TRIGGER IF EXISTS CongTyVanChuyen.trigger_insert_ThongTinXuatHang$$
CREATE TRIGGER CongTyVanChuyen.trigger_insert_ThongTinXuatHang BEFORE INSERT ON CongTyVanChuyen.ThongTinXuatHang
FOR EACH ROW
BEGIN
IF (EXISTS(SELECT * FROM CongTyVanChuyen.ThongTinNhapHang WHERE IdTtinNhap = NEW.IdTtinXuat)) THEN
	SIGNAL SQLSTATE '10008'
		SET MESSAGE_TEXT = 'Id cua thong tin hang nay da ton tai o thong tin nhap hang!!!';
END IF;
END$$

DROP TRIGGER IF EXISTS CongTyVanChuyen.trigger_insert_NhanVienKho$$
CREATE TRIGGER CongTyVanChuyen.trigger_insert_NhanVienKho BEFORE INSERT ON CongTyVanChuyen.NhanVienKho
FOR EACH ROW
BEGIN
IF (EXISTS(SELECT * FROM CongTyVanChuyen.NhanVienVanChuyen WHERE IdNvVc = NEW.IdNvKho)) THEN
	SIGNAL SQLSTATE '10009'
		SET MESSAGE_TEXT = 'Id cua nhan vien nay da ton tai o nhan vien van chuyen!!!';
END IF;
END$$

DROP TRIGGER IF EXISTS CongTyVanChuyen.trigger_insert_NhanVienVanChuyen$$
CREATE TRIGGER CongTyVanChuyen.trigger_insert_NhanVienVanChuyen BEFORE INSERT ON CongTyVanChuyen.NhanVienVanChuyen
FOR EACH ROW
BEGIN
IF (EXISTS(SELECT * FROM CongTyVanChuyen.NhanVienKho WHERE IdNvKho = NEW.IdNvVc)) THEN
	SIGNAL SQLSTATE '10010'
		SET MESSAGE_TEXT = 'Id cua nhan vien nay da ton tai o nhan vien kho!!!';
END IF;
END$$

-- Update

DROP TRIGGER IF EXISTS CongTyVanChuyen.trigger_update_BienBanNhanHang$$
CREATE TRIGGER CongTyVanChuyen.trigger_update_BienBanNhanHang BEFORE UPDATE ON CongTyVanChuyen.BienBanNhanHang
FOR EACH ROW 
BEGIN
DECLARE ngayGui DATE;
SELECT NgayGui FROM CongTyVanChuyen.BienBanHang
WHERE IdBienBan = NEW.IdBbanN
INTO ngayGui;
IF (NEW.NgayNhan <= ngayGui) THEN 
	SIGNAL SQLSTATE '10001'
		SET MESSAGE_TEXT = 'Ngay nhan hang phai dien ra sau ngay gui hang!!!';
ELSEIF (EXISTS(SELECT * FROM CongTyVanChuyen.BienBanGuiHang WHERE IdBbanG = NEW.IdBbanN)) THEN
	SIGNAL SQLSTATE '10002'
		SET MESSAGE_TEXT = 'Id cua bien ban nay da ton tai o bien ban nhan gui!!!';
END IF;
END$$

DROP TRIGGER IF EXISTS CongTyVanChuyen.trigger_update_BienBanGuiHang$$
CREATE TRIGGER CongTyVanChuyen.trigger_update_BienBanGuiHang BEFORE UPDATE ON CongTyVanChuyen.BienBanGuiHang
FOR EACH ROW 
BEGIN
IF (EXISTS(SELECT * FROM CongTyVanChuyen.BienBanNhanHang WHERE IdBbanN = NEW.IdBbanG)) THEN 
	SIGNAL SQLSTATE '10003'
		SET MESSAGE_TEXT = 'Id cua bien ban nay da ton tai o bien ban nhan hang!!!';
END IF; 
END$$

DROP TRIGGER IF EXISTS CongTyVanChuyen.trigger_update_CuocXeLienTinh$$
CREATE TRIGGER CongTyVanChuyen.trigger_update_CuocXeLienTinh BEFORE UPDATE ON CongTyVanChuyen.CuocXeLienTinh
FOR EACH ROW 
BEGIN
DECLARE ngayDi DATE;
SELECT NgayDi FROM CongTyVanChuyen.ThongTinCuocXe
WHERE IdCuocXe = NEW.IdCuocXeLt
INTO ngayDi;
IF (NEW.NgayDen <= ngayDi) THEN 
	SIGNAL SQLSTATE '10004'
		SET MESSAGE_TEXT = 'Ngay den cua cuoc xe lien tinh phai dien ra sau ngay di!!!';
ELSEIF (EXISTS(SELECT * FROM CongTyVanChuyen.CuocXeNoiThanh WHERE IdCuocXeNt = NEW.IdCuocXeLt)) THEN
	SIGNAL SQLSTATE '10005'
		SET MESSAGE_TEXT = 'Id cua cuoc xe nay da ton tai o cuoc xe noi thanh!!!';
END IF;
END$$

DROP TRIGGER IF EXISTS CongTyVanChuyen.trigger_update_CuocXeNoiThanh$$
CREATE TRIGGER CongTyVanChuyen.trigger_update_CuocXeNoiThanh BEFORE UPDATE ON CongTyVanChuyen.CuocXeNoiThanh
FOR EACH ROW
BEGIN
IF (EXISTS(SELECT * FROM CongTyVanChuyen.CuocXeLienTinh WHERE IdCuocXeLt = NEW.IdCuocXeNt)) THEN
	SIGNAL SQLSTATE '10006'
		SET MESSAGE_TEXT = 'Id cua cuoc xe nay da ton tai o cuoc xe lien tinh!!!';
END IF;
END$$

DROP TRIGGER IF EXISTS CongTyVanChuyen.trigger_update_ThongTinNhapHang$$
CREATE TRIGGER CongTyVanChuyen.trigger_update_ThongTinNhapHang BEFORE UPDATE ON CongTyVanChuyen.ThongTinNhapHang
FOR EACH ROW
BEGIN
IF (EXISTS(SELECT * FROM CongTyVanChuyen.ThongTinXuatHang WHERE IdTtinXuat = NEW.IdTtinNhap)) THEN
	SIGNAL SQLSTATE '10007'
		SET MESSAGE_TEXT = 'Id cua thong tin hang nay da ton tai o thong tin xuat hang!!!';
END IF;
END$$

DROP TRIGGER IF EXISTS CongTyVanChuyen.trigger_update_ThongTinXuatHang$$
CREATE TRIGGER CongTyVanChuyen.trigger_update_ThongTinXuatHang BEFORE UPDATE ON CongTyVanChuyen.ThongTinXuatHang
FOR EACH ROW
BEGIN
IF (EXISTS(SELECT * FROM CongTyVanChuyen.ThongTinNhapHang WHERE IdTtinNhap = NEW.IdTtinXuat)) THEN
	SIGNAL SQLSTATE '10008'
		SET MESSAGE_TEXT = 'Id cua thong tin hang nay da ton tai o thong tin nhap hang!!!';
END IF;
END$$

DROP TRIGGER IF EXISTS CongTyVanChuyen.trigger_update_NhanVienKho$$
CREATE TRIGGER CongTyVanChuyen.trigger_update_NhanVienKho BEFORE UPDATE ON CongTyVanChuyen.NhanVienKho
FOR EACH ROW
BEGIN
IF (EXISTS(SELECT * FROM CongTyVanChuyen.NhanVienVanChuyen WHERE IdNvVc = NEW.IdNvKho)) THEN
	SIGNAL SQLSTATE '10009'
		SET MESSAGE_TEXT = 'Id cua nhan vien nay da ton tai o nhan vien van chuyen!!!';
END IF;
END$$

DROP TRIGGER IF EXISTS CongTyVanChuyen.trigger_update_NhanVienVanChuyen$$
CREATE TRIGGER CongTyVanChuyen.trigger_update_NhanVienVanChuyen BEFORE UPDATE ON CongTyVanChuyen.NhanVienVanChuyen
FOR EACH ROW
BEGIN
IF (EXISTS(SELECT * FROM CongTyVanChuyen.NhanVienKho WHERE IdNvKho = NEW.IdNvVc)) THEN
	SIGNAL SQLSTATE '10010'
		SET MESSAGE_TEXT = 'Id cua nhan vien nay da ton tai o nhan vien kho!!!';
END IF;
END$$

-- Delete

DROP TRIGGER IF EXISTS CongTyVanChuyen.trigger_delete_BienBanNhanHang$$
CREATE TRIGGER CongTyVanChuyen.trigger_delete_BienBanNhanHang BEFORE DELETE ON CongTyVanChuyen.BienBanNhanHang
FOR EACH ROW 
BEGIN
DELETE FROM CongTyVanChuyen.BienBanHang
WHERE IdBienBan = OLD.IdBbanN;
END$$

DROP TRIGGER IF EXISTS CongTyVanChuyen.trigger_delete_BienBanGuiHang$$
CREATE TRIGGER CongTyVanChuyen.trigger_delete_BienBanGuiHang BEFORE DELETE ON CongTyVanChuyen.BienBanGuiHang
FOR EACH ROW 
BEGIN
DELETE FROM CongTyVanChuyen.BienBanHang
WHERE IdBienBan = OLD.IdBbanG;
END$$

DROP TRIGGER IF EXISTS CongTyVanChuyen.trigger_delete_CuocXeLienTinh$$
CREATE TRIGGER CongTyVanChuyen.trigger_delete_CuocXeLienTinh BEFORE DELETE ON CongTyVanChuyen.CuocXeLienTinh
FOR EACH ROW 
BEGIN
DELETE FROM CongTyVanChuyen.ThongTinCuocXe
WHERE IdCuocXe = OLD.IdCuocXeLt;
END$$

DROP TRIGGER IF EXISTS CongTyVanChuyen.trigger_delete_CuocXeNoiThanh$$
CREATE TRIGGER CongTyVanChuyen.trigger_delete_CuocXeNoiThanh BEFORE DELETE ON CongTyVanChuyen.CuocXeNoiThanh
FOR EACH ROW
BEGIN
DELETE FROM CongTyVanChuyen.ThongTinCuocXe
WHERE IdCuocXe = OLD.IdCuocXeNt;
END$$

DROP TRIGGER IF EXISTS CongTyVanChuyen.trigger_delete_ThongTinNhapHang$$
CREATE TRIGGER CongTyVanChuyen.trigger_delete_ThongTinNhapHang BEFORE DELETE ON CongTyVanChuyen.ThongTinNhapHang
FOR EACH ROW
BEGIN
DELETE FROM CongTyVanChuyen.ThongTinHang
WHERE IdThongTin = OLD.IdTtinNhap;
END$$

DROP TRIGGER IF EXISTS CongTyVanChuyen.trigger_delete_ThongTinXuatHang$$
CREATE TRIGGER CongTyVanChuyen.trigger_delete_ThongTinXuatHang BEFORE DELETE ON CongTyVanChuyen.ThongTinXuatHang
FOR EACH ROW
BEGIN
DELETE FROM CongTyVanChuyen.ThongTinHang
WHERE IdThongTin = OLD.IdTtinXuat;
END$$

DROP TRIGGER IF EXISTS CongTyVanChuyen.trigger_delete_NhanVienKho$$
CREATE TRIGGER CongTyVanChuyen.trigger_delete_NhanVienKho BEFORE DELETE ON CongTyVanChuyen.NhanVienKho
FOR EACH ROW
BEGIN
DELETE FROM CongTyVanChuyen.NhanVien
WHERE IdNhanVien = OLD.IdNvKho;
END$$

DROP TRIGGER IF EXISTS CongTyVanChuyen.trigger_delete_NhanVienVanChuyen$$
CREATE TRIGGER CongTyVanChuyen.trigger_delete_NhanVienVanChuyen BEFORE DELETE ON CongTyVanChuyen.NhanVienVanChuyen
FOR EACH ROW
BEGIN
DELETE FROM CongTyVanChuyen.NhanVien
WHERE IdNhanVien = OLD.IdNvVc;
END$$

DELIMITER ;