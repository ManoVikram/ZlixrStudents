const mongoose = require("mongoose");
const Schema = mongoose.Schema;

const FacultySchema = new Schema(
    {
        email: {
            type: String,
            required: true,
        },
        password: {
            type: String,
            required: true,
        },
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

module.exports = Person = mongoose.model("faculty", FacultySchema);