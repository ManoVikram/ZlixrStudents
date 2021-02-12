part of 'departmentData_bloc.dart';

abstract class DepartmentDataEvent {
  const DepartmentDataEvent();

  @override
  List<Object> get props => [];
}

class FetchDepartmentData extends DepartmentDataEvent {
  final String firebaseUID;

  const FetchDepartmentData({
    @required this.firebaseUID,
  });
}
