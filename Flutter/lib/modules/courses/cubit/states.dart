import 'package:lms/models/new/courses_model.dart';

abstract class CourseStates {}

class CourseInitialState extends CourseStates {}

class ChangeItemState extends CourseStates {}
class ChangeActivityState extends CourseStates {}
class CourseLoadingState extends CourseStates {}

class CourseSuccessState extends CourseStates {
  final CoursesModel courseModel;

  CourseSuccessState(this.courseModel);
}

class CourseErrorState extends CourseStates {
  final String error;

  CourseErrorState(this.error);
}

class ChangeEnrolledState extends CourseStates{}
class ChangeWishlistState extends CourseStates{}

class AllCoursesLoadingState extends CourseStates {}

class AllCoursesSuccessState extends CourseStates {
  final CoursesModel? courseModel;

  AllCoursesSuccessState(this.courseModel);
}

class AllCoursesErrorState extends CourseStates {
  final String error;

  AllCoursesErrorState(this.error);
}

class GetCourseByIDLoadingState extends CourseStates {}
class GetCourseByIDSuccessState extends CourseStates {}
class GetCourseByIDErrorState extends CourseStates {
  final String error;

  GetCourseByIDErrorState(this.error);
}

class CreateCourseLoadingState extends CourseStates {}

class CreateCourseSuccessState extends CourseStates {
  final CoursesModel courseModel;

  CreateCourseSuccessState(this.courseModel);
}

class CreateCourseErrorState extends CourseStates {
  final String error;

  CreateCourseErrorState(this.error);
}


class EnrollCourseLoadingState extends CourseStates {}

class EnrollCourseSuccessState extends CourseStates {}

class EnrollCourseErrorState extends CourseStates {
  final String error;

  EnrollCourseErrorState(this.error);
}

class WishlistCourseLoadingState extends CourseStates {}

class WishlistCourseSuccessState extends CourseStates {}

class WishlistCourseErrorState extends CourseStates {
  final String error;

  WishlistCourseErrorState(this.error);
}

class SearchCourseLoadingState extends CourseStates {}

class SearchCourseSuccessState extends CourseStates {}

class CoursesModelAuthorLoadingState extends CourseStates {}

class CoursesModelAuthorSuccessState extends CourseStates {}

class SearchCourseErrorState extends CourseStates {
  final String error;

  SearchCourseErrorState(this.error);
}


