import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms/models/course_model.dart';
import 'package:lms/modules/courses/cubit/states.dart';

import '../../../shared/component/constants.dart';
import '../../../shared/network/end_points.dart';
import '../../../shared/network/remote/dio-helper.dart';

class CourseCubit extends Cubit<CourseStates> {
  CourseCubit() : super(CourseInitialState());

  static CourseCubit get(context) => BlocProvider.of(context);

  List<CourseModel?> coursesModel =[];
  void getAllCoursesData() {
    emit(AllCoursesLoadingState());
    DioHelper.getData(url: courses).then((value) {
      value.data['courses'].forEach((element) {
        coursesModel.add(CourseModel.fromJson(element)) ;
      });
      emit(AllCoursesSuccessState(coursesModel));
    }).catchError((error) {
      emit(AllCoursesErrorState(error.toString()));
      print(error.toString());
    });
  }

  CourseModel? courseModel;
  void getCourseData({required courseId}) {
    emit(CourseLoadingState());
    DioHelper.getData(url: "$CourseModel/$courseId", token: userToken).then((value) {
      courseModel = CourseModel.fromJson(value.data);
      emit(CourseSuccessState(courseModel!));
    }).catchError((error) {
      emit(CourseErrorState(error.toString()));
      print(error.toString());
    });
  }
}
