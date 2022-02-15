
const express = require('express')
const router = express.Router()
const User = require('../models/user')
const bcrypt = require('bcryptjs')
const auth = require('../middleware/auth')
const admin = require('../middleware/admin')

const jwt = require('jsonwebtoken')
const _= require('lodash')
const Course = require('../models/course')

router.post('/', async (req, res) => {

    //* const { title,  description,author } = req.body
   
    try {
     const course = User({
        userName: "Ashi1sh",
        email: "Sut1har@gmail.com",
        password: "BitOrbits",
        phone:"01124180480",
        userEducation: {
          major: "software",
          interest: ["asissuthar@gmail.com", "contact.bitorbits@gmail.com"],
        },
      });
  
      const newCourse = await course.save()
      res.status(201).json(newCourse)
    } catch (err) {
      res.status(400).json({ message: err.message })
    }
  })

  module.exports = router