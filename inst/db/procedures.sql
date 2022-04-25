USE stanford_policing;

DROP procedure IF EXISTS create_person;
DELIMITER //

CREATE PROCEDURE create_person(IN number INT UNSIGNED, IN age TINYINT UNSIGNED, IN race VARChAR(50), IN sex VARCHAR(6))
BEGIN
	DECLARE sql_error INT DEFAULT FALSE;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET sql_error = TRUE;

    START TRANSACTION;
        INSERT INTO persons (raw_row_number, subject_age, subject_race, subject_sex)
        VALUES (number, age, race, sex);
    IF sql_error = FALSE THEN
		COMMIT;
        SELECT "The transaction was committed." as ret;
	ELSE
		ROLLBACK;
        SELECT ERRORS as error;
	END IF;
END//

DELIMITER ;

CALL create_person( 3092230, 120, "haha", "lol");
