import 'package:flutter/widgets.dart';

class StudentInfoData {
  final String name;
  final String rollNo;
  final String phoneNumber;
  final DateTime dob;
  final String department;
  final int year;
  final int semester;

  StudentInfoData({
    this.name,
    this.rollNo,
    this.phoneNumber,
    this.dob,
    this.department,
    this.year,
    this.semester,
  });
}

class StudentInfo with ChangeNotifier {
  StudentInfoData _studentInfo;

  StudentInfoData get studentInfo {
    notifyListeners();
    return _studentInfo;
  }
}
