const express = require('express')
const bcrypt = require('bcryptjs')
const User = require('../models/user');
const jwt = require('jsonwebtoken')

const JWT_SECRET = 'kdhakjdhwdhqwiu;hdl/akjd;lakhdulhdw$$@$#^324uoqdald'

const router = express.Router()


router.post('/', async (req, res) => {
    //* take the inputs from user and validate them
    const { newpassword: plainTextPassword } = req.body
    //* take the token from header
    var token = req.header('x-auth-token')

    if (!plainTextPassword || typeof plainTextPassword !== 'string') {
        return res.json({ status: 'error', error: 'Invalid password' })
    }

    if (plainTextPassword.length < 5) {
        return res.json({
            status: 'error',
            error: 'Password too small. Should be atleast 6 characters'
        })
    }

    try {
        const user = jwt.verify(token, 'privateKey')

        const id = user.id

        const password = await bcrypt.hash(plainTextPassword, 10)

        await User.updateOne(
            { id },
            {
                $set: { password: password }
            }
        )
        console.log(id)
        console.log(password)
        res.json({ status: 'ok' })
    } catch (error) {
        console.log(error)
        res.json({ status: 'error', error: ';))' })
    }
})




module.exports = router