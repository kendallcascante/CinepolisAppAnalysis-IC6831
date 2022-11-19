const mysql= require('mysql2');
const moment = require('moment-timezone');
const nodemailer = require('nodemailer');
const { text } = require('express');
const handlebars = require('handlebars');
const fs = require('fs');
const pdf = require('html-pdf');
var billcount = 0;
module.exports = class SPController { 
    static instance;
    dbconnection;
    constructor(){
        try
        {
            this.dbconnection = mysql.createPool({
            host: 'us-cdbr-east-05.cleardb.net',
            user: 'bcec01a657d74a',
            password: 'c2fc8e4c',
            database: 'heroku_e87e366c90dde4a'
            });
        } catch (e)
        {
            console.log(`There was an error during the connection process.`,e);
        }
    }
    getMovies(req, res){
        console.log(`Request from ${req.ip} to  path ${req.url}.`)  
        this.dbconnection.execute('SELECT Movies.MovieId, Movies.Title, Movies.Year, Movies.Duration, Movies.MinAge, Movies.PictureURL, Participants.ParticipantName as Director  FROM Movies INNER JOIN Participants ON Movies.ParticipantId = Participants.ParticipantId',
        (err, data, fields) => {
            if (err){res.status(500).json(err.message)}
            else{res.status(200).json({data})}
        })
    }
    getFunctions(req, res){
        const { cinema } = req.body;
        const { date } = req.body;
        const mySQLDateString = moment(new Date(date)).format('YYYY-MM-DD HH:mm:ss')
        console.log(cinema,mySQLDateString)
        console.log(`Request from ${req.ip} to  path ${req.url}.`)  
        this.dbconnection.execute('CALL GetMovies(?,?)',[cinema,mySQLDateString],
        (err, data, fields) => {
            if (err){res.status(500).json(err.message)}
            else{res.status(200).json({data})}
        })
    }
    register(req, res){
        const { name } = req.body;
        const { lastName1 } = req.body;
        const { lastName2 } = req.body;
        const { email } = req.body;
        const { birthdate } = req.body;
        const { personalId } = req.body;
        const { personalIdType } = req.body;
        const { vac1Id } = req.body;
        const { vac2Id } = req.body;
        const { vac1Date } = req.body;
        const { vac2Date } = req.body;
        
        console.log(`Request from ${req.ip} to  path ${req.url}.`)
            var generado = Math.random().toString(36).slice(-8);
            var nombreFinal = name + " " + lastName1
            let transporter = nodemailer.createTransport({
                host: "smtp-mail.outlook.com",
                port: 587,
                auth: {
                  user: "cinepolisOnline@outlook.com",
                  pass: "Daae2001!"
                },
            })
            let html = fs.readFileSync('controllers/mail.html', 'utf8');
            let template = handlebars.compile(html);
            let data = { 
                cPass: generado,
                usuario: nombreFinal};
            let htmlToSend = template(data);
            let mailOptions = {
                from: "Cinepolis Costa Rica",
                to: email,
                subject: "Cuenta creada con éxito",
                html: htmlToSend
    
                }
            this.dbconnection.execute('CALL RegisterUser (?,?,?,?,?,?,?,?,?,?,?,?)',
            [name,lastName1,lastName2, email,birthdate,generado,personalId,personalIdType,vac1Id,vac1Date,vac2Id,vac2Date],
            (err, data, fields) => {
                if (err){res.status(500).send(err.message)}
                else{
                    transporter.sendMail(mailOptions, (error, info) => {
                    if (error) res.status(500).send(error.message);
                    else res.status(200).jsonp(req.body)
                    })
                }
            })
    }
    logIn(req, res){
        const { email } = req.body;
        const { pass } = req.body;
        console.log(req.body)
        console.log(`Request from ${req.ip} to  path ${req.url}.`)  
        console.log(req.body)
        this.dbconnection.execute('CALL LogIn(?,?)',[email,pass],
        (err, data, fields) => {
            if (err){res.status(500).json(err.message)}
            else {res.status(200).json({data})}
        })
    }
    registerMovie(req, res){
        const { title } = req.body;
        const { year } = req.body;
        const { director } = req.body;
        const { duration } = req.body;
        const { minAge } = req.body;
        const { pictureUrl } = req.body;
        this.dbconnection.execute('CALL RegisterMovie (?,?,?,?,?,?)',[title,year,minAge,duration,director,pictureUrl], 
        (err, data, fields) => {
            if (err){res.status(500).json(err.message)}
            else{res.status(200).json({data})}
        })

    }
    getGenres(req, res){
        console.log(`Request from ${req.ip} to  path ${req.url}.`)  
        this.dbconnection.execute('SELECT * FROM Genres',	
        (err, data, fields) => {
            if (err){res.status(500).json(err.message)}
            else{res.status(200).json({data})}  
        })
    } 
    getLanguages(req, res){
        console.log(`Request from ${req.ip} to  path ${req.url}.`)  
        this.dbconnection.execute('SELECT * FROM Languages',	
        (err, data, fields) => {
            if (err){res.status(500).json(err.message)}
            else{res.status(200).json({data})}
        })
    } 
    getVaccines(req, res){
        res.header("Access-Control-Allow-Origin", "*");
        console.log(`Request from ${req.ip} to  path ${req.url}.`)
        console.log(req.header)
        this.dbconnection.execute('SELECT * FROM Vaccines',
        (err, data, fields) => {
            if (err){res.status(500).json(err.message)};
            res.status(200).json({data})
        })
    }
    addGenre(req, res){
        const { genre } = req.body;
        const { movie} = req.body;
        console.log(`Request from ${req.ip} to  path ${req.url}.`) 
        console.log(req.body)
        this.dbconnection.execute('CALL RegisterGenresMovie(?,?)',[genre,movie],
        (err, data, fields) => {
            if (err){res.status(500).json(err.message)};
            res.status(200).json({data})
        })
    }
    deleteGenre(req, res){
        const {genre} = req.body;
        const {movie} = req.body;
        console.log(`Request from ${req.ip} to  path ${req.url}.`)
        console.log(genre,movie)
        this.dbconnection.execute('DELETE from genrespermovie WHERE genreId ='+genre+" and MovieId ="+movie,
        (err, data, fields) => {
            if (err){res.status(500).json(err.message)}
            else{res.status(200).json({data})}
        })
    }
    addLanguage(req, res){
        const { language } = req.body;
        const { movie} = req.body;
        console.log(`Request from ${req.ip} to  path ${req.url}.`) 
        console.log(req.body)
        this.dbconnection.execute('CALL RegisterLanguageMovie(?,?)',[language,movie],
        (err, data, fields) => {
            if (err){res.status(500).json(err.message)}
            else{res.status(200).json({data})}
        })
    }
    deleteLanguage(req, res){
        const {language} = req.body;
        const {movie} = req.body;
        this.dbconnection.execute("DELETE from languagespermovie  WHERE  LanguageId ="+ language  +" AND MovieId ="+ movie,
        (err, data, fields) => {
            if (err){res.status(500).json(err.message)}
            else{res.status(200).json({data})}
        })
    }
    addParticipant(req,res){
        const {name} = req.body;
        const {movie} = req.body;
        this.dbconnection.execute('CALL RegisterParticipant(?,?)',[name,movie],
        (err, data, fields) => {
            if (err){res.status(500).json(err.message)}
            else{res.status(200).json({data})}
        })
    }
    deleteParticipant(req, res){
        const {participant} = req.body;
        const {movie} = req.body;
        this.dbconnection.execute('DELETE from participantspermovie  WHERE  ParticipantId='+participant+" and "+movie+"=movieId",
        (err, data, fields) => {
            if (err){res.status(500).json(err.message)}
            else{res.status(200).json({data})}
        })
    }
    addPrice(req, res){
        const {price} = req.body;
        const {type} = req.body;
        const {movie} = req.body;
        console.log("Variables: "+price,type,movie)
        this.dbconnection.execute('CALL RegisterPrice(?,?,?)',[type,movie,price],
        (err, data, fields) => {
            if (err){
                res.status(500).json({err})
                console.log(err)}
            else
            {res.status(200).json({data})}
        })
    }
    deletePrice(req, res){
        const {type} = req.body;
        const {movie} = req.body;
        this.dbconnection.execute('DELETE from pricespermovie WHERE priceId = '+type+" and "+movie+"= movieId",
        (err, data, fields) => {
            if (err){res.status(500).json(err.message)}
            else{res.status(200).json({data})}
        })
    }
    getLanguagesPerMovie(req, res){
        const { movie } = req.body;
        console.log(`Request from ${req.ip} to  path ${req.url}.`) 
        this.dbconnection.execute('SELECT Languages.LanguageId, Languages.LanguageName FROM languagespermovie INNER JOIN Languages ON languagespermovie.LanguageId = Languages.LanguageId WHERE MovieId = '+movie,
        (err, data, fields) => {
            if (err){res.status(500).json(err.message)}
            else{res.status(200).json({data})}
        })
    }
    getGenresPerMovie(req, res){
        const { movie } = req.body;
        this.dbconnection.execute('SELECT genres.GenreId, genres.genreName FROM genrespermovie INNER JOIN genres ON genrespermovie.genreId = genres.genreId WHERE MovieId = '+movie,
        (err, data, fields) => {
            if (err){res.status(500).json(err.message)}
            else{res.status(200).json({data})}
        })
    }
    getParticipantsPerMovie(req, res){
        const { movie } = req.body;
        this.dbconnection.execute('SELECT participants.participantId, participants.participantName FROM participants INNER JOIN participantspermovie ON participants.ParticipantId = participantspermovie.ParticipantId WHERE MovieId ='+movie,
        (err, data, fields) => {
            if (err){res.status(500).json(err.message)}
            else{res.status(200).json({data})}
        })
    }
    getPricesPerMovie(req, res){
        const { movie } = req.body;
        this.dbconnection.execute('SELECT prices.PriceTitle, pricespermovie.amount FROM prices INNER JOIN pricespermovie ON prices.priceId = pricespermovie.priceId WHERE pricespermovie.MovieId ='+movie,
        (err, data, fields) => {
            if (err){res.status(500).json(err.message)}
            else{res.status(200).json({data})}
        })
    }
    addFunction(req, res){
        const { movie } = req.body;
        const { cinemaRoom } = req.body;
        const { date } = req.body;
        const { language } = req.body;
        this.dbconnection.execute("CALL AddFunction(?,?,?,?)",[movie,cinemaRoom,date,language],(err, data, fields) => {
            if (err){res.status(500).json(err.message)}
            else{res.status(200).json(data)}
        })
    }
    deleteMovie(req, res){
        const { movie } = req.body;
        this.dbconnection.execute("CALL DeleteMovie(?)",[movie],(err, data, fields) => {
            if (err){
                res.status(500).json(err.message)
                console.log(err.message)
            }
            else{res.status(200).json({data})}
        })
    }
    deleteUser(req, res){
        const { user } = req.body;
        this.dbconnection.execute("CALL DeleteUser(?)",[user],(err, data, fields) => {
            if (err){
                res.status(500).json(err.message)
                console.log(err.message)
            }
            else{res.status(200).json({data})}
        })
    }
    updateMovie(req, res){
        const { movie } = req.body;
        const { title } = req.body;
        const { year } = req.body;
        const { director } = req.body;
        const { duration } = req.body;
        const { minAge } = req.body;
        const { pictureUrl } = req.body;
        console.log(req.body)
        this.dbconnection.execute("CALL UpdateMovie(?,?,?,?,?,?,?)",[movie,title,year,minAge,duration,director,pictureUrl],(err, data, fields) => {
            if (err){
                res.status(500).json(err.message)
                console.log(err.message)
            }
            else{res.status(200).json({data})}
        })
    }
    updateUser(req, res){
        const { user } = req.body;
        const { name } = req.body;
        const { lastName1 } = req.body;
        const { lastName2 } = req.body;
        const { email } = req.body;
        const { birthdate } = req.body;
        const { personalId } = req.body;
        const { personalIdType } = req.body;
        const { vac1Id } = req.body;
        const { vac2Id } = req.body;
        const { vac1Date } = req.body;
        const { vac2Date } = req.body;
        const { admin } = req.body;
        this.dbconnection.execute("CALL UpdateUser(?,?,?,?,?,?,?,?,?,?,?,?,?)",[user,name,lastName1,lastName2,email,birthdate,personalId,personalIdType,vac1Id,vac1Date,vac2Id,vac2Date,admin],(err, data, fields) => {
            if (err){
                res.status(500).json(err.message)
                console.log(err.message)
            }
            else{res.status(200).json({data})}
        })
    }
    addFood(req, res){
        const { food } = req.body;
        const { quantity } = req.body;
        const { price } = req.body;
        const { foodType } = req.body;
        this.dbconnection.execute("INSERT INTO foods(Name,Quantity,Price,FoodTypeId) VALUES (?,?,?,?)",[food,quantity,price,foodType],(err, data, fields) => {
            if (err){
                res.status(500).json(err.message)
                console.log(err.message)
            }
            else{res.status(200).json({data})}
        })
    }
    updateFood(req, res){
        const { foodId } = req.body;
        const { food } = req.body;
        const { quantity } = req.body;
        const { price } = req.body;
        const { foodType } = req.body;
        this.dbconnection.execute("UPDATE foods SET Name = ?, Quantity = ?, Price = ?, FoodTypeId = ? WHERE FoodId = ?",[food,quantity,price,foodType,foodId],(err, data, fields) => {
            if (err){
                res.status(500).json(err.message)
                console.log(err.message)
            }
            else{res.status(200).json({data})}
        })
    }
    deleteFood(req, res){
        const { food } = req.body;
        this.dbconnection.execute("DELETE FROM foods WHERE FoodId = ?",[food],(err, data, fields) => {
            if (err){
                res.status(500).json(err.message)
                console.log(err.message)
            }
            else{res.status(200).json({data})}
        })
    }
    getFoods(req, res){
        this.dbconnection.execute("SELECT * FROM foods",(err, data, fields) => {
            if (err){
                res.status(500).json(err.message)
                console.log(err.message)
            }
            else{res.status(200).json({data})}
        })
    }
    getSeats(req, res){
        const { func } = req.body;
        this.dbconnection.execute("SELECT * FROM seatsperfunction INNER JOIN seats ON seatsperfunction.seatsId = seats.seatsId WHERE FunctionId = "+func,(err, data, fields) => {
            if (err){
                res.status(500).json(err.message)
                console.log(err.message)
            }
            else{res.status(200).json({data})}
        })
    }
    addTicketToCart(req, res){
        const { user } = req.body;
        const { func } = req.body;
        const { seat } = req.body;
        const { price } = req.body;
        const { priceType } = req.body;
        this.dbconnection.execute("INSERT INTO ticketspercart VALUES(?,?,?,?,?,?)",[user,func,1,seat,priceType,price],(err, data, fields) => {
            if (err){res.status(500).json(err.message)}
            else{
                this.dbconnection.execute("UPDATE seatsperfunction SET avaliable = 0, UserId = "+user+" WHERE seatsId = "+seat+ " AND functionId = "+func,(err, data, fields) => {
                    if (err){
                        res.status(500).json(err.message)
                        console.log(err.message)
                    }
                    else{res.status(200).json({data})}
                })
            }
        })
    }
    removeTicketsFromCart(req, res){
        const { user } = req.body;
        const { func } = req.body;
        const { seat } = req.body;
        this.dbconnection.execute("DELETE FROM ticketspercart WHERE ShoppingCartsId = "+user+" AND FunctionId = "+func+" AND SeatId = "+seat,(err, data, fields) => {
            if (err){res.status(500).json(err.message)}
            else{
                this.dbconnection.execute("UPDATE seatsperfunction SET avaliable = 1, UserId = NULL WHERE seatsId = "+seat+ " AND functionId = "+func,(err, data, fields) => {
                if (err){res.status(500).json(err.message)}
                else {res.status(200).json({data})} })
            }
        })
    }
    addFoodToCart(req, res){
        const { user } = req.body;
        const { food } = req.body;
        const { quantity } = req.body;
        const { price } = req.body;
        this.dbconnection.execute("INSERT INTO foodspercart VALUES(?,?,?,?)",[user,food,quantity,price],(err, data, fields) => {
            if (err){res.status(500).json(err.message)};
            this.dbconnection.execute("UPDATE foods SET Quantity = Quantity - "+quantity+" WHERE FoodId = "+food,(err, data, fields) => {
                if (err){
                    res.status(500).json(err.message)}
                else {
                    res.status(200).json({data})
                }
            })
        })
    }
    removeFoodFromCart(req, res){
        const { user } = req.body;
        const { food } = req.body;
        const { quantity } = req.body;
        this.dbconnection.execute("DELETE FROM foodspercart WHERE ShoppingCartsId = "+user+" AND FoodId = "+food,(err, data, fields) => {
            if (err){res.status(500).json(err.message)}
                else{
                this.dbconnection.execute("UPDATE foods SET Quantity = Quantity + "+quantity+" WHERE FoodId = "+food,(err, data, fields) => {
                    if (err){res.status(500).json(err.message)}
                    else {res.status(200).json({data})}
                })
            }
        })
    }
    getCart(req, res){
        const { user } = req.body;
        this.dbconnection.execute("SELECT functions.functionId, Movies.Title, functions.FunctionDate, languages.LanguageName,seats.SeatsId, seats.Position, ticketspercart.Price, prices.PriceTitle FROM ticketspercart INNER JOIN functions ON ticketspercart.FunctionId = functions.FunctionId INNER JOIN movies ON functions.MovieId = movies.MovieId INNER JOIN languages ON languages.LanguageId = functions.LanguageId INNER JOIN prices ON prices.PriceId = ticketspercart.PriceId INNER JOIN seats ON ticketspercart.SeatId = seats.seatsId WHERE ShoppingCartsId ="+user,(err, tickets, fields) => {
            if (err){res.status(500).json(err.message)}
            else{
                this.dbconnection.execute("SELECT foods.FoodId, foods.Name, foodspercart.Quantity, foodspercart.Price FROM foodspercart INNER JOIN foods ON foodspercart.FoodId = foods.FoodId WHERE ShoppingCartsId ="+user,(err, foods, fields) => {
                    let data = [];
                    for (let i = 0; i < tickets.length; i++) {
                        data[i] = {Id : tickets[i].functionId, Name : tickets[i].Title + " - " + tickets[i].LanguageName + " - " + tickets[i].Position+" - "+moment(tickets[i].FunctionDate).format('DD/mm/YYYY H:MM')+ " - "+tickets[i].PriceTitle, Quantity : 1,Seat : tickets[i].SeatsId,Price : tickets[i].Price, Kind : "Ticket",};
                    }
                    for (let i = 0; i < foods.length; i++) {
                        data[data.length] = {Id : foods[i].FoodId, Name : foods[i].Name, Quantity : foods[i].Quantity,Price : foods[i].Price, Kind : "Food"};
                    }
                    res.status(200).json({data})
                })
            }
        })
    }
    createBill(req, res){
        const { user } = req.body;
        this.dbconnection.execute("SELECT Movies.Title, functions.FunctionDate, languages.LanguageName, seats.Position, ticketspercart.Price, prices.PriceTitle FROM ticketspercart INNER JOIN functions ON ticketspercart.FunctionId = functions.FunctionId INNER JOIN movies ON functions.MovieId = movies.MovieId INNER JOIN languages ON languages.LanguageId = functions.LanguageId INNER JOIN prices ON prices.PriceId = ticketspercart.PriceId INNER JOIN seats ON ticketspercart.SeatId = seats.seatsId WHERE ShoppingCartsId ="+user,(err, tickets, fields) => {
            if (err){res.status(500).json(err.message)};
            this.dbconnection.execute("SELECT foods.Name, foodspercart.Quantity, foodspercart.Price FROM foodspercart INNER JOIN foods ON foodspercart.FoodId = foods.FoodId WHERE ShoppingCartsId ="+user,(err, foods, fields) => {
                if (err){res.status(500).json(err.message)};
                this.dbconnection.execute("SELECT name, lastname1, lastname2, email FROM users WHERE userId ="+user,(err, us, fields) => {
                    if (err){res.status(500).json(err.message)};
                    let data = [];
                    for (let i = 0; i < tickets.length; i++) {
                        data[i] = {Name : tickets[i].Title + " - " + tickets[i].LanguageName + " - " + tickets[i].Position+" - "+moment(tickets[i].FunctionDate).format('DD/mm/YYYY H:MM')+ " - "+tickets[i].PriceTitle, Quantity : 1,Price : tickets[i].Price};
                    }
                    for (let i = 0; i < foods.length; i++) {
                        data[data.length] = foods[i];
                    }
                    const formateador = new Intl.NumberFormat("en", { style: "currency", "currency": "CRC" });
                    let tabla = "";
                    let subtotal = 0;
                    for (const dato of data) {
                        const totalperItem = parseFloat(dato.Price) * dato.Quantity;
                        subtotal += totalperItem;
                        tabla += `<tr>
                        <td>${dato.Name}</td>
                        <td>${dato.Quantity}</td>
                        <td>${formateador.format(dato.Price)}</td>
                        <td>${formateador.format(totalperItem)}</td>
                        </tr>`;
                        
                    }
                    const descuento = 0;
                    const subtotalConDescuento = subtotal - descuento;
                    const impuestos = subtotalConDescuento * 0.13
                    const total = subtotalConDescuento + impuestos;
                    let html = fs.readFileSync('controllers/bill.html', 'utf8');
                    html = html.replace("{{tablaProductos}}", tabla);
                    let template = handlebars.compile(html);
                    let format = { 
                        subtotal: formateador.format(subtotal),
                        descuento: formateador.format(descuento),
                        subtotalConDescuento: formateador.format(subtotalConDescuento),
                        impuestos: formateador.format(impuestos),
                        total: formateador.format(total),
                        numeroFactura : billcount,
                        Fecha : moment().tz('America/Costa_Rica').format('DD/mm/YYYY'),
                        Nombre : us[0].name + " " + us[0].lastname1 + " " + us[0].lastname2,
                        tablaProductos: tabla};
                    let htmlToSend = template(format);
                    billcount++;
                    pdf.create(htmlToSend).toBuffer(function (error,buffer) {
                        console.log(buffer)
                        if (error) {
                            console.log("Error creando PDF: " + error)
                        } else {
                            let transporter = nodemailer.createTransport({
                                host: "smtp-mail.outlook.com",
                                port: 587,
                                auth: {
                                  user: "cinepolisOnline@outlook.com",
                                  pass: "Daae2001!"
                                },
                            })
                            let htmlfinal = fs.readFileSync('controllers/thanks.html', 'utf8');
                            let mailOptions = {
                                from: "Cinepolis Costa Rica",
                                to: us[0].email,
                                subject: "¡Tu compra ha sido realizada!",
                                html: htmlfinal,
                                attachments: [{
                                    filename: 'factura.pdf',
                                    contentType: 'application/pdf',
                                    content : buffer
                                  }]
                            }
                            transporter.sendMail(mailOptions, (error, info) => {
                                console.log("done")
                                res.status(200).jsonp(req.body)
                            });
                        }
                    });
                    this.dbconnection.execute("DELETE FROM ticketspercart WHERE ShoppingCartsId ="+user,(err, tickets, fields) => {
                        console.log(tickets)
                        this.dbconnection.execute("DELETE FROM foodspercart WHERE ShoppingCartsId ="+user,(err, foods, fields) => {
                            console.log("done")
                            res.status(200).jsonp(req.body)
                        })

                    });
                })
            })
        })
    }
    getUsers(req, res){
        this.dbconnection.execute("SELECT UserId FROM users",(err, data, fields) => {
            if (err){res.status(500).json(err.message)}            
            else{
                res.status(200).jsonp({data})
            }
        })
    }
    getData(req, res){
        const { user } = req.body;
        this.dbconnection.execute("Call GetData(?)",[user],(err, data, fields) => {
            if (err){res.status(500).json(err.message)}
            else{
                res.status(200).json({data})
            }
        })
    }
    getCinemaRooms(req, res){
        this.dbconnection.execute("SELECT * FROM cinemarooms WHERE cinemaId = 0",(err, cinemarooms, fields) => {
            if (err){res.status(500).json(err.message)};
            res.status(200).json({cinemarooms})
        })
    }
    deleteFunction(req, res){
        const { functionId } = req.body;
        this.dbconnection.execute("DELETE FROM seatsperFunction WHERE FunctionId ="+functionId,(err, data, fields) => {
            console.log(err,data)
            this.dbconnection.execute("DELETE FROM ticketspercart WHERE FunctionId ="+functionId,(err, data, fields) => {
                console.log(err, data)
                this.dbconnection.execute("DELETE FROM functions WHERE FunctionId = "+functionId,(err, data, fields) => {
                    console.log(err, data)
                    if (err){res.status(500).json(err.message)}
                    else{
                        if (err){res.status(500).json(err.message)}
                        else {res.status(200).json({data})}
                    }
                })
            })
        })
    }
    updateFunction(req, res){
        const { functionId} = req.body;
        const { movie } = req.body;
        const { cinemaRoom } = req.body;
        const { date } = req.body;
        const { language } = req.body;
        console.log(functionId, movie, cinemaRoom, date, language)
        this.dbconnection.execute("CALL UpdateFunction(?,?,?,?,?)",[functionId, movie, cinemaRoom, date, language],(err, data, fields) => {
            if (err){res.status(500).json(err.message)
            console.log(err)}
            else{res.status(200).json({data})
            console.log(data)}
        });
    }
    updateGenre(req, res){
        const { user } = req.body;
        const { genre} = req.body;
        this.dbconnection.execute("UPDATE users SET genre = ? WHERE UserId = ?",[genre, user],(err, data, fields) => {
            if (err){res.status(500).json(err.message)}
            else{res.status(200).json({data})}
        });
    }
    static getInstance(){
            if (!this.instance)
            {
                this.instance = new SPController();
            }
            return this.instance;
    }
    
};
