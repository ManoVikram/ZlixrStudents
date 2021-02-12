part of 'registerStudent_bloc.dart';

abstract class RegisterStudentEvent {
  const RegisterStudentEvent();

  @override
  List<Object> get props => [];
}

class RegisterStudent extends RegisterStudentEvent {
  final String firebaseUID;
  final String email;

  const RegisterStudent({
    @required this.firebaseUID,
    @required this.email,
  });
}
