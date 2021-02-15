import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;

import '../../../GLOBALS.dart';

part 'courseData_event.dart';
part 'courseData_state.dart';

class CourseDataBloc extends Bloc<CourseDataEvent, CourseDataState> {
  CourseDataBloc() : super(CourseDataState());

  @override
  Stream<CourseDataState> mapEventToState(CourseDataEvent event) async* {
    const String url = "http://$API_HOST/api/department/course/all";

    if (event is FetchCourseData) {
      final response = await http.post(
        url,
        body: {
          "firebaseUID": event.firebaseUID,
          "departmentID": event.departmentID,
        },
      );

      final extractedData = json.decode(response.body) as Map<String, dynamic>;

      List<CourseData> coursesList = [];
      for (var courses in extractedData["courses"]) {
        coursesList.add(
          CourseData(
            courseID: courses["_id"],
            departmentID: courses["departmentID"],
            courseName: courses["courseName"],
          ),
        );
      }

      CourseDataState loadedData = CourseDataState(
        courseData: coursesList,
      );

      yield loadedData;
    }
  }
}
