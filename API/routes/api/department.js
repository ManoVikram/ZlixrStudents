const express = require("express");
const router = express.Router();

const Student = require("../../models/Student");
const Department = require("../../models/Department");

/*
TYPE    POST
ROUTE   /api/department/new
DESC    Route for adding new department
ACCESS  PRIVATE
 */
router.post("/new", (request, response) => {
    if (request.body.firebaseUID == "Yw1et8lu8lXPrkTHxxTR2o6tB1p1") {
        Student.findOne({ firebaseUID: request.body.firebaseUID }).then(
            (student) => {
                if (!student) {
                    return response.status(400).json({ unavailable: "Unable to find the student for the given ID." });
                } else {
                    Department.findOne({ name: request.body.name }).then(
                        (department) => {
                            if (department) {
                                return response.status(400).json({ departmentAvailable: "Department for the given name available." });
                            } else {
                                const newDepartment = new Department(
                                    {
                                        name: request.body.name,
                                    }
                                );

                                newDepartment.save().then(
                                    (department) => response.json(department),
                                ).catch(
                                    (error) => console.log("Unable to create department." + error),
                                );
                            }
                        }
                    ).catch(
                        (error) => console.log("Unable to find department" + error),
                    );
                }
            }
        ).catch(
            (error) => console.log("You don't have access to access this route." + error),
        );
    }
});

/*
TYPE    GET
ROUTE   /api/department/all
DESC    Route for viewing all the available departments
ACCESS  PRIVATE
 */
router.get("/all", (request, response) => {
    if (request.body.firebaseUID == "Yw1et8lu8lXPrkTHxxTR2o6tB1p1") {
        Student.findOne({ firebaseUID: request.body.firebaseUID }).then(
            (student) => {
                Department.find({}, (error, department) => {
                    var departments = [];

                    department.forEach((dept) => {
                        departments.push(dept);
                    });
                    response.json(departments);
                });
            }
        ).catch(
            (error) => console.log("You are not allowed to access this route." + error),
        );
    }
});

/*
TYPE    DELETE
ROUTE   /api/department/delete
DESC    Route for deleting a department
ACCESS  PRIVATE
 */
router.delete("/delete", (request, response) => {
    if (request.body.firebaseUID == "Yw1et8lu8lXPrkTHxxTR2o6tB1p1") {
        Student.findOne({ firebaseUID: request.body.firebaseUID }).then(
            (student) => {
                if (!student) {
                    return response.status(400).json({ unavailable: "You don't have access to this route." });
                } else {
                    Department.findOneAndDelete({ _id: request.body._id }).then(
                        // TODO: Modify the below line to delete all the courses under the department
                        () => response.json({ success: "Successfully deleted department." }),
                    ).catch(
                        (error) => console.log("Unable to remove deparment: " + error),
                    );
                }
            }
        ).catch(
            (error) => console.log("Unable to delete department." + error),
        );
    }
});

module.exports = router;