import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms/models/new/courses_model.dart';
import 'package:lms/modules/new/course_cubit/course_state.dart';
import 'package:lms/shared/network/end_points.dart';
import 'package:lms/shared/network/remote/dio-helper.dart';

class CourseCubit extends Cubit<CourseStates> {
  CourseCubit() : super(CourseInitialState());

  static CourseCubit get(context) => BlocProvider.of(context);

  CoursesModel? coursesModel;

  void getAllCoursesData() {
    emit(AllCoursesLoadingState());
    DioHelper.getData(url: courses).then((value) {
      coursesModel = CoursesModel.fromJson(value.data);
      emit(AllCoursesSuccessState(coursesModel));
    }).catchError((error) {
      emit(AllCoursesErrorState(error.toString()));
      print(error.toString());
    });
  }
}