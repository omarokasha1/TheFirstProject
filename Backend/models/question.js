const mongoose = require('mongoose')


const QuestionSchema = new mongoose.Schema({
    questionTitle:{type : String,required:true},
    answerIndex:{type:Number},
    options:[{type:String}],
   
    author:{
            type:mongoose.Schema.Types.ObjectId ,
                ref:'User'
            }  ,
    courses:
        [ {type:mongoose.Schema.Types.ObjectId,
          ref:'Course'}]
})

module.exports = mongoose.model('Question',QuestionSchema)