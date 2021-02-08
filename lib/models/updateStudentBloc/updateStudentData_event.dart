part of 'updateStudentData_bloc.dart';

abstract class UpdateStudentDataEvent {
  const UpdateStudentDataEvent();

  @override
  List<Object> get props => [];
}

class UpdateStudentData extends UpdateStudentDataEvent {
  final String firebaseUID;
  final String name;
  final String phone;
  final String studentRollNo;
  final DateTime dateOfBirth;
  final dynamic degreeID;
  final int year;
  final int semester;

  const UpdateStudentData({
    this.firebaseUID,
    this.name,
    this.phone,
    this.studentRollNo,
    this.dateOfBirth,
    this.degreeID,
    this.year,
    this.semester,
  });
}
