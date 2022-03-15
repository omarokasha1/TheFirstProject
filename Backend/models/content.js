const mongoose = require('mongoose')


const Content = new mongoose.Schema({
    
        contentTitle:{type : String,required:true},
        contentDuration:{type:String},
        imageUrl:{type:String},
        createdAt:{type:String},
        enumType:{ type: String, enum: ['image', 'video','document']},   
        description:{type:String},
        author:{        
                type:mongoose.Schema.Types.ObjectId ,
                ref:'User'
            }  ,
            courses:
            [ {type:mongoose.Schema.Types.ObjectId,
              ref:'Course'}] ,
})

module.exports = mongoose.model('Content',Content)