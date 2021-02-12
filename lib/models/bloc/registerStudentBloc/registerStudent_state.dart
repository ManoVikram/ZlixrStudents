part of 'registerStudent_bloc.dart';

class StudentData {
  final String firebaseUID;
  final String email;

  StudentData({
    @required this.firebaseUID,
    @required this.email,
  });
}

class RegisterStudentState extends Equatable {
  final StudentData studentData;

  const RegisterStudentState({
    this.studentData,
  });

  @override
  List<Object> get props => [studentData];
}
