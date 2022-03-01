const mongoose = require('mongoose')
const Joi = require('joi')
const jwt = require('jsonwebtoken');
const { type } = require('express/lib/response');



// *schema like model of user
const UserSchema = new mongoose.Schema({
    userName: { type: String, lowercase: true, minlength: 3, maxlength: 44 },
    email: { type: String,  required: true, maxlength: 1024 },
    password: { type: String, required: true, minlength: 8, maxlength: 1024 },
    phone: { type: String, minlength: 11, maxlength: 11, },
    gender: { type: String, enum: ['male', 'female'] },
    imageUrl: { type: String, },
    cloudinary_id: {  type: String, },
    birthDay: { type: String },
    country: { type: String },
    city: { type: String },
    bio: { type: String },
    isAdmin: { type: Boolean },
    isAuthor:{type:Boolean},
    wishList:[{type:mongoose.Schema.Types.ObjectId,
        ref:'Courses'}],
        favoriteList:[{type:mongoose.Schema.Types.ObjectId,
            ref:'Courses'}],
    myCourses: [ {type:mongoose.Schema.Types.ObjectId,
        ref:'Courses'}],
    userEducation:  {
        university: { type: String, },
        major: { type: String, },
        faculty: { type: String, },
        experince: { type: String, },
        grade: { type: String, },
        interest: 
            [{type:String}]
        
    } ,
})


//*validation on user inputs register
function validateUser(user) {
    const JoiSchema = Joi.object({

        userName: Joi.string().min(3).max(44).regex(/[a-zA-Z]/).lowercase(),

        email: Joi.string().email().max(1024).required(),

        password: Joi.string().min(8).max(512).required(),

        phone: Joi.string().min(11).max(11),

        gender: Joi.string(),

        imageUrl: Joi.string(),

        birthDay: Joi.string(),

        country: Joi.string(),

        city: Joi.string(),

        bio: Joi.string(),


    }).options({ abortEarly: false });

    return JoiSchema.validate(user)
}

//*validation on user inputs in login
function validateUserLogin(user) {
    const JoiSchema = Joi.object({

        email: Joi.string().email().min(3).max(256).required(),

        password: Joi.string().min(8).max(512).required()

    }).options({ abortEarly: false });

    return JoiSchema.validate(user)
}

//*export to use this scehma or function in different files
//module.exports = mongoose.model('omar', UserEducation)
module.exports = mongoose.model('User', UserSchema)


module.exports.validateUser = validateUser
module.exports.validateUserLogin = validateUserLogin
