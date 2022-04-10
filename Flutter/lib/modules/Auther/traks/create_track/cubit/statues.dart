
import 'package:lms/models/course_model.dart';
import 'package:lms/models/new/courses_model.dart';
import 'package:lms/models/track_model.dart';

import '../../../../../models/response_model.dart';

abstract class CreateTrackStates {}

class InitCreateTrackState extends CreateTrackStates {}
class GetAuthorCoursesLoadingState extends CreateTrackStates{}
class GetAuthorCoursesSuccessState extends CreateTrackStates{
  final CoursesModel? coursesModel;

  GetAuthorCoursesSuccessState(this.coursesModel);
}
class GetAuthorCoursesErrorState extends CreateTrackStates{
  final String error;

  GetAuthorCoursesErrorState(this.error);
}
class ChangeActivityState extends CreateTrackStates{}

class CreateTrackLoadingState extends CreateTrackStates{}
class CreateTrackSuccessState extends CreateTrackStates{
  final TrackModel? trackModel;
  CreateTrackSuccessState(this.trackModel);
}
class CreateTrackErrorState extends CreateTrackStates{
  final String error;
  CreateTrackErrorState(this.error);
}

class AllTrackLoadingState extends CreateTrackStates {}

class AllTrackSuccessState extends CreateTrackStates {
  final TrackModel? tracksModel;

  AllTrackSuccessState(this.tracksModel);
}

class AllTrackErrorState extends CreateTrackStates {
  final String error;

  AllTrackErrorState(this.error);
}
class UpdateTrackLoadingState extends CreateTrackStates {}

class UpdateTrackSuccessState extends CreateTrackStates {

  //final ResponseModel  responseModel;
  UpdateTrackSuccessState();
}

class UpdateTrackErrorState extends CreateTrackStates {
  final String error;
  UpdateTrackErrorState(this.error);
}

class DeleteTrackLoadingState extends CreateTrackStates {}

class DeleteTrackSuccessState extends CreateTrackStates {

  final ResponseModel responseModel;
  DeleteTrackSuccessState(this.responseModel);
}

class DeleteTrackErrorState extends CreateTrackStates {
  final String error;
  DeleteTrackErrorState(this.error);
}

class GetAuthorTrackPublishLoadingState extends CreateTrackStates {}
class GetAuthorTrackPublishSuccessState extends CreateTrackStates {
  final TrackModel? authorTrackModel;

  GetAuthorTrackPublishSuccessState(this.authorTrackModel);
}
class GetAuthorTrackPublishErrorState extends CreateTrackStates {
  final String error;

  GetAuthorTrackPublishErrorState(this.error);
}


class SendTrackRequestLoadingState extends CreateTrackStates {}

class SendTrackRequestSuccessState extends CreateTrackStates {}

class SendTrackRequestErrorState extends CreateTrackStates {
  final String error;

  SendTrackRequestErrorState(this.error);
}


class GetAuthorCoursesPublishLoadingState extends CreateTrackStates {}
class GetAuthorCoursesPublishSuccessState extends CreateTrackStates {
  final CoursesModel? authorCoursesTestModel;

  GetAuthorCoursesPublishSuccessState(this.authorCoursesTestModel);
}
class GetAuthorCoursesPublishErrorState extends CreateTrackStates {
  final String error;

  GetAuthorCoursesPublishErrorState(this.error);
}
