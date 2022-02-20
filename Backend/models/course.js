const mongoose = require('mongoose')
const Joi = require('joi')
const jwt = require('jsonwebtoken');


const CourseSchema = new mongoose.Schema({
    totalTime: { type: String, },
    lastUpdate: { type: String,},
    requiremnets: { type: String,  },
    title: { type: String,  },
    price: { type: String,  },
    discount: { type: String,  },
    language: { type: String,  },
    description: { type: String,  },
    review: { type: String,  },
    imageUrl: { type: String,  },
    contents:
        [ {type:mongoose.Schema.Types.ObjectId,
          ref:'Content'}]
    ,
    author:{
        
        type:mongoose.Schema.Types.ObjectId ,
        ref:'User'
    }
    ,})


    module.exports = mongoose.model('Course', CourseSchema)
