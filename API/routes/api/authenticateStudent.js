const { response } = require("express");
const express = require("express");
const router = express.Router();

const Student = require("../../models/Student");

/*
TYPE    POST
ROUTE   /api/auth/register
DESC    Route for signing up students
ACCESS  PUBLIC
 */
router.post("/register", (request, response) => {
    Student.findOne({ email: request.body.email }).then(
        (student) => {
            if (student) {
                return response.status(400).json({ emailAvailable: "Email address already registered." });
            } else {
                const newStudent = new Student(
                    {
                        firebaseUID: request.body.firebaseUID,
                        email: request.body.email,
                    }
                );

                newStudent.save().then(
                    (student) => response.json(student),
                ).catch(
                    (error) => console.log("Unable to save user to the Database:" + error),
                );
            }
        }
    ).catch(
        (error) => console.log("Unable to save student to database."),
    );
});

/*
TYPE    GET
ROUTE   /api/auth/profile
DESC    Route for user profile
ACCESS  PRIVATE
 */
router.get("/profile", (request, response) => {
    Student.findOne({ firebaseUID: request.body.firebaseUID }).then(
        (student) => {
            if (student) {
                response.json(student);
            } else {
                response.status(404).json({ error: "Unable to find user." });
            }
        }
    ).catch(
        (error) => console.log(error),
    );
});

module.exports = router;