const Course = require("../models/course");
const Content = require("../models/content");
const Track = require("../models/track");
const Assignment = require("../models/assignment");


const bcrypt = require('bcrypt');
const jwt = require("jsonwebtoken");
const sendMail = require("./sendMail");
const cloudinary = require('../controllers/cloudinary')
const { google } = require("googleapis");
const { OAuth2 } = google.auth;
const uploadCtrl = require('../controllers/uploadCtrl')

const { CLIENT_URL } = process.env;

const courseCtrl = {

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
  

  };

 
  module.exports = courseCtrl;
