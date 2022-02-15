import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms/models/chage_password_model.dart';
import 'package:lms/modules/authertication/change%20password/cubit/states.dart';
import 'package:lms/shared/network/end_points.dart';
import 'package:lms/shared/network/remote/dio-helper.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordStates> {
  //This Initialize Cubit and Send Initial State to Start
  ChangePasswordCubit() : super(ChangePasswordInitialState());

  //This get Function to be Used when we need to get The Cubit all Over the Project
  static ChangePasswordCubit get(context) => BlocProvider.of(context);

  //
  ChangePasswordModel? changePasswordModel;

  void createNewPassword(
      {required String token,
      required String currentPass,
      required String newPass}) {
    emit(ChangePasswordLoadingState());
    DioHelper.postData(url: changePassword, token: "00", data: {
      "current_password": currentPass,
      "new_password": newPass,
    }).then((value) {
      changePasswordModel = ChangePasswordModel.fromJson(value.data);

      emit(ChangePasswordSuccessState(changePasswordModel!));
    }).catchError((onError) {
      print(onError.toString());
      emit(ChangePasswordErrorState(onError.toString()));
    });
  }

  bool eye1 = true;
  bool eye2 = true;
  bool eye3 = true;

  //This to Toggle Eye in Old Password
  void changeEye1() {
    eye1 = !eye1;
    emit(ChangeEyeState());
  }

  //This to Toggle Eye in New Password
  void changeEye2() {
    eye2 = !eye2;
    emit(ChangeEyeState());
  }

  //This to Toggle Eye in Confirm New Password
  void changeEye3() {
    eye3 = !eye3;
    emit(ChangeEyeState());
  }
  //This bool variable to check a Validate Password
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
