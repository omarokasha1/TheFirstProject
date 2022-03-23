import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms/models/course_model.dart';
import 'package:lms/models/wishlist_courses.dart';
import 'package:lms/modules/my_learning/my_learning_cubit/state.dart';
import 'package:lms/shared/component/constants.dart';
import 'package:lms/shared/network/end_points.dart';
import 'package:lms/shared/network/remote/dio-helper.dart';

class MyLearningCubit extends Cubit<MyLearningStates> {
  MyLearningCubit() : super(MyLearningInitialState());

  static MyLearningCubit get(context) => BlocProvider.of(context);


  // List<CourseModel?> coursesModel =[];
  // void getAllCoursesData() {
  //   emit(MyLearningLoadingState());
  //   DioHelper.getData(url: enrolledCourses).then((value) {
  //     value.data.forEach((element) {
  //       coursesModel.add(CourseModel.fromJson(element)) ;
  //     });
  //     emit(MyLearningSuccessState(coursesModel));
  //   }).catchError((error) {
  //     emit(MyLearningErrorState(error.toString()));
  //     print(error.toString());
  //   });
  // }

  WishlistCourses? wishlistCourses;
  void getAllWishlistData() {
    emit(GetWishlistCoursesLoadingState());
    DioHelper.getData(url: wishlist,token: userToken).then((value) {
      //print(value.data);
      wishlistCourses = WishlistCourses.fromJson(value.data);
      //print('Hereeeeeeeeeeeeeeeeeeee ${wishlistCourses!.wishList!.length}');
      emit(GetWishlistCoursesSuccessState());
    }).catchError((error) {
      emit(GetWishlistCoursesErrorState(error.toString()));
      print(error.toString());
    });
  }

  List<Courses> enrolledCourses =[];
  void getEnrollCourses() {
    emit(GetEnrolledCoursesLoadingState());
    DioHelper.getData(url: getEnrolledCourses,token: userToken).then((value) {
      //print('Hereeeeeeeeeeeeeeeeeeee ${wishlistCourses!.wishList!.length}');
      value.data['myCourses'].forEach((v) {
        enrolledCourses.add(Courses.fromJson(v));
      });
      emit(GetEnrolledCoursesSuccessState());
    }).catchError((error) {
      emit(GetEnrolledCoursesErrorState(error.toString()));
      print(error.toString());
    });
  }

}