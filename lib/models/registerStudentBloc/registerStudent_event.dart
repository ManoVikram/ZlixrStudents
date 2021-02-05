part of 'registerStudent_bloc.dart';

abstract class RegisterStudentEvent {
  const RegisterStudentEvent();

  @override
  List<Object> get props => [];
}

class RegisterStudent extends RegisterStudentEvent {
  const RegisterStudent();
}
