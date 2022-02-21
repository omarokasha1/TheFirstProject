const express = require('express')
const router = express.Router()
const auth = require('../middleware/auth')
const admin = require('../middleware/admin')
const authCtrl = require('../controllers/authController')
const jwt = require('jsonwebtoken')
const Course = require('../models/course')
const Content = require('../models/content')
const Track = require('../models/track')
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
router.get('/allCourses',authCtrl.getCourses, async (req, res) => {
  res.status(200).json({status : "ok",courses:res.course})
})
// Getting Author Contents
router.get('/authorContent',authCtrl.getAuthorContents, async (req, res) => {
  res.status(200).json({status : "ok",contents:res.content})
})

// Getting Author Courses
router.get('/authorCourse',authCtrl.getAuthorCourses, (req, res) => {

  res.status(200).json({status : "ok",courses:res.course})
})

// Getting Author tracks
router.get('/authorTracks', authCtrl.getAuthorTracks, (req, res) => {

  res.status(200).json({status : "ok",tracks:res.track})
})

// Creating one Course
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
  const fileUrl = req.file.path
 const token = req.header('x-auth-token')
 try {
   const user = jwt.verify(token, 'privateKey')
   console.log(user)
   const id = user.id
   console.log(id)
   const result = await cloudinary.uploader.upload(fileUrl, {
  
     public_id: `${user.id}_content`,
     folder: 'content', width: 1920, height: 1080, crop: "fill"
   });

   const content = new Content({
    contentTitle:req.body.contentTitle,
    contentDuration:req.body.contentDuration,
    imageUrl:result.url,
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

// Creating one Track
router.post('/newTrack', [auth,upload.single('imageUrl')],async (req, res) => {
//const {trackName,description,duration,courses} = req.body
 
  const fileUrl = req.file.path
 const token = req.header('x-auth-token')
 try {
   const user = jwt.verify(token, 'privateKey')
   console.log(user)
   const id = user.id
   console.log(id)
   const result = await cloudinary.uploader.upload(fileUrl, {
  
    public_id: `${user.id}_track`,
    folder: 'track', width: 1920, height: 1080, crop: "fill"
  });

  const track = new Track({
    trackName:req.body.trackName,
    description:req.body.description, 
    duration:req.body.duration,
   imageUrl:result.url,
    author:id,
    courses:req.body.courses,
  })
  console.log(track)
   const newTrack = await track.save()
   res.status(201).json(newTrack)
 } catch (err) {
   console.log(err)
   res.status(400).json({ message: err })
 }
})
// Deleting One
router.delete('/:id', [auth, admin],authCtrl.getUsers, async (req, res) => {
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

module.exports = router