const express = require('express')
const bcrypt = require('bcryptjs')
const User = require('../models/user');
const jwt = require('jsonwebtoken')
const JWT_SECRET = 'kdhakjdhwdhqwiu;hdl/akjd;lakhdulhdw$$@$#^324uoqdald'
const { validateUserLogin } = require('../models/user')
const _ = require('lodash')
const router = express.Router()
const auth = require('../middleware/auth')



router.post('/', async (req, res) => {
    //* take the inputs from user and validate them
    const { userName, email, password: plainTextPassword } = req.body
    const validateError = validateUserLogin(req.body)

    //* if validate error just send to user an error message
    if (validateError.error) {
        return res.json({ error: validateError.error.details[0].message })
    }

    //* check in database by email
    let user = await User.findOne({ email }).lean()

    //* if not exist return an error messge
    if (!user) {
        return res.status(404).json({ status: 'error', error: 'Invalid email or password' })
    }

    try {
        //* compare between password and crypted password of user 
        const checkPassword = await bcrypt.compare(req.body.password, user.password)

        //* if password doesnt match return to user an error message 
        if (!checkPassword) {
            return res.status(404).json({ status: 'error', error: 'Invalid email or password' })
        }

        //* generate token that have his id and if admin or not
        const token = jwt.sign({ id: user._id, isAdmin: user.isAdmin }, 'privateKey')

        console.log(token)
        return res.json({ status: 'ok', token: token })
    } catch (error) {
        console.log(error)
        return res.json({ status: 'error', error: error.message })

    }
})

/* router.post('/', async (req, res) => {
    const { userName, email, password } = req.body
    const user = await User.findOne({ email }).lean()

    if (!user) {
        return res.json({ status: 'error', error: 'Invalid email or password' })
    }

    if (await bcrypt.compare(password, user.password)) {
        const token = jwt.sign({ id: user.id, userName: user.userName, email: user.email }, JWT_SECRET)
        return res.json({ status: 'ok', token: token })
    }
    res.json({ status: 'error', error: 'Invalid username/password' })
}) */
module.exports = router