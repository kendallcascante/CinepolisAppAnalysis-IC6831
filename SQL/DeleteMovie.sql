
DELIMITER //
 DROP PROCEDURE IF EXISTS DeleteMovie;
CREATE PROCEDURE DeleteMovie(
    IN pMovie INT
)
BEGIN
	DELETE FROM Movies WHERE MovieId = pMovie;
    DELETE FROM functions WHERE MovieId = pMovie;
END//
DELIMITER ;