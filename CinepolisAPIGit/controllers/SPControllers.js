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
    static getInstance(){
            if (!this.instance)
            {
                this.instance = new SPController();
            }
            return this.instance;
    }
    
};
