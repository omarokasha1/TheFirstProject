
const Course = require('../models/course')
const Content = require('../models/content')
const Track = require('../models/track')

const User = require('../models/user')
const jwt = require('jsonwebtoken')
const mongoose =require('mongoose')
const ObjectId = mongoose.Types.ObjectId;

const authorCtr ={
getCourses: async(req, res, next) =>{
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
  },

getAuthorContents:async(req, res, next)=> {
    let content
    const token = req.header('x-auth-token')
    try {
      const user = jwt.verify(token, 'privateKey')
     console.log(user)
     const id = user.id
     console.log(id)
      content = await Content.aggregate([
        {
          $match: { author: ObjectId(id) }
        }
      ])
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
  },

  getAuthorCourses:async(req, res, next)=> {
    let course
    const token = req.header('x-auth-token')
    try {
      const user = jwt.verify(token, 'privateKey')
     console.log(user)
     const id = user.id
     console.log(id)
      course = await Course.aggregate([
        {
          $match: { author: ObjectId(id) }
        }
      ])
      if (!course) {
        return res.status(200).json({ status: 'false', message: 'Cannot find courses' })
      }
      res.course = course
    } catch (err) {
      console.log(err)
      return res.status(500).json({ message: err })
    }
  
    res.course = course
    next()
  },

    getAuthorTracks:async(req, res, next) =>{
    let track
    const token = req.header('x-auth-token')
    try {
      const user = jwt.verify(token, 'privateKey')
     console.log(user)
     const id = user.id
     console.log(id)
     track = await Track.aggregate([
        {
          $match: { author: ObjectId(id) }
        }
      ])
      if (!track) {
        return res.status(200).json({ status: 'false', message: 'Cannot find tracks' })
      }
      res.track = track
    } catch (err) {
      console.log(err)
      return res.status(500).json({ message: err })
    }
  
    res.track = track
    next()
  },

    getUsers:async(req, res, next)=> {
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
  },
}
module.exports = authorCtr;

  