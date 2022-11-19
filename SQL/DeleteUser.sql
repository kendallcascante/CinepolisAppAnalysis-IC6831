DELIMITER //
 DROP PROCEDURE IF EXISTS DeleteUser;
CREATE PROCEDURE DeleteUser(
    IN pUser INT
)
BEGIN
	DELETE FROM users WHERE UserId = pUser;
    DELETE FROM vaccinesperuser WHERE UserId = pUser;
    DELETE FROM shoppingcarts WHERE UserId = pUser;
    UPDATE seatsperfunction
    SET UserId = NULL, Avaliable = 1
	WHERE UserId = pUser;
END//
DELIMITER ;