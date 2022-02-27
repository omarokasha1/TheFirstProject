
const Course = require("../models/course");
const Content = require("../models/content");
const Track = require("../models/track");
const Assignment = require("../models/assignment");
const Quiz = require("../models/quiz");
const Question = require("../models/question")
const User = require('../models/user')

const cloudinary = require('./cloudinary')
const jwt = require('jsonwebtoken')
const mongoose =require('mongoose')
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
      course = await Course.find().populate('author','-__V').select('-__v')
      if (!course) {
        return res.status(200).json({ status: 'false', message: 'Cannot find courses' })
      }
     
     return res.status(200).json({status : "ok",courses:course})
    } catch (err) {
      return res.status(500).json({ message: err.message })
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
      res.status(200).json({status : "ok",contents:content})
    } catch (err) {
      console.log(err)
      return res.status(500).json({ message: err })
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
      course = await Course.aggregate([
        {
          $match: { author: ObjectId(id) }
        }
      ])
      if (!course) {
        return res.status(200).json({ status: 'false', message: 'Cannot find courses' })
      }
      return res.status(200).json({status : "ok",courses:course})
    } catch (err) {
      console.log(err)
      return res.status(500).json({ message: err.message })
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
     track = await Track.aggregate([
        {
          $match: { author: ObjectId(id) }
        }
      ])
      if (!track) {
        return res.status(200).json({ status: 'false', message: 'Cannot find tracks' })
      }
   return   res.status(200).json({status : "ok",tracks:track})
    } catch (err) {
      console.log(err)
      return res.status(500).json({ message: err.message })
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
     track = await Track.aggregate([
        {
          $match: { author: ObjectId(id),check:check }
        }
      ])
      if (!track) {
        return res.status(200).json({ status: 'false', message: 'Cannot find tracks' })
      }
      console.log(track)
    return  res.status(200).json({status : "ok",tracks:track})
    } catch (err) {
      console.log(err)
      return res.status(500).json({ message: err })
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
     return   res.status(200).json({status : "ok",assignments:assignment})
    } catch (err) {
      console.log(err)
      return res.status(500).json({ message: err })
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
     return res.status(200).json({status : "ok",quizes:quiz})
    } catch (err) {
      console.log(err)
      return res.status(500).json({ message: err.message })
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
      return res.status(200).json({status : "ok",questions:question})
    } catch (err) {
      console.log(err)
      return res.status(500).json({ message: err.message })
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

  // const fileUrl = req.file
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
      header

   const course = new Course({
     title:req.body.title,
     description:req.body.description,
     price:req.body.price,
     discount:req.body.discount,
     lastUpdate:req.body.lastUpdate,
     totalTime:req.body.totalTime,
     language:req.body.language,
     review:req.body.review,
    //imageUrl:result.url,
    imageUrl:req.body.imageUrl,
    contents:req.body.contents,
     author:id
   })

     newCourse = await course.save()
    // res.newCourse = newCourse
   return res.status(201).json(newCourse)
  } catch (err) {
    console.log(err)
    return res.status(400).json({ message: err })
  }
  //res.newCourse = newCourse
  return res.status(201).json(newCourse)
   
  },

  createContent:async(req,res)=>{

    let newContent
    req.headers['content-type'] = 'application/json';
  const uploadType=req.body.enumType
  console.log(uploadType)
  //const fileUrl = req.file
  console.log("hhhhhhhhhhhhhhhhhhhhhhh")
  //console.log(fileUrl)
 const token = req.header('x-auth-token')
 try {
   const user = jwt.verify(token, 'privateKey')
   console.log(user)
   const id = user.id
   console.log(id)
  //  const result = await cloudinary.uploader.upload(fileUrl.path, {
  
  //    public_id: `${user.id}_content${Date.now()}`,
  //    folder: 'content', width: 1920, height: 1080, crop: "fill"
  //  });

   const content = new Content({
    contentTitle:req.body.contentTitle,
    contentDuration:req.body.contentDuration,
    imageUrl:req.body.imageUrl,
    contentType:req.body.contentType,
    description:req.body.description,
     author:id
   })

    newContent = await content.save()
  return res.status(201).json(newContent)
 } catch (err) {
   console.log(err)
 return  res.status(400).json({ message: err })
 }
  },

  createTrack:async(req,res)=>{
let newTrack
  //const {trackName,description,duration,courses} = req.body
 
  //const fileUrl = req.file
 const token = req.header('x-auth-token')
 try {
   const user = jwt.verify(token, 'privateKey')
   console.log(user)
   const id = user.id
   console.log(id)
  //  const result = await cloudinary.uploader.upload(fileUrl.path, {
  
  //   public_id: `${user.id}_track${Date.now()}`,
  //   folder: 'track', width: 1920, height: 1080, crop: "fill"
  // });

  const track = new Track({
    trackName:req.body.trackName,
    description:req.body.description, 
    duration:req.body.duration,
    check:req.body.check,
   imageUrl:req.body.imageUrl,
    author:id,
    courses:req.body.courses,
  })
  console.log(track)
    newTrack = await track.save()
  return res.status(201).json(newTrack)
 } catch (err) {
   console.log(err)
  return res.status(400).json({ message: err })
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
  return res.status(201).json(newAssignment)
 } catch (err) {
   console.log(err)
  return res.status(400).json({ message: err })
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
  return res.status(201).json(newQuestion)
 } catch (err) {
   console.log(err)
  return res.status(400).json({ message: err.message })
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
  return  res.status(201).json(newQuiz)
  } catch (err) {
    console.log(err)
  return  res.status(400).json({ message: err.message })
  }
  },

  //? ______________________________________UPDATE FUNCTION_____________________________

  updateCourse:async(req,res)=>{

    const {id, title, description, price,discount,lastUpdate,totalTime,language,review ,imageUrl,contents} = req.body
    
  const token = req.header('x-auth-token')
  try {
    const user = jwt.verify(token, 'privateKey')
    console.log(user)
    const id = user.id
    console.log(id)
    await Course.updateOne(
        { _id: req.body.id },
        {
          $set: req.body
        }
     )
    // if(req.file){
    //   await User.updateOne(
    //     { _id: id },
    //     {
    //       $set: {
    //         imageUrl:req.file.filename
    //       }
    //     }
    //   )
    // }else{
    //     await User.updateOne(
    //   { _id: id },
    //   {
    //     $set: req.body
    //   }
    // )
    // }

  

    return res.json({ status: 'ok', message: ' changed', })
  } catch (error) {
    if (error.code === 11000) {
      return res.json({ status: 'false', message: 'in use' })
    }
    return res.json({ status: 'false', message: error.message})
  }
  },

  updateContent:async(req,res)=>{

    const { id,contentTitle, contentDuration, imageUrl,createdAt,enumType,description} = req.body
   
  const token = req.header('x-auth-token')
  try {
   
    await Content.updateOne(
        { _id: req.body.id },
        {
          $set: req.body
        }
     )
    // if(req.file){
    //   await User.updateOne(
    //     { _id: id },
    //     {
    //       $set: {
    //         imageUrl:req.file.filename
    //       }
    //     }
    //   )
    // }else{
    //     await User.updateOne(
    //   { _id: id },
    //   {
    //     $set: req.body
    //   }
    // )
    // }

  

  return res.json({ status: 'ok', message: ' changed', })
  } catch (error) {
    if (error.code === 11000) {
      return res.json({ status: 'false', message: 'in use' })
    }
    return res.json({ status: 'false', message: error.message})
  }
  },

  updateTrack:async(req,res)=>{
    const {id, trackName, description, duration,imageUrl,check,courses} = req.body
  
  const token = req.header('x-auth-token')
  try {
    const user = jwt.verify(token, 'privateKey')
    console.log(user)
    const id = user.id
    console.log(id)
    await Track.updateOne(
        { _id: req.body.id },
        {
          $set: req.body
        }
     )
    // if(req.file){
    //   await User.updateOne(
    //     { _id: id },
    //     {
    //       $set: {
    //         imageUrl:req.file.filename
    //       }
    //     }
    //   )
    // }else{
    //     await User.updateOne(
    //   { _id: id },
    //   {
    //     $set: req.body
    //   }
    // )
    // }

  

   return res.json({ status: 'ok', message: ' changed', })
  } catch (error) {
    if (error.code === 11000) {
      return res.json({ status: 'false', message: 'in use' })
    }
    return res.json({ status: 'false', message: error.message })
  }
  },

  updateAssignment:async(req,res)=>{
    const {id, assignmentTitle, assignmentDuration, fileUrl,createdAt,description} = req.body

   const token = req.header('x-auth-token')
   try {
     const user = jwt.verify(token, 'privateKey')
     console.log(user)
     const id = user.id
     console.log(id)
     await Assignment.updateOne(
         { _id: req.body.id },
         {
           $set: req.body
         }
      )
     // if(req.file){
     //   await User.updateOne(
     //     { _id: id },
     //     {
     //       $set: {
     //         imageUrl:req.file.filename
     //       }
     //     }
     //   )
     // }else{
     //     await User.updateOne(
     //   { _id: id },
     //   {
     //     $set: req.body
     //   }
     // )
     // }
 
   
 
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
  
      return  res.json({ message: "Deleted Success!" });
      } catch (err) {
        return res.status(500).json({ message: err.message });
      }
    },


    deleteContent: async (req, res) => {
      try {
        await Content.findByIdAndDelete(req.params.id);
  
      return  res.json({ message: "Deleted Success!" });
      } catch (err) {
        return res.status(500).json({ message: err.message });
      }
    },


    deleteTrack: async (req, res) => {
      try {
        await Track.findByIdAndDelete(req.params.id);
  
      return  res.json({ message: "Deleted Success!" });
      } catch (err) {
        return res.status(500).json({ message: err.message });
      }
    },


    deleteAssignment: async (req, res) => {
      try {
        await Assignment.findByIdAndDelete(req.params.id);
  
      return  res.json({ message: "Deleted Success!" });
      } catch (err) {
        return res.status(500).json({ message: err.message });
      }
    },

    deleteQuiz: async (req, res) => {
      try {
        console.log(req.params.id)
        await Quiz.findByIdAndDelete(req.params.id);
        
      return  res.json({ message: "Deleted Success!" });
      } catch (err) {
        return res.status(500).json({ message: err.message });
      }
    },

    deleteQuestion: async (req, res) => {
      try {
        await Question.findByIdAndDelete(req.params.id);
  
      return  res.json({ message: "Deleted Success!" });
      } catch (err) {
        return res.status(500).json({ message: err.message });
      }
    },
}
module.exports = authorCtr;

  