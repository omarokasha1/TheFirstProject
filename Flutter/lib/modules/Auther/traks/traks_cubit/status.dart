import 'package:lms/models/track_model.dart';

abstract class TrackStates {}

class TrackInitialState extends TrackStates {}

class AllTrackLoadingState extends TrackStates {}

class AllTrackSuccessState extends TrackStates {
  final TrackModel? tracksModel;

  AllTrackSuccessState(this.tracksModel);
}

class AllTrackErrorState extends TrackStates {
  final String error;

  AllTrackErrorState(this.error);
}
