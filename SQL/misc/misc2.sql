
SELECT vaccines.Name, vaccinesperuser.Date INTO @name1, @date1 FROM vaccinesperuser 
INNER JOIN vaccines ON vaccinesperuser.VaccinesId = vaccines.VaccinesId
WHERE  vaccinesperuser.UserId = @UserId ORDER BY vaccinesperuser.Date ASC LIMIT 1;
SELECT vaccines.Name, vaccinesperuser.Date INTO @name2, @date2 FROM vaccinesperuser 
INNER JOIN vaccines ON vaccinesperuser.VaccinesId = vaccines.VaccinesId
WHERE  vaccinesperuser.UserId = @UserId ORDER BY vaccinesperuser.Date DESC LIMIT 1;
SELECT Users.UserId,Users.Name, Users.LastName1, Users.LastName2, Users.Email,Users.Birthdate, Users.PersonalId, @name1 as vac1, @date1 as date1,@name2 as vac2, @date2 as date2  FROM Users
WHERE Users.UserId = @UserId;

SELECT * FROM cinemarooms