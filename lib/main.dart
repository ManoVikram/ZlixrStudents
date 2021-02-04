import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

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

class ZlixrStudents extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Center(
            child: Text("ERROR: Someting went wrong."),
          );
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return LoginScreen();
        }

        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}
