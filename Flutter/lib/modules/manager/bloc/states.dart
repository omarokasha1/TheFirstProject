import 'package:lms/models/author_manger_request.dart';
import 'package:lms/models/author_request.dart';
import 'package:lms/models/new/course_requests.dart';
import 'package:lms/models/new/track_requests.dart';

abstract class ManagerStates {}

class ManagerRequestAuthorInitialState extends ManagerStates {}

class GetAllAuthorRequestsLoadingState extends ManagerStates {}

class GetAllAuthorRequestsSuccessState extends ManagerStates {
  final AuthorRequests authorRequests;

  GetAllAuthorRequestsSuccessState(this.authorRequests);
}

class GetAllAuthorRequestsErrorState extends ManagerStates {
  final String error;

  GetAllAuthorRequestsErrorState(this.error);
}


class GetAllCoursesRequestsLoadingState extends ManagerStates {}

class GetAllCoursesRequestsSuccessState extends ManagerStates {
  final CourseRequestModel coursesRequests;

  GetAllCoursesRequestsSuccessState(this.coursesRequests);
}

class GetAllCoursesRequestsErrorState extends ManagerStates {
  final String error;

  GetAllCoursesRequestsErrorState(this.error);
}

class GetAllTracksRequestsLoadingState extends ManagerStates {}

class GetAllTracksRequestsSuccessState extends ManagerStates {
  final TrackRequestsModel trackRequestsModel;

  GetAllTracksRequestsSuccessState(this.trackRequestsModel);
}

class GetAllTracksRequestsErrorState extends ManagerStates {
  final String error;

  GetAllTracksRequestsErrorState(this.error);
}
class UpdateUserRoleLoadingState extends ManagerStates {}

class UpdateUserRoleSuccessState extends ManagerStates {}

class UpdateUserRoleErrorState extends ManagerStates {
  final String error;

  UpdateUserRoleErrorState(this.error);
}

class AcceptCourseLoadingState extends ManagerStates {}

class AcceptCourseSuccessState extends ManagerStates {}

class AcceptCourseErrorState extends ManagerStates {
  final String error;

  AcceptCourseErrorState(this.error);
}


class AcceptTrackLoadingState extends ManagerStates {}

class AcceptTrackSuccessState extends ManagerStates {}

class AcceptTrackErrorState extends ManagerStates {
  final String error;

  AcceptTrackErrorState(this.error);
}

class DeleteAuthorRequestLoadingState extends ManagerStates {}

class DeleteAuthorRequestSuccessState extends ManagerStates {}

class DeleteAuthorRequestErrorState extends ManagerStates {
  final String error;

  DeleteAuthorRequestErrorState(this.error);
}


class DeleteCourseRequestLoadingState extends ManagerStates {}

class DeleteCourseRequestSuccessState extends ManagerStates {}

class DeleteCourseRequestErrorState extends ManagerStates {
  final String error;

  DeleteCourseRequestErrorState(this.error);
}

class DeleteTrackRequestLoadingState extends ManagerStates {}

class DeleteTrackRequestSuccessState extends ManagerStates {}

class DeleteTrackRequestErrorState extends ManagerStates {
  final String error;

  DeleteTrackRequestErrorState(this.error);
}

class GetAllUsersLoadingState extends ManagerStates{}
class GetAllUsersSuccessState extends ManagerStates{
  final AuthorsManagerRequest authorsManagerRequest;
  GetAllUsersSuccessState(this.authorsManagerRequest);
}
class GetAllUsersErrorState extends ManagerStates{
  final String error;
  GetAllUsersErrorState(this.error);
}