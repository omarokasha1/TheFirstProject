const mongoose = require('mongoose')
const Joi = require('joi')
const jwt = require('jsonwebtoken')

// *schema like model of user
const UserSchema = new mongoose.Schema({
    userName: { type: String, required: true, minlength: 3, maxlength: 44 },
    email: { type: String, required: true, maxlength: 254 },
    password: { type: String, required: true, minlength: 8, maxlength: 1024 },
    phone: { type: Number, unique: true, minlength: 11, maxlength: 11 },
    isAdmin: { type: Boolean }
})

/* UserSchema.methods.generateTokens = function () {

    const token = jwt.sign({ _id: this._id }, 'privateKey')
    return token
} */

//*validation on user inputs register
function validateUser(user) {
    const JoiSchema = Joi.object({

        userName: Joi.string().min(3).max(44).required(),

        email: Joi.string().email().max(254).required(),

        password: Joi.string().min(8).max(512).required()

    }).options({ abortEarly: false });

    return JoiSchema.validate(user)
}

//*validation on user inputs in login
function validateUserLogin(user) {
    const JoiSchema = Joi.object({

        email: Joi.string().email().min(3).max(25).required(),

        password: Joi.string().min(8).max(512).required()

    }).options({ abortEarly: false });

    return JoiSchema.validate(user)
}

//*export to use this scehma or function in different files
module.exports = mongoose.model('User', UserSchema)
module.exports.validateUser = validateUser
module.exports.validateUserLogin = validateUserLogin
