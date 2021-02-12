import 'dart:async';
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

import '../../../GLOBALS.dart';

part 'registerStudent_event.dart';
part 'registerStudent_state.dart';

class RegisterStudentBloc
    extends Bloc<RegisterStudentEvent, RegisterStudentState> {
  RegisterStudentBloc() : super(RegisterStudentState());

  @override
  Stream<RegisterStudentState> mapEventToState(
      RegisterStudentEvent event) async* {
    const String url = "http://$API_HOST/api/auth/register";

    if (event is RegisterStudent) {
      final response = await http.post(
        url,
        body: {
          "firebaseUID": event.firebaseUID,
          "email": event.email,
        },
      );

      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      print(extractedData);

      StudentData loadedData = StudentData(
        firebaseUID: extractedData["firebaseUID"],
        email: extractedData["email"],
      );

      yield RegisterStudentState(
        studentData: loadedData,
      );
    }
  }
}
