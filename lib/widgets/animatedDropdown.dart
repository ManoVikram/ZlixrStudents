import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import '../models/bloc/departmentDataBloc/departmentData_bloc.dart';
import '../models/bloc/courseDataBloc/courseData_bloc.dart';

import '../models/provider/studentInfo.dart';

class AnimatedDropdown extends StatefulWidget {
  final List<dynamic> dataList;
  final bool isOpen;

  AnimatedDropdown({
    @required this.dataList,
    @required this.isOpen,
  });

  @override
  _AnimatedDropdownState createState() => _AnimatedDropdownState();
}

class _AnimatedDropdownState extends State<AnimatedDropdown>
    with TickerProviderStateMixin {
  AnimationController _animationController;
  Animation<Size> _heightAnimation;
  Animation<double> _opacityAnimation;
  Animation<Offset> _slideAnimation;
  Animation<Color> _circularProgressIndicatorColor;

  List<dynamic> _listData = [];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    _heightAnimation = Tween(
      begin: Size(double.infinity, 0),
      end: Size(double.infinity, 350),
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeIn,
      ),
    );

    _opacityAnimation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeIn,
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset(0, 0),
      end: Offset(0, 0),
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeIn,
      ),
    );

    _circularProgressIndicatorColor = _animationController.drive(
      ColorTween(
        begin: Colors.indigo,
        end: Colors.redAccent,
      ),
    );

    _animationController.repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final studentInfo = context.watch<StudentInfo>();

    _listData.clear();

    if (widget.dataList is List<DepartmentData>) {
      print(widget.dataList[0].departmentName);
      for (DepartmentData department in widget.dataList) {
        _listData.add(department.departmentName);
      }
      print("LIST: " + _listData.toString());
    }

    if (widget.dataList is List<CourseData>) {
      for (CourseData course in widget.dataList) {
        _listData.add(course.courseName);
      }
      print("LIST: " + _listData.toString());
    }

    if (widget.dataList is List<int>) {
      for (int batch in widget.dataList) {
        _listData.add(batch);
      }
      print("LIST: " + _listData.toString());
    }

    return Padding(
      padding: widget.isOpen
          ? const EdgeInsets.all(8.0)
          : const EdgeInsets.symmetric(vertical: 0.0, horizontal: 8.0),
      child: Scrollbar(
        child: Neumorphic(
          style: NeumorphicStyle(
            shadowLightColorEmboss: Colors.white,
            shadowDarkColorEmboss: Colors.blueGrey[100],
            color: Colors.grey[100],
            depth: 10,
          ),
          child: AnimatedContainer(
            duration: Duration(
              milliseconds: 500,
            ),
            constraints: BoxConstraints(
              minHeight: widget.isOpen ? 50 : 0,
              maxHeight: widget.isOpen ? 200 : 0,
            ),
            curve: Curves.easeIn,
            child: _listData.isEmpty
                ? Center(
                    child: SizedBox(
                      height: 50.0,
                      width: 50.0,
                      child: CircularProgressIndicator(
                        valueColor: _circularProgressIndicatorColor,
                        strokeWidth: 2.0,
                      ),
                    ),
                  )
                : ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (contxt, index) => Column(
                      children: [
                        NeumorphicButton(
                          onPressed: () {
                            if (widget.dataList is List<DepartmentData>) {
                              print(_listData[index]);
                              studentInfo.department = widget.dataList
                                  .firstWhere((department) =>
                                      department.departmentName ==
                                      _listData[index]);
                            } else if (widget.dataList is List<CourseData>) {
                              print(_listData[index]);
                              studentInfo.course = widget.dataList.firstWhere(
                                  (course) =>
                                      course.courseName == _listData[index]);
                            } else {
                              print(_listData[index]);
                              studentInfo.batch = _listData[index];
                            }
                          },
                          pressed: true,
                          minDistance: -10,
                          style: NeumorphicStyle(
                            shadowLightColorEmboss: Colors.white,
                            shadowDarkColorEmboss: Colors.blueGrey[100],
                            color: Colors.grey[100],
                            surfaceIntensity: 1.0,
                            depth: 0,
                            // boxShape: NeumorphicBoxShape.beveled(
                            //   BorderRadius.circular(20),
                            // ),
                          ),
                          child: ListTile(
                            leading: Icon(
                              Icons.arrow_right,
                              color: Colors.cyanAccent,
                            ),
                            title: Text(
                              _listData[index].toString(),
                              softWrap: true,
                              // overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontFamily: GoogleFonts.oxygen().fontFamily,
                              ),
                            ),
                          ),
                        ),
                        Divider(),
                      ],
                    ),
                    itemCount: _listData?.length,
                  ),
          ),
        ),
      ),
    );
  }
}

// With Fade and Slide transition

/* Padding(
                  padding: _isMenuOpen1
                      ? const EdgeInsets.all(8.0)
                      : const EdgeInsets.all(0.0),
                  child: Neumorphic(
                    style: NeumorphicStyle(
                      shadowLightColorEmboss: Colors.white,
                      shadowDarkColorEmboss: Colors.blueGrey[100],
                      color: Colors.grey[100],
                      depth: 10,
                    ),
                    child: AnimatedContainer(
                      duration: Duration(
                        milliseconds: 500,
                      ),
                      constraints: BoxConstraints(
                        minHeight: _isMenuOpen1 ? 50 : 0,
                        maxHeight: _isMenuOpen1 ? 200 : 0,
                      ),
                      curve: Curves.easeIn,
                      child: FadeTransition(
                        opacity: _opacityAnimation,
                        child: SlideTransition(
                          position: _slideAnimation,
                          child: ListView.builder(
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (contxt, index) => Column(
                              children: [
                                ListTile(
                                  leading: Icon(
                                    Icons.arrow_right,
                                    color: Colors.redAccent,
                                  ),
                                  title: Text(
                                    _department[index],
                                    style: TextStyle(
                                      fontFamily:
                                          GoogleFonts.oxygen().fontFamily,
                                    ),
                                  ),
                                ),
                                Divider(),
                              ],
                            ),
                            itemCount: _department.length,
                          ),
                        ),
                      ),
                    ),
                  ),
                ), */
