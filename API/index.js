const express = require("express");
const mongoose = require("mongoose");
const bodyParser = require("body-parser");
const passport = require("passport");

const app = express();

const HOST = "127.0.0.1";
const PORT = process.env.PORT || 3000;

// Middleware for body-parser
app.use(bodyParser.urlencoded( { extended: false } ));
app.use(bodyParser.json());

// All routes
const auth = require("./routes/api/auth");

// MongoDB configuration
const db = require("./setup/urls").mongoURL;

// Attempt to connect to database
mongoose.connect(db, { useNewUrlParser: true, useUnifiedTopology: true }).then(
    () => console.log("Connected to MongoDB successfully."),
).catch(
    (error) => console.log("Error connecting to MongoDB: " + error),
);

// Passport middleware
app.use(passport.initialize());

// Configuration for JWT strategy
require("./strategies/jsonwtStrategy")(passport);

// Route
app.use("/api/auth", auth);

// app.listen(PORT, HOST, () => console.log(`Server is running on http://${HOST}:${PORT}`));
app.listen(PORT, () => console.log(`Server is running on http://127.0.0.1:${PORT}`));