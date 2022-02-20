const mongoose = require('mongoose')


const Content = new mongoose.Schema({
    
        contentTitle:{type : String},
        contentDuration:{type:String},
        contentType:{type:String},
        createdAt:{type:String},
        enumType:{ type: String, enum: ['image', 'video','document']},   
   
})

module.exports = mongoose.model('Content',Content)