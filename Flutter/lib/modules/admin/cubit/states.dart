import 'package:lms/models/author_manger_request.dart';
import 'package:lms/models/new/courses_model.dart';

import '../../../models/track_model.dart';

abstract class AdminStates {}

class ManagerInitialState extends AdminStates {}

class GetAllAuthorsLoadingState extends AdminStates{}
class GetAllAuthorsSuccessState extends AdminStates{
  final AuthorsManagerRequest authorsManagerRequest;
  GetAllAuthorsSuccessState(this.authorsManagerRequest);
}
class GetAllAuthorsErrorState extends AdminStates{
  final String error;
  GetAllAuthorsErrorState(this.error);
}
class GetAllNumberCoursesLoadingState extends AdminStates{}
class GetAllNumberCoursesSuccessState extends AdminStates{
  final CoursesModel numberOfCourses;
  GetAllNumberCoursesSuccessState(this.numberOfCourses);
}
class GetAllNumberCoursesErrorState extends AdminStates{
  final String error;
  GetAllNumberCoursesErrorState(this.error);
}
class GetAllNumberTracksLoadingState extends AdminStates{}
class GetAllNumberTracksSuccessState extends AdminStates{
  final TrackModel trackNumber;
  GetAllNumberTracksSuccessState(this.trackNumber);
}
class GetAllNumberTracksErrorState extends AdminStates{
  final String error;
  GetAllNumberTracksErrorState(this.error);
}

class MakeAuthorManagerLoadingState extends AdminStates{}
class MakeAuthorManagerSuccessState extends AdminStates{}
class MakeAuthorManagerErrorState extends AdminStates{
  final String error;
  MakeAuthorManagerErrorState(this.error);
}

class GetAllUsersLoadingState extends AdminStates{}
class GetAllUsersSuccessState extends AdminStates{}
class GetAllUsersErrorState extends AdminStates{
  final String error;
  GetAllUsersErrorState(this.error);
}

class SearchManagerLoadingState extends AdminStates{}
class SearchManagerSuccessState extends AdminStates{}
class SearchManagerErrorState extends AdminStates{
  final String error;
  SearchManagerErrorState(this.error);
}
