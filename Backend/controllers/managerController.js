const Course = require("../models/course");
const Content = require("../models/content");
const Track = require("../models/track");
const Assignment = require("../models/assignment");
const Quiz = require("../models/quiz");
const Question = require("../models/question")
const User = require('../models/user')
const {RequestToManager,courseRequest,enrollRequest} = require('../models/manager')

const cloudinary = require('./cloudinary')
const jwt = require('jsonwebtoken')
const mongoose =require('mongoose');
const manager = require("../middleware/manager");
const ObjectId = mongoose.Types.ObjectId;


const managerCtrl={

    //* _______________________________________Getting REQUESTS____________________________
    getPromotRequest:async(req, res, next) =>{
        let promotRequest
        const token = req.header('x-auth-token')
      
        try {
          const user = jwt.verify(token, 'privateKey')
         console.log(user)
         const id = user.id
         console.log(id)
         promotRequest = await RequestToManager.find().select('-__v -userEnrolled -trackPublished -coursePublished')
          if (!promotRequest) {
            return res.status(200).json({ status: 'false', message: 'Cannot find question' })
          }
          return res.status(200).json({status : "ok",message:'get Author Promot Success',promotRequests:promotRequest})
        } catch (err) {
          console.log(err)
          return res.status(500).json({status:'false', message: err.message })
        }
      
       },

       getEnrollRequest:async(req, res, next) =>{
        let enrollRequests
        const token = req.header('x-auth-token')
      
        try {
          const user = jwt.verify(token, 'privateKey')
         console.log(user)
         const id = user.id
         console.log(id)
         enrollRequests = await enrollRequest.find().select(' -__v ')
          if (!enrollRequests) {
            return res.status(200).json({ status: 'false', message: 'Cannot find Enroll Request' })
          }
          return res.status(200).json({status : "ok",message:'Get User Enroll Course Success',userEnrolled:enrollRequests})
        } catch (err) {
          console.log(err)
          return res.status(500).json({status:'false', message: err.message })
        }
      
       },

       getCourseRequest:async(req, res, next) =>{
        let courseRequests
        const token = req.header('x-auth-token')
      
        try {
          const user = jwt.verify(token, 'privateKey')
         console.log(user)
         const id = user.id
         console.log(id)
         courseRequests = await courseRequest.find().select(' -__v ')
          if (!courseRequests) {
            return res.status(200).json({ status: 'false', message: 'Cannot find courses Request' })
          }
          return res.status(200).json({status : "ok",message:'Get User Enroll Course Success',courseRequests:courseRequests})
        } catch (err) {
          console.log(err)
          return res.status(500).json({status:'false', message: err.message })
        }
      
       },


    //* _______________________________________CREATE REQUEST______________________________
    

    //? _______________________________________ACCEPT REQUEST AND UPDATE_____________________

      acceptPromotRequest:async(req,res)=>{
       const userRequestId = req.body.userRequestId
        let promotRequested
        console.log(userRequestId)
    try{
      promotRequested = await RequestToManager.findOne({authorPromoted:ObjectId(userRequestId)})
      console.log('here' + promotRequested._id)
    
        await User.updateOne(
          { _id: userRequestId },
          {
            $set: {isAuthor:true}
          }
       )
       await promotRequested.remove()
      res.json({ status: 'ok', message: ' changed', })
    } catch (error) {
      return res.status(500).json({ status: 'false', message: error.message})
    }
      },

      acceptEnrollRequest:async(req,res)=>{
        const userId = req.body.userId
         let enrollRequested
         console.log(userId)
     try{
        enrollRequested = await enrollRequest.findOne({userId:userId})
       console.log('here' + enrollRequested)
       console.log('here' + enrollRequested.id)

     
         await User.updateOne(
           { _id: userId },
           {
             $set: {myCourses:req.body.courseId}
           }
        )
        await enrollRequested.remove()
       res.json({ status: 'ok', message: ' changed', })
     } catch (error) {
         console.log(error)
       return res.status(500).json({ status: 'false', message: error.message})
     }
       },

       acceptCourseRequest:async(req,res)=>{
        const authorId = req.body.authorId
        const courseId = req.body.courseId
         let courseRequested
         console.log(authorId)
         console.log(courseId)
     try{
        courseRequested = await courseRequest.findOne({userId:authorId})
       console.log('here' + courseRequested)
       console.log('here' + courseRequested.id)

     
         await Course.updateOne(
           { _id: courseId },
           {
             $set: {isPublished:true}
           }
        )
        await courseRequested.remove()
       res.json({ status: 'ok', message: ' changed', })
     } catch (error) {
         console.log(error)
       return res.status(500).json({ status: 'false', message: error.message})
     }
       },


      //! ______________________________________DELETE REQUEST________________________________

      deleteRequest : async (req, res) => {
        const userRequestId = req.body.userRequestId
        let promotRequested
        try {
            promotRequested = await RequestToManager.findOne({authorPromoted:ObjectId(userRequestId)})
          await RequestToManager.findByIdAndDelete(promotRequested);
    
        return  res.json({status:'ok', message: "Deleted Success!" });
        } catch (err) {
          return res.status(500).json({status:'false', message: err.message });
        }
      },

      deleteEnrollRequest : async (req, res) => {
        const userRequestId = req.body.userRequestId
        console.log(userRequestId)
        let enrollRequested
        try {
            enrollRequested = await enrollRequest.findOne({userId:ObjectId(userRequestId)})

          await enrollRequest.findByIdAndDelete(enrollRequested);
    
        return  res.json({status:'ok', message: "Deleted Success!" });
        } catch (err) {
          return res.status(500).json({status:'false', message: err.message });
        }
      },

};

module.exports=managerCtrl;