const mongoose = require('mongoose')


const TrackSchema = new mongoose.Schema({
    
    trackName:{type : String,required:true},
    description:{type:String},
    imageUrl:{type:String},
    check:{type:String},
    isPublished:{type:Boolean,default:false},
    author:{
            type:mongoose.Schema.Types.ObjectId ,
                ref:'User'
            }  ,
    courses:
        [ {type:mongoose.Schema.Types.ObjectId,
          ref:'Course'}]
})

module.exports = mongoose.model('Track',TrackSchema)