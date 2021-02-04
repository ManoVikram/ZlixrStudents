import 'package:flutter/material.dart';

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
