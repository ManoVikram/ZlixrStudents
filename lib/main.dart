import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './screens/loginScreen.dart';
import './screens/signupScreen.dart';
import './screens/onboardingScreen.dart';
import './screens/dataFormScreen.dart';

import './models/registerStudentBloc/registerStudent_bloc.dart';
import './models/updateStudentBloc/updateStudentData_bloc.dart';
import 'screens/onboardingScreen.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<RegisterStudentBloc>(
          create: (contxt) => RegisterStudentBloc(),
        ),
        BlocProvider<UpdateStudentDataBloc>(
          create: (contxt) => UpdateStudentDataBloc(),
        )
      ],
      child: MaterialApp(
        title: "Zlixr Students",
        debugShowCheckedModeBanner: false,
        home: ZlixrStudents(),
        routes: {
          LoginScreen.routeName: (contxt) => LoginScreen(),
          SignUpScreen.routeName: (contxt) => SignUpScreen(),
          DataFormScreen.routeName: (contxt) => DataFormScreen(),
        },
      ),
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
