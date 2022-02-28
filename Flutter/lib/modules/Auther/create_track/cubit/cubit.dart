import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http_parser/http_parser.dart';
import 'package:lms/models/course_model.dart';
import 'package:lms/models/module_model.dart';
import 'package:lms/models/track_model.dart';
import 'package:lms/modules/Auther/create_track/cubit/statues.dart';
import 'package:lms/shared/component/component.dart';
import 'package:lms/shared/component/constants.dart';
import 'package:lms/shared/network/end_points.dart';
import 'package:lms/shared/network/local/cache_helper.dart';
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

  changeRadio(Sequences? value) {
    character = value;
  }

  AuthorCoursesTestModel? authorCoursesTestModel;
  List? list = [];
  List? myActivities = [];

  void getAuthorCoursesData() {
    emit(GetAuthorCoursesLoadingState());
    DioHelper.getData(url: getAuthorCourses, token: userToken).then((value) {
      print(value.data);
      list = [];
      authorCoursesTestModel = AuthorCoursesTestModel.fromJson(value.data);

      authorCoursesTestModel!.courses!.forEach((element) {
        list!.add({'display': element.title, 'value': element.sId});
      });
      //print(authorCoursesTestModel!.courses.toString());
      emit(GetAuthorCoursesSuccessState(authorCoursesTestModel));
    }).catchError((error) {
      emit(GetAuthorCoursesErrorState(error.toString()));
      print(error.toString());
    });
  }

  void changeActivity(value) {
    myActivities = value;
    emit(ChangeActivityState());
  }

  TrackModel? trackModel;

  Future<void> createNewTrack({
    required String trackName,
    required String shortDescription,
    required String duration,
    required courses,
    required trackImage,
  }) async {
    emit(CreateTrackLoadingState());
    DioHelper.postData(files: true,
      data: {
        'trackName': trackName,
        'description': shortDescription,
        'duration': duration,
        //'imageUrl': trackImage,
        'courses': courses,
        'check' : 'drafts',
        'imageUrl': await fileUpload(trackImage),
      },
      url: createTrack,
      token: userToken,
    ).then((value) async {
    //  trackModel = TrackModel.fromJson(value.data);
    print('Hereeeeeee : ${value.data}');
    await getAllTracks();
      emit(CreateTrackSuccessState(trackModel!));
    }).catchError((onError) {
      print(onError.toString());
      emit(CreateTrackErrorState(onError.toString()));
    });
  }

  Future<void> getAllTracks() async {
    emit(AllTrackLoadingState());
    await DioHelper.getData(url: getTrack,token: userToken).then((value) {
      trackModel = TrackModel.fromJson(value.data);
      //print(value.data);
      emit(AllTrackSuccessState(trackModel));
    }).catchError((error) {
      emit(AllTrackErrorState(error.toString()));
      print(error.toString());
    });
  }
}
