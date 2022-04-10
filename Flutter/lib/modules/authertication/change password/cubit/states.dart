import '../../../../models/chage_password_model.dart';

abstract class ChangePasswordStates {}

class ChangePasswordInitialState extends ChangePasswordStates {}

class ChangePasswordLoadingState extends ChangePasswordStates {}

class ChangePasswordSuccessState extends ChangePasswordStates {

  ChangePasswordSuccessState();
}

class ChangePasswordErrorState extends ChangePasswordStates {
  final String error;

  ChangePasswordErrorState(this.error);
}

class ChangeEyeState extends ChangePasswordStates {}
