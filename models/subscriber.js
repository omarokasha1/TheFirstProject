const mongoose = require('mongoose')

const UserSchema = new mongoose.Schema({
  userName: { type: String, required: true, minlength: 3, maxlength: 44 },
  email: { type: String, required: true, minlength: 3, maxlength: 25 },
  password: { type: String, required: true, minlength: 8, maxlength: 1024 },
  phone: { type: Number, unique: true, minlength: 11, maxlength: 11 },
  isAdmin: { type: Boolean }
})

module.exports = mongoose.model('subscribers', UserSchema)