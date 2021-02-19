const express = require("express");
const router = express.Router();
const mongoose = require("mongoose");

const Student = require("../../models/Student");

/*
TYPE    POST
ROUTE   /api/student/update/
DESC    Route for updating student details
ACCESS  PRIVATE
 */
router.post("/", (request, response) => {
    Student.findOne({ firebaseUID: request.body.firebaseUID }).then(
        (student) => {
            if (!student) {
                response.json({ unavailable: "Unable to find student with this Firebase UID." });
            }

            const studentProfileValues = {};
            studentProfileValues.firebaseUID = request.body.firebaseUID;

            if (request.body.name) studentProfileValues.name = request.body.name;
            if (request.body.phone) studentProfileValues.phone = request.body.phone;
            if (request.body.studentRollNo) studentProfileValues.studentRollNo = request.body.studentRollNo;
            if (request.body.dateOfBirth) studentProfileValues.dateOfBirth = new Date(request.body.dateOfBirth);
            if (request.body.degreeID) studentProfileValues.degreeID = request.body.degreeID;
            if (request.body.courseID) studentProfileValues.courseID = request.body.courseID;
            if (request.body.batch) studentProfileValues.batch = request.body.batch;
            if (request.body.year) studentProfileValues.year = request.body.year;
            if (request.body.semester) studentProfileValues.semester = request.body.semester;

            mongoose.set("useFindAndModify", false);
            Student.findOneAndUpdate(
                {
                    firebaseUID: request.body.firebaseUID,
                },
                {
                    $set: studentProfileValues,
                },
                {
                    new: true,
                }
            ).then(
                (student) => response.json(student),
            ).catch(
                (error) => console.log("Unable to update student data." + error),
            );
        },
    ).catch(
        (error) => console.log("Unable to find the student for this Firebase UID: " + error),
    );
});


module.exports = router;