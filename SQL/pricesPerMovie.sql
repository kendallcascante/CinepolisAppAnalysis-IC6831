
DELIMITER //
 
CREATE PROCEDURE RegisterPrice(
    IN pPriceType INT,
    IN pMovieId INT,
    IN pPrice DECIMAL(10,2)
)
BEGIN
	INSERT INTO pricespermovie VALUES (pPriceType,pMovieId,pPrice);
END//
DELIMITER ;