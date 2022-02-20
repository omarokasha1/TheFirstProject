const express = require('express')
const router = express.Router()
const User = require('../models/user')
const auth = require('../middleware/auth')
const admin = require('../middleware/admin')
const getCourses = require('../middleware/getCourse')
const jwt = require('jsonwebtoken')
const _= require('lodash')
const Course = require('../models/course')
const Content = require('../models/content')
const cloudinary = require('../controllers/cloudinary')


const multer = require('multer');
const path = require('path')
//define storage for the images

const storage = multer.diskStorage({
  //destination for files
  destination: function (request, file, callback) {
    callback(null, './uploads/');
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
    fieldSize: 1024 * 1024 * 2,
  },
});

// Getting all
//* get courses middleware
router.get('/',getCourses, async (req, res) => {
  res.status(200).json({status : "ok",courses:res.course})
})

router.get('/AuthorContent',getContent, async (req, res) => {
  res.status(200).json({status : "ok",contents:res.content})
})

// Getting One
router.get('/:title', getCourse, (req, res) => {

  res.json(res.course)
})

// Creating one
router.post('/newCourse', [auth,upload.single('imageUrl')],async (req, res) => {

  
   const fileUrl = req.file.path
  console.log(fileUrl)
  const token = req.header('x-auth-token')
  try {
    const user = jwt.verify(token, 'privateKey')
    console.log(user)
    const id = user.id
    console.log(id)
    const result = await cloudinary.uploader.upload(fileUrl, {
        
      public_id: `${user.id}_course`,
      folder: 'course', width: 150, height: 150, crop: "fill"
    });
    console.log(result)

   const course = new Course({
     title:req.body.title,
     description:req.body.description,
     price:req.body.price,
     discount:req.body.discount,
     lastUpdate:req.body.lastUpdate,
     totalTime:req.body.totalTime,
     language:req.body.language,
     review:req.body.review,
    imageUrl:result.url,
    contents:req.body.contents,
     author:id
   })

    const newCourse = await course.save()
    res.status(201).json(newCourse)
  } catch (err) {
    console.log(err)
    res.status(400).json({ message: err })
  }
})
// Creating content
router.post('/newContent', [auth,upload.single('imageUrl')],async (req, res) => {

  const uploadType=req.body.enumType
  console.log(uploadType)
 // const fileUrl = req.file.path
 const token = req.header('x-auth-token')
 try {
   const user = jwt.verify(token, 'privateKey')
   console.log(user)
   const id = user.id
   console.log(id)
   /* const result = await cloudinary.uploader.upload(fileUrl, {
  
     public_id: `${user.id}_content`,
     folder: 'content', width: 1920, height: 1080, crop: "fill"
   });
   console. */

   const content = new Content({
    contentTitle:req.body.contentTitle,
    contentDuration:req.body.contentDuration,
   // imageUrl:result.url,
    contentType:req.body.contentType,
    description:req.body.description,
     author:id
   })

   const newContent = await content.save()
   res.status(201).json(newContent)
 } catch (err) {
   console.log(err)
   res.status(400).json({ message: err })
 }
})

// Deleting One
router.delete('/:id', [auth, admin], getUsers, async (req, res) => {
  try {
    await res.user.remove()
    res.json({ message: 'Deleted User' })
  } catch (err) {
    res.status(500).json({ message: err.message })
  }
})

async function getCourse(req, res, next) {
  let course
 
  try {
    course = await Course.find({title:req.params.title}).populate('author').select('-__v')
    if (!course) {
      return res.status(200).json({ status: 'false', message: 'Cannot find course' })
    }
    res.course = course
  } catch (err) {
    return res.status(500).json({ message: err.message })
  }

  res.course = course
  next()
}

async function getContent(req, res, next) {
  let content
  const token = req.header('x-auth-token')
  try {
    const user = jwt.verify(token, 'privateKey')
   console.log(user)
   const id = user.id
   console.log(id)
    content = await Content.find().populate('author').select('-__v')
    if (!content) {
      return res.status(200).json({ status: 'false', message: 'Cannot find contents' })
    }
    res.content = content
  } catch (err) {
    console.log(err)
    return res.status(500).json({ message: err })
  }

  res.content = content
  next()
}
async function getUsers(req, res, next) {
  let user
  try {
    user = await User.findById(req.user.id)
    if (!user) {
      return res.status(200).json({ status: 'false', message: 'Cannot find user' })
    }
    res.user = user
  } catch (err) {
    return res.status(500).json({ message: err.message })
  }

  res.user = user
  next()
}

module.exports = router