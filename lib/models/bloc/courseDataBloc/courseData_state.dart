part of 'courseData_bloc.dart';

class CourseData {
  final dynamic courseID;
  final dynamic departmentID;
  final String courseName;

  CourseData({
    this.courseID,
    this.departmentID,
    this.courseName,
  });
}

class CourseDataState extends Equatable {
  final List<CourseData> courseData;

  CourseDataState({
    this.courseData,
  });

  @override
  List<Object> get props => [courseData];
}
