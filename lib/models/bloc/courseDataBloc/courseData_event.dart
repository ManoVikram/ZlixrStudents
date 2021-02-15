part of 'courseData_bloc.dart';

abstract class CourseDataEvent extends Equatable {
  const CourseDataEvent();

  @override
  List<Object> get props => [];
}

class FetchCourseData extends CourseDataEvent {
  final String firebaseUID;
  final dynamic departmentID;

  const FetchCourseData({
    @required this.firebaseUID,
    @required this.departmentID,
  });
}
