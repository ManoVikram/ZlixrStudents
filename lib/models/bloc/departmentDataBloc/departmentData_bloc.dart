import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;

import '../../../GLOBALS.dart';

part 'departmentData_event.dart';
part 'departmentData_state.dart';

class DepartmentDataBloc
    extends Bloc<DepartmentDataEvent, DepartmentDataState> {
  DepartmentDataBloc() : super(DepartmentDataState());

  @override
  Stream<DepartmentDataState> mapEventToState(
      DepartmentDataEvent event) async* {
    const String url = "http://$API_HOST/api/department/all";
    print(url);

    if (event is FetchDepartmentData) {
      final response = await http.post(
        url,
        body: {
          "firebaseUID": event.firebaseUID,
        },
      );

      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      print(extractedData["allDepartments"]);

      List<DepartmentData> departmentList = [];
      for (var departments in extractedData["allDepartments"]) {
        departmentList.add(
          DepartmentData(
            departmentID: departments["_id"],
            departmentName: departments["name"],
            hod: departments["hod"] ?? null,
          ),
        );
      }

      DepartmentDataState loadedData = DepartmentDataState(
        departmentData: departmentList,
      );

      yield loadedData;
    }
  }
}
