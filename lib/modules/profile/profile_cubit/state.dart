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