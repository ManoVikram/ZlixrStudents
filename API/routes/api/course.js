const express = require("express");
const router = express.Router();

const Student = require("../../models/Student");
const Department = require("../../models/Department");
const Course = require("../../models/Course");

/*
TYPE    POST
ROUTE   /api/department/course/new
DESC    Route for adding a new course under a department
ACCESS  PRIVATE
 */
router.post("/department/course/new", (request, response) => {
    Student.findOne({ firebaseUID: request.body.firebaseUID }).then(
        (student) => {
            if (!student) {
                return response.status(400).json({ accessDenied: "You are not allowed to access this route." });
            } else {
                Department.findOne({ _id: request.body.departmentID }).then(
                    (department) => {
                        if (!department) {
                            return response.status(400).json({ unavailable: "Department unavailable." });
                        } else {
                            Course.findOne({ courseName: request.body.courseName }).populate("departmentID").then(
                                (course) => {
                                    if (course) {
                                        return response.status(400).json({ available: "Course available." });
                                    } else {
                                        newCourse = new Course(
                                            {
                                                departmentID: department._id,
                                                courseName: request.body.courseName,
                                            }
                                        );

                                        newCourse.save().then(
                                            (course) => response.json(course),
                                        ).catch(
                                            (error) => console.log("Unable to create course." + error),
                                        );
                                    }
                                }
                            ).catch(
                                (error) => console.log("Unable to find Course." + error),
                            );
                        }
                    }
                ).catch(
                    (error) => console.log("Department unavailable." + error),
                );
            }
        }
    ).catch(
        (error) => console.log("You are not allowed to access this route." + error),
    );
});

module.exports = router;