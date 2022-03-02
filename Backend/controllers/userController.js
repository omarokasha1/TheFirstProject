const express = require('express')
const bcrypt = require('bcryptjs')
const Users = require('../models/user');
const Course = require('../models/course');
const {RequestToManager,courseRequest,enrollRequest} = require('../models/manager')
const jwt = require('jsonwebtoken')
const { validateUser } = require('../models/user')
const JWT_SECRET = 'kdhakjdhwdhqwiu;hdl/akjd;lakhdulhdw$$@$#^324uoqdald'
const router = express.Router()
const _ = require('lodash')
const { validateUserLogin } = require('../models/user')
var fs = require('fs');
var multer  = require('multer')
const cloudinary = require('./cloudinary')
const path = require('path');
const mongoose =require('mongoose')
const ObjectId = mongoose.Types.ObjectId; 



const userCtrl = {

    register:async(req,res)=>{

         //* take the inputs from user and validate them
    //* register by phone or userName just change email below to phone or userName
    const { userName, email, password: plainTextPassword,phone } = req.body
    // console.log(userName.replace(/\s+/g, ''))
  //   let userNameCheck =userName.replace(/\s+/g, '')
     
    
     const validateError = validateUser(req.body)
 
     //* if validate error just send to user an error message
     if (validateError.error) {
         return res.json({status:"false", message: validateError.error.details[0].message })
     }
 
     //* check in database by email     
     //* register by phone or userName just change email below to phone or userName
     let user = await Users.findOne({ email }).lean()
 
     //* if exist return an error messge
     if (user) {
         return res.status(200).json({ status: 'false', message: 'email already in use' })
     }
     try {
         //* take from user userName , email and password and not care for any value else
         user = new Users(_.pick(req.body, ['userName', 'email', 'password','phone',]))
 
         //* crypt the password using bcrypt package
         user.password = await bcrypt.hash(plainTextPassword, 10)
         //   user.userName = userNameCheck
         //* generate token that have his id
         const token = jwt.sign({ id: user.id }, 'privateKey')
 
         //* then save the user
         await user.save()
 
         console.log(user)
 
         //* send his token in header and his data in body
        // return res.header('x-auth-token', token).json(_.pick(user, ['_id', 'userName', 'email','phone','token']),token)
        return res.json({status:"ok",message:'Register Success',id:user._id,userName:user.userName,email:user.email,phone:user.phone,token:token})
     } catch (error) {
         return res.json({status:"false",error:error.message})
     }
    },

    login:async(req,res)=>{
           //* take the inputs from user and validate them
    const { userName, email, password: plainTextPassword } = req.body
    const validateError = validateUserLogin(req.body)

    //* if validate error just send to user an error message
    if (validateError.error) {
        return res.json({status:"false", message: validateError.error.details[0].message })
    }

    //* check in database by email
    let user = await Users.findOne({ email }).lean()

    //* if not exist return an error messge
    if (!user) {
        return res.status(200).json({ status: 'false', message: 'Invalid email or password' })
    }

    try {
        //* compare between password and crypted password of user 
        const checkPassword = await bcrypt.compare(req.body.password, user.password)

        //* if password doesnt match return to user an error message 
        if (!checkPassword) {
            return res.status(200).json({ status: 'false', message: 'Invalid email or password' })
        }

        //* generate token that have his id and if admin or not
        const token = jwt.sign({ id: user._id, isAdmin: user.isAdmin, isAuthor:user.isAuthor,isManager:user.isManager }, 'privateKey')

        console.log(token)
        return res.json({ status: 'ok',message:'Login Success', token: token })
    } catch (error) {
       
          return res.json({ status: 'false', message: error.message })

    }
    },

    profile:async(req,res)=>{
      try {
                //* find the user info by his id and not show the password at response
  const profile = await Users.findById(req.user.id).select('-password -__v -isAdmin -isAuthor')
  console.log(req.params.id)
  console.log(profile)
    return res.status(200).json({status:'ok',message:'Profile', profile })
      } catch (error) {
        console.log(error)
        return res.status(500).json({status:'false',message:error.message})
      }
 
    },

    updateProfile:async(req,res)=>{
   
  const token = req.header('x-auth-token')
  try {
    const user = jwt.verify(token, 'privateKey')
    console.log(user)
    const id = user.id
    console.log(id)

       
  
    await Users.updateOne(
        { _id: id },
        {
          $set: req.body
        }
     )

    res.json({ status: 'ok', message: ' changed', })
  } catch (error) {
    return res.status(500).json({ status: 'false', message: error.message})
  }
    },

    allUsers:async(req,res)=>{
        try {
            const users = await Users.find().select('-__v')
            return res.status(200).json({status : "ok",message:"get users",users})
          } catch (err) {
          return  res.status(500).json({status:'false', message: err.message })
          }
    },

    changePassword:async(req,res)=>{
        //! take the password from user and validate it
    const { password: plainTextPassword } = req.body

    //? take the token from header
    const token = req.header('x-auth-token')
    
    //! validate the password if not string
    if (!plainTextPassword || typeof plainTextPassword !== 'string') {
        return res.status(200).json({ status: 'false', message: 'Invalid password' })
    }
    //! validate the password if less than 8 char
    if (plainTextPassword.length < 8) {
        return res.status(200).json({
            status: 'false',
            message: 'Password too small. Should be atleast 8 characters'
        })
    }

    try {
        //* decode the token to get user data
        const user = jwt.verify(token, 'privateKey')
        console.log(user)

        //* get user id 
        const id = user.id
        console.log(id)

        //* incrypt new password
        const newPassword = await bcrypt.hash(plainTextPassword, 10)

        //* find the user by id and change the password
        await Users.updateOne(
            { _id: id },
            {
                $set: { password: newPassword }
            }
        )
        console.log(id)
        console.log(newPassword)

       return res.status(200).json({ status: 'ok', message: 'password changed' })
    } catch (error) {
        console.log(error)
       return res.json({ status: 'false', message: error.message })
    }
    },


  uploadProfile : async (req, res) => {
    
  
  const { user } = req;
 // var ip = req.headers['x-forwarded-for'] || req.socket.remoteAddress 
 //console.log("Received file" + req.file.originalname);

    if (!user)
      return res
        .status(401)
        .json({ success: false, message: 'unauthorized access!' });
       
        const imageUrl = req.file
    console.log(imageUrl)
    try {
      const result = await cloudinary.uploader.upload(imageUrl, {
  
        public_id: `${user.id}_avatar${Date.now()}`,
        folder: 'avatar', width: 1920, height: 1080, crop: "fill"
      });
  console.log(result)
      const updatedUser = await Users.findByIdAndUpdate(
        user.id,
        { imageUrl: result.url },
        { new: true }   
      );
    return  res
        .status(201)
        .json({ status: 'ok', message: 'Your profile has updated!' });
    } catch (error) {
      console.log('Error while uploading profile image', error);
     return res
        .status(500)
        .json({ status: 'flase', message: 'server error, try after some time' });
     
    }
    },

  uploadImage:async(req,res)=>{
    const file = req.file

    try {
        const { user } = req;

        if (!user)
      return res
        .status(401)
        .json({ staus: 'false', message: 'unauthorized access!' });

        if (!file) {
            const error = new Error('Please upload a file')
            error.httpStatusCode = 400
            return res.status(400).json({status:"false",message:error.message})
          }
            
            
           
            const result = await cloudinary.uploader.upload(file.path, {
        
              public_id: `${user.id}_avatar${Date.now()}`,
              folder: 'avatar', width: 1920, height: 1080, crop: "fill"
            });
      
            const updatedUser = await Users.findByIdAndUpdate(
                user.id,
                { imageUrl: result.url },
                { new: true }   
              );
            const savedimage= await updatedUser.save()
            console.log(savedimage)
            res.json({status:'ok',message:'Uploaded',savedimage}) 

    } catch (error) {
      console.log(error)
       return res.status(500).json({status:"false",message:error.message})
      
    }
    
    },

  authorPromot:async(req,res)=>{

    let newRequest
    let promotRequested
  const token = req.header('x-auth-token')
  try {
    const user = jwt.verify(token, 'privateKey')
    console.log(user)
    const authorPromoted = user.id
    console.log(authorPromoted)

 promotRequested = await RequestToManager.findOne({authorPromoted:ObjectId(authorPromoted)})
 console.log('here' + promotRequested)

      if (promotRequested) {
        return res.status(200).json({ status: 'false', message: 'you are already requested' })
      }
   const request = new RequestToManager({
    authorPromoted:authorPromoted
   })
 
   newRequest = await request.save()
  return  res.status(201).json({status:'ok',message:'Request Created Success',id:newRequest._id,authorPromoted:newRequest.authorPromoted})
  } catch (err) {
    console.log(err)
  return  res.status(400).json({status:'false', message: err.message })
  }
   },

  enrollCourse :async(req,res)=>{
    const courseId = req.body.courseId
     console.log(courseId)
     const token = req.header('x-auth-token')

 try{
  const user = jwt.verify(token, 'privateKey')
  console.log(user)
  const id = user.id
  console.log(id)

   const course=  await Users.updateOne({_id:id} , { $push: { myCourses:ObjectId(courseId) } } ,{
    upsert: true,
    runValidators: true
  });
   console.log(course)
   res.json({ status: 'ok', message: ' Enroll Success', })
 } catch (error) {
   console.log(error)
   return res.status(500).json({ status: 'false', message: error.message})
 }
   },

   enrollCourseRequest:async(req,res)=>{

    let newRequest
    let enrollCourse
    const token = req.header('x-auth-token')
  try {
    const user = jwt.verify(token, 'privateKey')
    console.log(user)
    const enrollRequestId = user.id
    console.log(enrollRequestId)

    enrollCourse = await enrollRequest.findOne({userEnrolled:ObjectId(enrollRequestId)})
  console.log('here' + enrollCourse)

      if (enrollCourse) {
        return res.status(200).json({ status: 'false', message: 'you are already requested' })
      }
   const request = await new enrollRequest({
    userId:enrollRequestId,
    courseId:req.body.courseId
   }).save()
 
   //newRequest = await request.save()
  return  res.status(201).json({status:'ok',message:'Request Created Success',userEnrolled:request})
  } catch (err) {
    console.log(err)
  return  res.status(400).json({status:'false', message: err.message })
  }
    },

   wishListCourse :async(req,res)=>{
    const courseId = req.body.courseId
     console.log(courseId)
     const token = req.header('x-auth-token')
    let wishList
   try{
    const user = jwt.verify(token, 'privateKey')
    console.log(user)
    const id = user.id
    console.log(id)

  let check = await Users.findOne({_id:id,wishList:ObjectId(courseId)})
      console.log("check "+check)
  if(check){
  wishList=  await  Users.updateMany({ '_id': id}, { $pull: { wishList: courseId } });

   console.log("remove "+wishList)
   return res.status(200).json({ status: 'ok', message: ' Removed From WishList Success', })
    }else{
  wishList=  await  Users.updateMany({ '_id': id}, { $push: { wishList: courseId } });
  let addWishToCourse=  await  Course.updateMany({ '_id': courseId}, { $push: { wishers: id } });
  console.log("add "+wishList)
  console.log("add "+addWishToCourse)

  return res.status(200).json({ status: 'ok', message: ' Add From WishList Success', })
    }
   
 } catch (error) {
   console.log(error)
   return res.status(500).json({ status: 'false', message: error.message})
 }
   },

};

 
module.exports = userCtrl;