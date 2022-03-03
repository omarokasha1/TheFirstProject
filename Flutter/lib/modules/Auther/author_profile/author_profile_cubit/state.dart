import 'package:lms/models/login_model.dart';
import 'package:lms/models/user.dart';

abstract class AuthorProfileStates {}

class InitAuthorProfileState extends AuthorProfileStates {}

class AuthorProfileLoadingState extends AuthorProfileStates {}

class AuthorProfileSuccessState extends AuthorProfileStates {
  final User model;

  AuthorProfileSuccessState(this.model);
}

class AuthorProfileErrorState extends AuthorProfileStates {
  final String error;

  AuthorProfileErrorState(this.error);
}
