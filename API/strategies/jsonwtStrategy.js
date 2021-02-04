const JwtStrategy = require("passport-jwt").Strategy;
const ExtractJwt = require("passport-jwt").ExtractJwt;
const mongoose = require("mongoose");
const Student = mongoose.model("student");
const myKey = require("../setup/urls");

var opts = {};
opts.jwtFromRequest = ExtractJwt.fromAuthHeaderAsBearerToken();
opts.secretOrKey = myKey.secret;

module.exports = passport => {
    passport.use(
        new JwtStrategy(
            opts,
            (jwt_payload, done) => {
                Student.findById(jwt_payload.id).then(
                    (student) => {
                        if (student) {
                            return done(null, student);
                        }
                        return done(null, false);
                    },
                ).catch(
                    (error) => console.log(error),
                );
            },
        ),
    );
};