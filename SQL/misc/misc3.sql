INSERT INTO GenresPerMovie VALUES (4,34);
INSERT INTO languagespermovie (LanguageId,MovieId) VALUES (3,4);
CALL RegisterLanguageMovie(2,4);
SELECT * FROM Languages;
CALL RegisterLanguageMovie (3,4);
SELECT * FROM languagespermovie;
SELECT * FROM genrespermovie INNER JOIN genres ON genrespermovie.genreId = genres.genreId WHERE MovieId = 4;
SELECT * FROM participantspermovie;
SELECT * FROM participants;
DELETE FROM participants WHERE ParticipantId = 54;
INSERT INTO Users (Name,LastName1,LastName2,Email,Birthdate,VaccinationCount,Password,PersonalIdTypeId,PersonalId,Admin)
VALUES ("Administrador"," ","Cinepolis","administrador",str_to_date("1/1/2000",'%d/%m/%Y'),0,SHA(CONCAT("admin",",","administrador")),0,"000",1);
SELECT participants.participantName FROM participants INNER JOIN participantspermovie ON participants.ParticipantId = participantspermovie.ParticipantId WHERE MovieId = 4;