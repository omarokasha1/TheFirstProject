const mongoose = require('mongoose')


const TrackSchema = new mongoose.Schema({
    
    trackName:{type : String,required:true},
    description:{type:String},
    duration:{type:String},
    imageUrl:{type:String},
    author:{
            type:mongoose.Schema.Types.ObjectId ,
                ref:'User'
            }  ,
    courses:
        [ {type:mongoose.Schema.Types.ObjectId,
          ref:'Course'}]
})

module.exports = mongoose.model('Track',TrackSchema)