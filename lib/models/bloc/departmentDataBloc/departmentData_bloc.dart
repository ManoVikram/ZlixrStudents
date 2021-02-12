import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;

part 'departmentData_event.dart';
part 'departmentData_state.dart';

class DepartmentDataBloc
    extends Bloc<DepartmentDataEvent, DepartmentDataState> {
  DepartmentDataBloc() : super(DepartmentDataState());

  @override
  Stream<DepartmentDataState> mapEventToState(
      DepartmentDataEvent event) async* {
    const String url = "http://192.168.43.50:3000/api/department/all";

    if (event is FetchDepartmentData) {
      final response = await http.post(
        url,
        body: {
          "firebaseUID": event.firebaseUID,
        },
      );

      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      print(extractedData);

      List<DepartmentData> departmentList = extractedData["allDepartments"].map(
        (department) => DepartmentData(
          departmentID: department["_id"],
          departmentName: department["name"],
          hod: department["hod"] ?? null,
        ),
      );

      DepartmentDataState loadedData = DepartmentDataState(
        departmentData: departmentList,
      );

      yield loadedData;
    }
  }
}
