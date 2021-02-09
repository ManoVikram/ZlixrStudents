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
router.post("/new", (request, response) => {
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

/*
TYPE    GET
ROUTE   /api/department/course/all
DESC    Route for viewing all the courses under a department
ACCESS  PUBLIC
 */
router.get("/all", (request, response) => {
    Student.findOne({ firebaseUID: request.body.firebaseUID }).then(
        (student) => {
            if (!student) {
                return response.status(400).json({ accessDenied: "No student available for that given ID." });
            }
            Department.findOne({ _id: request.body.departmentID }).then(
                (department) => {
                    if (!department) {
                        return response.status(400).json({ accessDenied: "No such department available." });
                    } else {
                        Course.find({}, (error, course) => {
                            if (error) {
                                throw error;
                            }

                            var courses = [];

                            course.forEach((cours) => {
                                if (department._id.toString() === cours.departmentID.toString()) {
                                    courses.push(cours);
                                }
                            });
                            response.json(courses);
                        });
                    }
                }
            ).catch(
                (error) => console.log("Couldn't show all courses in that department: " + error),
            );
        }
    ).catch(
        (error) => console.log("Couldn't show all courses in that department: " + error),
    );
});

/*
TYPE    DELETE
ROUTE   /api/department/course/delete
DESC    Route for deleting a course under a department
ACCESS  PRIVATE
 */
router.delete("/delete", (request, response) => {
    if (request.body.firebaseUID == "Yw1et8lu8lXPrkTHxxTR2o6tB1p1") {
        Student.findOne({ firebaseUID: request.body.firebaseUID }).then(
            (student) => {
                if (!student) {
                    return response.status(400).json({ accessDenied: "You don't have right to access this route." });
                } else {
                    Department.findOne({ _id: request.body.departmentID }).then(
                        (department) => {
                            if (!department) {
                                return response.status(400).json({ departmentUnavailable: "The department containing the course in unavailable." });
                            } else {
                                Course.findOneAndDelete({ _id: request.body.courseID }).then(
                                    () => response.json({ success: "Successfully deleted course." }),
                                ).catch(
                                    (error) => console.log("Error deleting the course." + error),
                                );
                            }
                        }
                    ).catch(
                        (error) => console.log("Error while deleting the course." + error),
                    );
                }
            }
        ).catch(
            (error) => console.log("Error deleting the course." + error),
        );
    }
});

module.exports = router;