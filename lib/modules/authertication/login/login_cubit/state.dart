import 'package:lms/models/login_model.dart';

abstract class LoginStates {}

class InitLoginState extends LoginStates {}

class LoginLoadingState extends LoginStates {}

class LoginSuccessState extends LoginStates {
  final LoginModel model;

  LoginSuccessState(this.model);
}

class LoginErrorState extends LoginStates {
  final String error;

  LoginErrorState(this.error);
}

class RegisterLoadingState extends LoginStates {}

class RegisterSuccessState extends LoginStates {
  final LoginModel model;

  RegisterSuccessState(this.model);
}

class RegisterErrorState extends LoginStates {
  final String error;

  RegisterErrorState(this.error);
}

class LogOutState extends LoginStates {}

class ChangeEyeState extends LoginStates{}

class ChangeLoginState extends LoginStates{}
class ChangeForgetPasswordState extends LoginStates{}

class ChangeEmailValidateState extends LoginStates{}
class ChangePasswordValidateState extends LoginStates{}
