
DELIMITER //
DROP PROCEDURE IF EXISTS GetMovies;
CREATE PROCEDURE GetMovies(
	IN pCinemaId INT,
    IN pReqDate DATE
)
BEGIN
	SELECT Functions.FunctionId, Movies.MovieId ,Movies.Title, Movies.Duration, Movies.MinAge, Movies.Year, Movies.PictureURL,  Participants.ParticipantName as 'Director', Functions.FunctionDate,Languages.LanguageId ,Languages.LanguageName,CinemaRooms.CinemaRoomId ,CinemaRooms.Name as 'RoomName' FROM Functions
	INNER JOIN Cinemas ON Functions.CinemaId = Cinemas.CinemaId
	INNER JOIN Movies ON Functions.MovieId = Movies.MovieId
	INNER JOIN Languages ON Languages.LanguageId = Functions.LanguageId
	INNER JOIN CinemaRooms ON Functions.CinemaRoomId = CinemaRooms.CinemaRoomId AND CinemaRooms.CinemaId = Cinemas.CinemaId
	INNER JOIN Participants ON Participants.ParticipantId = Movies.ParticipantId
	WHERE DAY(Functions.FunctionDate) = DAY(pReqDate) AND Functions.CinemaId = pCinemaId
    ORDER BY Functions.FunctionDate ASC;

END//
DELIMITER ;