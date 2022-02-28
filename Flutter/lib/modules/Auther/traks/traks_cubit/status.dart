import 'package:lms/models/course_model.dart';
import 'package:lms/models/track_model.dart';

abstract class TrackStates {}

class TrackInitialState extends TrackStates {}



class UpdateTrackLoadingState extends TrackStates {}

class UpdateTrackSuccessState extends TrackStates {

}

class UpdateTrackErrorState extends TrackStates {
  final String error;
  UpdateTrackErrorState(this.error);
}

