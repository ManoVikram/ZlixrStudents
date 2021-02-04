import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import './signupScreen.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = "/loginScreen";

  final Function toggleScreen;

  LoginScreen({this.toggleScreen});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  Widget _textField(String labelText, bool isPassword) {
    return TextFormField(
      controller: isPassword ? _passwordTextController : _emailTextController,
      obscureText: isPassword ? true : false,
      cursorColor: Colors.indigo,
      keyboardType: isPassword
          ? TextInputType.emailAddress
          : TextInputType.visiblePassword,
      textInputAction: isPassword ? TextInputAction.done : TextInputAction.next,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(
          fontFamily: GoogleFonts.montserrat().fontFamily,
          fontWeight: FontWeight.bold,
          color: Colors.grey,
        ),
        focusColor: Colors.indigo,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.indigo,
            width: 3.0,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Image.asset("assets/images/authentication.png"),
              ),
              Container(
                padding: EdgeInsets.only(
                  top: 35,
                  left: 20,
                  right: 20,
                ),
                child: Column(
                  children: [
                    _textField("EMAIL", false),
                    SizedBox(
                      height: 20,
                    ),
                    _textField("PASSWORD", true),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      alignment: Alignment(1, 0),
                      padding: EdgeInsets.only(
                        top: 15,
                        left: 20,
                      ),
                      child: InkWell(
                        child: Text(
                          "Forgot Password",
                          style: TextStyle(
                            color: Colors.indigo,
                            fontFamily: GoogleFonts.montserrat().fontFamily,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: RaisedButton(
                          onPressed: () {},
                          elevation: 7,
                          padding: EdgeInsets.symmetric(
                            vertical: 20,
                            horizontal: 40,
                          ),
                          color: Colors.indigo,
                          child: Text(
                            "LOGIN",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: GoogleFonts.montserrat().fontFamily,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      width: MediaQuery.of(context).size.width * 0.8,
                      // color: Colors.transparent,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(
                          color: Colors.black,
                          style: BorderStyle.solid,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: RaisedButton(
                          onPressed: () {},
                          elevation: 7,
                          padding: EdgeInsets.symmetric(
                            vertical: 20,
                            horizontal: 40,
                          ),
                          color: Colors.white,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/images/GoogleLogo.png",
                                width: 18,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "LOGIN USING GOOGLE",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily:
                                      GoogleFonts.montserrat().fontFamily,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "New to Zlixr?",
                            style: TextStyle(
                              fontFamily: GoogleFonts.montserrat().fontFamily,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.of(context)
                                  .pushReplacementNamed(SignUpScreen.routeName);
                              // widget.toggleScreen();
                            },
                            child: Text(
                              "Join us",
                              style: TextStyle(
                                color: Colors.indigo,
                                fontFamily: GoogleFonts.montserrat().fontFamily,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
