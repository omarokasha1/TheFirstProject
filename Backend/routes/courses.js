const express = require('express')

const Course = require('../models/course')

const router = express.Router()
const auth = require('../middleware/auth')
const manager = require('../middleware//manager')
const author = require('../middleware/author')
const admin = require('../middleware/admin')

const authorCtrl = require('../controllers/authorController')
const managerCtrl = require('../controllers/managerController')

const multer = require('multer');
const path = require('path')



//* define storage for the images
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

//* upload parameters for multer
const upload = multer({
  storage: storage,
  limits: {
    fieldSize: 1024 * 1024 * 5,
  },
});

// ____________________________GETTING_________________________________



// get courses middleware
router.get('/allCourses', authorCtrl.getCourses)

// get course middleware
router.get('/getCoursea/:search', authorCtrl.getCourse)

router.get('/getCourse/:id',  authorCtrl.getCourseId)


// get tracks search middleware
router.get('/getTrack/:search', authorCtrl.getTrackSearch)

// get content search middleware
router.get('/getContent/:search', authorCtrl.getContentSearch)

// get course count middleware
router.get('/coursesCount', authorCtrl.getCourseCount)

// get tracks count middleware
router.get('/tracksCount', authorCtrl.getTrackCount)

// get content count middleware
router.get('/contentCount', authorCtrl.getContentCount)

// get course middleware
router.get('/getCourse/:search',authorCtrl.getCourse)

// get tracks search middleware
router.get('/getTrack/:search',authorCtrl.getTrackSearch)

// get content search middleware
router.get('/getContent/:search',authorCtrl.getContentSearch)

// get course count middleware
router.get('/coursesCount',authorCtrl.getCourseCount)

// get tracks count middleware
router.get('/tracksCount',authorCtrl.getTrackCount)

// get content count middleware
router.get('/contentCount',authorCtrl.getContentCount)

// Getting Author Contents
router.get('/authorContents', authorCtrl.getAuthorContents)


// Getting Author Courses
router.get('/authorCourses', authorCtrl.getAuthorCourses)

// Getting Author published Courses
router.get('/authorCoursesPublished', authorCtrl.getAuthorPublishedCourses)

// Getting Author tracks
router.get('/authorTracks', authorCtrl.getAuthorTracks)

// Getting Author published tracks
router.get('/authorTracksPublished', authorCtrl.getAuthorTracksPublished)

// Getting Author published tracks
router.get('/allTracksPublished', authorCtrl.getAllTracksPublished)

// Getting Author published tracks
router.get('/allCoursesPublished', authorCtrl.getAllPublishedCourses)

// Getting Author assignment
router.get('/authorAssignments', authorCtrl.getAuthorAssignment)

// Getting Author quiz
router.get('/authorQuizzes', authorCtrl.getAuthorQuiz)

// Getting Author question
router.get('/authorQuestions', authorCtrl.getAuthorQuestion)



//* ________________________________CREATE_________________________________________

// Creating one Course
router.post('/newCourse', [auth, author, upload.single('imageUrl'), authorCtrl.createCourse])
// Creating content
router.post('/newContent', [auth, author, upload.single('imageUrl'), authorCtrl.createContent])

// Creating one Track
router.post('/newTrack', [auth, author, upload.single('imageUrl'), authorCtrl.createTrack])

// Creating assignment
router.post('/newAssignment', [auth, author, upload.single('fileUrl'), authorCtrl.createAssignment])

// Creating question
router.post('/newQuestion', [auth, author, authorCtrl.createQuestion])
// Creating quiz
router.post('/newQuiz', [auth, author, authorCtrl.createQuiz])

// Creating course Request
router.post('/courseRequest', [auth, author, authorCtrl.courseRequest])

// Creating track Request
router.post('/trackRequest', [auth, author, authorCtrl.trackRequest])



//? ____________________________________UPDATE____________________________________________

//? Updating One Course
router.put('/update-course', [auth, author, upload.single('imageUrl'), authorCtrl.updateCourse])

//? Updating One Content
router.put('/update-content', [auth, author, upload.single('imageUrl'), authorCtrl.updateContent])

//? Updating One Track
router.put('/update-track', [auth, author, upload.single('imageUrl'), authorCtrl.updateTrack])

//? Updating One Assignment
router.put('/update-assignment', [auth, author, upload.single('fileUrl'), authorCtrl.updateAssignment])

//? Updating One Quiz
router.put('/update-quiz', [auth, author, authorCtrl.updateQuiz])

//? Updating One Question
router.put('/update-question', [auth, author, authorCtrl.updateQuestion])





//! _____________________________________________DELETE_____________________________________

//! Deleting course
router.delete('/delete-course/:id', [auth, author], authorCtrl.deleteCourse)
router.delete('/delete-courses/:id', [auth, author], authorCtrl.deleteCourses)


//! Deleting content
router.delete('/delete-content/:id', [auth, author], authorCtrl.deleteContent)
router.delete('/delete-contents/:id', [auth, author], authorCtrl.deleteContents)


//! Deleting Track
router.delete('/delete-track/:id', [auth, author], authorCtrl.deleteTrack)


//! Deleting assignment
router.delete('/delete-assignment/:id', [auth, author], authorCtrl.deleteAssignment)

//! Deleting assignment
router.delete('/delete-quiz/:id', [auth, author], authorCtrl.deleteQuiz)

//! Deleting assignment
router.delete('/delete-question/:id', [auth, author], authorCtrl.deleteQuestion)




//! Deleting One
router.delete('/:id', [auth, admin], authorCtrl.getUsers, async (req, res) => {
  try {
    await res.user.remove()
    res.json({ message: 'Deleted User' })
  } catch (err) {
    res.status(500).json({ message: err.message })
  }
})


module.exports = router