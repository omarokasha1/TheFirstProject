import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms/models/course_model.dart';
import 'package:lms/modules/Auther/create_track/cubit/statues.dart';
import 'package:lms/shared/component/constants.dart';
import 'package:lms/shared/network/end_points.dart';
import 'package:lms/shared/network/remote/dio-helper.dart';
enum Sequences { ordered, unordered }

class CreateTrackCubit extends Cubit<CreateTrackStates> {
  CreateTrackCubit() : super(InitCreateTrackState());

  static CreateTrackCubit get(context) => BlocProvider.of(context);

  bool hasTrackName = false;
  var formKey = GlobalKey<FormState>();

  Sequences? character = Sequences.ordered;
  onCourseNameChanged(String name) {
    hasTrackName = false;
    if (name.length > 2) {
      hasTrackName = true;
    }
  }
  changeRadio (Sequences? value) {
    character = value;
  }
  AuthorCoursesTestModel? authorCoursesTestModel;
  List? list = [];
  List? myActivities = [];

  void getAuthorCoursesData() {
    emit(GetAuthorCoursesLoadingState());
    DioHelper.getData(url: getAuthorCourses,token: userToken).then((value) {
      print(value.data);
      list = [];
      authorCoursesTestModel = AuthorCoursesTestModel.fromJson(value.data);

      authorCoursesTestModel!.courses!.forEach((element) {
        list!.add({'display': element.title, 'value': element.sId});
      });
      print(authorCoursesTestModel!.courses.toString());
      emit(GetAuthorCoursesSuccessState(authorCoursesTestModel));
    }).catchError((error) {
      emit(GetAuthorCoursesErrorState(error.toString()));
      print(error.toString());
    });
  }
  void changeActivity(value)
  {
    myActivities=value;
    emit(ChangeActivityState());
  }
}