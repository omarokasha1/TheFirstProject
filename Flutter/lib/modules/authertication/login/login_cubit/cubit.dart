import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms/models/login_model.dart';
import 'package:lms/modules/authertication/login/login_cubit/state.dart';
import 'package:lms/shared/network/end_points.dart';
import 'package:lms/shared/network/remote/dio-helper.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(InitLoginState());

  static LoginCubit get(context) => BlocProvider.of(context);

  LoginModel? model;

  bool eye = true;
  bool confirmEye = true;

  int loginStatus = 0;



  void userLogin({required String email, required String password}) {
    emit(LoginLoadingState());
    DioHelper.postData(url: login, data: {
      'email': email,
      'password': password,
    }).then((value) {
      model = LoginModel.fromJson(value.data);
      print("${model!.message}");
      emit(LoginSuccessState(model!));
    }).catchError((onError) {
      print(onError.toString());
      emit(LoginErrorState(onError.toString()));
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

  void changeLoginState(int index) {
    loginStatus = index;
    emit(ChangeLoginState());
  }
  bool forgetPassword=false;
  void changeForgetPassword()
  {
    forgetPassword=!forgetPassword;
    emit(ChangeForgetPasswordState());
  }

  bool isPasswordCharacters = false;
  bool hasPasswordNumber = false;
  bool hasEmailValid = false;


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

  onEmailChanged(String email)
  {
    final emailValid =RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
      hasEmailValid =false;
      if(emailValid.hasMatch(email)){
        hasEmailValid = true;
      }

  }



}
