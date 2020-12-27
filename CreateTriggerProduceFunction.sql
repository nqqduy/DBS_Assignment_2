-- Rang buoc boi trigger
DELIMITER $$
-- Trigger BienBanNhanHang
DROP TRIGGER IF EXISTS CongTyVanChuyen.trigger_insert_BienBanNhanHang$$
CREATE TRIGGER CongTyVanChuyen.trigger_insert_BienBanNhanHang BEFORE INSERT ON CongTyVanChuyen.BienBanNhanHang
FOR EACH ROW 
BEGIN
DECLARE ngayGui DATE;
SELECT NgayGui FROM CongTyVanChuyen.BienBangHang
WHERE IdBienBan = NEW.IdBbanN
INTO ngayGui;
IF (NEW.NgayNhan <= ngayGui) THEN 
	SIGNAL SQLSTATE '10001'
		SET MESSAGE_TEXT = 'Ngay nhan hang phai dien ra sau ngay gui hang!!!';
ELSEIF (EXISTS(SELECT * FROM CongTyVanChuyen.BienBanGuiHang
WHERE IdBbanG = NEW.IdBbanN)) THEN 
	SIGNAL SQLSTATE '10002'
		SET MESSAGE_TEXT = 'Id cua bien ban nay da ton tai o bien ban nhan gui!!!';
END IF; 
END$$
DROP TRIGGER IF EXISTS CongTyVanChuyen.trigger_update_BienBanNhanHang$$
CREATE TRIGGER CongTyVanChuyen.trigger_update_BienBanNhanHang BEFORE UPDATE ON CongTyVanChuyen.BienBanNhanHang
FOR EACH ROW 
BEGIN
DECLARE ngayGui DATE;
SELECT NgayGui FROM CongTyVanChuyen.BienBangHang
WHERE IdBienBan = NEW.IdBbanN
INTO ngayGui;
IF (NEW.NgayNhan <= ngayGui) THEN 
	SIGNAL SQLSTATE '10001'
		SET MESSAGE_TEXT = 'Ngay nhan hang phai dien ra sau ngay gui hang!!!';
END IF; 
END$$
-- Trigger BienBanGuiHang
DROP TRIGGER IF EXISTS CongTyVanChuyen.trigger_insert_BienBanGuiHang$$
CREATE TRIGGER CongTyVanChuyen.trigger_insert_BienBanGuiHang BEFORE INSERT ON CongTyVanChuyen.BienBanGuiHang
FOR EACH ROW 
BEGIN
IF (EXISTS(SELECT * FROM CongTyVanChuyen.BienBanNhanHang
WHERE IdBbanN = NEW.IdBbanG)) THEN 
	SIGNAL SQLSTATE '10001'
		SET MESSAGE_TEXT = 'Id cua bien ban nay da ton tai o bien ban nhan hang!!!';
END IF; 
END$$
-- Trigger CuocXeLienTinh
DROP TRIGGER IF EXISTS CongTyVanChuyen.trigger_insert_CuocXeLienTinh$$
CREATE TRIGGER CongTyVanChuyen.trigger_insert_CuocXeLienTinh BEFORE INSERT ON CongTyVanChuyen.CuocXeLienTinh
FOR EACH ROW 
BEGIN
DECLARE ngayDi DATE;
SELECT NgayDi FROM CongTyVanChuyen.ThongTinCuocXe
WHERE IdCuocXe = NEW.IdCuocXeLt
INTO ngayDi;
IF (NEW.NgayDen <= ngayDi) THEN 
	SIGNAL SQLSTATE '10002'
		SET MESSAGE_TEXT = 'Ngay den cua cuoc xe lien tinh phai dien ra sau ngay di!!!';
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
	SIGNAL SQLSTATE '10002'
		SET MESSAGE_TEXT = 'Ngay den cua cuoc xe lien tinh phai dien ra sau ngay di!!!';
END IF; 
END$$
DELIMITER ;