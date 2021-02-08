const mongoose = require("mongoose");
const Schema = mongoose.Schema;

const CourseSchema = new Schema(
    {
        departmentID: {
            type: Schema.Types.ObjectId,
            ref: "department",
        },
        courseName: {
            type: String,
        },
    },
);

module.exports = Course = mongoose.model("course", CourseSchema);