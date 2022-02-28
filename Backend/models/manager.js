const mongoose = require('mongoose')


const ManagerSchema = new mongoose.Schema({
    
       // _id:{type : mongoose.Schema.ObjectId,ref:'User'},
        userEnrolled:[{ type:mongoose.Schema.Types.ObjectId , ref:'User'} ] ,
        trackPublished:{ type:mongoose.Schema.Types.ObjectId , ref:'Track'}  ,            
        authorPromoted:{ type:mongoose.Schema.Types.ObjectId , ref:'User' }  ,
        coursePublished:[ {type:mongoose.Schema.Types.ObjectId,ref:'Course'}],               
})

module.exports = mongoose.model('Manager',ManagerSchema)