const express = require("express");
const router = express.Router();
const bcrypt = require("bcryptjs");
const jsonwt = require("jsonwebtoken");
const passport = require("passport");
const key = require("../../setup/urls");

/*
TYPE    GET
ROUTE   /api/auth
DESC    FOR TESTING
ACCESS  PUBLIC
 */
router.get("/", (request, response) => response.json({ test: "Testing authentication." }));

// Import Schema for student to register
const Student = require("../../models/Student");

/*
TYPE    POST
ROUTE   /api/auth/signup
DESC    Route for signing up students
ACCESS  PUBLIC
 */
router.post("/signup", (request, response) => {
    Student.findOne({ email: request.body.email }).then(
        (student) => {
            if (student) {
                return response.status(400).json({ emailAvailable: "Email is already registered." });
            } else {
                const newStudent = new Student(
                    {
                        email: request.body.email,
                        password: request.body.password,
                    }
                );

                // Ecrypt password using bcrypt
                bcrypt.genSalt(10, function (error, salt) {
                    if (error) throw error;

                    bcrypt.hash(newStudent.password, salt, function (error, hash) {
                        if (error) throw error;

                        newStudent.password = hash;
                        newStudent.save().then(
                            (student) => student.json(student),
                        ).catch(
                            (error) => console.log("Unable to save the hashed password: " + error),
                        );
                    })
                });
            }
        }
    ).catch(
        (error) => console.log("Unable to Sign up the user: " + error),
    );
});

/*
TYPE    POST
ROUTE   /api/auth/login
DESC    Route for login of students
ACCESS  PUBLIC
 */
router.post("/login", (request, response) => {
    const email = request.body.email;
    const password = request.body.password; // Recently hashed password

    Student.findOne(
        { email }
    ).then(
        (student) => {
            if (!student) {
                return response.status(404).json({ emailError: "No user found for this Email." });
            }

            bcrypt.compare(password, person.password).then(
                (isCorrect) => {
                    if (isCorrect) {
                        // Use payload and create token for the user
                        const payload = {
                            id: student.id,
                            email: student.email,
                        };

                        jsonwt.sign(
                            payload,
                            key.secret,
                            { expiresIn: "2days" },
                            (error, token) => {
                                if (error) throw error;
                                response.json(
                                    {
                                        success: true,
                                        token: "Bearer " + token,
                                    }
                                );
                            }
                        );
                    } else {
                        response.status(400).json( { passwordError: "Error authenticating the user. Password incorrect." } )
                    }
                }
            ).catch(
                (error) => console.log("Unable find the user." + error),
            );
        }
    ).catch(
        (error) => console.log("Error authenticating the user"),
    );
});

/*
TYPE    POST
ROUTE   /api/auth/profile
DESC    Route for user profile
ACCESS  PRIVATE
 */
router.get("/profile", passport.authenticate(
        "jwt",
        { session: false },
    ),
    (request, response) => {
        response.json(
            {
                id: request.user.id,
                email: request.user.email,
            }
        );
    }
);

module.exports = router;