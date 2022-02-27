
import 'package:lms/models/course_model.dart';

abstract class CreateTrackStates {}

class InitCreateTrackState extends CreateTrackStates {}

class GetAuthorCoursesLoadingState extends CreateTrackStates{}
class GetAuthorCoursesSuccessState extends CreateTrackStates{
  final AuthorCoursesTestModel? authorCoursesTestModel;

  GetAuthorCoursesSuccessState(this.authorCoursesTestModel);
}
class GetAuthorCoursesErrorState extends CreateTrackStates{
  final String error;

  GetAuthorCoursesErrorState(this.error);
}
class ChangeActivityState extends CreateTrackStates{}