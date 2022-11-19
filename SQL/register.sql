
DELIMITER //
CREATE PROCEDURE RegisterUser(
	IN pName NVARCHAR(100),
    IN pLastName1 NVARCHAR(100),
    IN pLastName2 NVARCHAR(100),
    IN pEmail VARCHAR(300),
    IN pBirthdate NVARCHAR(50),
    IN pPassword NVARCHAR(50),
    IN pPersonalId VARCHAR(45),
    IN pPersonalIdType TINYINT,
    IN pVac1Id TINYINT,
    IN pVac1Date NVARCHAR(50),
	IN pVac2Id TINYINT,
    IN pVac2Date NVARCHAR(50)
)
BEGIN
	DECLARE MailInUSe INT DEFAULT(53000);
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
	SELECT COUNT(*) INTO @emailRegisted FROM Users WHERE email = pEmail;
    IF  (@emailRegisted != 0)
    THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El email ya esta en uso', MYSQL_ERRNO = MailInUSe;
	END IF;
    SET @count = 0;
	IF pVac1Id <> 10 THEN
		SET @count = @count + 1;
	END IF;
    IF pVac2Id <> 10 THEN
		SET @count = @count + 1;
	END IF;
    
    START TRANSACTION;
		INSERT INTO Users (Name,LastName1,LastName2,Email,Birthdate,VaccinationCount,Password,PersonalIdTypeId,PersonalId,Admin)
        VALUES (pName,pLastName1,pLastName2,pEmail,str_to_date(pBirthdate,'%d/%m/%Y'),@count,SHA(CONCAT(pPassword,",",pEmail)),pPersonalIdType,pPersonalId,0);
		SET @UserId = (SELECT MAX(UserId) FROM Users);
        INSERT INTO VaccinesPerUser (VaccinesId,UserId,Date) VALUES
        (pVac1Id,@UserId,str_to_date(pVac1Date,'%d/%m/%Y')),
        (pVac2Id,@UserId,str_to_date(pVac2Date,'%d/%m/%Y'));
         INSERT INTO shoppingcarts VALUES (@UserId,@UserId);
	COMMIT;
END//
DELIMITER ;