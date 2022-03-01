const mongoose = require('mongoose')


const ManagerSchema = new mongoose.Schema({
    
       // _id:{type : mongoose.Schema.ObjectId,ref:'User'},
        userEnrolled:{ type:mongoose.Schema.Types.ObjectId , ref:'User'}  ,
        trackPublished:{ type:mongoose.Schema.Types.ObjectId , ref:'Track'}  ,            
        authorPromoted:{ type:mongoose.Schema.Types.ObjectId , ref:'User' }  ,
        coursePublished: {type:mongoose.Schema.Types.ObjectId,ref:'Course'},               
})

const CourseRequest = new mongoose.Schema({
    
         authorId:{ type:mongoose.Schema.Types.ObjectId , ref:'User'}  ,
         courseId: {type:mongoose.Schema.Types.ObjectId,ref:'Course'},               
 })

 const TrackRequest = new mongoose.Schema({
    
        authorId:{ type:mongoose.Schema.Types.ObjectId , ref:'User'}  ,
        trackId: {type:mongoose.Schema.Types.ObjectId,ref:'Track'},               
})

 const EnrollRequest = new mongoose.Schema({
    
        userId:{ type:mongoose.Schema.Types.ObjectId , ref:'User'}  ,
        courseId: {type:mongoose.Schema.Types.ObjectId,ref:'Course'},               
})




 
const managerSchema = mongoose.model('Manager',ManagerSchema)
const courseRequest= mongoose.model('CourseRequest',CourseRequest)
const enrollRequest = mongoose.model('EnrollRequest',EnrollRequest)
const trackRequest = mongoose.model('TrackRequest',TrackRequest)


module.exports = {
        RequestToManager: managerSchema,
        courseRequest: courseRequest,
        enrollRequest:enrollRequest,
        trackRequest:trackRequest
      }