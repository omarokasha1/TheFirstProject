
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms/models/course_model.dart';
import 'package:lms/models/track_model.dart';
import 'package:lms/modules/courses/cubit/states.dart';
import 'package:lms/modules/user_tracks/cubit/states.dart';

import '../../../shared/component/constants.dart';
import '../../../shared/network/end_points.dart';
import '../../../shared/network/remote/dio-helper.dart';
class TrackCubit extends Cubit<AllTracksStates> {
  TrackCubit() : super(AllTracksInitialState());

  static TrackCubit get(context) => BlocProvider.of(context);

  List<Tracks?> tracksModel = [];
  Tracks? trackModel;
  void getAllTracksData() {
    emit(AllTracksLoadingState());
    print("url $getAuthorTrackPublished");
    DioHelper.getData(url: getAllTrackPublished,token: userToken).then((value) {
      value.data['tracks'].forEach((element) {
        tracksModel.add(Tracks.fromJson(element));
        print("element$element");
      });
      emit(AllTracksSuccessState(tracksModel));
    }).catchError((error) {
      emit(AllTracksErrorState(error.toString()));
      print(error.toString());
    });
  }

  // TrackModel? trackModel;
  //
  // void getTrackData({required trackId}) {
  //   emit(AllTracksLoadingState());
  //   DioHelper.getData(url: "$TrackModel/$trackId", token: userToken)
  //       .then((value) {
  //     trackModel = TrackModel.fromJson(value.data);
  //     emit(AllTracksSuccessState(trackModel));
  //   }).catchError((error) {
  //     emit(AllTracksErrorState(error.toString()));
  //     print(error.toString());
  //   });
  // }

  // void enrollTrack({required courseId}){
  //   emit(EnrollTrackLoadingState());
  //   DioHelper.putData(url: enrollUserToTrack, data: {
  //     '_id':courseId,
  //   },token: userToken).then((value) {
  //     emit(EnrollTrackSuccessState());
  //   }).catchError((error){
  //     emit(EnrollTrackErrorState(error));
  //   });
  // }

// TrackModel? createTrackModel;
//
// void createNewTrack({
//   required String courseName,
//   required String description,
//   required String requirement,
//   required List<dynamic> content,
//   required String lang,
//   required image,
// }) {
//   emit(CreateTrackLoadingState());
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
//     createTrackModel = TrackModel.fromJson(value.data);
//     emit(CreateTrackSuccessState(createTrackModel!));
//   }).catchError((onError) {
//     print(onError.toString());
//     emit(CreateTrackErrorState(onError.toString()));
//   });
// }
}