
DELIMITER //
 
CREATE PROCEDURE RegisterLanguageMovie(
    IN pLanguage INT,
    IN pMovieId INT
)
BEGIN
	INSERT INTO LanguagesPerMovie (LanguageId,MovieId) VALUES (pLanguage,pMovieId);
END//
DELIMITER ;