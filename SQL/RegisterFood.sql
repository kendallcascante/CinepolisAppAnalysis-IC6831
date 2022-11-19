
DELIMITER //
 
CREATE PROCEDURE RegisterFoods(
	IN pName NVARCHAR(100),
    IN pQuantity INT,
    IN pPrice INT,
    IN pType INT
)
BEGIN
	DECLARE FoodInUSe INT DEFAULT(54000);
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
	SELECT COUNT(*) INTO @foodRegisted FROM Movies WHERE Title = Title;
    IF  (@movieRegisted != 0)
    THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La comida ya está registrada', MYSQL_ERRNO = MailInUSe;
	END IF;
    
    START TRANSACTION;
		INSERT INTO Foods VALUES (pName,pQuantitFoodsy, pPrice, pType);
	COMMIT;
END//
DELIMITER ;