const mongoose = require('mongoose')
const Joi = require('joi')
const jwt = require('jsonwebtoken');
<<<<<<< HEAD


=======
>>>>>>> d203f61374343ed9a27b7f0ceb3b0611d4e64e84



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
<<<<<<< HEAD
    contents:
        [ {type:mongoose.Schema.Types.ObjectId,
          ref:'Content'}]
    ,
=======
    contents:[{
        contentTitle:{type : String},
        contentDuration:{type:String},
        contentType:{type:String},
        createdAt:{type:String},
        enumType:{ type: String, enum: ['image', 'video','document']},   
    }],
>>>>>>> d203f61374343ed9a27b7f0ceb3b0611d4e64e84
    author:{
        
        type:mongoose.Schema.Types.ObjectId ,
        ref:'User'
    }
    ,})


    module.exports = mongoose.model('Course', CourseSchema)
