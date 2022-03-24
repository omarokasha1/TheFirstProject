const express = require('express')
const Users = require('../models/user');
const { validateUser } = require('../models/user')
const JWT_SECRET = 'kdhakjdhwdhqwiu;hdl/akjd;lakhdulhdw$$@$#^324uoqdald'
const router = express.Router()
const _ = require('lodash')

const mongoose =require('mongoose')
const ObjectId = mongoose.Types.ObjectId; 



const managerCtrl = {



    getAllUsers:async(req,res)=>{
        try {
            const users = await Users.find({isAuthor:false,isManager:false,isAdmin:false}).select('-__v')
            return res.status(200).json({status : "ok",message:"All Users",users})
          } catch (err) {
          return  res.status(500).json({status:'false', message: err.message })
          }
    },
    getAllManagers:async(req,res)=>{
      try {
          const users = await Users.find({isManager:true,isAdmin:false,isAuthor:false}).select('-__v')
          return res.status(200).json({status : "ok",message:"get all managers",users})
        } catch (err) {
        return  res.status(500).json({status:'false', message: err.message })
        }
  },

  getAllAuthors:async(req,res)=>{
    try {
        const users = await Users.find({isAuthor:true,isManager:false,isAdmin:false}).select('-__v')
        return res.status(200).json({status : "ok",message:"get all authors",users})
      } catch (err) {
      return  res.status(500).json({status:'false', message: err.message })
      }
},


    managerPromot:async(req,res)=>{
        const userRequestId = req.body.userRequestId
         let promotRequested
         console.log(userRequestId)
     try{
       promotRequested = await Users.findOne({_id:ObjectId(userRequestId)})
       console.log('here  ..' + promotRequested)
     
       const hello=  await Users.updateOne(
           { _id: userRequestId },
           {
             $set: {isManager:true}
           }
        )
           console.log(hello)
       
       res.json({ status: 'ok', message: ' Congrats You Are Manager' })
     } catch (error) {
       return res.status(500).json({ status: 'false', message: error.message})
     }
       },


};

 
module.exports = managerCtrl;