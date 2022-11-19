
DELIMITER //
DROP PROCEDURE IF EXISTS RegisterParticipant;
CREATE PROCEDURE RegisterParticipant(
    IN pParticipantName NVARCHAR(50),
    IN pMovieId INT
)
BEGIN
    SET @participant = -1 ;
    SELECT ParticipantId INTO @participant FROM Participants WHERE LOWER(ParticipantName) = LOWER(pParticipantName);
	IF  (@participant = -1)
    THEN
		INSERT INTO Participants (ParticipantName) VALUES (pParticipantName);
		SELECT ParticipantId INTO @participant FROM Participants WHERE LOWER(ParticipantName) = LOWER(pParticipantName) LIMIT 1;
	END IF;
	INSERT INTO ParticipantsPerMovie (MovieId,ParticipantId) VALUES (pMovieId,@participant);
END//
DELIMITER ;