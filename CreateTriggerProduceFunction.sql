DELIMITER $$
DROP TRIGGER IF EXISTS CongTyVanChuyen.TrigKmTraDnThoai$$

CREATE TRIGGER CongTyVanChuyen.TrigKmTraDnThoai BEFORE INSERT ON CongTyVanChuyen.data
FOR EACH ROW 
BEGIN 
IF (NEW.phone REGEXP '^0[0-9]{9}$' ) = 0 THEN 
    SIGNAL SQLSTATE '12345'
        SET MESSAGE_TEXT = 'The phone number must have 10 digits and begin with 0!!!';
END IF; 
END$$
DELIMITER ;

INSERT INTO CongTyVanChuyen.data VALUES ('08524567889');