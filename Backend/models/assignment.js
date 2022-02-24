const mongoose = require('mongoose')


const Assignment = new mongoose.Schema({
    
        assignmentTitle:{type : String,required:true},
        assignmentDuration:{type:String},
        fileUrl:{type:String},
        createdAt:{type:String},
        description:{type:String},
        author:{        
                type:mongoose.Schema.Types.ObjectId ,
                ref:'User'
            }  
})

module.exports = mongoose.model('Assignment',Assignment)