import 'package:flutter/material.dart';

import './screens/loginScreen.dart';
import './screens/signupScreen.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Zlixr Students",
      debugShowCheckedModeBanner: false,
      home: ZlixrStudents(),
      routes: {
        LoginScreen.routeName: (contxt) => LoginScreen(),
        SignUpScreen.routeName: (contxt) => SignUpScreen(),
      },
    );
  }
}

class ZlixrStudents extends StatefulWidget {
  @override
  _ZlixrStudentsState createState() => _ZlixrStudentsState();
}

class _ZlixrStudentsState extends State<ZlixrStudents> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}

void main() => runApp(MyApp());
