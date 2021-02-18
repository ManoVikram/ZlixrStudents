import 'package:flutter/widgets.dart';

import '../bloc/departmentDataBloc/departmentData_bloc.dart';
import '../bloc/courseDataBloc/courseData_bloc.dart';

class StudentInfoData {
  String name;
  String rollNo;
  String phoneNumber;
  String dob;
  DepartmentData department;
  CourseData course;
  int batch;
  int year;
  int semester;

  StudentInfoData({
    this.name,
    this.rollNo,
    this.phoneNumber,
    this.dob,
    this.department,
    this.course,
    this.batch,
    this.year,
    this.semester,
  });
}

class StudentInfo with ChangeNotifier {
  StudentInfoData _studentInfo = StudentInfoData(
    name: null,
    rollNo: null,
    phoneNumber: null,
    dob: null,
    department: null,
    course: null,
    batch: null,
    year: null,
    semester: null,
  );

  StudentInfoData get studentInfo {
    return _studentInfo;
  }

  set name(String name) {
    _studentInfo.name = name;
    notifyListeners();
  }

  set rollNo(String rollNo) {
    _studentInfo.rollNo = rollNo;
    notifyListeners();
  }

  set phoneNumber(String phoneNumber) {
    _studentInfo.phoneNumber = phoneNumber;
    notifyListeners();
  }

  set dob(String dob) {
    _studentInfo.dob = dob;
    notifyListeners();
  }

  set department(DepartmentData department) {
    _studentInfo.department = department;
    print(_studentInfo.department);
    notifyListeners();
  }

  set course(CourseData course) {
    _studentInfo.course = course;
    notifyListeners();
  }

  set batch(int batch) {
    _studentInfo.batch = batch;
    notifyListeners();
  }
}
