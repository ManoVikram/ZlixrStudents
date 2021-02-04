const mongoose = require("mongoose");
const Schema = mongoose.Schema;

const ProfileSchema = new Schema(
    {
        student: {
            type: Schema.Types.ObjectId,
            ref: "student",
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
    }
);

module.exports = Profile = mongoose.model("profile", ProfileSchema);