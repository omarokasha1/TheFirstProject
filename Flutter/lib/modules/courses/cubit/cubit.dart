
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lms/models/course_model.dart';
import 'package:lms/modules/courses/cubit/states.dart';

import '../../../shared/component/constants.dart';
import '../../../shared/network/end_points.dart';
import '../../../shared/network/remote/dio-helper.dart';
class CourseCubit extends Cubit<CourseStates> {
  CourseCubit() : super(CourseInitialState());

  static CourseCubit get(context) => BlocProvider.of(context);

  List<CourseModel?> coursesModel = [];

  void getAllCoursesData() {
    emit(AllCoursesLoadingState());
    print("url $courses");
    DioHelper.getData(url: courses).then((value) {
      value.data['courses'].forEach((element) {
        coursesModel.add(CourseModel.fromJson(element));
        //searchModel.add(CourseModel.fromJson(element));
        print("element$element");
      });
      emit(AllCoursesSuccessState(coursesModel));
    }).catchError((error) {
      emit(AllCoursesErrorState(error.toString()));
      print(error.toString());
    });
  }
  // List<CourseModel?> searchModel= [];
  // bool searchFlag = false;
  // void searchCourse(String search){
  //   searchFlag = true;
  //   searchModel.clear();
  //   emit(SearchCourseLoadingState());
  //   for (var i in coursesModel){
  //     if(i!.title!.contains(search)||i.description!.contains(search)||i.requiremnets!.contains(search)){
  //       searchModel.add(i);
  //     }
  //   }
  //   if(searchModel.isEmpty){
  //     searchModel = coursesModel;
  //   }
  //   emit(SearchCourseSuccessState());
  //   searchFlag = false;
  // }

  CourseModel? courseModel;

  void getCourseData({required courseId}) {
    emit(CourseLoadingState());
    DioHelper.getData(url: "$CourseModel/$courseId", token: userToken)
        .then((value) {
      courseModel = CourseModel.fromJson(value.data);
      emit(CourseSuccessState(courseModel!));
    }).catchError((error) {
      emit(CourseErrorState(error.toString()));
      print(error.toString());
    });
  }

  void enrollCourse({required courseId}){
    emit(EnrollCourseLoadingState());
    DioHelper.putData(url: enrollUserToCourse, data: {
      '_id':courseId,
    },token: userToken).then((value) {
      emit(EnrollCourseSuccessState());
    }).catchError((error){
      emit(EnrollCourseErrorState(error));
    });
  }

  void wishlistCourse({required courseId}){
    emit(WishlistCourseLoadingState());
    DioHelper.putData(url: wishlist, data: {
      'courseId':courseId,
    },token: userToken).then((value) {
      print(value.data);
      Fluttertoast.showToast(msg: value.data['message']);
      emit(WishlistCourseSuccessState());
    }).catchError((error){
      emit(WishlistCourseErrorState(error));
    });
  }


  // CourseModel? createCourseModel;
  //
  // void createNewCourse({
  //   required String courseName,
  //   required String description,
  //   required String requirement,
  //   required List<dynamic> content,
  //   required String lang,
  //   required image,
  // }) {
  //   emit(CreateCourseLoadingState());
  //   DioHelper.postData(
  //     data: {
  //       'title': courseName,
  //       'description': description,
  //       'requirements': requirement,
  //       'language': lang,
  //       'imageUrl': image
  //     },
  //     url: module,
  //     token: userToken,
  //   ).then((value) {
  //     createCourseModel = CourseModel.fromJson(value.data);
  //     emit(CreateCourseSuccessState(createCourseModel!));
  //   }).catchError((onError) {
  //     print(onError.toString());
  //     emit(CreateCourseErrorState(onError.toString()));
  //   });
  // }
}
