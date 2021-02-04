const mongoose = require("mongoose");
const Schema = mongoose.Schema;

const SubjectSchema = new Schema(
    {
        degree: {
            type: Schema.Types.ObjectId,
        },
        courseName: {
            type: String,
        },
        handlingFaculty: {
            type: Schema.Types.ObjectId,
        },
        elective: {
            type: Boolean,
        },
        year: {
            type: Number,
        },
        semester: {
            type: Number,
        },
        credits: {
            type: Number,
        },
    },
);

module.exports = Course = mongoose.model("subject", SubjectSchema);