require('dotenv').config()
const express = require('express')
require('express-async-errors');
const bodyParser =require('body-parser')
const mongoose = require('mongoose')
const logger = require('./config/logger')
const app = express()
const compression = require('compression')
const fileUpoad = require("express-fileupload");
const cors = require("cors");



//app.use(cors());
//app.use(fileUpoad({ useTempFiles: true ,parseNested:true}));


//* initial start
app.use(bodyParser.json())
app.use(express.urlencoded({ extended: false }));

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
const Course = require('./models/course')

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
app.use("/user", require("./routes/userRouter"));


//* if write invalide url or end point send to user an error message
app.all('*', (req, res, next) => {
    res.status(404).json({
        status: 'false',
        message: 'Page not found !'
    })
})
//* listen on port 8080 local host
app.listen( process.env.PORT, function(){
    console.log("Expreass server listening on port 80801");
  });