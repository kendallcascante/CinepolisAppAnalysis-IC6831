
DELIMITER //
 DROP PROCEDURE IF EXISTS UpdateMovie;
CREATE PROCEDURE UpdateMovie(
	IN pMovie INT,
	IN pTitle NVARCHAR(100),
    IN pYear INT,
    IN pMinAge INT,
    IN pDuration INT,
    IN pDirector NVARCHAR(100),
    IN imgURL VARCHAR(100)
)
BEGIN
	DECLARE MovieInUSe INT DEFAULT(54000);
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
		GET DIAGNOSTICS CONDITION 1 @err_no = MYSQL_ERRNO, @message = MESSAGE_TEXT;
        -- si es un exception de sql, ambos campos vienen en el diagnostics
        -- pero si es una excepction forzada por el programador solo viene el ERRNO, el texto no
        IF (ISNULL(@message)) THEN -- quiere decir q es una excepcion forzada del programador
			SET @message = 'aqui saco el mensaje de un catalogo de mensajes que fue creado por equipo de desarrollo';            
        ELSE
			-- es un exception de SQL que no queremos que salga hacia la capa de aplicacion
            -- tengo que guardar el error en una bitácora de errores... patron de bitacora
            -- sustituyo el texto del mensaje
            SET @message = CONCAT('Internal error: ', @message);
        END IF;
        RESIGNAL SET MESSAGE_TEXT = @message;
	END;
	SELECT COUNT(*) INTO @movieRegisted FROM Movies WHERE Title = Title;
    IF  (@movieRegisted != 0)
    THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La pelicula ya está registrada', MYSQL_ERRNO = MailInUSe;
	END IF;
    SET @director = -1 ;
    SELECT ParticipantId INTO @director FROM Participants WHERE LOWER(ParticipantName) = LOWER(pDirector);
	IF  (@director = -1)
    THEN
		INSERT INTO Participants (ParticipantName) VALUES (pDirector);
		SELECT ParticipantId INTO @director FROM Participants WHERE LOWER(ParticipantName) = LOWER(pDirector) LIMIT 1;
	END IF;
    
    START TRANSACTION;
		UPDATE Movies 
        SET Title = pTitle ,Year = pYear ,MinAge = pMinAge ,Duration = pDuration ,ParticipantId = @director ,PictureURL = imgURL
        WHERE MovieId = pMovie;
	COMMIT;
		SELECT MovieId FROM Movies WHERE pTitle = Title;
END//
DELIMITER ;