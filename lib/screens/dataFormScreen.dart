import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class DataFormScreen extends StatefulWidget {
  static const String routeName = "/dataForm";

  @override
  _DataFormScreenState createState() => _DataFormScreenState();
}

class _DataFormScreenState extends State<DataFormScreen>
    with TickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameTextController = TextEditingController();
  final TextEditingController _rollNoTextController = TextEditingController();
  final TextEditingController _phoneTextController = TextEditingController();

  String _dateOfBirth;
  int _year, _semester;
  bool _isMenuOpen1 = false, _isMenuOpen2 = false, _isMenuOpen3 = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _nameTextController.dispose();
    _rollNoTextController.dispose();
    _phoneTextController.dispose();
    super.dispose();
  }

  List<int> _studyingYear = [
    1,
    2,
    3,
    4,
    5,
  ];

  List<int> _studyingSemester = [
    1,
    2,
  ];

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

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Material(
      child: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            margin: EdgeInsets.all(16.0),
            height: size.height,
            width: double.infinity,
            child: Column(
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
                Flexible(
                  child: FractionallySizedBox(
                    heightFactor: 0.20,
                  ),
                ),
                Form(
                  key: _formKey,
                  child: ListView(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: [
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
                            autocorrect: true,
                            enableSuggestions: true,
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
                            autocorrect: true,
                            enableSuggestions: true,
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
                                      fontFamily:
                                          GoogleFonts.oxygen().fontFamily,
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                NeumorphicText(
                                  _dateOfBirth == null
                                      ? ""
                                      : DateFormat.yMMMd().format(
                                          DateTime.parse(_dateOfBirth),
                                        ),
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
                                          _dateOfBirth = _dateFormatter
                                              .format(_pickedDate);
                                        });
                                      }
                                    },
                                    pressed: true,
                                    minDistance: -5,
                                    style: NeumorphicStyle(
                                      shadowLightColorEmboss: Colors.white,
                                      shadowDarkColorEmboss:
                                          Colors.blueGrey[100],
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
                                    "Department",
                                    style: TextStyle(
                                      color: Colors.deepOrange,
                                      fontFamily:
                                          GoogleFonts.oxygen().fontFamily,
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: NeumorphicButton(
                                    onPressed: () {
                                      setState(() {
                                        _isMenuOpen1 = !_isMenuOpen1;
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
                                      shadowDarkColorEmboss:
                                          Colors.blueGrey[100],
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
                                    "Year",
                                    style: TextStyle(
                                      color: Colors.deepOrange,
                                      fontFamily:
                                          GoogleFonts.oxygen().fontFamily,
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
                                        _isMenuOpen2 = !_isMenuOpen2;
                                        if (_isMenuOpen1) {
                                          _isMenuOpen1 = false;
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
                                      shadowDarkColorEmboss:
                                          Colors.blueGrey[100],
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
                                      fontFamily:
                                          GoogleFonts.oxygen().fontFamily,
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.bold,
                                    ),
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
                                      });
                                    },
                                    pressed: true,
                                    minDistance: -5,
                                    style: NeumorphicStyle(
                                      shadowLightColorEmboss: Colors.white,
                                      shadowDarkColorEmboss:
                                          Colors.blueGrey[100],
                                      color: Colors.grey[100],
                                      surfaceIntensity: 1.0,
                                      depth: 10,
                                    ),
                                    child: !_isMenuOpen3
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
                    ],
                  ),
                ),
                Flexible(
                  child: FractionallySizedBox(
                    heightFactor: 0.25,
                  ),
                ),
                Container(
                  height: 65,
                  width: size.width * 0.7,
                  child: NeumorphicButton(
                    onPressed: () {},
                    pressed: true,
                    minDistance: -5,
                    style: NeumorphicStyle(
                      shadowLightColorEmboss: Colors.white,
                      shadowDarkColorEmboss: Colors.blueGrey[100],
                      color: Colors.indigo,
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
