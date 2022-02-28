
import 'package:lms/models/course_model.dart';
import 'package:lms/models/track_model.dart';

import '../../../../models/response_model.dart';

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
class UpdateModuleLoadingState extends CreateTrackStates {}

class UpdateModuleSuccssesState extends CreateTrackStates {

  final ResponseModel  responseModel;
  UpdateModuleSuccssesState(this.responseModel);
}

class UpdateModuleErrorState extends CreateTrackStates {
  final String error;
  UpdateModuleErrorState(this.error);
}
class DeleteModuleLoadingState extends CreateTrackStates {}

class DeleteModuleSuccssesState extends CreateTrackStates {

  final ResponseModel responseModel;
  DeleteModuleSuccssesState(this.responseModel);
}

class DeleteModuleErrorState extends CreateTrackStates {
  final String error;
  DeleteModuleErrorState(this.error);
}