const mongoose = require("mongoose");
const Schema = mongoose.Schema;

const StudentSchema = new Schema(
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
        name: {
            type: String,
        },
        phone: {
            type: String,
        },
        studentRollNo: {
            type: String,
        },
        dateOfBirth: {
            type: Date,
        },
        degreeID: {
            type: Schema.Types.ObjectId,
        },
        batch: {
            type: Number,
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
        scoresGained: [
            [
                {
                    student: {
                        type: Schema.Types.ObjectId,
                        ref: "student",
                    },
                    givenScore: {
                        type: Number,
                        default: 0,
                    },
                    date: {
                        type: Date,
                        default: Date.now(),
                    },
                }
            ],
        ],
        score: [
            {
                scorePerSession: {
                    type: Number,
                },
                date: {
                    type: Date,
                    default: Date.now(),
                },
            },
        ],
        zlixrs: {
            type: Number,
            default: 0,
        },
        date: {
            type: Date,
            default: Date.now(),
        },
    }
);

module.exports = Student = mongoose.model("student", StudentSchema);