const mongoose = require('mongoose')
const Joi = require('joi')


const UserSchema = new mongoose.Schema({
  userName: { type: String, required: true, minlength: 3, maxlength: 44 },
  email: { type: String, required: true, minlength: 3, maxlength: 25 },
  password: { type: String, required: true, minlength: 8, maxlength: 1024 },
 // phone: { type: Number,  minlength: 11, maxlength: 11 },
  isAdmin: { type: Boolean }
})

//*validation on user inputs register
function validateUser(user) {
    const JoiSchema = Joi.object({

        userName: Joi.string().min(3).max(44).required(),

        email: Joi.string().email().min(3).max(25).required(),

        password: Joi.string().min(8).max(512).required()

    }).options({ abortEarly: false });

    return JoiSchema.validate(user)
}

module.exports = mongoose.model('subscribers', UserSchema)
module.exports.validateUser = validateUser
