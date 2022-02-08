require('dotenv').config()
const express = require('express')
require('express-async-errors');
const bodyParser = require('body-parser');
const mongoose = require('mongoose')
const logger = require('./config/logger')
const app = express()
const compression = require('compression')

app.use(bodyParser.json())
mongoose.connect(process.env.DATABASE_URL, { useNewUrlParser: true, useUnifiedTopology: true, }).then(
    () => console.log('connected to database')).catch((error) => logger.error(error))

//* copmresed requests
app.use(compression())

//* import register
const usersRegister = require('./routes/register')
app.use('/register', usersRegister)

const usersLogin = require('./routes/login')
app.use('/login', usersLogin)

const userProfile = require('./routes/profile')
app.use('/profile', userProfile)

const subscriber = require('./routes/subscribers')
app.use('/subscriber', subscriber)

const usersChangePassword = require('./routes/changePassword')
app.use('/changePassword', usersChangePassword)

//* if write invalide url or end point send to user an error message
app.all('*', (req, res, next) => {
    res.status(404).json({
        status: 'false',
        message: 'Page not found !'
    })
})

app.listen(8080, () => logger.info('server started 8080 ....'))