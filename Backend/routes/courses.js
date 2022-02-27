const express = require('express')

const Course = require('../models/course')

const router = express.Router()
const auth = require('../middleware/auth')
const author = require('../middleware/author')
const admin = require('../middleware/admin')

const authorCtrl = require('../controllers/authorController')

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

//* ____________________________GETTING_________________________________

//* get courses middleware
router.get('/allCourses',authorCtrl.getCourses)
// Getting Author Contents
router.get('/authorContents',authorCtrl.getAuthorContents)

// Getting Author Courses
router.get('/authorCourses',authorCtrl.getAuthorCourses)

// Getting Author tracks
router.get('/authorTracks', authorCtrl.getAuthorTracks)

// Getting Author tracks
router.get('/authorTracksPublished', authorCtrl.getAuthorTracksPublished)

// Getting Author assignment
router.get('/authorAssignments', authorCtrl.getAuthorAssignment)

// Getting Author quiz
router.get('/authorQuizes', authorCtrl.getAuthorQuiz)

// Getting Author question
router.get('/authorQuestions', authorCtrl.getAuthorQuestion)

//* ________________________________CREATE_________________________________________
// Creating one Course
router.post('/newCourse', [auth,author,upload.single('imageUrl'),authorCtrl.createCourse])
// Creating content
router.post('/newContent', [auth,author,upload.single('imageUrl'),authorCtrl.createContent])

// Creating one Track
router.post('/newTrack', [auth,author,upload.single('imageUrl'),authorCtrl.createTrack])

// Creating assignment
router.post('/newAssignment', [auth,author,upload.single('fileUrl'),authorCtrl.createAssignment])

// Creating question
router.post('/newQuestion', [auth,author,authorCtrl.createQuestion])
// Creating quiz
router.post('/newQuiz', [auth,author,authorCtrl.createQuiz])


//? _____________________________________UPDATE____________________________________________
// Updating One Course
router.put('/update-Course',[auth,author, upload.single('imageUrl'),authorCtrl.updateCourse])

// Updating One Content
router.put('/update-Content',[auth,author, upload.single('imageUrl'),authorCtrl.updateContent])

// Updating One Track
router.put('/update-Track',[auth,author, upload.single('imageUrl'),authorCtrl.updateTrack])
// Updating One Assignment
router.put('/update-Assignment',[ auth,author,upload.single('imageUrl'),authorCtrl.updateAssignment])

// Updating One Quiz
router.put('/update-Quiz',[ auth,author,authorCtrl.updateQuiz])

// Updating One Question
router.put('/update-Question',[ auth,author,authorCtrl.updateQuestion])


//! _____________________________________________DELETE_____________________________________

// Deleting course
router.delete('/delete-course/:id', [auth, author],authorCtrl.deleteCourse)

// Deleting content
router.delete('/delete-content/:id', [auth, author],authorCtrl.deleteContent)
router.delete('/delete-contents/:id', [auth, author],authorCtrl.deleteContents)


// Deleting Track
router.delete('/delete-track/:id', [auth, author],authorCtrl.deleteTrack)


// Deleting assignment
router.delete('/delete-assignment/:id', [auth, author],authorCtrl.deleteAssignment)

// Deleting assignment
router.delete('/delete-quiz/:id', [auth, author],authorCtrl.deleteQuiz)

// Deleting assignment
router.delete('/delete-question/:id', [auth, author],authorCtrl.deleteQuestion)

// Deleting One
router.delete('/:id', [auth, admin],authorCtrl.getUsers, async (req, res) => {
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