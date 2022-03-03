
import 'package:lms/models/course_model.dart';

abstract class CourseStates {}

class CourseInitialState extends CourseStates {}

class ChangeItemState extends CourseStates {}
class ChangeActivityState extends CourseStates {}
class CourseLoadingState extends CourseStates {}

class CourseSuccessState extends CourseStates {
  final CourseModel courseModel;

  CourseSuccessState(this.courseModel);
}

class CourseErrorState extends CourseStates {
  final String error;

  CourseErrorState(this.error);
}


class AllCoursesLoadingState extends CourseStates {}

class AllCoursesSuccessState extends CourseStates {
  final List<CourseModel?> courseModel;

  AllCoursesSuccessState(this.courseModel);
}

class AllCoursesErrorState extends CourseStates {
  final String error;

  AllCoursesErrorState(this.error);
}



class CreateCourseLoadingState extends CourseStates {}

class CreateCourseSuccessState extends CourseStates {
  final CourseModel courseModel;

  CreateCourseSuccessState(this.courseModel);
}

class CreateCourseErrorState extends CourseStates {
  final String error;

  CreateCourseErrorState(this.error);
}

