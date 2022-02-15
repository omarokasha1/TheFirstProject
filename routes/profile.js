const express = require('express')
const User = require('../models/user');
const jwt = require('jsonwebtoken')
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

// Updating One
router.put('/update', auth, async (req, res) => {
  const token = req.header('x-auth-token')
  try {
    const user = jwt.verify(token, 'privateKey')
    console.log(user)
    const id = user.id
    console.log(id)

    await User.updateOne(
      { _id: id },
      {
        $set: req.body
      }
    )

    res.json({ status: 'ok', message: ' changed', },)
  } catch (error) {
    if (error.code === 11000) {
      return res.json({ status: 'false', message: 'in use' })
    }
    throw error
  }
})

// Getting all
router.get('/allUsers', async (req, res) => {
  try {
    const users = await User.find().select('-__v')
     res.status(200).json({status : "ok",message:"get users",users})
  } catch (err) {
    res.status(500).json({ message: err.message })
  }
})

module.exports = router