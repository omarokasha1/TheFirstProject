import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms/models/login_model.dart';
import 'package:lms/models/user.dart';
import 'package:lms/modules/profile/profile_cubit/state.dart';
import 'package:lms/shared/network/end_points.dart';
import 'package:lms/shared/network/local/cache_helper.dart';
import 'package:lms/shared/network/remote/dio-helper.dart';

import '../../../shared/component/constants.dart';

class ProfileCubit extends Cubit<ProfileStates> {
  ProfileCubit() : super(InitProfileState());

  static ProfileCubit get(context) => BlocProvider.of(context);

  User? model;

  var interestedItems;

  void addInterestedItem(String value){
    interestedItems.add(value);
    emit(AddInterestedItemState());
  }

  void deleteInterestedItem(int index){
    interestedItems.removeAt(index);
    emit(DeleteInterestedItemState());
  }

  void getUserProfile() {
    emit(ProfileLoadingState());
    DioHelper.getData(
      url: profile,
      token:userToken,
    ).then((value) {
      model = User.fromJson(value.data);
      // print(model!.userName);
      emit(ProfileSuccessState(model!));
    }).catchError((onError) {
      print(onError.toString());
      emit(ProfileErrorState(onError.toString()));
    });
  }

  void updateUserProfile({
    required String? phone,
    required String? birthday,
    required String? city,
    required String? country,
    required String? gender,
    //required String? imageUrl,
    required String? university,
    required String? major,
    required String? faculty,
    required String? grade,
    required String? experience,
    required List<String>? interest,
    required String? bio,

  }) {
    emit(UpdadteProfileLoadingState());

    DioHelper.putData(url: updateProfile, token:userToken, data: {
      'phone': phone,
      'birthDay': birthday,
      'city': city,
      'country': country,
      'gender': gender,
      //'imageUrl': imageUrl,
      'userEducation': {
        'university': university,
        'major': major,
        'faculty': faculty,
        'grade': grade,
        'experince': experience,
        'interest': interest,
      },
      'bio': bio,
    }).then((value) {
      print(value.toString());
      model = User.fromJson(value.data);
      getUserProfile();
      //print(model!.profile!.userName);
      emit(UpdadteProfileSuccessState(model!));
    }).catchError((onError) {
      print(onError.toString());
      emit(UpdadteProfileErrorState(onError.toString()));
    });
  }

  List<String> gradeItems = ['Excellent', 'Very Good', 'Good', 'Satisfy', 'Pass', 'GPA',];
  String? selectedItemGrade;
  
  void changeSelectedItemGrade (String value){
    selectedItemGrade = value;
    emit(ChangeSelectedItemGradeState());
  }
}
