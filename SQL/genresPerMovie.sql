
DELIMITER //
 
CREATE PROCEDURE RegisterGenresMovie(
    IN pGenreId INT,
    IN pMovieId INT
)
BEGIN
	INSERT INTO GenresPerMovie VALUES (pMovieId,pGenreId);
END//
DELIMITER ;