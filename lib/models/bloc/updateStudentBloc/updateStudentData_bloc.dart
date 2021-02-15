import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

import '../../../GLOBALS.dart';

part 'updateStudentData_event.dart';
part 'updateStudentData_state.dart';

class UpdateStudentDataBloc
    extends Bloc<UpdateStudentDataEvent, UpdateStudentDataState> {
  UpdateStudentDataBloc() : super(UpdateStudentDataState());

  @override
  Stream<UpdateStudentDataState> mapEventToState(
      UpdateStudentDataEvent event) async* {
    const url = "http://$API_HOST/api/update";

    if (event is UpdateStudentData) {
      final response = await http.post(
        url,
        body: {
          "firebaseUID": event.firebaseUID,
          "name": event.name,
          "phone": event.phone,
          "studentRollNo": event.studentRollNo,
          "dateOfBirth": event.dateOfBirth,
          "degreeID": event.degreeID,
          "batch": event.batch,
          "year": event.year ?? null,
          "semester": event.semester ?? null,
        },
      );

      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      print(extractedData);

      // TODO: Store the extractedData in UpdateData class and yield it
    }
  }
}
