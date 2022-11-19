
DELIMITER //
CREATE PROCEDURE getData(
    IN pId INT
)
BEGIN
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
	SELECT vaccines.Name, vaccinesperuser.Date INTO @name1, @date1 FROM vaccinesperuser 
	INNER JOIN vaccines ON vaccinesperuser.VaccinesId = vaccines.VaccinesId
	WHERE  vaccinesperuser.UserId = pId ORDER BY vaccinesperuser.Date ASC LIMIT 1;
	SELECT vaccines.Name, vaccinesperuser.Date INTO @name2, @date2 FROM vaccinesperuser 
	INNER JOIN vaccines ON vaccinesperuser.VaccinesId = vaccines.VaccinesId
	WHERE  vaccinesperuser.UserId = pId ORDER BY vaccinesperuser.Date DESC LIMIT 1;
	SELECT Users.UserId,Users.Name, Users.LastName1, Users.LastName2, Users.Email,Users.Birthdate, Users.PersonalId, @name1 as vac1, @date1 as date1,@name2 as vac2, @date2 as date2, Users.Admin  FROM Users
	WHERE Users.UserId = pId;
    
END//
DELIMITER ;