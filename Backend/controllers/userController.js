const express = require('express')
const bcrypt = require('bcryptjs')
const Users = require('../models/user');
const jwt = require('jsonwebtoken')
const { validateUser } = require('../models/user')
const JWT_SECRET = 'kdhakjdhwdhqwiu;hdl/akjd;lakhdulhdw$$@$#^324uoqdald'
const router = express.Router()
const _ = require('lodash')
const { validateUserLogin } = require('../models/user')



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
        return res.json({status:"ok",id:user._id,userName:user.userName,email:user.email,phone:user.phone,token:token})
     } catch (error) {
         return res.json({error:error.message})
     }
    },

    login:async(req,res)=>{
           //* take the inputs from user and validate them
    const { userName, email, password: plainTextPassword } = req.body
    const validateError = validateUserLogin(req.body)

    //* if validate error just send to user an error message
    if (validateError.error) {
        return res.json({ message: validateError.error.details[0].message })
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
        const token = jwt.sign({ id: user._id, isAdmin: user.isAdmin, isAuthor:user.isAuthor }, 'privateKey')

        console.log(token)
        return res.json({ status: 'ok', token: token })
    } catch (error) {
       
          return res.json({ status: 'false', message: error.message })

    }
    },

    profile:async(req,res)=>{
         //* find the user info by his id and not show the password at response
  const profile = await Users.findById(req.user.id).select('-password -__v -isAdmin -isAuthor')
  console.log(req.params.id)
  console.log(profile)
    return res.json({ profile })
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

  

    res.json({ status: 'ok', message: ' changed', })
  } catch (error) {
    return res.json({ status: 'false', message: error.message})
  }
    },

    allUsers:async(req,res)=>{
        try {
            const users = await Users.find().select('-__v')
            return res.status(200).json({status : "ok",message:"get users",users})
          } catch (err) {
          return  res.status(500).json({ message: err.message })
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
    }

};

 
module.exports = userCtrl;