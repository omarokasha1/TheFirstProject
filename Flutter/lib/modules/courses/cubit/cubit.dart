import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lms/models/new/contents_model.dart';
import 'package:lms/models/new/courses_model.dart';
import 'package:lms/modules/courses/cubit/states.dart';
import 'package:lms/shared/component/component.dart';
import '../../../shared/component/constants.dart';
import '../../../shared/network/end_points.dart';
import '../../../shared/network/remote/dio-helper.dart';
class CourseCubit extends Cubit<CourseStates> {
  CourseCubit() : super(CourseInitialState());

  static CourseCubit get(context) => BlocProvider.of(context);

  CoursesModel? coursesModel;

  void getAllCoursesData() {
    emit(AllCoursesLoadingState());
    DioHelper.getData(url: courses).then((value) {
      coursesModel = CoursesModel.fromJson(value.data);
      search = coursesModel!.courses!;
      emit(AllCoursesSuccessState(coursesModel));
    }).catchError((error) {
      emit(AllCoursesErrorState(error.toString()));
      print(error.toString());
    });
  }
  List<Courses> search = [];
  void searchCourse (String word){
    search = coursesModel!.courses!;
    emit(SearchCourseLoadingState());
    if(word.isEmpty){
      search = coursesModel!.courses!;
    }else{
      search = coursesModel!.courses!.where((element) {
        final titleLower = element.title!.toLowerCase();
        final authorLower =
        element.author!.userName!.toLowerCase();
        final descriptionLower =
        element.description!.toLowerCase();
        final requirementsLower =
        element.requirements!.toLowerCase();
        final searchLower = word.toLowerCase();

        return titleLower.contains(searchLower) ||
            authorLower.contains(searchLower) ||
            descriptionLower.contains(searchLower) ||
            requirementsLower.contains(searchLower);
      }).toList();
    }
    emit(SearchCourseSuccessState());
    //return search;
  }

  CoursesModel? courseModel;

  void getCourseData({required courseId}) {
    emit(CourseLoadingState());
    DioHelper.getData(url: "$CoursesModel/$courseId", token: userToken)
        .then((value) {
      courseModel = CoursesModel.fromJson(value.data);
      emit(CourseSuccessState(courseModel!));
    }).catchError((error) {
      emit(CourseErrorState(error.toString()));
      print(error.toString());
    });
  }

  void enrollCourse({required courseId}){
    emit(EnrollCourseLoadingState());
    DioHelper.putData(url: enrollUserToCourse, data: {
      'courseId':courseId,
    },token: userToken).then((value) {
      showToast(message: value.data['message']);
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

  ContentsModel? newContent;
  void getContentDetails(String id) {
    DioHelper.getData(
      url: "${getModule+ id}",
    ).then((value) {
      print(value.data.toString());
      newContent = ContentsModel.fromJson(value.data);
    }).catchError((error) {
      print(error.toString());
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
