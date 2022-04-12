import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms/models/new/courses_model.dart';
import 'package:lms/models/response_model.dart';
import 'package:lms/models/track_model.dart';
import 'package:lms/modules/Auther/traks/create_track/cubit/statues.dart';
import 'package:lms/shared/component/component.dart';
import 'package:lms/shared/component/constants.dart';
import 'package:lms/shared/network/end_points.dart';
import 'package:lms/shared/network/remote/dio-helper.dart';

class CreateTrackCubit extends Cubit<CreateTrackStates> {
  CreateTrackCubit() : super(InitCreateTrackState());

  static CreateTrackCubit get(context) => BlocProvider.of(context);

  List? myActivities = [];

  bool hasTrackName = false;
  var formKey = GlobalKey<FormState>();

  void selectImage()
  {
    emit(SelectImageState());
  }

  onCourseNameChanged(String name) {
    hasTrackName = false;
    if (name.length > 2) {
      hasTrackName = true;
    }
  }

  List coursesList = [];
  CoursesModel? coursesModelPublish;

  Future<void> getAuthorCoursesPublishedData() async {
    emit(GetAuthorCoursesPublishLoadingState());
    coursesList = [];
    await DioHelper.getData(url: getAuthorCoursesPublished, token: userToken)
        .then((value) {
      coursesModelPublish = CoursesModel.fromJson(value.data);
      coursesModelPublish!.courses!.forEach((element) {
        coursesList.add({'display': element.title, 'value': element.sId});
      });
      print(coursesList);
      //print(authorCoursesTestModel!.courses.toString());
      emit(GetAuthorCoursesPublishSuccessState(coursesModelPublish));
    }).catchError((error) {
      emit(GetAuthorCoursesPublishErrorState(error.toString()));
      print(error.toString());
    });
  }

  TrackModel? trackModelPublished;

  Future<void> getAuthorTrackPublishedData() async {
    emit(GetAuthorTrackPublishLoadingState());
    await DioHelper.getData(url: getAuthorTrackPublished, token: userToken).then((value) {
      trackModelPublished = TrackModel.fromJson(value.data);
      // coursesList = [];
      // coursesModel!.courses!.forEach((element) {
      //   coursesList!.add({'display': element.title, 'value': element.sId});
      // });
      emit(GetAuthorTrackPublishSuccessState(trackModelPublished));
    }).catchError((error) {
      emit(GetAuthorTrackPublishErrorState(error.toString()));
      print(error.toString());
    });
  }

  Tracks? trackModelByID;

  Future<void> getAuthorTrackByIDData(String trackID) async {
    emit(GetAuthorTrackByIDLoadingState());
    await DioHelper.getData(url: '$getTrackData/$trackID', token: userToken).then((value) {
      print('herooooooooo >>>> ${value.data}');
      trackModelByID = Tracks.fromJson(value.data['tracks']);
      emit(GetAuthorTrackByIDSuccessState(trackModelByID));
    }).catchError((error) {
      emit(GetAuthorTrackByIDErrorState(error.toString()));
      print('asd asd here   ---->>> ${error.toString()}');
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
    //required String duration,
    required courses,
    required trackImage,
  }) async {
    emit(CreateTrackLoadingState());
    DioHelper.postData(
      files: true,
      data: {
        'trackName': trackName,
        'description': shortDescription,
        //'duration': duration,
        'imageUrl': await fileUpload(trackImage),
        'courses': courses,
        'check': 'drafts',
      },
      url: createTrack,
      token: userToken,
    ).then((value) async {
      await getAllTracks();
      await getAuthorTrackPublishedData();
      emit(CreateTrackSuccessState());
    }).catchError((onError) {
      print(onError.toString());
      emit(CreateTrackErrorState(onError.toString()));
    });
  }

  ResponseModel? updateModel;
  String? message;

  Future<void> updateTrackData({
    required String trackName,
    required String shortDescription,
    required courses,
    required trackImage,
    required sID,
  }) async {
    emit(UpdateTrackLoadingState());
    DioHelper.putData(
      data: {
        'trackName': trackName,
        'description': shortDescription,
        'imageUrl': await fileUpload(trackImage),
        'courses': courses,
        'check': 'drafts',
        'id': sID,
      },
      files: true,
      url: updateTrack,
      token: userToken,
    ).then((value) async {
      //  trackModel = TrackModel.fromJson(value.data);
      updateModel = ResponseModel.fromJson(value.data);
      showToast(message: '${updateModel!.message}',color: Colors.green);
      print('Hereeeeeee Update Track : ${value.data}');
      await getAllTracks();
      await getAuthorTrackPublishedData();
      emit(UpdateTrackSuccessState());
    }).catchError((onError) {
      print(onError.toString());
      emit(UpdateTrackErrorState(onError.toString()));
    });
  }


  Future<void> getAllTracks() async {
    emit(AllTrackLoadingState());
    await DioHelper.getData(url: getAuthorTrack, token: userToken).then((value) {
      //trackModel!.tracks = [];
      trackModel = TrackModel.fromJson(value.data);
      emit(AllTrackSuccessState(trackModel));
    }).catchError((error) {
      emit(AllTrackErrorState(error.toString()));
      print(error.toString());
    });
  }

  ResponseModel? deleteModel;
  Future<void> deleteTrack({required String trackId}) async {
    emit(DeleteTrackLoadingState());
    await DioHelper.deleteData(url:'$deleteTrackData/$trackId',).then((value) async {
      print(value.data);
      deleteModel = ResponseModel.fromJson(value.data);
      await getAllTracks();
      await getAuthorTrackPublishedData();
      await showToast(message: '${deleteModel!.message}',color: Colors.green);
      emit(DeleteTrackSuccessState(deleteModel!));
    }).catchError((error) {
      emit(DeleteTrackErrorState(error));
    });
  }


  Future<void> sendTracksRequest({
    required trackId,
  }) async {
    emit(SendTrackRequestLoadingState());
    DioHelper.postData(
      data: {
        'trackId': trackId,
        // 'token':userToken,
      },
      url: sendTrackRequest,
      token: userToken,
    ).then((value) async {
      print(value.data);
      emit(SendTrackRequestSuccessState());
      showToast(message: '${value.data['message']}',color: Colors.green);
      await getAllTracks();
      await getAuthorTrackPublishedData();
    }).catchError((onError) {
      print(onError.toString());
      emit(SendTrackRequestErrorState(onError.toString()));
    });
  }

}
