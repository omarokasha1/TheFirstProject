import 'package:lms/models/track_model.dart';

abstract class AllTracksStates {}


// class ChangeItemState extends AllTracksStates {}
// class ChangeActivityState extends AllTracksStates {}
// class CourseLoadingState extends AllTracksStates {}
//
// class CourseSuccessState extends AllTracksStates {
//   final CourseModel courseModel;
//
//   CourseSuccessState(this.courseModel);
// }
//
// class CourseErrorState extends AllTracksStates {
//   final String error;
//
//   CourseErrorState(this.error);
// }


class AllTracksInitialState extends AllTracksStates {}
class AllTracksLoadingState extends AllTracksStates {}

class AllTracksSuccessState extends AllTracksStates {
  final   List<Tracks?> tracksModel ;

  AllTracksSuccessState(this.tracksModel);
}

class AllTracksErrorState extends AllTracksStates {
  final String error;

  AllTracksErrorState(this.error);
}


class EnrollTrackLoadingState extends AllTracksStates {}

class EnrollTrackSuccessState extends AllTracksStates {}

class EnrollTrackErrorState extends AllTracksStates {
  final String error;

  EnrollTrackErrorState(this.error);
}

class TracksModelAuthorLoadingState extends AllTracksStates {}

class TracksModelAuthorSuccessState extends AllTracksStates {}

class ChangeEnrolledState extends AllTracksStates {}

