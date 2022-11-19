
DELIMITER //
DROP PROCEDURE IF EXISTS AddFunction;
CREATE PROCEDURE AddFunction(
	IN pMovie INT,
    IN pCinemaRoomId INT,
    IN pDateTime NVARCHAR(100),
	IN pLanguageId INT
    
)
BEGIN
	DECLARE done INT DEFAULT FALSE;
    DECLARE cur_seatId INT;
    DECLARE cur_pos varchar(5);
    DECLARE cur CURSOR FOR SELECT * FROM Seats;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
		GET DIAGNOSTICS CONDITION 1 @err_no = MYSQL_ERRNO, @message = MESSAGE_TEXT;
        IF (ISNULL(@message)) THEN
			SET @message = 'Se ha producido un error';            
        ELSE
            SET @message = CONCAT('Internal error: ', @message);
        END IF;
        ROLLBACK;
        RESIGNAL SET MESSAGE_TEXT = @message;
	END;
	INSERT INTO functions (MovieId,CinemaRoomId,FunctionDate,CinemaId,LanguageId)
	VALUES (pMovie,pCinemaRoomId,str_to_date(pDateTime,"%d/%m/%Y %k:%i:%s"),0,pLanguageId);
	OPEN cur;
	insertSeats: LOOP
		FETCH cur INTO cur_seatId,cur_pos;
		IF done THEN 
			LEAVE insertSeats;
		END IF;
		INSERT INTO seatsperfunction(FunctionId,SeatsId,UserId,Avaliable) VALUES ((SELECT MAX(FunctionId) FROM functions),cur_seatId,NULL,1);
	END LOOP insertSeats;
    CLOSE cur;
END//
DELIMITER ;