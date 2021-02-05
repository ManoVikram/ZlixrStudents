const mongoose = require("mongoose");
const Schema = mongoose.Schema;

const FacultySchema = new Schema(
    {
        firebaseUID: {
            type: String,
            required: true,
        },
        email: {
            type: String,
            required: true,
        },
        /* password: {
            type: String,
            required: true,
        }, */
        departmentId: {
            type: Schema.Types.ObjectId,
        },
        name: {
            type: String,
        },
        phone: {
            type: String,
        },
        facultyRollNo: {
            type: String,
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

module.exports = Faculty = mongoose.model("faculty", FacultySchema);