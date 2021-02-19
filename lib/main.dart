import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:after_layout/after_layout.dart';

import './screens/loginScreen.dart';
import './screens/signupScreen.dart';
import './screens/onboardingScreen.dart';
import './screens/dataFormScreen.dart';

import './models/bloc/registerStudentBloc/registerStudent_bloc.dart';
import './models/bloc/updateStudentBloc/updateStudentData_bloc.dart';
import './models/bloc/departmentDataBloc/departmentData_bloc.dart';
import './models/bloc/courseDataBloc/courseData_bloc.dart';

import './models/provider/studentInfo.dart';

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
        ),
        BlocProvider<DepartmentDataBloc>(
          create: (contxt) => DepartmentDataBloc(),
        ),
        BlocProvider<CourseDataBloc>(
          create: (context) => CourseDataBloc(),
        ),
      ],
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (contxt) => StudentInfo(),
          ),
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
      ),
    );
  }
}

class ZlixrStudents extends StatefulWidget {
  @override
  _ZlixrStudentsState createState() => _ZlixrStudentsState();
}

class _ZlixrStudentsState extends State<ZlixrStudents>
    with AfterLayoutMixin<ZlixrStudents> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  SharedPreferences preferences;
  bool _seen;

  Future<void> checkSeenAlready() async {
    preferences = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    super.initState();
    checkSeenAlready();
  }

  @override
  void afterFirstLayout(BuildContext context) => checkSeenAlready();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: checkSeenAlready(),
      builder: (context, seenSnapshot) {
        _seen = (preferences?.getBool("seen") ?? false);
        if (seenSnapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (seenSnapshot.connectionState == ConnectionState.done) {
          if (_seen) {
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
          } else {
            preferences.setBool("seen", true);
            return OnboardingScreen();
          }
        }
      },
    );
  }
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}
