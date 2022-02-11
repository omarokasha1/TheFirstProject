require('dotenv').config()
const express = require('express')
require('express-async-errors');
const bodyParser = require('body-parser');
const mongoose = require('mongoose')
const logger = require('./config/logger')
const app = express()
const compression = require('compression')


//* initial start
app.use(bodyParser.json())
//* mongoose connection
mongoose.connect(process.env.DATABASE_URL, { useNewUrlParser: true, useUnifiedTopology: true, }).then(
    () => console.log('connected to database')).catch((error) => logger.error(error))

//* copmresed requests
app.use(compression())

//* import register
const usersRegister = require('./routes/register')
app.use('/register', usersRegister)
//* import login
const usersLogin = require('./routes/login')
app.use('/login', usersLogin)
//* import profile 
const userProfile = require('./routes/profile')
app.use('/profile', userProfile)
//* import profile 
const changePassword = require('./routes/changePassword')
app.use('/changePassword', changePassword)

const newCourse = require('./routes/courses')
app.use('/course', newCourse)


//* if write invalide url or end point send to user an error message
app.all('*', (req, res, next) => {
    res.status(404).json({
        status: 'false',
        message: 'Page not found !'
    })
})
//* listen on port 8080 local host
app.listen(8080, () => logger.info('server started 8080 ....'))