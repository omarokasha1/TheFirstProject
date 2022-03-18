import 'package:lms/models/author_request.dart';

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

class UpdateUserRoleLoadingState extends ManagerStates {}

class UpdateUserRoleSuccessState extends ManagerStates {}

class UpdateUserRoleErrorState extends ManagerStates {
  final String error;

  UpdateUserRoleErrorState(this.error);
}

class DeleteAuthorRequestLoadingState extends ManagerStates {}

class DeleteAuthorRequestSuccessState extends ManagerStates {}

class DeleteAuthorRequestErrorState extends ManagerStates {
  final String error;

  DeleteAuthorRequestErrorState(this.error);
}
