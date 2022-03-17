import 'package:lms/models/login_model.dart';
import 'package:lms/models/user.dart';

abstract class ProfileStates {}

class InitProfileState extends ProfileStates {}

class ProfileLoadingState extends ProfileStates {}

class ProfileSuccessState extends ProfileStates {
  final User model;

  ProfileSuccessState(this.model);
}

class ProfileErrorState extends ProfileStates {
  final String error;

  ProfileErrorState(this.error);
}

class UpdadteProfileLoadingState extends ProfileStates {}

class UpdadteProfileSuccessState extends ProfileStates {
  final User model;

  UpdadteProfileSuccessState(this.model);
}

class UpdadteProfileErrorState extends ProfileStates {
  final String error;

  UpdadteProfileErrorState(this.error);
}
class UpdadteProfileImageLoadingState extends ProfileStates {}

class UpdadteProfileImageSuccessState extends ProfileStates {}

class UpdadteProfileImageErrorState extends ProfileStates {
  final String error;

  UpdadteProfileImageErrorState(this.error);
}

class AddInterestedItemState extends ProfileStates {}

class DeleteInterestedItemState extends ProfileStates {}

class ChangeSelectedItemGradeState extends ProfileStates {}

class BecomeAuthorRequestLoadingState extends ProfileStates {}
class BecomeAuthorRequestSuccessState extends ProfileStates {}
class BecomeAuthorRequestErrorState extends ProfileStates {
  final String error;
  BecomeAuthorRequestErrorState(this.error);
}


