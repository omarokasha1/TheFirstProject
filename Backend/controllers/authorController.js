
const Course = require("../models/course");
const Content = require("../models/content");
const Track = require("../models/track");
const Assignment = require("../models/assignment");
const Quiz = require("../models/quiz");
const Question = require("../models/question")
const User = require('../models/user')
const {RequestToManager,courseRequest,enrollRequest,trackRequest} = require('../models/manager')

const cloudinary = require('./cloudinary')
const jwt = require('jsonwebtoken')
const mongoose =require('mongoose');
const { file } = require("googleapis/build/src/apis/file");
const author = require("../middleware/author");
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

  //* _________________________________GET FUNCTION_____________________________________________
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
      course = await Course.find().populate('author','-__v').select('-__v')
      if (!course) {
        return res.status(200).json({ status: 'false', message: 'Cannot find courses' })
      }
     
     return res.status(200).json({status : "ok",message:'get Courses success',courses:course})
    } catch (err) {
      return res.status(500).json({status:"false", message: err.message })
    }
  
   
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
      res.status(200).json({status : "ok",message:'get Author Content Success',contents:content})
    } catch (err) {
      console.log(err)
      return res.status(500).json({status:'false', message: err.message })
    }
  
  // return res.status(200).json({status : "ok",contents:res.content})
   
   },

  getAuthorCourses:async(req, res, next)=> {
    let course
    const token = req.header('x-auth-token')
    try {
      const user = jwt.verify(token, 'privateKey')
     console.log(user)
     const id = user.id
     console.log(id)
      // course = await Course.aggregate([
      //   {
      //     $match: { author: ObjectId(id) }
      //   }
      // ])
      const course = await Course.find({author:ObjectId(id)}).populate('contents','-__v').select('-__v')
      if (!course) {
        return res.status(200).json({ status: 'false', message: 'Cannot find courses' })
      }
      return res.status(200).json({status : "ok",message:'get Author Courses Success',courses:course})
    } catch (err) {
      console.log(err)
      return res.status(500).json({status:'false', message: err.message })
    }
  
  
   },

  getAuthorTracks:async(req, res, next) =>{
    let track
    const token = req.header('x-auth-token')
    try {
      const user = jwt.verify(token, 'privateKey')
     console.log(user)
     const id = user.id
     console.log(id)
      track = await Track.find({author:ObjectId(id)}).populate('courses','-__v').select('-__v')

      if (!track) {
        return res.status(200).json({ status: 'false', message: 'Cannot find tracks' })
      }
   return   res.status(200).json({status : "ok",message:'get Author Tracks Success',tracks:track})
    } catch (err) {
      console.log(err)
      return res.status(500).json({status:'false', message: err.message })
    }
  
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
 
      let track = await Track.find({author:ObjectId(id),isPublished:true}).populate('courses','-__v',).select('-__v')
      if (!track) {
        return res.status(200).json({ status: 'false', message: 'Cannot find tracks' })
      }
      console.log(track)
    return  res.status(200).json({status : "ok",message:'get Author Tracks Published Success',tracks:track})
    } catch (err) {
      console.log(err)
      return res.status(500).json({status:'false', message: err.message })
    }
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
     return   res.status(200).json({status : "ok",message:'get Author Assignment Success',assignments:assignment})
    } catch (err) {
      console.log(err)
      return res.status(500).json({status:'false', message: err.message })
    }
  
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
     return res.status(200).json({status : "ok",message:'get Author Quiz Success',quizes:quiz})
    } catch (err) {
      console.log(err)
      return res.status(500).json({status:'false', message: err.message })
    }

   },

  getAuthorQuestion:async(req, res, next) =>{
    let question
    const token = req.header('x-auth-token')
   
   
    try {
      const user = jwt.verify(token, 'privateKey')
     console.log(user)
     const id = user.id
     console.log(id)
     question = await Quiz.aggregate([
        {
          $match: { author: ObjectId(id) }
        }
      ])
      if (!question) {
        return res.status(200).json({ status: 'false', message: 'Cannot find question' })
      }
      return res.status(200).json({status : "ok",message:'get Author Questions Success',questions:question})
    } catch (err) {
      console.log(err)
      return res.status(500).json({status:'false', message: err.message })
    }
  
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

    //* ______________________________________CREATE FUNCTION__________________________
  createCourse:async(req,res,next)=>{

   const fileUrl = req.file
 // console.log(fileUrl)
  const token = req.header('x-auth-token')
  let newCourse
  try {
    const user = jwt.verify(token, 'privateKey')
    console.log(user)
    const id = user.id
    console.log(id)
    // let index = 1
    // const result = await cloudinary.uploader.upload(fileUrl.path, {
      const result = await cloudinary.uploader.upload(fileUrl.path, {

        public_id: `${user.id}_course${Date.now()}`,
        folder: 'course', width: 1920, height: 1080, crop: "fill"
      });

   const course = new Course({
     title:req.body.title,
     description:req.body.description,
     requirements:req.body.requirements,
     price:req.body.price,
     discount:req.body.discount,
     lastUpdate:req.body.lastUpdate,
     totalTime:req.body.totalTime,
     language:req.body.language,
     review:req.body.review,
    imageUrl:result.url,
    
    contents:req.body.contents,
     author:id
   })

     newCourse = await course.save()
    // res.newCourse = newCourse
   return res.status(201).json({status:'ok',message:'Course Created',course:newCourse})
  } catch (err) {
    console.log(err)
    return res.status(400).json({status:'false', message: err })
  }
  //res.newCourse = newCourse
  //return res.status(201).json(newCourse)
   
  },

  createContent:async(req,res)=>{

    let newContent
    req.headers['content-type'] = 'application/json';
  const uploadType=req.body.enumType
  console.log(uploadType)
  const fileUrl = req.file
  console.log("hhhhhhhhhhhhhhhhhhhhhhh")
  //console.log(fileUrl)
 const token = req.header('x-auth-token')
 try {
   const user = jwt.verify(token, 'privateKey')
   console.log(user)
   const id = user.id
   console.log(id)
   const result = await cloudinary.uploader.upload(fileUrl.path, {
  
     public_id: `${user.id}_content${Date.now()}`,
     folder: 'content', width: 1920, height: 1080, crop: "fill"
   });

   const content = new Content({
    contentTitle:req.body.contentTitle,
    contentDuration:req.body.contentDuration,
    imageUrl:result.url,
    contentType:req.body.contentType,
    description:req.body.description,
    courses:req.body.courses,
     author:id
   })

    newContent = await content.save()
  return res.status(201).json({status:'ok',message:'Content Created Success',content:newContent})
 } catch (err) {
   console.log(err)
 return  res.status(400).json({status:'false', message: err.message })
 }
  },

  createTrack:async(req,res)=>{
let newTrack
  const {trackName,description,check,courses} = req.body

 const token = req.header('x-auth-token')
 const file = req.file
 try {
  
  console.log(file)
   const user = jwt.verify(token, 'privateKey')
   console.log(user)
   const id = user.id
   console.log(id)
   /* if (!file) {
    const error = new Error('Please upload a file')
    error.httpStatusCode = 400
    return res.status(400).json({status:"false",message:error.message})
  } */
    
    
   
    const result = await cloudinary.uploader.upload(file.path, {

      public_id: `${user.id}_track${Date.now()}`,
      folder: 'track', width: 1920, height: 1080, crop: "fill"
    });
    console.log(result.url)
  const track = new Track({
    trackName:req.body.trackName,
    description:req.body.description, 
    duration:req.body.duration,
    check:req.body.check,
   imageUrl:result.url,
    author:id,
    courses:req.body.courses,
  })
  console.log(track)
    newTrack = await track.save()
  return res.status(201).json({status:'ok',message:'Track Created Success',track:newTrack})
 } catch (err) {
   console.log(err)
  return res.status(400).json({status:'false', message: err.message })
 }
  },

  createAssignment:async(req,res)=>{

    let newAssignment
  //const fileUrl = req.file
 const token = req.header('x-auth-token')
 try {
   const user = jwt.verify(token, 'privateKey')
   console.log(user)
   const id = user.id
   console.log(id)
  //  const result = await cloudheaderdth: 1920, height: 1080, crop: "fill"
  //  });

   const assignment = new Assignment({
    assignmentTitle:req.body.assignmentTitle,
    assignmentDuration:req.body.assignmentDuration,
    fileUrl:req.body.fileUrl,
    description:req.body.description,
     author:id
   })

    newAssignment = await assignment.save()
  return res.status(201).json({status:'ok',message:'Assignment Created Success',assignment:newAssignment})
 } catch (err) {
   console.log(err)
  return res.status(400).json({status:'false', message: err.message })
 }
  },

  createQuestion:async(req,res)=>{
let newQuestion

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

    newQuestion = await question.save()
  return res.status(201).json({status:'ok',message:'Question Created Success',question:newQuestion})
 } catch (err) {
   console.log(err)
  return res.status(400).json({status:'false', message: err.message })
 }
  },

  createQuiz:async(req,res)=>{

    let newQuiz
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
 
     newQuiz = await quiz.save()
  return  res.status(201).json({status:'ok',message:'Quiz Created Success',quiz:newQuiz})
  } catch (err) {
    console.log(err)
  return  res.status(400).json({status:'false', message: err.message })
  }
  },

  courseRequest:async(req,res)=>{

    let newRequest
    let enrollCourse
  const token = req.header('x-auth-token')
  try {
    const user = jwt.verify(token, 'privateKey')
    console.log(user)
    const enrollRequestId = user.id
    console.log(enrollRequestId)

    enrollCourse = await courseRequest.findOne({userEnrolled:ObjectId(enrollRequestId)})
 console.log('here' + enrollCourse)

      if (enrollCourse) {
        return res.status(200).json({ status: 'false', message: 'you are already requested' })
      }
   const request = new courseRequest({
    authorId:enrollRequestId,
    courseId:req.body.courseId
   })
   console.log(request)
 
   newRequest = await request.save()
  return  res.status(201).json({status:'ok',message:'Request Created Success',courseRequest:newRequest})
  } catch (err) {
    console.log(err)
  return  res.status(400).json({status:'false', message: err.message })
  }
  },

  trackRequest:async(req,res)=>{

    let newRequest
    let trackRequeted
  const token = req.header('x-auth-token')
  try {
    const user = jwt.verify(token, 'privateKey')
    console.log(user)
    const authorRequestId = user.id
    console.log(authorRequestId)

    trackRequeted = await trackRequest.findOne({userEnrolled:ObjectId(authorRequestId)})
 console.log('here' + trackRequeted)

      if (trackRequeted) {
        return res.status(200).json({ status: 'false', message: 'you are already requested' })
      }
   const request = new trackRequest({
    authorId:authorRequestId,
    trackId:req.body.trackId
   })
   console.log(request)
 
   newRequest = await request.save()
  return  res.status(201).json({status:'ok',message:'Request Created Success',trackRequest:newRequest})
  } catch (err) {
    console.log(err)
  return  res.status(400).json({status:'false', message: err.message })
  }
  },
 

  //? ______________________________________UPDATE FUNCTION_____________________________

  updateCourse:async(req,res)=>{

    const {id, title, description, price,discount,lastUpdate,totalTime,language,review ,contents, requirements} = req.body
    const file = req.file
  const token = req.header('x-auth-token')
  try {
    const user = jwt.verify(token, 'privateKey')
    console.log(user)
    const id = user.id
    console.log(id)

    const result = await cloudinary.uploader.upload(file.path, {

      public_id: `${user.id}_course${Date.now()}`,
      folder: 'course', width: 1920, height: 1080, crop: "fill"
    });
      console.log(result.url)
      console.log(req.body.id)

    await Course.updateOne(
        { _id: req.body.id },
        {
          $set: req.body
        }
     ) 
     await Course.updateOne(
        { _id: req.body.id },
        {
          $set: {
            imageUrl:result.url
          }
        }
      )
  
    return res.json({ status: 'ok', message: ' changed', })
  } catch (error) {
    if (error.code === 11000) {
      return res.json({ status: 'false', message: 'in use' })
    }
    return res.json({ status: 'false', message: error.message})
  }
  },

  updateContent:async(req,res)=>{
    const token = req.header('x-auth-token')
    const { id,contentTitle, contentDuration, imageUrl,createdAt,enumType,description} = req.body
    const file = req.file
 
  try {
    const user = jwt.verify(token, 'privateKey')
    console.log(user)
    const id = user.id
    console.log(id)

    const result = await cloudinary.uploader.upload(file.path, {

      public_id: `${user.id}_content${Date.now()}`,
      folder: 'content', width: 1920, height: 1080, crop: "fill"
    });
      console.log(result.url)
      console.log(req.body.id)
    await Content.updateOne(
        { _id: req.body.id },
        {
          $set: req.body
        }
     )
         await Content.updateOne(
        { _id: req.body.id },
        {
          $set: {
            imageUrl:result.url
          }
        }
      )
   
  

  return res.json({ status: 'ok', message: ' changed', })
  } catch (error) {
    if (error.code === 11000) {
      return res.json({ status: 'false', message: 'in use' })
    }
    return res.json({ status: 'false', message: error.message})
  }
  },

  updateTrack:async(req,res)=>{
    const {id, trackName, description,check,courses} = req.body
    const file = req.file
  const token = req.header('x-auth-token')
  try {
    const user = jwt.verify(token, 'privateKey')
    console.log(user)
    const id = user.id
    console.log(id)
    
    const result = await cloudinary.uploader.upload(file.path, {

      public_id: `${user.id}_track${Date.now()}`,
      folder: 'track', width: 1920, height: 1080, crop: "fill"
    });
      console.log(result.url)
      console.log(req.body.id)
      await Track.updateOne(
        { _id: req.body.id },
        {
          $set: {
            imageUrl:result.url
          }
        }
      )
   
        await Track.updateOne(
      { _id: req.body.id },
      {
        $set: req.body
      }
    )
    

  

   return res.json({ status: 'ok', message: ' changed', })
  } catch (error) {
    if (error.code === 11000) {
      return res.json({ status: 'false', message: 'in use' })
    }
    return res.json({ status: 'false', message: error.message })
  }
  },

  updateAssignment:async(req,res)=>{
    const token = req.header('x-auth-token')
    const {id, assignmentTitle, assignmentDuration, fileUrl,createdAt,description} = req.body
    const file = req.file
   
   try {
     const user = jwt.verify(token, 'privateKey')
     console.log(user)
     const id = user.id
     console.log(id)
     const result = await cloudinary.uploader.upload(file.path, {

      public_id: `${user.id}_track${Date.now()}`,
      folder: 'track', width: 1920, height: 1080, crop: "fill"
    });
      console.log(result.url)
      console.log(req.body.id)

     await Assignment.updateOne(
         { _id: req.body.id },
         {
           $set: req.body
         }
      )
     await User.updateOne(
         { _id: req.body.id },
         {
           $set: {
             imageUrl:result.url
           }
         }
       )
 
   
 
    return res.json({ status: 'ok', message: ' changed', })
   } catch (error) {
     if (error.code === 11000) {
       return res.json({ status: 'false', message: 'in use' })
     }
     return res.json({ status: 'false', message: error.message})
   }
  },

  updateQuiz:async(req,res)=>{
    const {id, quizName, questions, courses} = req.body
    
  const token = req.header('x-auth-token')
  //console.log(id)
  try {
  
    await Quiz.updateOne(
        { _id: req.body.id },
        {
          $set: req.body
        }
     )
  
   return res.json({ status: 'ok', message: ' changed', })
  } catch (error) {
    if (error.code === 11000) {
      return res.json({ status: 'false', message: 'Cannot change' })
    }
    return res.json({ status: 'false', message: error.message})
  }
  },

  updateQuestion:async(req,res)=>{
    const {id, questionTitle, answerIndex, options,courses} = req.body
    
  const token = req.header('x-auth-token')
  try {
    const user = jwt.verify(token, 'privateKey')
    console.log(user)
    const id = user.id
    console.log(id)
    await Question.updateOne(
        { _id: req.body.id },
        {
          $set: req.body
        }
     )
  
   return res.json({ status: 'ok', message: ' changed', })
  } catch (error) {
    if (error.code === 11000) {
      return res.json({ status: 'false', message: 'Cannot change' })
    }
    return res.json({ status: 'false', message: error.message})
  }
  },

//! __________________________________________DELETE FINCTION____________________________


    deleteCourse: async (req, res) => {
      try {
        await Course.findByIdAndDelete(req.params.id);
  
      return  res.json({ status:'ok', message: "Deleted Success!" });
      } catch (err) {
        return res.status(500).json({status:'false', message: err.message });
      }
    },

    deleteCourses: async (req, res) => {
      try {
        const _id = req.params.id;
         const course = await Course.findOne({ _id });
          console.log(course)
        await course.remove();
         console.log(course.contents)
      const content=  await Content.updateMany({ '_id': course.contents }, { $pull: { courses: course._id } });
      const user=  await User.updateMany({ '_id': course.learner }, { $pull: { myCourses: course._id } });
      const wisher = await User.updateMany({ '_id': course.wishers }, { $pull: { wishList: course._id } })
       console.log(content)
       console.log(user)
       console.log(wisher)
  
      return  res.json({status:'ok', message: "Deleted Success!" });
      } catch (err) {
        return res.status(500).json({status:'false', message: err.message });
      }
    },
    deleteContents: async (req, res) => {
      try {
        const _id = req.params.id;
         const content = await Content.findOne({ _id });
          console.log(content)
        await content.remove();
          console.log(content.courses)
       const course=  await Course.updateMany({ '_id': content.courses }, { $pull: { contents: content._id } });
        console.log(course)
  
  
      return  res.json({status:'ok', message: "Deleted Success!" });
      } catch (err) {
        return res.status(500).json({status:'false', message: err.message });
      }
    },

    deleteContent: async (req, res) => {
      try {
        await Content.findByIdAndDelete(req.params.id);
  
      return  res.json({status:'ok', message: "Deleted Success!" });
      } catch (err) {
        return res.status(500).json({status:'false', message: err.message });
      }
    },


    deleteTrack: async (req, res) => {
      try {
        await Track.findByIdAndDelete(req.params.id);
  
      return  res.json({status:'ok', message: "Deleted Success!" });
      } catch (err) {
        return res.status(500).json({status:'false', message: err.message });
      }
    },


    deleteAssignment: async (req, res) => {
      try {
        await Assignment.findByIdAndDelete(req.params.id);
  
      return  res.json({status:'ok', message: "Deleted Success!" });
      } catch (err) {
        return res.status(500).json({status:'false', message: err.message });
      }
    },

    deleteQuiz: async (req, res) => {
      try {
        console.log(req.params.id)
        await Quiz.findByIdAndDelete(req.params.id);
        
      return  res.json({status:'ok', message: "Deleted Success!" });
      } catch (err) {
        return res.status(500).json({status:'false', message: err.message });
      }
    },

    deleteQuestion: async (req, res) => {
      try {
        await Question.findByIdAndDelete(req.params.id);
  
      return  res.json({status:'ok', message: "Deleted Success!" });
      } catch (err) {
        return res.status(500).json({status:'false', message: err.message });
      }
    },
}
module.exports = authorCtr;

  