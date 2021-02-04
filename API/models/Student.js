const mongoose = require("mongoose");
const Schema = mongoose.Schema;

const StudentSchema = new Schema(
    {
        email: {
            type: String,
            required: true,
        },
        password: {
            type: String,
            required: true,
        },
        name: {
            type: String,
        },
        phone: {
            type: String,
        },
        studentRollNo: {
            type: String,
        },
        degreeId: {
            type: Schema.Types.ObjectId,
        },
        year: {
            type: Number,
        },
        semester: {
            type: Number,
        },
        profilePic: {
            type: String,
            // TODO: Add default
        },
        date: {
            type: Date,
            default: Date.now(),
        },
    }
);

module.exports = Student = mongoose.model("student", StudentSchema);