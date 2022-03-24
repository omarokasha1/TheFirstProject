const mongoose = require('mongoose')


const QuizSchema = new mongoose.Schema({
    quizName:{type:String},

    questions:[{type:mongoose.Schema.Types.ObjectId,
        ref:'Question'}],
   
    author:{
            type:mongoose.Schema.Types.ObjectId ,
                ref:'User'
            }  ,
    courses:
        [ {type:mongoose.Schema.Types.ObjectId,
          ref:'Course'}]
    
   
})

module.exports = mongoose.model('Quiz',QuizSchema)