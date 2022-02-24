
const Course = require("../models/course");
const Content = require("../models/content");
const Track = require("../models/track");
const Assignment = require("../models/assignment");
const Quiz = require("../models/quiz");

const User = require('../models/user')
const jwt = require('jsonwebtoken')
const mongoose =require('mongoose')
const assignment = require('../models/assignment')
const ObjectId = mongoose.Types.ObjectId;

const authorCtr ={


  uploadCourse : async (req, res) => {
    const { user } = req;
    if (!user)
      return res
        .status(401)
        .json({ success: false, message: 'unauthorized access!' });
       // const { title,  description } = req.body
       const titlee= req.body.title
       const desc = req.body.description

        console.log(titlee)
        const fileUrl = req.files
    console.log(fileUrl)
    const token = req.header('x-auth-token')
  try {
 
   const user = jwt.verify(token, 'privateKey')
    console.log(user)
    const id = user.id
    console.log(id)

    const result = await cloudinary.uploader.upload(fileUrl.tempFilePath, {
        
        public_id: `${user.id}_course`,
        folder: 'course', width: 150, height: 150, crop: "fill"
      });
      console.log(result)
   const course = new Course({
     title:titlee,
     description:desc,
     /*price:req.body.price,
     discount:req.body.discount,
     lastUpdate:req.body.lastUpdate,
     totalTime:req.body.totalTime,
     language:req.body.language,
     review:req.body.review,*/
    imageUrl:result.url,
    //contents:req.body.contents,
     author:id
   })

    const newCourse = await course.save()
     res.status(201).json(newCourse)
    } catch (error) {
      console.log('Error while uploading profile image', error);
     return res
        .status(500)
        .json({ success: false, message: 'server error, try after some time' });
     
    }},
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

  getAuthorTracksPublished:async(req, res, next) =>{
    let track
    const token = req.header('x-auth-token')
    const check = req.body.check
    try {
      const user = jwt.verify(token, 'privateKey')
     console.log(user)
     const id = user.id 
     console.log(id)
     console.log(check)
     track = await Track.aggregate([
        {
          $match: { author: ObjectId(id),check:check }
        }
      ])
      if (!track) {
        return res.status(200).json({ status: 'false', message: 'Cannot find tracks' })
      }
      console.log(track)
      res.track = track
    } catch (err) {
      console.log(err)
      return res.status(500).json({ message: err })
    }
  
    res.track = track
    next()
  },

  getAuthorAssignment:async(req, res, next) =>{
    let assignment
    const token = req.header('x-auth-token')
    try {
      const user = jwt.verify(token, 'privateKey')
     console.log(user)
     const id = user.id
     console.log(id)
     assignment = await Assignment.aggregate([
        {
          $match: { author: ObjectId(id) }
        }
      ])
      if (!assignment) {
        return res.status(200).json({ status: 'false', message: 'Cannot find tracks' })
      }
      res.assignment = assignment
    } catch (err) {
      console.log(err)
      return res.status(500).json({ message: err })
    }
  
    res.assignment = assignment
    next()
  },
  getAuthorQuiz:async(req, res, next) =>{
    let quiz
    const token = req.header('x-auth-token')
    try {
      const user = jwt.verify(token, 'privateKey')
     console.log(user)
     const id = user.id
     console.log(id)
     quiz = await Quiz.aggregate([
        {
          $match: { author: ObjectId(id) }
        }
      ])
      if (!quiz) {
        return res.status(200).json({ status: 'false', message: 'Cannot find quiz' })
      }
      res.quiz = quiz
    } catch (err) {
      console.log(err)
      return res.status(500).json({ message: err.message })
    }
  
    res.quiz = quiz
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




    deleteCourse: async (req, res) => {
      try {
        await Course.findByIdAndDelete(req.params.id);
  
        res.json({ msg: "Deleted Success!" });
      } catch (err) {
        return res.status(500).json({ msg: err.message });
      }
    },


    deleteContent: async (req, res) => {
      try {
        await Content.findByIdAndDelete(req.params.id);
  
        res.json({ msg: "Deleted Success!" });
      } catch (err) {
        return res.status(500).json({ msg: err.message });
      }
    },


    deleteTrack: async (req, res) => {
      try {
        await Track.findByIdAndDelete(req.params.id);
  
        res.json({ msg: "Deleted Success!" });
      } catch (err) {
        return res.status(500).json({ msg: err.message });
      }
    },


    deleteAssignment: async (req, res) => {
      try {
        await Assignment.findByIdAndDelete(req.params.id);
  
        res.json({ msg: "Deleted Success!" });
      } catch (err) {
        return res.status(500).json({ msg: err.message });
      }
    },

    deleteQuiz: async (req, res) => {
      try {
        await Quiz.findByIdAndDelete(req.params.id);
  
        res.json({ msg: "Deleted Success!" });
      } catch (err) {
        return res.status(500).json({ msg: err.message });
      }
    },
}
module.exports = authorCtr;

  