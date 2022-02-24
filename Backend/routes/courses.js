const express = require('express')

const Course = require('../models/course')
const Content = require('../models/content')
const Assignmet = require('../models/assignment')
const Track = require('../models/track')
const Quiz = require('../models/quiz')

const router = express.Router()
const auth = require('../middleware/auth')
const author = require('../middleware/author')
const admin = require('../middleware/admin')

const courseCtrl = require('../controllers/courseController')
const authCtrl = require('../controllers/authController')

const jwt = require('jsonwebtoken')
const cloudinary = require('../controllers/cloudinary')
const multer = require('multer');
const path = require('path')
const Question = require('../models/question')


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

//* ____________________________GETTING_________________________________

//* get courses middleware
router.get('/allCourses',authCtrl.getCourses, async (req, res) => {
  res.status(200).json({status : "ok",courses:res.course})
})
// Getting Author Contents
router.get('/authorContents',authCtrl.getAuthorContents, async (req, res) => {
  res.status(200).json({status : "ok",contents:res.content})
})

// Getting Author Courses
router.get('/authorCourses',authCtrl.getAuthorCourses, (req, res) => {

  res.status(200).json({status : "ok",courses:res.course})
})

// Getting Author tracks
router.get('/authorTracks', authCtrl.getAuthorTracks, (req, res) => {

  res.status(200).json({status : "ok",tracks:res.track})
})

// Getting Author tracks
router.get('/authorTracksPublished', authCtrl.getAuthorTracksPublished, (req, res) => {

  res.status(200).json({status : "ok",tracks:res.track})
})

// Getting Author assignment
router.get('/authorAssignments', authCtrl.getAuthorAssignment, (req, res) => {

  res.status(200).json({status : "ok",assignments:res.assignment})
})

// Getting Author quiz
router.get('/authorQuizes', authCtrl.getAuthorQuiz, (req, res) => {

  res.status(200).json({status : "ok",quizes:res.quiz})
})

//* ________________________________CREATE_________________________________________
// Creating one Course
router.post('/newCourse', [auth,author,upload.single('imageUrl')],async (req, res) => {

  
  // const fileUrl = req.file
 // console.log(fileUrl)
  const token = req.header('x-auth-token')
  try {
    const user = jwt.verify(token, 'privateKey')
    console.log(user)
    const id = user.id
    console.log(id)
    // let index = 1
    // const result = await cloudinary.uploader.upload(fileUrl.path, {
        
    //   public_id: `${user.id}_course${Date.now()}`,
    //   folder: 'course', width: 150, height: 150, crop: "fill"
    // });
    // console.log(index)
    // console.log(result)

   const course = new Course({
     title:req.body.title,
     description:req.body.description,
     price:req.body.price,
     discount:req.body.discount,
     lastUpdate:req.body.lastUpdate,
     totalTime:req.body.totalTime,
     language:req.body.language,
     review:req.body.review,
    //imageUrl:result.url,
    imageUrl:req.body.imageUrl,
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
router.post('/newContent', [auth,author,upload.single('imageUrl')],async (req, res) => {
  req.headers['content-type'] = 'application/json';
  const uploadType=req.body.enumType
  console.log(uploadType)
  //const fileUrl = req.file
  console.log("hhhhhhhhhhhhhhhhhhhhhhh")
  //console.log(fileUrl)
 const token = req.header('x-auth-token')
 try {
   const user = jwt.verify(token, 'privateKey')
   console.log(user)
   const id = user.id
   console.log(id)
  //  const result = await cloudinary.uploader.upload(fileUrl.path, {
  
  //    public_id: `${user.id}_content${Date.now()}`,
  //    folder: 'content', width: 1920, height: 1080, crop: "fill"
  //  });

   const content = new Content({
    contentTitle:req.body.contentTitle,
    contentDuration:req.body.contentDuration,
    imageUrl:req.body.imageUrl,
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
router.post('/newTrack', [auth,author,upload.single('imageUrl')],async (req, res) => {
//const {trackName,description,duration,courses} = req.body
 
  //const fileUrl = req.file
 const token = req.header('x-auth-token')
 try {
   const user = jwt.verify(token, 'privateKey')
   console.log(user)
   const id = user.id
   console.log(id)
  //  const result = await cloudinary.uploader.upload(fileUrl.path, {
  
  //   public_id: `${user.id}_track${Date.now()}`,
  //   folder: 'track', width: 1920, height: 1080, crop: "fill"
  // });

  const track = new Track({
    trackName:req.body.trackName,
    description:req.body.description, 
    duration:req.body.duration,
    check:req.body.check,
   imageUrl:req.body.imageUrl,
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

// Creating assignment
router.post('/newAssignment', [auth,author,upload.single('fileUrl')],async (req, res) => {

  
  
  //const fileUrl = req.file
 const token = req.header('x-auth-token')
 try {
   const user = jwt.verify(token, 'privateKey')
   console.log(user)
   const id = user.id
   console.log(id)
  //  const result = await cloudinary.uploader.upload(fileUrl.path, {
  
  //    public_id: `${user.id}_assignment`,
  //    folder: 'assignment', width: 1920, height: 1080, crop: "fill"
  //  });

   const assignment = new Assignmet({
    assignmentTitle:req.body.assignmentTitle,
    assignmentDuration:req.body.assignmentDuration,
    fileUrl:req.body.fileUrl,
    description:req.body.description,
     author:id
   })

   const newAssignment = await assignment.save()
   res.status(201).json(newAssignment)
 } catch (err) {
   console.log(err)
   res.status(400).json({ message: err })
 }
})

// Creating question
router.post('/newQuestion', [auth,author],async (req, res) => {

 const token = req.header('x-auth-token')
 try {
   const user = jwt.verify(token, 'privateKey')
   console.log(user)
   const id = user.id
   console.log(id)

   const question = new Question({
    
      questionTitle:req.body.questionTitle,
      answerIndex:req.body.answerIndex,
      options:req.body.options,
      courses:req.body.courses,
       author:id
    
   })

   const newQuestion = await question.save()
   res.status(201).json(newQuestion)
 } catch (err) {
   console.log(err)
   res.status(400).json({ message: err.message })
 }
})
// Creating quiz
router.post('/newQuiz', [auth,author],async (req, res) => {

  const token = req.header('x-auth-token')
  try {
    const user = jwt.verify(token, 'privateKey')
    console.log(user)
    const id = user.id
    console.log(id)
 
    const quiz = new Quiz({
      quizName:req.body.quizName,
      questions:req.body.questions,
      
       courses:req.body.courses,
        author:id
     
     
    })
 
    const newQuiz = await quiz.save()
    res.status(201).json(newQuiz)
  } catch (err) {
    console.log(err)
    res.status(400).json({ message: err.message })
  }
 })


//? _____________________________________UPDATE____________________________________________
// Updating One Course
router.put('/update-Course',[auth,author, upload.single('imageUrl'),auth], async (req, res) => {
  const { title, description, price,discount,lastUpdate,totalTime,language,review ,imageUrl,contents} = req.body
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
    await Course.updateOne(
        { _id: id },
        {
          $set: req.body
        }
     )
    // if(req.file){
    //   await User.updateOne(
    //     { _id: id },
    //     {
    //       $set: {
    //         imageUrl:req.file.filename
    //       }
    //     }
    //   )
    // }else{
    //     await User.updateOne(
    //   { _id: id },
    //   {
    //     $set: req.body
    //   }
    // )
    // }

  

    res.json({ status: 'ok', message: ' changed', })
  } catch (error) {
    if (error.code === 11000) {
      return res.json({ status: 'false', message: 'in use' })
    }
    throw error
  }
})

// Updating One Content
router.put('/update-Content',[auth,author, upload.single('imageUrl'),auth], async (req, res) => {
  const { contentTitle, contentDuration, imageUrl,createdAt,enumType,description} = req.body
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
    await Content.updateOne(
        { _id: id },
        {
          $set: req.body
        }
     )
    // if(req.file){
    //   await User.updateOne(
    //     { _id: id },
    //     {
    //       $set: {
    //         imageUrl:req.file.filename
    //       }
    //     }
    //   )
    // }else{
    //     await User.updateOne(
    //   { _id: id },
    //   {
    //     $set: req.body
    //   }
    // )
    // }

  

    res.json({ status: 'ok', message: ' changed', })
  } catch (error) {
    if (error.code === 11000) {
      return res.json({ status: 'false', message: 'in use' })
    }
    throw error
  }
})

// Updating One Track
router.put('/update-Track',[auth,author, upload.single('imageUrl'),auth], async (req, res) => {
  const { trackName, description, duration,imageUrl,check,courses} = req.body
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
    await Track.updateOne(
        { _id: id },
        {
          $set: req.body
        }
     )
    // if(req.file){
    //   await User.updateOne(
    //     { _id: id },
    //     {
    //       $set: {
    //         imageUrl:req.file.filename
    //       }
    //     }
    //   )
    // }else{
    //     await User.updateOne(
    //   { _id: id },
    //   {
    //     $set: req.body
    //   }
    // )
    // }

  

    res.json({ status: 'ok', message: ' changed', })
  } catch (error) {
    if (error.code === 11000) {
      return res.json({ status: 'false', message: 'in use' })
    }
    throw error
  }
})
// Updating One Assignment
router.put('/update-Assignment',[ auth,author,upload.single('imageUrl'),auth], async (req, res) => {
  const { assignmentTitle, assignmentDuration, fileUrl,createdAt,description} = req.body
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
    await Assignmet.updateOne(
        { _id: id },
        {
          $set: req.body
        }
     )
    // if(req.file){
    //   await User.updateOne(
    //     { _id: id },
    //     {
    //       $set: {
    //         imageUrl:req.file.filename
    //       }
    //     }
    //   )
    // }else{
    //     await User.updateOne(
    //   { _id: id },
    //   {
    //     $set: req.body
    //   }
    // )
    // }

  

    res.json({ status: 'ok', message: ' changed', })
  } catch (error) {
    if (error.code === 11000) {
      return res.json({ status: 'false', message: 'in use' })
    }
    throw error
  }
})

// Updating One Assignment
router.put('/update-Quiz',[ auth,author], async (req, res) => {
  const { questionTitle, answerIndex, options,courses} = req.body
    
  const token = req.header('x-auth-token')
  try {
    const user = jwt.verify(token, 'privateKey')
    console.log(user)
    const id = user.id
    console.log(id)
    await Assignmet.updateOne(
        { _id: id },
        {
          $set: req.body
        }
     )
  
    res.json({ status: 'ok', message: ' changed', })
  } catch (error) {
    if (error.code === 11000) {
      return res.json({ status: 'false', message: 'Cannot change' })
    }
    throw error
  }
})


//! _____________________________________________DELETE_____________________________________

// Deleting course
router.delete('/delete-course/:id', [auth, author],authCtrl.deleteCourse)

// Deleting content
router.delete('/delete-content/:id', [auth, author],authCtrl.deleteContent)

// Deleting Track
router.delete('/delete-track/:id', [auth, author],authCtrl.deleteTrack)


// Deleting assignment
router.delete('/delete-assignment/:id', [auth, author],authCtrl.deleteAssignment)

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