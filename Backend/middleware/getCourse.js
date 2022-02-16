
const Course = require('../models/course')
const User = require('../models/user')

module.exports = async function getCourses(req, res, next) {
    let course
    try {
      course = await Course.find().populate('author','-__V').select('-__v')
      if (!course) {
        return res.status(200).json({ status: 'false', message: 'Cannot find courses' })
      }
      res.course = course
    } catch (err) {
      return res.status(500).json({ message: err.message })
    }
  
    res.course = course
    next()
  }

  