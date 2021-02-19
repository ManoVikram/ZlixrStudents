import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:zlixr_students_psg_tech/models/bloc/courseDataBloc/courseData_bloc.dart';

import '../widgets/animatedDropdown.dart';

import '../models/bloc/registerStudentBloc/registerStudent_bloc.dart';
import '../models/bloc/departmentDataBloc/departmentData_bloc.dart';
import '../models/bloc/updateStudentBloc/updateStudentData_bloc.dart';

import '../models/provider/studentInfo.dart';

class DataFormScreen extends StatefulWidget {
  static const String routeName = "/dataForm";

  @override
  _DataFormScreenState createState() => _DataFormScreenState();
}

class _DataFormScreenState extends State<DataFormScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameTextController = TextEditingController();
  final TextEditingController _rollNoTextController = TextEditingController();
  final TextEditingController _phoneTextController = TextEditingController();

  AnimationController _animationController;

  String _dateOfBirth;
  int _year, _semester;
  bool _isMenuOpen1 = false,
      _isMenuOpen2 = false,
      _isMenuOpen3 = false,
      _isMenuOpen4 = false;

  List<int> _batchYear = [
    for (int i = DateTime.now().year; i >= DateTime.now().year - 6; i--) i
  ].reversed.toList();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
  }

  @override
  void dispose() {
    _nameTextController.dispose();
    _rollNoTextController.dispose();
    _phoneTextController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  Future<DateTime> _openCalendar(BuildContext contxt) async {
    return await showDatePicker(
      context: contxt,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (contxt, _) => Theme(
        data: ThemeData.light().copyWith(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          colorScheme: ColorScheme.light(
            primary: Colors.redAccent,
            onPrimary: Colors.white,
            surface: Colors.deepOrange,
            onSurface: Colors.black,
          ),
        ),
        child: _,
      ),
    );
  }

  bool _verifyUpdates(BuildContext contxt) {
    String message;

    if (_phoneTextController.text.length != 10) {
      message = "Enter the correct phone number";
    } else if (_nameTextController.text.isEmpty) {
      message = "Enter a valid name";
    } else if (_rollNoTextController.text.isEmpty) {
      message = "Enter a valid Roll No.";
    }

    if (message != null) {
      print(message);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          duration: Duration(
            seconds: 2,
          ),
          elevation: 7,
          backgroundColor: Theme.of(context).errorColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
        ),
      );

      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final departmentBloc = BlocProvider.of<DepartmentDataBloc>(context);
    final courseBloc = BlocProvider.of<CourseDataBloc>(context);
    final updateStudentBloc = BlocProvider.of<UpdateStudentDataBloc>(context);
    final studentInfoProvider = context.watch<StudentInfo>();

    final Size size = MediaQuery.of(context).size;

    return Material(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Let's get closer...",
                  style: TextStyle(
                    fontSize: 30.0,
                    fontFamily: GoogleFonts.oxygen().fontFamily,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        color: Colors.grey[300],
                        blurRadius: 10.0,
                        offset: Offset(2, 6),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Neumorphic(
                    style: NeumorphicStyle(
                      shadowLightColorEmboss: Colors.white,
                      shadowDarkColorEmboss: Colors.blueGrey[100],
                      color: Colors.grey[100],
                      depth: -10,
                    ),
                    child: TextFormField(
                      controller: _nameTextController,
                      autocorrect: true,
                      enableSuggestions: true,
                      keyboardType: TextInputType.name,
                      cursorColor: Colors.cyanAccent,
                      cursorHeight: 24.0,
                      cursorWidth: 3.0,
                      textAlignVertical: TextAlignVertical.center,
                      textAlign: TextAlign.center,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(16.0),
                        border: InputBorder.none,
                        labelText: "Name",
                        hintText: "Enter your name...",
                        labelStyle: TextStyle(
                          color: Colors.deepOrange,
                          fontFamily: GoogleFonts.oxygen().fontFamily,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Neumorphic(
                    style: NeumorphicStyle(
                      shadowLightColorEmboss: Colors.white,
                      shadowDarkColorEmboss: Colors.blueGrey[100],
                      color: Colors.grey[100],
                      depth: -10,
                    ),
                    child: TextFormField(
                      controller: _rollNoTextController,
                      keyboardType: TextInputType.text,
                      cursorColor: Colors.cyanAccent,
                      cursorHeight: 24.0,
                      cursorWidth: 3.0,
                      textAlignVertical: TextAlignVertical.center,
                      textAlign: TextAlign.center,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(16.0),
                        border: InputBorder.none,
                        labelText: "Roll No",
                        hintText: "Enter your Roll number...",
                        labelStyle: TextStyle(
                          color: Colors.deepOrange,
                          fontFamily: GoogleFonts.oxygen().fontFamily,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Neumorphic(
                    style: NeumorphicStyle(
                      shadowLightColorEmboss: Colors.white,
                      shadowDarkColorEmboss: Colors.blueGrey[100],
                      color: Colors.grey[100],
                      depth: -10,
                    ),
                    child: TextFormField(
                      controller: _phoneTextController,
                      keyboardType: TextInputType.phone,
                      cursorColor: Colors.cyanAccent,
                      cursorHeight: 24.0,
                      cursorWidth: 3.0,
                      textAlignVertical: TextAlignVertical.center,
                      textAlign: TextAlign.center,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(16.0),
                        border: InputBorder.none,
                        labelText: "Phone",
                        hintText: "Enter your Phone number...",
                        labelStyle: TextStyle(
                          color: Colors.deepOrange,
                          fontFamily: GoogleFonts.oxygen().fontFamily,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Neumorphic(
                    style: NeumorphicStyle(
                      shadowLightColorEmboss: Colors.white,
                      shadowDarkColorEmboss: Colors.blueGrey[100],
                      color: Colors.grey[100],
                      depth: 10,
                    ),
                    child: Container(
                      height: 65,
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              "DOB",
                              style: TextStyle(
                                color: Colors.deepOrange,
                                fontFamily: GoogleFonts.oxygen().fontFamily,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          NeumorphicText(
                            studentInfoProvider.studentInfo?.dob == null
                                ? ""
                                : DateFormat.yMMMd().format(
                                    DateTime.parse(
                                        studentInfoProvider.studentInfo?.dob),
                                  ),
                            textAlign: TextAlign.center,
                            textStyle: NeumorphicTextStyle(
                              fontFamily: GoogleFonts.oxygen().fontFamily,
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                            style: NeumorphicStyle(
                              color: Colors.black,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: NeumorphicButton(
                              onPressed: () async {
                                await Future.delayed(
                                  Duration(milliseconds: 500),
                                );
                                final DateTime _pickedDate =
                                    await _openCalendar(context);
                                final DateFormat _dateFormatter =
                                    DateFormat("yyyy-MM-dd");
                                if (_pickedDate != null) {
                                  setState(() {
                                    studentInfoProvider.dob =
                                        _dateFormatter.format(_pickedDate);
                                  });
                                }
                              },
                              pressed: true,
                              minDistance: -5,
                              style: NeumorphicStyle(
                                shadowLightColorEmboss: Colors.white,
                                shadowDarkColorEmboss: Colors.blueGrey[100],
                                color: Colors.grey[100],
                                surfaceIntensity: 1.0,
                                depth: 10,
                              ),
                              child: Icon(
                                Icons.calendar_today,
                                color: Colors.blueGrey,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                BlocBuilder<RegisterStudentBloc, RegisterStudentState>(
                  builder: (context, state) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Neumorphic(
                        style: NeumorphicStyle(
                          shadowLightColorEmboss: Colors.white,
                          shadowDarkColorEmboss: Colors.blueGrey[100],
                          color: Colors.grey[100],
                          depth: 10,
                        ),
                        child: Container(
                          height: 65,
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(
                                  "Department",
                                  style: TextStyle(
                                    color: Colors.deepOrange,
                                    fontFamily: GoogleFonts.oxygen().fontFamily,
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Consumer<StudentInfo>(
                                builder: (contxt, data, _) => Container(
                                  width: size.width * 0.4,
                                  child: NeumorphicText(
                                    studentInfoProvider.studentInfo.department
                                            ?.departmentName ??
                                        "",
                                    textAlign: TextAlign.center,
                                    textStyle: NeumorphicTextStyle(
                                      fontFamily:
                                          GoogleFonts.oxygen().fontFamily,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    style: NeumorphicStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: NeumorphicButton(
                                  onPressed: () async {
                                    await departmentBloc.add(
                                      FetchDepartmentData(
                                        // firebaseUID:
                                        //     state.studentData.firebaseUID,
                                        firebaseUID:
                                            "Yw1et8lu8lXPrkTHxxTR2o6tB1p1",
                                      ),
                                    );
                                    /* await Future.delayed(
                                      Duration(seconds: 1),
                                    ); */
                                    setState(() {
                                      _isMenuOpen1 = !_isMenuOpen1;

                                      if (_isMenuOpen2) {
                                        _isMenuOpen2 = false;
                                      }
                                      if (_isMenuOpen3) {
                                        _isMenuOpen3 = false;
                                      }
                                      if (_isMenuOpen4) {
                                        _isMenuOpen4 = false;
                                      }
                                    });
                                  },
                                  pressed: true,
                                  minDistance: -5,
                                  style: NeumorphicStyle(
                                    shadowLightColorEmboss: Colors.white,
                                    shadowDarkColorEmboss: Colors.blueGrey[100],
                                    color: Colors.grey[100],
                                    surfaceIntensity: 1.0,
                                    depth: 10,
                                  ),
                                  child: !_isMenuOpen1
                                      ? Icon(
                                          Icons.expand_more,
                                          color: Colors.blueGrey,
                                          key: UniqueKey(),
                                        )
                                      : Icon(
                                          Icons.close,
                                          color: Colors.blueGrey,
                                          key: UniqueKey(),
                                        ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
                BlocBuilder<DepartmentDataBloc, DepartmentDataState>(
                  builder: (context, state) {
                    print(state.departmentData);
                    return AnimatedDropdown(
                      dataList: state.departmentData,
                      isOpen: _isMenuOpen1,
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Neumorphic(
                    style: NeumorphicStyle(
                      shadowLightColorEmboss: Colors.white,
                      shadowDarkColorEmboss: Colors.blueGrey[100],
                      color: Colors.grey[100],
                      depth: 10,
                    ),
                    child: Container(
                      height: 65,
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              "Course",
                              style: TextStyle(
                                color: Colors.deepOrange,
                                fontFamily: GoogleFonts.oxygen().fontFamily,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Consumer<StudentInfo>(
                            builder: (contxt, data, _) => Container(
                              width: size.width * 0.4,
                              child: NeumorphicText(
                                studentInfoProvider
                                        .studentInfo.course?.courseName ??
                                    "",
                                textAlign: TextAlign.center,
                                textStyle: NeumorphicTextStyle(
                                  fontFamily: GoogleFonts.oxygen().fontFamily,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                                style: NeumorphicStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: NeumorphicButton(
                              onPressed: () async {
                                await courseBloc.add(
                                  FetchCourseData(
                                    firebaseUID: "Yw1et8lu8lXPrkTHxxTR2o6tB1p1",
                                    departmentID: studentInfoProvider
                                        .studentInfo.department?.departmentID,
                                  ),
                                );
                                /* await Future.delayed(
                                  Duration(seconds: 1),
                                ); */
                                setState(() {
                                  _isMenuOpen2 = !_isMenuOpen2;

                                  if (_isMenuOpen1) {
                                    _isMenuOpen1 = false;
                                  }
                                  if (_isMenuOpen3) {
                                    _isMenuOpen3 = false;
                                  }
                                  if (_isMenuOpen4) {
                                    _isMenuOpen4 = false;
                                  }
                                });
                              },
                              pressed: true,
                              minDistance: -5,
                              style: NeumorphicStyle(
                                shadowLightColorEmboss: Colors.white,
                                shadowDarkColorEmboss: Colors.blueGrey[100],
                                color: Colors.grey[100],
                                surfaceIntensity: 1.0,
                                depth: 10,
                              ),
                              child: !_isMenuOpen2
                                  ? Icon(
                                      Icons.expand_more,
                                      color: Colors.blueGrey,
                                      key: UniqueKey(),
                                    )
                                  : Icon(
                                      Icons.close,
                                      color: Colors.blueGrey,
                                      key: UniqueKey(),
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                BlocBuilder<CourseDataBloc, CourseDataState>(
                  builder: (context, state) {
                    return AnimatedDropdown(
                      dataList: state.courseData,
                      isOpen: _isMenuOpen2,
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Neumorphic(
                    style: NeumorphicStyle(
                      shadowLightColorEmboss: Colors.white,
                      shadowDarkColorEmboss: Colors.blueGrey[100],
                      color: Colors.grey[100],
                      depth: 10,
                    ),
                    child: Container(
                      height: 65,
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              "Batch",
                              style: TextStyle(
                                color: Colors.deepOrange,
                                fontFamily: GoogleFonts.oxygen().fontFamily,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Consumer<StudentInfo>(
                            builder: (contxt, data, _) => Container(
                              width: size.width * 0.4,
                              child: NeumorphicText(
                                data.studentInfo.batch?.toString() ?? "",
                                textAlign: TextAlign.center,
                                textStyle: NeumorphicTextStyle(
                                  fontFamily: GoogleFonts.oxygen().fontFamily,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                                style: NeumorphicStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: NeumorphicButton(
                              onPressed: () {
                                print(_batchYear);
                                setState(() {
                                  _isMenuOpen3 = !_isMenuOpen3;

                                  if (_isMenuOpen1) {
                                    _isMenuOpen1 = false;
                                  }
                                  if (_isMenuOpen2) {
                                    _isMenuOpen2 = false;
                                  }
                                  if (_isMenuOpen4) {
                                    _isMenuOpen4 = false;
                                  }
                                });
                              },
                              pressed: true,
                              minDistance: -5,
                              style: NeumorphicStyle(
                                shadowLightColorEmboss: Colors.white,
                                shadowDarkColorEmboss: Colors.blueGrey[100],
                                color: Colors.grey[100],
                                surfaceIntensity: 1.0,
                                depth: 10,
                              ),
                              child: !_isMenuOpen3
                                  ? Icon(
                                      Icons.expand_more,
                                      color: Colors.blueGrey,
                                      key: UniqueKey(),
                                    )
                                  : Icon(
                                      Icons.close,
                                      color: Colors.blueGrey,
                                      key: UniqueKey(),
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                AnimatedDropdown(
                  dataList: _batchYear,
                  isOpen: _isMenuOpen3,
                ),
                /* Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Neumorphic(
                    style: NeumorphicStyle(
                      shadowLightColorEmboss: Colors.white,
                      shadowDarkColorEmboss: Colors.blueGrey[100],
                      color: Colors.grey[100],
                      depth: 10,
                    ),
                    child: Container(
                      height: 65,
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              "Year",
                              style: TextStyle(
                                color: Colors.deepOrange,
                                fontFamily: GoogleFonts.oxygen().fontFamily,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          NeumorphicText(
                            _year?.toString(),
                            textAlign: TextAlign.center,
                            textStyle: NeumorphicTextStyle(
                              fontFamily: GoogleFonts.oxygen().fontFamily,
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                            ),
                            style: NeumorphicStyle(
                              color: Colors.black,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: NeumorphicButton(
                              onPressed: () {
                                setState(() {
                                  _isMenuOpen3 = !_isMenuOpen3;

                                  if (_isMenuOpen1) {
                                    _isMenuOpen1 = false;
                                  }
                                  if (_isMenuOpen2) {
                                    _isMenuOpen2 = false;
                                  }
                                  if (_isMenuOpen4) {
                                    _isMenuOpen4 = false;
                                  }
                                });
                              },
                              pressed: true,
                              minDistance: -5,
                              style: NeumorphicStyle(
                                shadowLightColorEmboss: Colors.white,
                                shadowDarkColorEmboss: Colors.blueGrey[100],
                                color: Colors.grey[100],
                                surfaceIntensity: 1.0,
                                depth: 10,
                              ),
                              child: !_isMenuOpen3
                                  ? Icon(
                                      Icons.expand_more,
                                      color: Colors.blueGrey,
                                      key: UniqueKey(),
                                    )
                                  : Icon(
                                      Icons.close,
                                      color: Colors.blueGrey,
                                      key: UniqueKey(),
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                AnimatedDropdown(
                  dataList: _studyingYear,
                  isOpen: _isMenuOpen3,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Neumorphic(
                    style: NeumorphicStyle(
                      shadowLightColorEmboss: Colors.white,
                      shadowDarkColorEmboss: Colors.blueGrey[100],
                      color: Colors.grey[100],
                      depth: 10,
                    ),
                    child: Container(
                      height: 65,
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              "Semester",
                              style: TextStyle(
                                color: Colors.deepOrange,
                                fontFamily: GoogleFonts.oxygen().fontFamily,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          NeumorphicText(
                            _year?.toString(),
                            textAlign: TextAlign.center,
                            textStyle: NeumorphicTextStyle(
                              fontFamily: GoogleFonts.oxygen().fontFamily,
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                            ),
                            style: NeumorphicStyle(
                              color: Colors.black,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: NeumorphicButton(
                              onPressed: () {
                                setState(() {
                                  _isMenuOpen4 = !_isMenuOpen4;

                                  if (_isMenuOpen1) {
                                    _isMenuOpen1 = false;
                                  }
                                  if (_isMenuOpen2) {
                                    _isMenuOpen2 = false;
                                  }
                                  if (_isMenuOpen3) {
                                    _isMenuOpen3 = false;
                                  }
                                });
                              },
                              pressed: true,
                              minDistance: -5,
                              style: NeumorphicStyle(
                                shadowLightColorEmboss: Colors.white,
                                shadowDarkColorEmboss: Colors.blueGrey[100],
                                color: Colors.grey[100],
                                surfaceIntensity: 1.0,
                                depth: 10,
                              ),
                              child: !_isMenuOpen4
                                  ? Icon(
                                      Icons.expand_more,
                                      color: Colors.blueGrey,
                                    )
                                  : Icon(
                                      Icons.close,
                                      color: Colors.blueGrey,
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                AnimatedDropdown(
                  dataList: _studyingSemester,
                  isOpen: _isMenuOpen4,
                ), */
                SizedBox(
                  height: 25,
                ),
                Container(
                  height: 65,
                  width: size.width * 0.7,
                  child: NeumorphicButton(
                    onPressed: () {
                      bool allCorrect = _verifyUpdates(context);

                      if (allCorrect) {
                        updateStudentBloc.add(
                          UpdateStudentData(
                            firebaseUID: "Yw1et8lu8lXPrkTHxxTR2o6tB1p1",
                            name: _nameTextController.text,
                            phone: _phoneTextController.text,
                            studentRollNo: _rollNoTextController.text,
                            degreeID: studentInfoProvider
                                .studentInfo.department?.departmentID,
                            courseID: studentInfoProvider
                                .studentInfo.course?.courseID,
                            /* dateOfBirth: DateTime.parse(
                                studentInfoProvider.studentInfo?.dob), */
                            dateOfBirth: studentInfoProvider.studentInfo?.dob,
                            batch: studentInfoProvider.studentInfo?.batch,
                          ),
                        );
                      }
                    },
                    pressed: true,
                    minDistance: -5,
                    style: NeumorphicStyle(
                      shadowLightColorEmboss: Colors.white,
                      shadowDarkColorEmboss: Colors.blueGrey[100],
                      color: Colors.deepPurpleAccent,
                      surfaceIntensity: 1.0,
                      depth: 20,
                    ),
                    child: Center(
                      child: Text(
                        "CONNECT",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: GoogleFonts.oxygen().fontFamily,
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
