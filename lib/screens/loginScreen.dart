import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

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

  Future<void> _firebaseSignInUser() async {
    try {
      print(_emailTextController.text);
      print(_passwordTextController.text);
      _userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailTextController.text,
        password: _passwordTextController.text,
      );
      print(_userCredential);
      print(_userCredential.user.uid);
    } on FirebaseAuthException catch (error) {
      String message = "ERROR: Enter correct EMAIL and PASSWORD.";

      if (error.code == 'user-not-found') {
        message = "No user found for that EMAIL.";
      } else if (error.code == 'wrong-password') {
        message = "Wrong PASSWORD provided for that user.";
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

  Future<void> _firebaseGoogleSignInUser() async {
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    UserCredential googleAuthUser =
        await FirebaseAuth.instance.signInWithCredential(credential);
    print(googleAuthUser);
    print(googleAuthUser.credential.token);
  }

  Future<void> _resetPassword() async {
    await _auth.sendPasswordResetEmail(email: _emailTextController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
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
                        onTap: _resetPassword,
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
                        child: ElevatedButton(
                          onPressed: _firebaseSignInUser,
                          style: ElevatedButton.styleFrom(
                            elevation: 7,
                            padding: EdgeInsets.symmetric(
                              vertical: 20,
                              horizontal: 40,
                            ),
                            primary: Colors.indigo,
                          ),
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
                        child: ElevatedButton(
                          onPressed: _firebaseGoogleSignInUser,
                          style: ElevatedButton.styleFrom(
                            elevation: 7,
                            padding: EdgeInsets.symmetric(
                              vertical: 20,
                              horizontal: 40,
                            ),
                            primary: Colors.white,
                          ),
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
