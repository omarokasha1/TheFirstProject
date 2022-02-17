require('dotenv').config()
const express = require('express')
require('express-async-errors');
const bodyParser = require('body-parser');
const mongoose = require('mongoose')
const logger = require('./config/logger')
const app = express()
const compression = require('compression')

const Course = require('./models/course')

//* initial start
app.use(bodyParser.json())
app.use(express.urlencoded({ extended: true }));

//* mongoose connection
mongoose.connect(process.env.DATABASE_URL, { useNewUrlParser: true, useUnifiedTopology: true, }).then(
    () => console.log('connected to database')).catch((error) => logger.error(error))

//* copmresed requests
app.use(compression())

//* import register
const usersRegister = require('./routes/register')
app.use('/api/register', usersRegister)

//* import login
const usersLogin = require('./routes/login')
app.use('/api/login', usersLogin)

//* import profile 
const userProfile = require('./routes/profile')
app.use('/api/profile', userProfile)

//* import profile 
const changePassword = require('./routes/changePassword')
app.use('/api/changePassword', changePassword)

const newCourse = require('./routes/courses')
app.use('/api/course', newCourse)

app.use('/uploads',express.static('./uploads'));

app.get('/', async(req, res) => {
    try {   
        const blog = await Course.find()
        res.json(blog)
      } catch (err) {
        res.status(500).json({ message: err.message })
      }
});

//* if write invalide url or end point send to user an error message
app.all('*', (req, res, next) => {
    res.status(404).json({
        status: 'false',
        message: 'Page not found !'
    })
})
//* listen on port 8080 local host
app.listen( 8080, function(){
    console.log("Express server listening on port %d in %s mode");
  });