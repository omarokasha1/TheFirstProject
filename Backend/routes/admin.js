const express = require('express')

const Course = require('../models/course')

const router = express.Router()
const auth = require('../middleware/auth')
const manager = require('../middleware//manager')
const author = require('../middleware/author')
const admin = require('../middleware/admin')

const authorCtrl = require('../controllers/authorController')
const managerCtrl = require('../controllers/managerController')
const adminCtrl = require('../controllers/adminController')




//* getting all users
router.get('/allUsers', [auth, admin, adminCtrl.getAllUsers])

//* getting all users
router.get('/allAuthors', [auth, admin, adminCtrl.getAllAuthors])

//* getting all users
router.get('/allManagers', [auth, admin, adminCtrl.getAllManagers])

//? Updating user role
router.put('/promot-manager', [auth, admin, adminCtrl.managerPromot])



module.exports = router