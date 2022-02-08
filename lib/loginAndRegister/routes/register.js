const express = require('express')
const bcrypt = require('bcryptjs')
const Users = require('../models/user');
const jwt = require('jsonwebtoken')
const { validateUser } = require('../models/user')
const JWT_SECRET = 'kdhakjdhwdhqwiu;hdl/akjd;lakhdulhdw$$@$#^324uoqdald'
const router = express.Router()
const _ = require('lodash')


router.post('/', async (req, res) => {
    //* take the inputs from user and validate them
    //* register by phone or userName just change email below to phone or userName
    const { userName, email, password: plainTextPassword } = req.body
    const validateError = validateUser(req.body)

    //* if validate error just send to user an error message
    if (validateError.error) {
        return res.json({ error: validateError.error.details[0].message })
    }

    //* check in database by email     
    //* register by phone or userName just change email below to phone or userName
    let user = await Users.findOne({ email }).lean()

    //* if exist return an error messge
    if (user) {
        return res.status(404).json({ status: 'false', message: 'email already in use' })
    }
    try {
        //* take from user userName , email and password and not care for any value else
        user = new Users(_.pick(req.body, ['userName', 'email', 'password']))

        //* crypt the password using bcrypt package
        user.password = await bcrypt.hash(plainTextPassword, 10)

        //* generate token that have his id
        const token = jwt.sign({ id: user.id }, 'privateKey')

        //* then save the user
        await user.save()

        console.log(user)

        //* send his token in header and his data in body
        return res.header('x-auth-token', token).json(_.pick(user, ['_id', 'userName', 'email']))
    } catch (error) {
        return res.json({ status: 'error', error: error.message })

    }
})



/* router.post('/', async (req, res) => {
    const { userName, email, password: plainTextPassword } = req.body
    const validateError = validateUser(req.body)
    if (validateError.error) {
        return res.json({ error: validateError.error.details[0].message })
    }
    const password = await bcrypt.hash(plainTextPassword, 10)
    try {

        const response = await Users.create({
            userName,
            email,
            password
        })
        console.log(response)
        return res.json({ response: response })
    } catch (error) {
        return res.json({ status: 'error', error: error.message })

    }
}) */



module.exports = router