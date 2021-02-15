import 'package:flutter/widgets.dart';

class StudentInfoData {
  String name;
  String rollNo;
  String phoneNumber;
  String dob;
  String department;
  String course;
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

  set department(String department) {
    _studentInfo.department = department;
    notifyListeners();
  }

  set course(String course) {
    _studentInfo.course = course;
    notifyListeners();
  }

  set batch(int batch) {
    _studentInfo.batch = batch;
    notifyListeners();
  }
}
