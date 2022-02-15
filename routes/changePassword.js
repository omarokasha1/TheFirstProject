const express = require('express')
const bcrypt = require('bcryptjs')
const User = require('../models/user');
const jwt = require('jsonwebtoken')

const JWT_SECRET = 'kdhakjdhwdhqwiu;hdl/akjd;lakhdulhdw$$@$#^324uoqdald'

const router = express.Router()


router.post('/', async (req, res) => {
    //! take the password from user and validate it
    const { password: plainTextPassword } = req.body

    //? take the token from header
    const token = req.header('x-auth-token')
    
    //! validate the password if not string
    if (!plainTextPassword || typeof plainTextPassword !== 'string') {
        return res.status(200).json({ status: 'false', message: 'Invalid password' })
    }
    //! validate the password if less than 8 char
    if (plainTextPassword.length < 8) {
        return res.status(200).json({
            status: 'false',
            message: 'Password too small. Should be atleast 8 characters'
        })
    }

    try {
        //* decode the token to get user data
        const user = jwt.verify(token, 'privateKey')
        console.log(user)

        //* get user id 
        const id = user.id
        console.log(id)

        //* incrypt new password
        const newPassword = await bcrypt.hash(plainTextPassword, 10)

        //* find the user by id and change the password
        await User.updateOne(
            { _id: id },
            {
                $set: { password: newPassword }
            }
        )
        console.log(id)
        console.log(newPassword)

        res.status(200).json({ status: 'ok', message: 'password changed' })
    } catch (error) {
        console.log(error)
        res.json({ status: 'false', message: error.message })
    }
})


module.exports = router