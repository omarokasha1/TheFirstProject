const express = require('express')
const router = express.Router()
const User = require('../models/user')
const auth = require('../middleware/auth')
const admin = require('../middleware/admin')
const getCourses = require('../middleware/getCourse')

const _= require('lodash')
const Course = require('../models/course')


// Getting all
//* get courses middleware
router.get('/',getCourses, async (req, res) => {
  res.status(200).json({status : "ok",courses:res.course})
})

// Getting One
router.get('/:title', getCourse, (req, res) => {

  res.json(res.course)
})

// Creating one
router.post('/newCourse', async (req, res) => {

  //* const { title,  description,author } = req.body
 
  try {
   const course = new Course(_.pick(req.body, ['title', 'description',
   'imageUrl','totalTime','requiremnets',
   'price','discount','language','review','lastUpdate', 'author']))

    const newCourse = await course.save()
    res.status(201).json(newCourse)
  } catch (err) {
    res.status(400).json({ message: err.message })
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
    course = await Course.find({title:req.params.title}).populate('author')
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