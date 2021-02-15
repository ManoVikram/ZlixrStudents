part of 'updateStudentData_bloc.dart';

class UpdateData {
  final String name;
  final String phone;
  final String studentRollNo;
  final DateTime dateOfBirth;
  final dynamic degreeID;
  final dynamic courseID;
  final int batch;
  final int year;
  final int semester;

  UpdateData({
    this.name,
    this.phone,
    this.studentRollNo,
    this.dateOfBirth,
    this.degreeID,
    this.courseID,
    this.batch,
    this.year,
    this.semester,
  });
}

class UpdateStudentDataState extends Equatable {
  const UpdateStudentDataState();

  @override
  List<Object> get props => [];
}
