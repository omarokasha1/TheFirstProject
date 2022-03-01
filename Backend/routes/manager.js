const express = require('express')

const Course = require('../models/course')

const router = express.Router()
const auth = require('../middleware/auth')
const manager = require('../middleware//manager')
const author = require('../middleware/author')
const admin = require('../middleware/admin')

const authorCtrl = require('../controllers/authorController')
const managerCtrl=require('../controllers/managerController')




//* ______________________________________________GETTING REQUESTS________________________________

//* Getting Promot Requests
router.get('/promotRequest',[auth,manager,managerCtrl.getPromotRequest] )

router.get('/enrollRequest',[auth,manager,managerCtrl.getEnrollRequest] )

router.get('/courseRequest',[auth,manager,managerCtrl.getCourseRequest] )




//? _________________________________________________UPDATE USER ROLE______________________________

//? Updating user role
router.put('/accept-promot',[ auth,manager,managerCtrl.acceptPromotRequest])

//? Updating user enroll request
router.put('/accept-enroll',[ auth,manager,managerCtrl.acceptEnrollRequest])

//? Updating user enroll request
router.put('/accept-course',[ auth,manager,managerCtrl.acceptCourseRequest])

//!_________________________________________________________DELETE REQUEST_______________________________

//! Delete request
router.delete('/delete-request', [auth, manager],managerCtrl.deleteRequest)

//! Delete request
router.delete('/delete-enroll', [auth, manager],managerCtrl.deleteEnrollRequest)

module.exports = router