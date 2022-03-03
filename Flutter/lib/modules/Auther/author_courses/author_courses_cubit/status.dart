import 'package:lms/models/course_model.dart';

abstract class AuthorCoursesStates {}

class AuthorCourseInitialState extends AuthorCoursesStates {}
class ChangeItemState extends AuthorCoursesStates {}
class GetAuthorCoursesLoadingState extends AuthorCoursesStates {}
class GetAuthorCoursesSuccessState extends AuthorCoursesStates {
  final AuthorCoursesTestModel? authorCoursesTestModel;
  GetAuthorCoursesSuccessState(this.authorCoursesTestModel);
}
class GetAuthorCoursesErrorState extends AuthorCoursesStates {
  final String error;
  GetAuthorCoursesErrorState(this.error);
}
class CreateCourseLoadingState extends AuthorCoursesStates{}
class CreateCourseSuccessState extends AuthorCoursesStates{

}
class CreateCourseErrorState extends AuthorCoursesStates{
  final String error;
  CreateCourseErrorState(this.error);
}
class DeleteCourseLoadingState extends AuthorCoursesStates{}
class DeleteCourseSuccessState extends AuthorCoursesStates{

}
class DeleteCourseErrorState extends AuthorCoursesStates{
  final String error;
  DeleteCourseErrorState(this.error);
}

