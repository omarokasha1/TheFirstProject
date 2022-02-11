const express = require('express')
const User = require('../models/user');
const JWT_SECRET = 'kdhakjdhwdhqwiu;hdl/akjd;lakhdulhdw$$@$#^324uoqdald'
const router = express.Router()
const auth = require('../middleware/auth')

//* middleware auth check first if user loged in and have a token 
router.get('/', auth, async (req, res) => {
    //* find the user info by his id and not show the password at response
    const profile = await User.findById(req.user.id).select('-password -__v -isAdmin')
    console.log(req.params.id)
    console.log(profile)
    res.json({ profile })
})

module.exports = router