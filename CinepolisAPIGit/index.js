const varController = require('./controllers/SPControllers.js');
const express = require('express');
const app=express();
const mysql= require('mysql2');
const cors = require('cors');

//Config server 
app.set('port', process.env.PORT || 8080);

//Middleware
app.use(express.json());

//Routes
app.use(require('./routes/router.js'));
//Cors
app.use(cors());
//Starting server
app.listen(app.get('port'), () => {
    console.log('Server on port', app.get('port'))
});

