const mongoose = require("mongoose");
const Schema = mongoose.Schema;

const DepartmentSchema = new Schema(
    {
        name: {
            type: String,
        },
        hod: {
            type: Schema.Types.ObjectId,
        },
    }
);

module.exports = Department = mongoose.model("department", DepartmentSchema);