const express = require('express')
const User = require('../models/user');
const jwt = require('jsonwebtoken')
const JWT_SECRET = 'kdhakjdhwdhqwiu;hdl/akjd;lakhdulhdw$$@$#^324uoqdald'
const router = express.Router()
const auth = require('../middleware/auth')

const multer = require('multer');
const path = require('path');
const { update } = require('lodash');
//define storage for the images

const storage = multer.diskStorage({
  //destination for files
  destination: function (request, file, callback) {
    callback(null, './uploads');
  },

  //add back the extension
  filename: function (request, file, callback) {
    let ext = path.extname(file.originalname)
    callback(null, Date.now() + ext);
  },
});

//upload parameters for multer
const upload = multer({
  storage: storage,
  limits: {
    fieldSize: 1024 * 1024 * 3,
  },
});

//* middleware auth check first if user loged in and have a token 
router.get('/', auth, async (req, res) => {
  //* find the user info by his id and not show the password at response
  const profile = await User.findById(req.user.id).select('-password -__v -isAdmin -isAuthor')
  console.log(req.params.id)
  console.log(profile)
  res.json({ profile })
})

// Updating One
router.put('/update',[ upload.single('imageUrl'),auth], async (req, res) => {
  const { userName, email, phone } = req.body
   // console.log(userName.replace(/\s+/g, ''))
 //   let userNameCheck =userName.replace(/\s+/g, '')
    
   
    const validateError = validateUser(req.body)

    //* if validate error just send to user an error message
    if (validateError.error) {
        return res.json({status:"false", message: validateError.error.details[0].message })
    }
  const token = req.header('x-auth-token')
  try {
    const user = jwt.verify(token, 'privateKey')
    console.log(user)
    const id = user.id
    console.log(id)
    if(req.file){
      await User.updateOne(
        { _id: id },
        {
          $set: {
            imageUrl:req.file.filename
          }
        }
      )
    }else{
        await User.updateOne(
      { _id: id },
      {
        $set: req.body
      }
    )
    }

  

    res.json({ status: 'ok', message: ' changed', })
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