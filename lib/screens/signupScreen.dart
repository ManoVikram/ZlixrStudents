import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './loginScreen.dart';
import './dataFormScreen.dart';
import '../models/bloc/registerStudentBloc/registerStudent_bloc.dart';

class SignUpScreen extends StatefulWidget {
  static const String routeName = "/signUpScreen";

  final Function toggleScreen;

  SignUpScreen({this.toggleScreen});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  UserCredential _userCredential;

  @override
  void dispose() {
    _emailTextController.dispose();
    _passwordTextController.dispose();
    super.dispose();
  }

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

  Future<void> _firebaseCreateUser() async {
    try {
      print(_emailTextController.text);
      print(_passwordTextController.text);
      _userCredential = await _auth.createUserWithEmailAndPassword(
        email: _emailTextController.text,
        password: _passwordTextController.text,
      );
    } on FirebaseAuthException catch (error) {
      String message = "ERROR: Enter a valid EMAIL and PASSWORD.";

      if (error.code == 'weak-password') {
        message = "The password provided is too weak.";
      } else if (error.code == 'email-already-in-use') {
        message = "The account already exists for that email.";
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    final registerStudentBloc = BlocProvider.of<RegisterStudentBloc>(context);

    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Image.asset("assets/images/welcome.png"),
              ),
              Container(
                padding: EdgeInsets.only(top: 35, left: 20, right: 20),
                child: Column(
                  children: [
                    _textField("EMAIL", false),
                    SizedBox(
                      height: 20,
                    ),
                    _textField("PASSWORD", true),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 20),
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: ElevatedButton(
                          onPressed: () async {
                            await _firebaseCreateUser();
                            await registerStudentBloc.add(RegisterStudent(
                              firebaseUID: _userCredential.user.uid,
                              email: _userCredential.user.email,
                            ));

                            if (_userCredential.user.uid != null) {
                              Navigator.of(context).pushReplacementNamed(
                                  DataFormScreen.routeName);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 7,
                            padding: EdgeInsets.symmetric(
                              vertical: 20,
                              horizontal: 40,
                            ),
                            primary: Colors.indigo,
                          ),
                          child: Text(
                            "SIGN UP",
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
                      margin: EdgeInsets.all(15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account?",
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
                                  .pushReplacementNamed(LoginScreen.routeName);
                              // widget.toggleScreen();
                            },
                            child: Text(
                              "Welcome Back",
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
