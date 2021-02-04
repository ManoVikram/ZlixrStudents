const mongoose = require("mongoose");
const Schema = mongoose.Schema;

const CourseSchema = new Schema(
    {
        department: {
            type: Schema.Types.ObjectId,
        },
        degreeName: {
            type: String,
        },
    },
);

module.exports = Course = mongoose.model("course", CourseSchema);