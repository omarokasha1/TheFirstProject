
import 'package:lms/models/new/courses_model.dart';

abstract class AuthorCoursesStates {}

class AuthorCourseInitialState extends AuthorCoursesStates {}

class ChangeItemState extends AuthorCoursesStates {}

class GetAuthorCoursesLoadingState extends AuthorCoursesStates {}

class GetAuthorCoursesSuccessState extends AuthorCoursesStates {
  final CoursesModel? authorCoursesTestModel;

  GetAuthorCoursesSuccessState(this.authorCoursesTestModel);
}

class GetAuthorCoursesErrorState extends AuthorCoursesStates {
  final String error;

  GetAuthorCoursesErrorState(this.error);
}

class GetAuthorCoursesPublishLoadingState extends AuthorCoursesStates {}
class GetAuthorCoursesPublishSuccessState extends AuthorCoursesStates {
  final CoursesModel? authorCoursesTestModel;

  GetAuthorCoursesPublishSuccessState(this.authorCoursesTestModel);
}
class GetAuthorCoursesPublishErrorState extends AuthorCoursesStates {
  final String error;

  GetAuthorCoursesPublishErrorState(this.error);
}

class CreateCourseLoadingState extends AuthorCoursesStates {}

class CreateCourseSuccessState extends AuthorCoursesStates {}

class CreateCourseErrorState extends AuthorCoursesStates {
  final String error;

  CreateCourseErrorState(this.error);
}

class SendCourseRequestLoadingState extends AuthorCoursesStates {}

class SendCourseRequestSuccessState extends AuthorCoursesStates {}

class SendCourseRequestErrorState extends AuthorCoursesStates {
  final String error;

  SendCourseRequestErrorState(this.error);
}

class UpdateCourseLoadingState extends AuthorCoursesStates {}

class UpdateCourseSuccessState extends AuthorCoursesStates {
  //final ResponseModel  responseModel;
  UpdateCourseSuccessState();
}

class UpdateCourseErrorState extends AuthorCoursesStates {
  final String error;

  UpdateCourseErrorState(this.error);
}

class DeleteCourseLoadingState extends AuthorCoursesStates {}

class DeleteCourseSuccessState extends AuthorCoursesStates {}

class DeleteCourseErrorState extends AuthorCoursesStates {
  final String error;

  DeleteCourseErrorState(this.error);
}
