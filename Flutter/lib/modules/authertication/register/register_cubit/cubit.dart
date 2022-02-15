import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms/models/login_model.dart';
import 'package:lms/modules/authertication/register/register_cubit/state.dart';
import 'package:lms/shared/network/end_points.dart';
import 'package:lms/shared/network/remote/dio-helper.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(InitRegisterState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  LoginModel? model;

  bool eye = true;
  bool confirmEye = true;

  int loginStatus = 0;

  void userRegister({
    required String userName,
    required String email,
    required String password,
    required String phone,
  }) {
    emit(RegisterLoadingState());
    DioHelper.postData(url: register, data: {
      'userName': userName,
      'email': email,
      'password': password,
      'phone': phone,
    }).then((value) {
      model = LoginModel.fromJson(value.data);
      emit(RegisterSuccessState(model!));
    }).catchError((onError) {
      print(onError.toString());

      emit(RegisterErrorState(onError.toString()));
    });
  }

  void changeEye() {
    eye = !eye;
    emit(ChangeEyeState());
  }

  void changeConfirmEye() {
    confirmEye = !confirmEye;
    emit(ChangeEyeState());
  }


  bool forgetPassword = false;

  void changeForgetPassword() {
    forgetPassword = !forgetPassword;
    emit(ChangeForgetPasswordState());
  }

  bool isPasswordCharacters = false;
  bool hasPasswordNumber = false;
  bool hasEmailValid = false;
  bool hasName = false;

  onNameChanged(String name)
  {
    hasName =false;
    if(name.length > 2 )
    {
      hasName = true;
    }
  }
  onPasswordChanged(String password) {
    final numericRegex = RegExp(r'[0-9]');
      isPasswordCharacters = false;
      if (password.length >= 8) {
        isPasswordCharacters = true;
      }
      hasPasswordNumber = false;
      if (numericRegex.hasMatch(password)) {
        hasPasswordNumber = true;
      }
  }

  onEmailChanged(String email) {
    final emailValid = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    hasEmailValid = false;
    if (emailValid.hasMatch(email)) {
      hasEmailValid = true;
    }
  }
  //
   bool hasPhonedNumber = false;

  onPhoneChange(String phone) {

    hasPhonedNumber = false;
    if (phone.length > 11) {
        hasPhonedNumber = true;
    }
  }
}