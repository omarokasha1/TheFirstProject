import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms/models/course_model.dart';
import 'package:lms/models/response_model.dart';
import 'package:lms/models/track_model.dart';
import 'package:lms/modules/Auther/author_courses/author_courses_cubit/status.dart';
import 'package:lms/shared/component/component.dart';
import 'package:lms/shared/component/constants.dart';
import 'package:lms/shared/network/end_points.dart';
import 'package:lms/shared/network/remote/dio-helper.dart';

class AuthorCoursesCubit extends Cubit<AuthorCoursesStates> {
  AuthorCoursesCubit() : super(AuthorCourseInitialState());

  static AuthorCoursesCubit get(context) => BlocProvider.of(context);

  bool hasCourseName = false;

  onCourseNameChanged(String name) {
    hasCourseName = false;
    if (name.length > 2) {
      hasCourseName = true;
    }
  }
  bool checkedValue = false;

  List<String> items = ['English', 'Arabic'];
  String selectedItem = "English";

  void changeItem(String value)
  {
    selectedItem=value;
    emit(ChangeItemState());
  }

  AuthorCoursesTestModel? authorCoursesTestModel;

  Future<void> getAuthorCoursesData() async {
    emit(GetAuthorCoursesLoadingState());

    await DioHelper.getData(url: getAuthorCourses, token: userToken).then((value) {
      //print(value.data);
      //authorCoursesTestModel!.courses=[];
      authorCoursesTestModel = AuthorCoursesTestModel.fromJson(value.data);
      //print(authorCoursesTestModel!.courses.toString());
      emit(GetAuthorCoursesSuccessState(authorCoursesTestModel));
    }).catchError((error) {
      emit(GetAuthorCoursesErrorState(error.toString()));
      print(error.toString());
    });
  }

  Future<void> createNewCourse({
    required String courseName,
    required String shortDescription,
    required String requirements,
    required contents,
    required language,
    required courseImage,
  }) async {
    emit(CreateCourseLoadingState());
    DioHelper.postData(
      files: true,
      data: {
        'title': courseName,
        'description': shortDescription,
        'requirements' : requirements,
        'contents': contents,
        'language': language,
        'imageUrl': await fileUpload(courseImage),
      },
      url: createAuthorCourse,
      token: userToken,
    ).then((value) async {
      //print('Hereeeeeee : ${value.data}');
      emit(CreateCourseSuccessState());
      getAuthorCoursesData();
    }).catchError((onError) {
      print(onError.toString());
      emit(CreateCourseErrorState(onError.toString()));
    });
  }

  ResponseModel? updateModel;
  String? message;

  Future<void> updateCourse({
    required String courseName,
    required String shortDescription,
    required String requirements,
    required contents,
    required language,
    required courseImage,
    required sID,
  }) async {
    emit(UpdateCourseLoadingState());
    DioHelper.putData(
      files: true,
      data: {
        'title': courseName,
        'description': shortDescription,
        'requirements' : requirements,
        'contents': contents,
        'language': language,
        'imageUrl': await fileUpload(courseImage),
        'id': sID,
      },
      url: updateAuthorCourse,
      token: userToken,
    ).then((value) async {
      //  trackModel = TrackModel.fromJson(value.data);
      updateModel = ResponseModel.fromJson(value.data);
      showToast(message: '${updateModel!.message}',color: Colors.green);
      print('Hereeeeeee : ${value.data}');
      emit(UpdateCourseSuccessState());
      getAuthorCoursesData();
    }).catchError((onError) {
      print(onError.toString());
      emit(UpdateCourseErrorState(onError.toString()));
    });
  }

  ResponseModel? deleteModel;

  void deleteCourse({required String courseId}) {
    emit(DeleteCourseLoadingState());
    DioHelper.deleteData(url:'$deleteAuthorCourse/$courseId',).then((value) async {
      //print(value.data);
      deleteModel = ResponseModel.fromJson(value.data);
      await getAuthorCoursesData();
      emit(DeleteCourseSuccessState());
    }).catchError((error) {
      emit(DeleteCourseErrorState(error));
    });
  }
}
