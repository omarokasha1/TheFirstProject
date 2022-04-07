import 'package:lms/models/new/courses_model.dart';

abstract class CourseStates {}

class CourseInitialState extends CourseStates {}

class AllCoursesLoadingState extends CourseStates {}

class AllCoursesSuccessState extends CourseStates {
  final CoursesModel? courseModel;

  AllCoursesSuccessState(this.courseModel);
}

class AllCoursesErrorState extends CourseStates {
  final String error;

  AllCoursesErrorState(this.error);
}