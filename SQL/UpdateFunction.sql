
DELIMITER //UpdateFunction
CREATE PROCEDURE UpdateFunction(
	IN pFunction INT,
	IN pMovie INT,
    IN pCinemaRoomId INT,
    IN pDateTime NVARCHAR(100),
	IN pLanguageId INT
    
)
BEGIN
	UPDATE functions 
    SET MovieId = pMovie,CinemaRoomId = pCinemaRoomId,FunctionDate = str_to_date(pDateTime,"%d/%m/%Y %k:%i:%s"),LanguageId = pLanguageId
    WHERE FunctionId = pFunction;
    SELECT * from functions where FunctionId = pFunction;
END//
DELIMITER ;