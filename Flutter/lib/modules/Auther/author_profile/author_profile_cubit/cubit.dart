import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms/models/user.dart';
import 'package:lms/modules/Auther/author_profile/author_profile_cubit/state.dart';
import 'package:lms/shared/component/constants.dart';
import 'package:lms/shared/network/end_points.dart';
import 'package:lms/shared/network/local/cache_helper.dart';
import 'package:lms/shared/network/remote/dio-helper.dart';

class AuthorProfileCubit extends Cubit<AuthorProfileStates> {
  AuthorProfileCubit() : super(InitAuthorProfileState());

  static AuthorProfileCubit get(context) => BlocProvider.of(context);

  User? model;

  void getAuthorProfile(
      String id,
      ) {
    emit(AuthorProfileLoadingState());
    //Remove this in Integration
    userToken = CacheHelper.get(key: 'token');
    DioHelper.getData(
      url: '$getUserProfile/$id',
      token: userToken,
    ).then((value) {
      model = User.fromJson(value.data);
      // print(model!.userName);
      emit(AuthorProfileSuccessState(model!));
    }).catchError((onError) {
      print(onError.toString());
      emit(AuthorProfileErrorState(onError.toString()));
    });
  }
}
