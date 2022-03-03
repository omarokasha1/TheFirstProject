require('dotenv').config()
const express = require('express')
require('express-async-errors');
const bodyParser =require('body-parser')
const mongoose = require('mongoose')
const logger = require('./config/logger')
const app = express()
const compression = require('compression')

//app.use(cors());
//app.use(fileUpoad({ useTempFiles: true ,parseNested:true}));


//* initial start
app.use(bodyParser.json())
app.use(express.urlencoded({ extended: false }));
app.use('/uploads', express.static(__dirname +'/uploads'));

//* mongoose connection
mongoose.connect(process.env.DATABASE_URL, { useNewUrlParser: true, useUnifiedTopology: true, }).then(
    () => console.log('connected to database')).catch((error) => logger.error(error))

//* copmresed requests
app.use(compression())


//* import user routes 
const user = require('./routes/users')
app.use('/api/user', user)

const course = require('./routes/courses')
app.use('/api/course', course)

const manager = require('./routes/manager')
app.use('/api/manager', manager)

//* if write invalide url or end point send to user an error message
app.all('*', (req, res, next) => {
    res.status(404).json({
        status: 'false',
        message: 'Page not found !'
    })
})

//* listen on port 8081 local host
app.listen( process.env.PORT || 8081, function(){
    console.log("Expreass server listening on port 8081");
  });