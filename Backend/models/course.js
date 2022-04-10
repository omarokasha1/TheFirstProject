const mongoose = require('mongoose')


const CourseSchema = new mongoose.Schema({
    totalTime: { type: String },
    lastUpdate: { type: String, },
    requirements: { type: String, },
    title: { type: String, },
    price: { type: String, },
    discount: { type: String, },
    language: { type: String, },
    description: { type: String, },
    review: { type: String, },
    imageUrl: { type: String, },
    wishers: [{ type: mongoose.Schema.Types.ObjectId, ref: 'User' }],
    isPublished: { type: Boolean, default: false },
    contents: [{ type: mongoose.Schema.Types.ObjectId, required: true, ref: 'Content', }],
    learner: [{ type: mongoose.Schema.Types.ObjectId, required: true, ref: 'User', }],
    assignments: [{ type: mongoose.Schema.Types.ObjectId, required: true, ref: 'Assignment', }],
    author: { type: mongoose.Schema.Types.ObjectId, ref: 'User' },


})




module.exports = mongoose.model('Course', CourseSchema)