
import 'package:lms/models/login_model.dart';

abstract class RegisterStates {}

class InitRegisterState extends RegisterStates {}

class RegisterLoadingState extends RegisterStates {}

class RegisterSuccessState extends RegisterStates {
  final LoginModel model;

  RegisterSuccessState(this.model);
}

class RegisterErrorState extends RegisterStates {
  final String error;

  RegisterErrorState(this.error);
}


class ChangeEyeState extends RegisterStates{}

class ChangeRegisterState extends RegisterStates{}
class ChangeForgetPasswordState extends RegisterStates{}