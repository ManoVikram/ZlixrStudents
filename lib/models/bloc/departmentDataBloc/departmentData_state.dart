part of 'departmentData_bloc.dart';

class DepartmentData {
  final dynamic departmentID;
  final String departmentName;
  final dynamic hod;

  DepartmentData({
    this.departmentID,
    this.departmentName,
    this.hod,
  });
}

class DepartmentDataState extends Equatable {
  final List<DepartmentData> departmentData;

  const DepartmentDataState({
    this.departmentData,
  });

  @override
  List<Object> get props => [departmentData];
}
