import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms/models/track_model.dart';
import 'package:lms/modules/Auther/traks/traks_cubit/status.dart';
import 'package:lms/shared/component/constants.dart';
import 'package:lms/shared/network/end_points.dart';
import 'package:lms/shared/network/local/cache_helper.dart';
import 'package:lms/shared/network/remote/dio-helper.dart';

import '../../author_courses/author_courses_cubit/status.dart';

class TrackCubit extends Cubit<TrackStates> {
  TrackCubit() : super(TrackInitialState());

  static TrackCubit get(context) => BlocProvider.of(context);

  TrackModel? trackModel ;

  void getAllTracks() {
    emit(AllTrackLoadingState());
    DioHelper.getData(url: getTrack,token: CacheHelper.get(key: 'token')).then((value) {
      trackModel = TrackModel.fromJson(value.data);
      //print(value.data);
      emit(AllTrackSuccessState(trackModel));
    }).catchError((error) {
      emit(AllTrackErrorState(error.toString()));
      print(error.toString());
    });
  }

  // void updateUserProfile({
  //   required String? phone,
  //   required String? birthday,
  //   required String? city,
  //   required String? country,
  //   required String? gender,
  //   //required File? imageUrl,
  //   required String? university,
  //   required String? major,
  //   required String? faculty,
  //   required String? grade,
  //   required String? experience,
  //   required List<String>? interest,
  //   required String? bio,
  // }) {
  //   emit(UpdadteProfileLoadingState());
  //
  //   DioHelper.putData(url: updateProfile, token:userToken, data: {
  //     'phone': phone,
  //     'birthDay': birthday,
  //     'city': city,
  //     'country': country,
  //     'gender': gender,
  //     //'imageUrl': imageUrl,
  //     'userEducation': {
  //       'university': university,
  //       'major': major,
  //       'faculty': faculty,
  //       'grade': grade,
  //       'experince': experience,
  //       'interest': interest,
  //     },
  //     'bio': bio,
  //   }).then((value) {
  //     print(value.toString());
  //     model = User.fromJson(value.data);
  //     getUserProfile();
  //     //print(model!.profile!.userName);
  //     emit(UpdadteProfileSuccessState(model!));
  //   }).catchError((onError) {
  //     print(onError.toString());
  //     emit(UpdadteProfileErrorState(onError.toString()));
  //   });
  // }
}
